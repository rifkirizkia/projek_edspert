import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projek_edspert/models/matapelajaran_list.dart';
import 'package:projek_edspert/screen/mapel_page.dart';

import '../repository/latihan_soal_api.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // fetchData() async {
  //   final uri = Uri.parse("https://jsonplaceholder.typicode.com/albums/1");
  //   final result = await http.get(uri);
  // }
  MataPelajaranList? mapelList;
  getMapel() async {
    final response =
        await LatihanSoalApi().getMataPelajaran("alitopan@widyaedu.com", "IPA");
    print(response);
    if (response != null) {
      final mapelList = MataPelajaranList.fromJson(response);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMapel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const _buildUserHomeProfile(),
            const SizedBox(
              height: 20.0,
            ),
            const _buildTopBanner(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pilih Pelajaran',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => const MapelPage()),
                        ),
                      );
                    },
                    child: const Text('Lihat Semua'))
              ],
            ),
            const SizedBox(
              width: 24,
            ),
            const _buildHomeListMapel(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Terbaru',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Image.asset("assets/img/img_banner.png"),
                    );
                  }))),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      )),
    );
  }
}

class _buildHomeListMapel extends StatelessWidget {
  const _buildHomeListMapel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MapelWidget(),
        const SizedBox(
          width: 15,
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Color.fromARGB(255, 243, 247, 248)),
                  child: Image.asset(
                    "assets/img/ic_atom.png",
                    width: 26,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Fisika'),
                      const Text('0/50 Pake latihan soal'),
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 5,
                            decoration: BoxDecoration(
                                color: Color(0xfff0f0f0),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: 5,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Color.fromARGB(255, 243, 247, 248)),
                  child: Image.asset(
                    "assets/img/ic_kimia.png",
                    width: 26,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Kimia'),
                      const Text('0/50 Pake latihan soal'),
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 5,
                            decoration: BoxDecoration(
                                color: Color(0xfff0f0f0),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: 5,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MapelWidget extends StatelessWidget {
  const MapelWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 21),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  color: Color.fromARGB(255, 243, 247, 248)),
              child: Image.asset(
                "assets/img/math.png",
                width: 26,
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Matematika'),
                  const Text('0/50 Pake latihan soal'),
                  Stack(
                    children: [
                      Container(
                          width: double.infinity,
                          height: 5,
                          decoration: BoxDecoration(
                              color: Color(0xfff0f0f0),
                              borderRadius: BorderRadius.circular(10))),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _buildTopBanner extends StatelessWidget {
  const _buildTopBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 1 / 6,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 58, 127, 213)),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              padding: const EdgeInsets.all(20),
              child: const Text(
                'Mau kerjain latihan soal apa hari ini?',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Image.asset("assets/img/img_home.png"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _buildUserHomeProfile extends StatelessWidget {
  const _buildUserHomeProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Hai, Rifki',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Selamat Datang')
            ],
          ),
        ),
        Image.asset(
          "assets/img/ic_avatar.png",
          width: 35,
        )
      ],
    );
  }
}
