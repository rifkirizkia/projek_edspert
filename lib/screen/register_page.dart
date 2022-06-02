import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:projek_edspert/helpers/user_email.dart';
import 'package:projek_edspert/models/data_by_user_email.dart';
import 'package:projek_edspert/models/network_response.dart';
import 'package:projek_edspert/repository/auth_api.dart';
import '../helpers/preference_helper.dart';
import 'main_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Gender { lakiLaki, perempuan }

class _RegisterPageState extends State<RegisterPage> {
  final fullNameController = TextEditingController();
  final schoolController = TextEditingController();
  final bool enabled = true;
  final emailController = TextEditingController();

  Decoration containerDecoration = BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
    border: Border.all(color: Colors.grey),
    color: Colors.white,
  );
  // String? selectedValue;
  // List<String> kelas = ['10', '11', '12', 'Gap Year', 'Umum'];
  String? gender;

  setGender(Gender type) {
    if (type == Gender.lakiLaki) {
      gender = "Laki-laki";
    } else {
      gender = "Perempuan";
    }
    setState(() {});
  }

  initDataUser() {
    emailController.text = UserEmail.getUserEmail()!;
    fullNameController.text = UserEmail.getUserDisplayName()!;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 243, 245),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0))),
          backgroundColor: Colors.white,
          title: const Text(
            'Yuk isi data diri',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: containerDecoration,
                  child: TextField(
                    enabled: false,
                    controller: emailController,
                    decoration: const InputDecoration(
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      hintText: "Email Anda",
                      hintStyle: TextStyle(color: Color(0XFFAAAAAA)),
                    ),
                  )),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Text('Nama lengkap',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: containerDecoration,
                  child: TextField(
                    controller: fullNameController,
                    decoration: const InputDecoration(
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      hintText: "Contoh: Rifki Rizkia",
                      hintStyle: TextStyle(color: Color(0XFFAAAAAA)),
                    ),
                  )),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Text('Jenis kelamin',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: gender == "Laki-laki"
                                ? const Color(0XFF3A7FD5)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                  width: 1,
                                  color: gender == "Laki-laki"
                                      ? const Color(0XFF3A7FD5)
                                      : const Color(0xffd6d6d6)),
                            ),
                          ),
                          onPressed: () {
                            setGender(Gender.lakiLaki);
                          },
                          child: Text(
                            "Laki-laki",
                            style: TextStyle(
                                color: gender == "Laki-laki"
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ))),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: gender == "Perempuan"
                            ? const Color(0XFF3A7FD5)
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                                width: 1,
                                color: gender == "Perempuan"
                                    ? const Color(0XFF3A7FD5)
                                    : const Color(0xffd6d6d6))),
                      ),
                      onPressed: () {
                        setGender(Gender.perempuan);
                      },
                      child: Text(
                        "Perempuan",
                        style: TextStyle(
                            color: gender == "Perempuan"
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
            //   child: Text('Kelas',
            //       style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //   child: Container(
            //     width: double.infinity,
            //     padding: const EdgeInsets.only(left: 20),
            //     decoration: BoxDecoration(
            //         color: Colors.white,
            //         border: Border.all(
            //             color: const Color.fromARGB(255, 214, 214, 214),
            //             style: BorderStyle.solid,
            //             width: 1),
            //         borderRadius: BorderRadius.circular(8)),
            //     child: DropdownButtonHideUnderline(
            //       child: DropdownButton<String>(
            //           value: selectedValue,
            //           items: kelas
            //               .map(
            //                 (e) => DropdownMenuItem<String>(
            //                   child: Text(e),
            //                   value: e,
            //                 ),
            //               )
            //               .toList(),
            //           onChanged: (String? val) {
            //             selectedValue = val!;
            //             setState(() {});
            //           }),
            //     ),
            //   ),
            // ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Text(
                'Nama sekolah',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: containerDecoration,
                  child: TextField(
                    controller: schoolController,
                    decoration: const InputDecoration(
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      hintText: "nama sekolah",
                      hintStyle: TextStyle(color: Color(0XFFAAAAAA)),
                    ),
                  )),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: const Color.fromARGB(255, 58, 127, 213),
                    fixedSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () async {
                    final json = {
                      "email": emailController.text,
                      "nama_lengkap": fullNameController.text,
                      "nama_sekolah": schoolController.text,
                      "kelas": "10",
                      "gender": gender,
                      "foto": UserEmail.getUserPhotoUrl()
                    };
                    print("hasil user");
                    print(json);
                    print("");
                    final result = await AuthApi().postRegisterUser(json);
                    if (result.status == Status.success) {
                      final registerResult =
                          DataUserByEmail.fromJson(result.data!);
                      if (registerResult.status == 1) {
                        await PreferenceHelper().setUserData(registerResult);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: ((context) => const MainPage()),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(registerResult.message!),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Terjadi kesalahan, silahkan ulangi"),
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Daftar',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )
                    ],
                  )),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
