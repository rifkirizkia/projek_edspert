import 'package:flutter/material.dart';

class PaketSoalPage extends StatefulWidget {
  const PaketSoalPage({Key? key}) : super(key: key);

  @override
  State<PaketSoalPage> createState() => _PaketSoalPageState();
}

class _PaketSoalPageState extends State<PaketSoalPage> {
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
              Text(
                "Pilih Paket Soal",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: GridView.count(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    children: const [
                      PaketSalWidget(),
                      PaketSalWidget(),
                      PaketSalWidget(),
                      PaketSalWidget(),
                    ]),
              ),
            ],
          ),
        ));
  }
}

class PaketSalWidget extends StatelessWidget {
  const PaketSalWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(13.0),
      // margin: const EdgeInsets.all(13.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              "assets/img/ic_note.png",
              width: 14,
            ),
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10)),
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            "Aljabar",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            "0/0 Paket Soal",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 9,
                color: Color(0xff8E8E8E)),
          )
        ],
      ),
    );
  }
}
