import 'package:flutter/material.dart';
import 'package:projek_edspert/controller/AuthProviderController.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late AuthProviderController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Provider.of<AuthProviderController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Akun Saya'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Edit',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(15, 28, 15, 60),
              decoration: const BoxDecoration(
                  color: Color(0xff3A7FD5),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(9),
                      bottomRight: Radius.circular(9))),
              child: Row(children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Nama User',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      Text(
                        'Nama Sekolah User',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  "assets/img/ic_avatar.png",
                  width: 50,
                  height: 50,
                )
              ]),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 7, color: Colors.black.withOpacity(0.25))
                  ]),
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 13),
              margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Identitas Diri'),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Nama Lengkap',
                    style: TextStyle(
                        color: Colors.black.withAlpha(66), fontSize: 12),
                  ),
                  const Text(
                    'Nama Lengkap User',
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Nama Lengkap',
                    style: TextStyle(
                        color: Colors.black.withAlpha(66), fontSize: 12),
                  ),
                  const Text(
                    'Nama Lengkap User',
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Nama Lengkap',
                    style: TextStyle(
                        color: Colors.black.withAlpha(66), fontSize: 12),
                  ),
                  const Text(
                    'Nama Lengkap User',
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Nama Lengkap',
                    style: TextStyle(
                        color: Colors.black.withAlpha(66), fontSize: 12),
                  ),
                  const Text(
                    'Nama Lengkap User',
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Nama Lengkap',
                    style: TextStyle(
                        color: Colors.black.withAlpha(66), fontSize: 12),
                  ),
                  const Text(
                    'Nama Lengkap User',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 13),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 7, color: Colors.black.withOpacity(0.25))
                    ]),
                child: InkWell(
                  onTap: () {
                    controller.signOut(context);
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Keluar',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
