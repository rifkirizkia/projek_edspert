import 'package:flutter/material.dart';
import 'package:projek_edspert/screen/home_page.dart';
import 'package:projek_edspert/screen/paket_soal.dart';

class MapelPage extends StatelessWidget {
  const MapelPage({Key? key}) : super(key: key);
  static String route = "mapel_page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Mata Pelajaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: ListView.builder(
          itemBuilder: ((context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => const PaketSoalPage()),
                    ),
                  );
                },
                child: MapelWidget());
          }),
        ),
      ),
    );
  }
}
