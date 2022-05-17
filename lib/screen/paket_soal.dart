import 'package:flutter/material.dart';
import 'package:projek_edspert/helpers/user_email.dart';
import 'package:projek_edspert/repository/latihan_soal_api.dart';
import 'package:projek_edspert/screen/kerjakan_latihan_soal.dart';

import '../models/materi.dart';
import '../models/paket_soal.dart';
import '../models/sub_materi.dart';

class PaketSoalPage extends StatefulWidget {
  const PaketSoalPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<PaketSoalPage> createState() => _PaketSoalPageState();
}

class _PaketSoalPageState extends State<PaketSoalPage> {
  PaketSoal? paketSoal;
  getPaketSoal(id) async {
    final response = await LatihanSoalApi().getPaketSoal(id);
    print(response);
    if (response != null) {
      paketSoal = PaketSoal.fromJson(response);
      setState(() {});
    }
  }

  Materi? materi;

  getMateri(id) async {
    final response =
        await LatihanSoalApi().getMateri(UserEmail.getUserEmail(), id);
    print(response);
    if (response != null) {
      materi = Materi.fromJson(response);
      final idMateri = materi!.data!.listCourseContent![0].courseId;
      print('hasil id Materi');
      print(idMateri);
      await getSubMateri(idMateri);
    }
  }

  SubMateri? subMateri;

  getSubMateri(id) async {
    final response =
        await LatihanSoalApi().getSubMateri(UserEmail.getUserEmail(), id);
    print(response);
    if (response != null) {
      subMateri = SubMateri.fromJson(response);
      final idMateri = subMateri!.data![0].subCourseContentId;
      print('isi idMateri');
      print(subMateri);
      await getPaketSoal(idMateri);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMateri(widget.id);
    getSubMateri(widget.id);
    getPaketSoal(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF3F7F8),
        appBar: AppBar(
          title: const Text("Paket Soal"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Pilih Paket Soal",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: paketSoal == null
                      ? const SizedBox(
                          height: 50,
                          child: Center(child: CircularProgressIndicator()))
                      : SingleChildScrollView(
                          child: Center(
                            child: Wrap(
                              children: List.generate(paketSoal!.data!.length,
                                  (index) {
                                return Container(
                                  padding: const EdgeInsets.all(3),
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: PaketSoalWidget(
                                    data: paketSoal!.data![index],
                                    title:
                                        paketSoal!.data![index].exerciseTitle!,
                                    id: paketSoal!.data![index].exerciseId!,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                  // GridView.count(
                  //     mainAxisSpacing: 10,
                  //     crossAxisSpacing: 10,
                  //     crossAxisCount: 2,
                  //     childAspectRatio: 3 / 2.5,
                  //     children:
                  //         ),
                  ),
            ],
          ),
        ));
  }
}

class PaketSoalWidget extends StatelessWidget {
  const PaketSoalWidget({
    Key? key,
    required this.data,
    required this.title,
    required this.id,
  }) : super(key: key);
  final PaketSoalData data;
  final String title;
  final String id;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => KerjakanLatihanSoalPage(
            id: id,
          ),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        // margin: const EdgeInsets.all(13.0),
        padding: const EdgeInsets.all(13.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.withOpacity(0.2)),
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                "assets/img/ic_note.png",
                width: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${data.jumlahDone}/${data.jumlahSoal} Paket Soal",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 9,
                  color: Color(0xff8E8E8E)),
            ),
          ],
        ),
      ),
    );
  }
}
