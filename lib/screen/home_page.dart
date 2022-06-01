import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:projek_edspert/helpers/preference_helper.dart';
import 'package:projek_edspert/models/data_by_user_email.dart';
import 'package:projek_edspert/models/matapelajaran_list.dart';
import 'package:projek_edspert/screen/mapel_page.dart';
import 'package:projek_edspert/screen/paket_soal.dart';

import '../helpers/user_email.dart';
import '../models/banner_list.dart';
import '../repository/latihan_soal_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = false;
  MataPelajaranList? mapelList;
  getMapel() async {
    loading = true;
    setState(() {});
    final response = await LatihanSoalApi()
        .getMataPelajaran(UserEmail.getUserEmail(), "IPA");
    print(response);
    if (response != null) {
      mapelList = MataPelajaranList.fromJson(response);
      setState(() {});
    }
    loading = false;
    setState(() {});
  }

  BannerList? banner;
  // bool loading = false;
  getBanner() async {
    loading = true;
    setState(() {});
    final response = await LatihanSoalApi().getBanner();
    print(response);
    if (response != null) {
      banner = BannerList.fromJson(response);
      setState(() {});
    }
    loading = false;
    setState(() {});
  }

  setUpFcm() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    final tokenFcm = await FirebaseMessaging.instance.getToken();
    print("tokenFcm: $tokenFcm");
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    // if (initialMessage != null) {
    //   _handleMessage(initialMessage);
    // }
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  final userName = UserEmail.getUserDisplayName()!;
  DataUserByEmail? dataUser;
  Future getUserData() async {
    dataUser = await PreferenceHelper().getUserData();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMapel();
    getBanner();
    setUpFcm();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f0f0),
      body: SafeArea(
        child: ListView(
          children: [
            _buildUserHomeProfile(),
            _buildTopBanner(context),
            mapelList == null
                ? const SizedBox(
                    height: 50,
                    child: Center(child: CircularProgressIndicator()))
                : _buildHomeListMapel(mapelList),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    "Terbaru",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 150,
                  child: banner == null
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Image.network(
                                  banner!.data![index].eventImage!,
                                  errorBuilder: (context, error, stackTrace) {
                                return Container();
                              }),
                            );
                          }),
                        ),
                ),
                const SizedBox(height: 35),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container _buildHomeListMapel(MataPelajaranList? list) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 21),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                "Pilih Pelajaran",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MapelPage(mapel: list!),
                  ));
                  // Navigator.of(context).pushNamed(MapelPage.route);
                },
                child: const Text(
                  "Lihat Semua",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Color.fromARGB(255, 58, 127, 213)),
                ),
              )
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final current = list!.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) =>
                          PaketSoalPage(id: current.courseId!)),
                    ),
                  );
                },
                child: MapelWidget(
                  title: current.courseName!,
                  count: current.jumlahDone.toString(),
                  total: current.jumlahMateri.toString(),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Container _buildTopBanner(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20.0,
        // vertical: 15,
      ),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 58, 127, 213),
          borderRadius: BorderRadius.circular(20)),
      height: 147,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 15,
            ),
            child: const Text(
              "Mau kerjain latihan soal apa hari ini?",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(
              "assets/img/img_home.png",
              width: MediaQuery.of(context).size.width * 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildUserHomeProfile() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 15,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hai, " + (dataUser?.data?.userName ?? "Nama User"),
                  style: GoogleFonts.poppins()
                      .copyWith(fontSize: 12, fontWeight: FontWeight.w700),
                ),
                Text(
                  "Selamat datang",
                  style: GoogleFonts.poppins().copyWith(
                    fontSize: 12,
                    // fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            "assets/img/ic_avatar.png",
            width: 35,
            height: 35,
          ),
        ],
      ),
    );
  }
}

class MapelWidget extends StatelessWidget {
  const MapelWidget({
    Key? key,
    required this.title,
    required this.count,
    required this.total,
  }) : super(key: key);

  final String title;
  final String count;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 21),
      child: Row(children: [
        Container(
          height: 53,
          width: 53,
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
              color: const Color(0xfff0f0f0),
              borderRadius: BorderRadius.circular(10)),
          child: Image.asset("assets/img/ic_atom.png"),
        ),
        const SizedBox(
          width: 6,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                "$count/$total Paket latihan soal",
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xff8E8E8E)),
              ),
              const SizedBox(height: 5),
              Stack(
                children: [
                  Container(
                    height: 5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xfff0f0f0),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: int.parse(count),
                        child: Container(
                          height: 5,
                          //width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 58, 127, 213),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      Expanded(
                        flex: int.parse(total) - int.parse(count),
                        child: Container(
                            // height: 5,
                            // width: MediaQuery.of(context).size.width * 0.4,
                            // decoration: BoxDecoration(
                            //     color: const Color.fromARGB(255, 58, 127, 213),
                            //     borderRadius: BorderRadius.circular(10)),
                            ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
