import 'dart:io';

import 'package:awesome_widgets/awesome_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:projek_edspert/controller/HomeController.dart';

import '../constant/api_url.dart';
import '../helpers/preference_helper.dart';
import '../models/data_by_user_email.dart';
import '../models/network_response.dart';

class DiscussionPage extends StatefulWidget {
  const DiscussionPage({Key? key, this.id}) : super(key: key);
  final String? id;
  @override
  State<DiscussionPage> createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  final textController = TextEditingController();
  late CollectionReference chat;
  late QuerySnapshot chatData;
  bool emojiShowing = false;
  final controller = HomeController();

  _onEmojiSelected(Emoji emoji) {
    textController
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: textController.text.length));
  }

  _onBackspacePressed() {
    textController
      ..text = textController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: textController.text.length));
  }

  Dio pushNotifDio() {
    String uri = "https://fcm.googleapis.com/fcm/";
    BaseOptions options = BaseOptions(
      baseUrl: uri,
      responseType: ResponseType.json,
      connectTimeout: 60000,
      receiveTimeout: 60000,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "key=" +
            "AAAA3pdkFBA:APA91bEpZ_HfFUQS7fZ7WnTBehXpOF53IpDZgi6aG4HfCLEWU6_5Xl5nDGRYtE2ceZZB-2E7cD8rXOOIHTKslmBlrIpbkoNNPDr4qgYOq28eK-hHU0vkAzThe1mzcu2I2p73fxF2L7wJ"
      },
    );
    Dio dio = Dio(options);

    return dio;
  }

  Future<NetworkResponse> _postNotif({path, body, onSendProgress}) async {
    try {
      final dio = pushNotifDio();

      final res = await dio.post(
        path,
        data: body,
        onSendProgress: onSendProgress,
      );
      return NetworkResponse.success(res.data);
    } catch (e) {
      print('e.toString()');
      print(e.toString());
      Get.snackbar(
        "Terjadi Kesalahan",
        "Silahkan ulangi beberapa saat lagi",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.black,
        dismissDirection: DismissDirection.horizontal,
      );
      return NetworkResponse.error();
    }
  }

  Future<NetworkResponse> postNotif(
    title,
    url,
    message,
  ) async {
    Map<String, dynamic> data = {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "sound": "default",
      "status": "done",
      "screen": "discussion_page",
    };

    final res = await _postNotif(path: ApiUrl.pushNotif, body: {
      "to": "/topics/kimia",
      "notification": {
        "body": message ?? "Foto",
        "title": title,
        "image": url ?? "",
        "text": "",
        "content_available": 1
      },
      "data": data,
      "priority": "high"
    });
    return res;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.subscribeToTopic("kimia");
  }

  @override
  Widget build(BuildContext context) {
    chat = FirebaseFirestore.instance
        .collection("room")
        .doc("kimia")
        .collection("chat");
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text("Diskusi Soal"),
      ),
      body: SafeArea(
          child: Column(children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: chat.orderBy("time").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                  //memeriksa apakah dia sudah mengambil data atau belum
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data!.docs.reversed.length,
                    itemBuilder: (BuildContext context, int index) {
                      final currentChat =
                          snapshot.data!.docs.reversed.toList()[index];
                      final currentDate =
                          (currentChat["time"] as Timestamp?)?.toDate();
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                            crossAxisAlignment: user.uid == currentChat["uid"]
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(currentChat["nama"],
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff5200FF))),
                              GestureDetector(
                                onLongPress: () {
                                  user.uid == currentChat["uid"]
                                      ? showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              child: Wrap(
                                                children: [
                                                  ListTile(
                                                    leading: const Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                    title: const Text(
                                                        'Hapus Pesan Anda'),
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            false,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                "Pesan ini akan dihapus"),
                                                            content: const Text(
                                                                "Apakah anda yakin pesan ini akan dihapus?"),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: const Text(
                                                                      "Batal")),
                                                              TextButton(
                                                                child:
                                                                    const Text(
                                                                        "Ya"),
                                                                onPressed: () {
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "room")
                                                                      .doc(
                                                                          "kimia")
                                                                      .collection(
                                                                          "chat")
                                                                      .doc(snapshot
                                                                          .data!
                                                                          .docs
                                                                          .reversed
                                                                          .toList()[
                                                                              index]
                                                                          .reference
                                                                          .id)
                                                                      .delete()
                                                                      //     .catchError(
                                                                      //         (err) {
                                                                      //   print(
                                                                      //       "Error: $err");
                                                                      // })
                                                                      .whenComplete(
                                                                          () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    Navigator.pop(
                                                                        context);
                                                                    AwesomeSnackbar.style1(
                                                                        duration: const Duration(
                                                                            seconds:
                                                                                3),
                                                                        context:
                                                                            context,
                                                                        primaryColor: Colors
                                                                            .green
                                                                            .shade300,
                                                                        title:
                                                                            "Berhasil",
                                                                        subTitle:
                                                                            "Pesan Anda Telah Dihapus",
                                                                        titleTextstyle: const TextStyle(
                                                                            color: Colors
                                                                                .green),
                                                                        subtitleTextstyle: const TextStyle(
                                                                            color: Colors
                                                                                .green,
                                                                            fontSize:
                                                                                13),
                                                                        backgroundColor:
                                                                            Colors
                                                                                .white,
                                                                        iconData:
                                                                            Icons
                                                                                .check,
                                                                        iconColor:
                                                                            Colors.white);
                                                                  });
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                  )
                                                ],
                                              ),
                                            );
                                          })
                                      : null;
                                },
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6.0, vertical: 10.0),
                                    decoration: BoxDecoration(
                                        color: user.uid == currentChat["uid"]
                                            ? const Color(0xff3A7FD5)
                                            : const Color(0xffFFDCDC),
                                        borderRadius: user.uid ==
                                                currentChat["uid"]
                                            ? const BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              )
                                            : const BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              )),
                                    child: currentChat["type"] == "file"
                                        ? Image.network(
                                            currentChat["file_url"],
                                            errorBuilder:
                                                ((context, error, stackTrace) {
                                              return Container(
                                                padding: EdgeInsets.all(10),
                                                child: Icon(Icons.warning),
                                              );
                                            }),
                                          )
                                        : Text(currentChat["content"],
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: user.uid ==
                                                        currentChat["uid"]
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: FontWeight.w400))),
                              ),
                              Text(
                                  currentDate == null
                                      ? ""
                                      : DateFormat("dd-MMM-yyy HH:mm")
                                          .format(currentDate),
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff979797))),
                            ]),
                      );
                    },
                  );
                },
              )),
        ),
        SafeArea(
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  offset: const Offset(0, -1),
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.25))
            ]),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      controller.focusNode.unfocus();
                      controller.isEmojiVisible.toggle();
                      setState(() {
                        emojiShowing = !emojiShowing;
                      });
                    },
                    icon: const Icon(
                      Icons.emoji_emotions,
                      color: Color(0xff3A7FD5),
                    )),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              focusNode: controller.focusNode,
                              controller: textController,
                              onTap: () {
                                setState(() {
                                  emojiShowing = false;
                                });
                              },
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () async {
                                        final imageResult = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.camera,
                                                maxHeight: 300,
                                                maxWidth: 300);

                                        if (imageResult != null) {
                                          File file = File(imageResult.path);
                                          // final name =
                                          //     imageResult.path.split("/");
                                          String room = widget.id ?? "kimia";
                                          String ref =
                                              "chat/$room/${user.uid}/${imageResult.name}";

                                          final imgResUpload =
                                              await FirebaseStorage.instance
                                                  .ref()
                                                  .child(ref)
                                                  .putFile(file);
                                          final url = await imgResUpload.ref
                                              .getDownloadURL();
                                          final chatContent = {
                                            "nama": user.displayName,
                                            "uid": user.uid,
                                            "content": textController.text,
                                            "email": user.email,
                                            "photo": user.photoURL,
                                            "ref": ref,
                                            "type": "file",
                                            "file_url": url,
                                            "time": FieldValue.serverTimestamp()
                                          };
                                          chat
                                              .add(chatContent)
                                              .whenComplete(() {
                                            final res = postNotif(
                                              user.displayName,
                                              url,
                                              "Foto",
                                            );
                                            textController.clear();
                                          });
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        color: Color(0xff3A7FD5),
                                      )),
                                  contentPadding:
                                      const EdgeInsets.only(left: 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "Tulis pesan disini...",
                                  hintStyle: const TextStyle(
                                      color: Color(0xff979797))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      if (textController.text.isEmpty) {
                        return;
                      }
                      print(textController.text);
                      //tambahan
                      //                   void fcmSubscribe() {
                      // firebaseMessaging.subscribeToTopic("kimia");
                      //}
                      final chatContent = {
                        "nama": user.displayName,
                        "uid": user.uid,
                        "content": textController.text,
                        "email": user.email,
                        "photo": user.photoURL,
                        "ref": null,
                        "type": "text",
                        "file_url": null,
                        "time": FieldValue.serverTimestamp()
                      };
                      final res = postNotif(
                        user.displayName,
                        "",
                        textController.text,
                      );
                      print("isi pesan");
                      print(res);
                      chat.add(chatContent).whenComplete(() {
                        textController.clear();
                      });
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Color(0xff3A7FD5),
                    )),
              ],
            ),
          ),
        ),
        Offstage(
          offstage: !emojiShowing,
          child: SizedBox(
            height: 250,
            child: EmojiPicker(
                onEmojiSelected: (Category category, Emoji emoji) {
                  _onEmojiSelected(emoji);
                },
                onBackspacePressed: _onBackspacePressed,
                config: Config(
                    backspaceColor: Colors.red.shade900,
                    columns: 7,
                    // Issue: https://github.com/flutter/flutter/issues/28894
                    emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                    verticalSpacing: 0,
                    horizontalSpacing: 0,
                    initCategory: Category.RECENT,
                    bgColor: const Color(0xFFF2F2F2),
                    indicatorColor: Colors.blue,
                    iconColor: Colors.grey,
                    iconColorSelected: Colors.blue,
                    progressIndicatorColor: Colors.blue,
                    skinToneDialogBgColor: Colors.white,
                    skinToneIndicatorColor: Colors.grey,
                    enableSkinTones: true,
                    showRecentsTab: true,
                    recentsLimit: 28,
                    noRecents: const Text(
                      'No Recents',
                      style: TextStyle(fontSize: 20, color: Colors.black26),
                      textAlign: TextAlign.center,
                    ),
                    tabIndicatorAnimDuration: kTabScrollDuration,
                    categoryIcons: const CategoryIcons(),
                    buttonMode: ButtonMode.MATERIAL)),
          ),
        ),
      ])),
    );
  }
}
