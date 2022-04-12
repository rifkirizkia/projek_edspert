import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
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
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
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
                TextButton(onPressed: () {}, child: const Text('Lihat Semua'))
              ],
            ),
            const SizedBox(
              width: 24,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Matematika'),
                        const Text('0/50 Pake latihan soal'),
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: 12,
                              color: Colors.grey,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: 12,
                              color: Colors.blue,
                            )
                          ],
                        )
                      ],
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
                padding: const EdgeInsets.all(8.0),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Fisika'),
                        const Text('0/50 Pake latihan soal'),
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: 12,
                              color: Colors.grey,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: 12,
                              color: Colors.blue,
                            )
                          ],
                        )
                      ],
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
                padding: const EdgeInsets.all(8.0),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Kimia'),
                        const Text('0/50 Pake latihan soal'),
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: 12,
                              color: Colors.grey,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: 12,
                              color: Colors.blue,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
