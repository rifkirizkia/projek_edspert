import 'package:flutter/material.dart';
import 'package:projek_edspert/models/result_response.dart';
import 'package:projek_edspert/repository/latihan_soal_api.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key, required this.exerciseId}) : super(key: key);
  final String exerciseId;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  ResultResponse? resultData;
  getResult() async {
    final result = await LatihanSoalApi().getResult(widget.exerciseId);
    if (result != null) {
      resultData = ResultResponse.fromJson(result);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3A7FD5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: resultData == null
              ? const Center(child: CircularProgressIndicator())
              : Column(children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close, color: Colors.white)),
                      const Text(
                        'Tutup',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Selamat',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w400),
                  ),
                  const Text('Kamu telah menyelesaikan Kuiz ini',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  const SizedBox(
                    height: 34,
                  ),
                  Image.asset(
                    "assets/img/img_result.png",
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text('Nilai kamu :',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w400)),
                  Text(resultData!.data!.result!.jumlahScore!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 96,
                          fontWeight: FontWeight.w400)),
                ]),
        ),
      ),
    );
  }
}
