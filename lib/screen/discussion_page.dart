import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
  // List<QueryDocumentSnapshot>? listChat;
  // getDataFromFirebase() async {
  //   chatData = await FirebaseFirestore.instance
  //       .collection("room")
  //       .doc("kimia")
  //       .collection("chat")
  //       .get();
  //   // listChat = chatData.docs;
  //   setState(() {});
  //   // print(chatData.docs);
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getDataFromFirebase();
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
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                  color: user.uid == currentChat["uid"]
                                      ? const Color(0xff3A7FD5)
                                      : const Color(0xffFFDCDC),
                                  borderRadius: user.uid == currentChat["uid"]
                                      ? const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        )
                                      : const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        )),
                              child: Text(
                                  currentChat["type"] == "file"
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
                                      : currentChat["content"],
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: user.uid == currentChat["uid"]
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w400)),
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
                          ],
                        ),
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
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
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
                              controller: textController,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () async {
                                        final imageResult = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.camera,
                                                maxHeight: 500,
                                                maxWidth: 500);

                                        if (imageResult != null) {
                                          File file = File(imageResult.path);
                                          final name =
                                              imageResult.path.split("/");
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
                                            textController.clear();
                                          });
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        color: Color(0xff3A7FD5),
                                      )),
                                  contentPadding: EdgeInsets.only(left: 10),
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
                    onPressed: () {
                      if (textController.text.isEmpty) {
                        return;
                      }
                      print(textController.text);

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
        )
      ])),
    );
  }
}
