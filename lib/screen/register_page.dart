import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:projek_edspert/repository/auth_api.dart';
import 'main_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Gender { lakiLaki, perempuan }

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();

  Decoration containerDecoration = BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
    border: Border.all(color: Colors.grey),
    color: Colors.white,
  );
  String? selectedValue;
  List<String> items = ['10', '11', '12', 'Gap Year', 'Umum'];
  String? gender;

  setGender(Gender type) {
    if (type == Gender.lakiLaki) {
      gender = "Laki-laki";
    } else {
      gender = "Perempuan";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 243, 245),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          shape: RoundedRectangleBorder(
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
      body: Column(
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
                child: const TextField(
                  decoration: InputDecoration(
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
                child: const TextField(
                  decoration: InputDecoration(
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
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
            child: Text('Kelas',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          ),
          DropdownButtonHideUnderline(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: const Color.fromARGB(255, 214, 214, 214),
                        style: BorderStyle.solid,
                        width: 1),
                    borderRadius: BorderRadius.circular(8)),
                child: DropdownButtonFormField2(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  isExpanded: true,
                  hint: const Text(
                    'Pilih kelas',
                    style: TextStyle(fontSize: 14),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                  buttonHeight: 60,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Tolong pilih kelas anda';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    selectedValue = value as String;
                  },
                  onSaved: (value) {
                    selectedValue = value.toString();
                  },
                ),
              ),
            ),
          ),
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
                child: const TextField(
                  decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: "nama sekolah",
                    hintStyle: TextStyle(color: Color(0XFFAAAAAA)),
                  ),
                )),
          ),
          const Spacer(),
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
                  final body = {
                    "user_name": "Edufren",
                    "user_email": "hamul@widyaedu.com",
                    "user_whatsapp": "082255550496",
                    "user_foto":
                        "https://api.widyaedu.com/assets/uploads/avatar/5a57317764486c77636d396d6157786c_emptyprofile.png",
                    "user_propinsi": "Prov. Aceh",
                    "user_kabupaten": "Kab. Aceh Barat",
                    "sosmed": "@widyaedu",
                    "user_prop_sekolah": "Prov. D.I. Yogyakarta",
                    "user_kab_sekolah": "Kab. Sleman",
                    "user_asal_sekolah": "SMA NEGERI 1 MEULABOH",
                    "kelas": "12",
                    "uniqcode": "7552",
                    "referral": "EDUEE2",
                    "date_create": "2022-02-24 08:28:55",
                    "jenjang": "SMA",
                    "user_gender": "Laki-laki",
                    "user_propinsi_id": "060000",
                    "user_prop_sekolah_id": "040000",
                    "user_kab_sekolah_id": "040200",
                    "user_token":
                        "cSEoPSOm50Ovi34p2fDBCm:APA91bF-l0gSL1C3BbZEwj6-BFqH3V-cbxH1Z01EihHMZ60MywOSx-6CaUl-tQ0VzkcOtcUYPX6N90CSMY0BFijOk_fFg6t4gM-xfhrbbDiS-Yqxf28srb1A3-cbWiFZJ5Fks409N6L5",
                    "verified_phone": "true",
                    "user_status": "verified",
                    "apple_id": "empty"
                  };
                  final result = await AuthApi().postRegisterUser(body);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => const MainPage()),
                    ),
                  );
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
    );
  }
}
