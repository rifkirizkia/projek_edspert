import 'package:flutter/material.dart';
import 'package:projek_edspert/controller/AuthProviderController.dart';
import 'package:projek_edspert/helpers/preference_helper.dart';
import 'package:projek_edspert/screen/edit_profile_page.dart';
import 'package:provider/provider.dart';

import '../helpers/user_email.dart';
import '../models/data_by_user_email.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DataUserByEmail? user;
  getUserData() async {
    final data = await PreferenceHelper().getUserData();
    user = data;
    setState(() {});
  }

  late AuthProviderController controller;

  final userName = UserEmail.getUserDisplayName()!;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Provider.of<AuthProviderController>(context, listen: false);
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: const Text('Akun Saya'),
        actions: [
          TextButton(
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => const EditProfile()),
                ),
              );
              if (result == true) {
                getUserData();
              }
            },
            child: const Text(
              'Edit',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: user == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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
                            children: [
                              Text(
                                user!.data!.userName!,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                              Text(
                                user!.data!.userAsalSekolah!,
                                style: const TextStyle(
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
                                blurRadius: 7,
                                color: Colors.black.withOpacity(0.25))
                          ]),
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 13),
                      margin: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 13),
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
                                color: Colors.black.withAlpha(66),
                                fontSize: 12),
                          ),
                          Text(
                            user!.data!.userName!,
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Email',
                            style: TextStyle(
                                color: Colors.black.withAlpha(66),
                                fontSize: 12),
                          ),
                          Text(
                            user!.data!.userEmail!,
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Jenis Kelamin',
                            style: TextStyle(
                                color: Colors.black.withAlpha(66),
                                fontSize: 12),
                          ),
                          Text(
                            user!.data!.userGender!,
                            style: TextStyle(fontSize: 13),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          // Text(
                          //   'Kelas',
                          //   style: TextStyle(
                          //       color: Colors.black.withAlpha(66),
                          //       fontSize: 12),
                          // ),
                          // Text(
                          //   user?.data?.kelas ?? "",
                          //   style: const TextStyle(fontSize: 13),
                          // ),
                          // const SizedBox(
                          //   height: 15,
                          // ),
                          Text(
                            'Sekolah',
                            style: TextStyle(
                                color: Colors.black.withAlpha(66),
                                fontSize: 12),
                          ),
                          Text(
                            user!.data!.userAsalSekolah!,
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 13),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 7,
                                  color: Colors.black.withOpacity(0.25))
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
      ),
    );
  }
}
