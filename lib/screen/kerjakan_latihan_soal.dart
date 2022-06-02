import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:projek_edspert/helpers/user_email.dart';
import 'package:projek_edspert/screen/result_page.dart';

import '../models/kerjakan_latihan_soal.dart';
import '../models/simple_response.dart';
import '../repository/latihan_soal_api.dart';

class KerjakanLatihanSoalPage extends StatefulWidget {
  const KerjakanLatihanSoalPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<KerjakanLatihanSoalPage> createState() =>
      _KerjakanLatihanSoalPageState();
}

class _KerjakanLatihanSoalPageState extends State<KerjakanLatihanSoalPage>
    with SingleTickerProviderStateMixin {
  KerjakanLatihanSoal? soal;
  getSoalLatihan(id) async {
    final response =
        await LatihanSoalApi().postMulaiKerjakan(UserEmail.getUserEmail(), id);
    if (response != null) {
      soal = KerjakanLatihanSoal.fromJson(response);
      _controller = TabController(
        length: soal!.data!.length,
        vsync: this,
      );
      _controller!.addListener(() {
        // if (!_controller.indexIsChanging) {
        //   if (_controller.index == soal!.data!.length - 1)
        // }
        setState(() {});
      });
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSoalLatihan(widget.id);
  }

  bool isLoading = false;
  TabController? _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Latihan Soal"),
      ),
      bottomNavigationBar: soal == null
          ? const Center(child: CircularProgressIndicator())
          : Container(
              margin: const EdgeInsets.only(bottom: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xff3A7FD5),
                          fixedSize: const Size(160, 45),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        if (soal!.data!.length - 1 == _controller!.index) {
                          final resultU = await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return const BottomSheetConfirmation();
                              });
                          print(resultU);
                          if (resultU == true) {
                            print('Kirim ke backend');
                            List<String> answer = [];
                            List<String> questionId = [];
                            soal!.data!.forEach((element) {
                              questionId.add(element.bankQuestionId!);
                              answer.add(element.studentAnswer!);
                            });
                            final payload = {
                              "user_email": UserEmail.getUserEmail(),
                              "exercise_id": widget.id,
                              "bank_question_id": questionId,
                              "student_answer": answer
                            };
                            print(payload);
                            final result = await LatihanSoalApi()
                                .postInputJawaban(payload);
                            if (result != null) {
                              final data = SimpleResponse.fromJson(result);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => ResultPage(
                                        exerciseId: widget.id,
                                      )));
                              // if (data.status == 1) {
                              //   isLoading = false;
                              //   setState(() {});
                              //   Navigator.of(context).pop();
                              //   // Navigator.of(context).pop();
                              // }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Submit Gagal. Silahkan Ulangi')));
                            }
                          }
                          // isLoading = true;
                          // setState(() {});
                          // Payload
                          final firebaseEmail =
                              FirebaseAuth.instance.currentUser!.email;
                          String? email = UserEmail.getUserEmail();
                          String exerciseId = widget.id;
                          List<String> answer = [];
                          List<String> idSoal = [];
                          for (var element in soal!.data!) {
                            answer.add(element.studentAnswer ?? "X");
                            idSoal.add(element.bankQuestionId!);
                          }
                        } else {
                          _controller!.animateTo(_controller!.index + 1);
                        }
                      },
                      child: Text(
                        soal!.data!.length - 1 == _controller!.index
                            ? "Kumpulin"
                            : "Selanjutnya",
                        style: const TextStyle(fontSize: 12),
                      )),
                ],
              )),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Container(
          child: soal == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TabBar(
                        controller: _controller,
                        isScrollable: true,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.blue,
                            width: 3,
                          ),
                        ),
                        tabs: List.generate(
                          soal!.data!.length,
                          (index) => Container(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "${index + 1}",
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TabBarView(
                          controller: _controller,
                          children: List.generate(
                            soal!.data!.length,
                            (index) => SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Soal no ${index + 1}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff979797)),
                                  ),
                                  if (soal!.data![index].questionTitle != null)
                                    Html(
                                        data: soal!.data![index].questionTitle,
                                        style: {
                                          "body":
                                              Style(padding: EdgeInsets.zero),
                                          "p": Style(
                                              fontSize: const FontSize(12))
                                        },
                                        customRender: {
                                          "table": (context, child) {
                                            // return null;
                                            return SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: (context.tree
                                                      as TableLayoutElement)
                                                  .toWidget(context),
                                            );
                                          }
                                        }),
                                  if (soal!.data![index].questionTitleImg !=
                                      null)
                                    Image.network(
                                      soal!.data![index].questionTitleImg!,
                                      errorBuilder: (context, _, s) {
                                        return Container();
                                      },
                                    ),
                                  _buildPilihanJawaban(
                                    "A",
                                    soal!.data![index].optionA,
                                    soal!.data![index].optionAImg,
                                    index,
                                    soal!.data![index].studentAnswer,
                                  ),
                                  _buildPilihanJawaban(
                                    "B",
                                    soal!.data![index].optionB,
                                    soal!.data![index].optionBImg,
                                    index,
                                    soal!.data![index].studentAnswer,
                                  ),
                                  _buildPilihanJawaban(
                                    "C",
                                    soal!.data![index].optionC,
                                    soal!.data![index].optionCImg,
                                    index,
                                    soal!.data![index].studentAnswer,
                                  ),
                                  _buildPilihanJawaban(
                                    "D",
                                    soal!.data![index].optionD,
                                    soal!.data![index].optionDImg,
                                    index,
                                    soal!.data![index].studentAnswer,
                                  ),
                                  _buildPilihanJawaban(
                                    "E",
                                    soal!.data![index].optionE,
                                    soal!.data![index].optionEImg,
                                    index,
                                    soal!.data![index].studentAnswer,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildPilihanJawaban(option, answerText, img, index, userAnswer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 3, color: Colors.grey),
        ),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: option == userAnswer
                  ? Colors.blue.withOpacity(0.4)
                  : Colors.white,
            ),
            onPressed: () {
              soal!.data![index].studentAnswer = option;
              setState(() {});
            },
            child: Builder(builder: (context) {
              if (img != null) return Image.network("$img");
              return Row(
                children: [
                  Text(
                    "$option.",
                    style: TextStyle(
                      color:
                          !(option == userAnswer) ? Colors.black : Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Html(data: "$answerText", style: {
                      "body": Style(
                        color: !(option == userAnswer)
                            ? Colors.black
                            : Colors.white,
                      )
                    }),
                  ),
                ],
              );
            })),
      ),
    );
  }
}

class BottomSheetConfirmation extends StatefulWidget {
  const BottomSheetConfirmation({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomSheetConfirmation> createState() =>
      _BottomSheetConfirmationState();
}

class _BottomSheetConfirmationState extends State<BottomSheetConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5,
            width: 100,
            decoration: BoxDecoration(
                color: const Color(0xffC4C4C4),
                borderRadius: BorderRadius.circular(10)),
          ),
          const SizedBox(
            height: 15,
          ),
          Image.asset("assets/img/ic_confirmation.png"),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Kumpulkan latihan soal sekarang?',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
          const Text(
            'Boleh langsung kumpulin dong',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xff9C9C9C)),
          ),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                                color: Colors.blue,
                                style: BorderStyle.solid,
                                width: 1)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text(
                        'Nanti Dulu',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff3A7FD5)),
                      ))),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text(
                        'Ya',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      )))
            ],
          )
        ],
      ),
    );
  }
}
