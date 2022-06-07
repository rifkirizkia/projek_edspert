import 'package:flutter/material.dart';
import 'package:projek_edspert/helpers/user_email.dart';
import 'package:projek_edspert/models/materi.dart';
import 'package:projek_edspert/repository/latihan_soal_api.dart';
import 'package:projek_edspert/screen/home_page.dart';
import 'package:projek_edspert/screen/paket_soal.dart';

import '../models/matapelajaran_list.dart';

class MapelPage extends StatelessWidget {
  const MapelPage({Key? key, required this.mapel}) : super(key: key);
  static String route = "mapel_page";
  final MataPelajaranList mapel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Mata Pelajaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: ListView.builder(
          itemCount: mapel.data!.length,
          itemBuilder: ((context, index) {
            final currentMapel = mapel.data![index];
            print("");
            print("");
            print("");
            print("hasil jumlah selesai");
            print(currentMapel);
            print("");
            print("");
            print("");
            return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) =>
                          PaketSoalPage(id: currentMapel.courseId!)),
                    ),
                  );
                },
                child: MapelWidget(
                  title: currentMapel.courseName!,
                  count: currentMapel.jumlahDone.toString(),
                  total: currentMapel.jumlahMateri.toString(),
                ));
          }),
        ),
      ),
    );
  }
}
