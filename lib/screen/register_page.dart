import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'main_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  bool isMan = false;
  bool isGirl = false;
  Color _colorContainer = Colors.white;
  String? selectedValue;
  List<String> items = [
    'Items 1',
    'Items 2',
    'Items 3',
    'Items 4',
  ];

  Decoration containerDecoration = BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
    border: Border.all(color: Colors.grey),
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 243, 245),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Yuk isi data diri',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 20,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.white,
              )),
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
                  child: InkWell(
                    onTap: () {
                      isMan = true;
                      setState(() {
                        if (isMan = true) {
                          _colorContainer = _colorContainer == Colors.white
                              ? Colors.blue
                              : Colors.white;
                        } else {
                          _colorContainer = Colors.white;
                        }
                      });
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: _colorContainer,
                            border: Border.all(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 1),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text(
                              'Laki-laki',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        )),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      isMan = false;
                      isGirl = true;
                      if (isGirl = true) {
                        setState(() {
                          _colorContainer = _colorContainer == Colors.white
                              ? Colors.blue
                              : Colors.white;
                        });
                      }
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: _colorContainer,
                            border: Border.all(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 1),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text(
                              'Perempuan',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        )),
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
                onPressed: () {
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
