import 'package:flutter/material.dart';

import 'discussion_page.dart';
import 'home_page.dart';
import 'profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pc = PageController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          child: Image.asset(
            "assets/img/ic_discuss.png",
            height: 40,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const DiscussionPage(),
              ),
            );
          }),
      bottomNavigationBar: _buildBottomNavigation(),
      body: PageView(
        controller: _pc,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomePage(),
          ProfilePage(),
        ],
      ),
    );
  }

  Container _buildBottomNavigation() {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.grey,
            offset: Offset(
              0,
              -2,
            ),
          )
        ],
      ),
      child: BottomAppBar(
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      index = 0;
                      setState(() {});
                      _pc.animateToPage(
                        0,
                        curve: Curves.easeInOut,
                        duration: const Duration(microseconds: 1),
                      );
                      setState(() {});
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/img/ic_home.png",
                          height: 20,
                          color: index == 0 ? null : Colors.grey,
                        ),
                        const Text(
                          'Beranda',
                          style: TextStyle(
                            // color: MrtColors.mrtBlueColor,
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: null,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/img/ic_discuss.png",
                        height: 20,
                      ),
                      const Text(
                        'Diskusi',
                        style: TextStyle(
                          // color: MrtColors.mrtBlueColor,
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      index = 1;
                      setState(() {});
                      _pc.animateToPage(
                        1,
                        curve: Curves.easeInOut,
                        duration: const Duration(microseconds: 1),
                      );
                      setState(() {});
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/img/ic_profile.png",
                          color: index == 1 ? null : Colors.grey,
                        )
                        // color: MrtColors.mrtBlueColor,
                        ,
                        const Text(
                          'Profil',
                          style: TextStyle(
                              // color: MrtColors.mrtBlueColor,
                              fontSize: 13),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // shape: CircularNotchedRectangle(),
      ),
    );
  }
}
