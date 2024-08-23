import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lotto_application/pages/login.dart';
import 'package:lotto_application/pages/user/cash.dart';
import 'package:lotto_application/pages/user/lotto.dart';
import 'package:lotto_application/pages/user/money.dart';
import 'package:lotto_application/pages/user/mylotto.dart';
import 'package:lotto_application/pages/user/profile.dart';
import 'package:lotto_application/pages/user/reward.dart';

class MainUserPage extends StatefulWidget {
  const MainUserPage({super.key});

  @override
  State<MainUserPage> createState() => _MainUserPageState();
}

class _MainUserPageState extends State<MainUserPage> {
  int numnews = 1;
  String nummoney = '21.00';
  String hideMoneytxt = 'ซ่อนยอดเงิน';
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // colorScheme: const ColorScheme.light(
        //   primary: Color(0xFF024B3F), // สีหลักของธีม
        //   onPrimary: Colors.white, // สีของข้อความบนสีหลัก
        // ),
        // useMaterial3: true,
        appBarTheme: const AppBarTheme(
          color: Color(0xFF024B3F), // สีพื้นหลังของ AppBar
          titleTextStyle: TextStyle(
            color: Colors.white, // สีของข้อความใน AppBar
            fontSize: 20,
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFF024B3F),
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Container(
              width: 50, // กำหนดความกว้าง
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFD9D9D9), // สีของกรอบ
                  width: 5, // ความหนาของกรอบ
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  // ฟังก์ชันเมื่อกดปุ่ม back
                  log("profile");
                },
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/LottoLogo.jpg',
                    width: 40, // กำหนดความกว้างของรูปภาพ
                    height: 40, // กำหนดความสูงของรูปภาพ
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.power_settings_new,
                color: Colors.white,
                size: 40,
              ), // ปุ่มที่อยู่ขวามือ
              onPressed: () {
                // ฟังก์ชันเมื่อกดปุ่ม settings
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ));
              },
            ),
          ],
        ),
        body: Stack(children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.chevron_left_outlined,
                            color: Colors.white,
                            size: 60,
                          ), // ปุ่มที่อยู่ขวามือ
                          onPressed: () {
                            // ฟังก์ชันเมื่อกดปุ่ม settings
                            if (numnews > 1) {
                              numnews = numnews - 1;
                            }
                            setState(() {});
                          },
                        ),
                        Container(
                          width: 290, // กำหนดความกว้างของ Container
                          height: 200, // กำหนดความสูงของ Container
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(16.0), // ทำให้ขอบมน
                            // สามารถเพิ่มสีพื้นหลังหรือลักษณะขอบได้หากต้องการ
                          ),
                          clipBehavior: Clip
                              .hardEdge, // ใช้เพื่อให้รูปภาพถูกครอบตามขอบมนของ Container
                          child: ClipRect(
                            child: Image.asset(
                              'assets/images/news$numnews.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.chevron_right_outlined,
                            color: Colors.white,
                            size: 60,
                          ), // ปุ่มที่อยู่ขวามือ
                          onPressed: () {
                            // ฟังก์ชันเมื่อกดปุ่ม settings
                            if (numnews < 3) {
                              numnews = numnews + 1;
                            }
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        width: 10, // กำหนดความกว้างของ Container
                        height: 40, // กำหนดความสูงของ Container
                        color: const Color(0xFF54B799), // กำหนดสีพื้นหลัง
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'เช็คยอดเงิน',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: "Prompt",
                              letterSpacing: 1),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Container(
                    width: 400, // กำหนดความกว้างของ Container
                    height: 70, // กำหนดความสูงของ Container
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0), // ทำให้ขอบมน
                      color: const Color(0xFFD9D9D9), // กำหนดสีพื้นหลัง
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.5, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ยงยอด แสนดี',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF555555),
                                    fontFamily: "Prompt",
                                    letterSpacing: 1),
                              ),
                              Text(
                                '089-76X-XXXX',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF777777),
                                    fontFamily: "Prompt",
                                    letterSpacing: 1),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                nummoney,
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E1E1E),
                                    fontFamily: "Prompt",
                                    letterSpacing: 1),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (nummoney != "XX.XX") {
                                    nummoney = "XX.XX";
                                    hideMoneytxt = "ดูยอดเงิน";
                                  } else {
                                    nummoney = "21.00";
                                    hideMoneytxt = "ซ่อนยอดเงิน";
                                  }
                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      hideMoneytxt,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF00A950),
                                          fontFamily: "Prompt",
                                          letterSpacing: 1),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(Icons.remove_red_eye_outlined,
                                        color: Color(0xFF00A950))
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MoneyPage(),
                            ));
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            const Size(125, 50)), // กำหนดขนาดของปุ่ม
                        backgroundColor: MaterialStateProperty.all(
                            const Color(0xFF139D51)), // สีพื้นหลังของปุ่ม
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // ทำให้ขอบมน
                        )),
                      ),
                      child: const Text('เติมเงิน',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFFFFF),
                              fontFamily: "Prompt",
                              letterSpacing: 1))),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    children: [
                      Container(
                        width: 10, // กำหนดความกว้างของ Container
                        height: 40, // กำหนดความสูงของ Container
                        color: const Color(0xFF54B799), // กำหนดสีพื้นหลัง
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyLottoPage(),
                              ));
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'รายการของคุณ',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: "Prompt",
                                letterSpacing: 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyLottoPage(),
                              ));
                        },
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/LottoLogo.jpg',
                            width: 70, // กำหนดความกว้างของรูปภาพ
                            height: 70, // กำหนดความสูงของรูปภาพ
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Container(
                        width:
                            70, // กำหนดขนาดของ Container (เช่น ขนาดเดียวกับ ClipOval)
                        height: 70,
                        decoration: BoxDecoration(
                          color: const Color(0xFF54B799).withOpacity(
                              0.5), // สีพื้นหลังใส (0.5 คือความโปร่งใส)
                          shape: BoxShape.circle, // ทำให้ Container มีขอบมน
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LottoPage(),
                                ));
                          },
                          child: ClipOval(
                            child: Icon(
                              Icons.add,
                              color: Colors.white.withOpacity(0.5),
                              size: 60,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 2.5),
              width: 400,
              height: 70,
              decoration: const BoxDecoration(
                color: Color(0xFFD9D9D9), // สีพื้นหลัง
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ), // ขอบมนที่ด้านบน
              ),
              child: Stack(
                clipBehavior:
                    Clip.none, // อนุญาตให้มีการวางซ้อนออกนอกขอบ Container
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        children: [
                          Icon(
                            Icons.home,
                            size: 40,
                            color: Color(0xFF54B799),
                          ),
                          Text(
                            'หน้าหลัก',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF54B799),
                                fontFamily: "Prompt",
                                letterSpacing: 1),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RewardPage(),
                            ),
                          );
                        },
                        child: const Column(
                          children: [
                            Icon(
                              Icons.emoji_events,
                              size: 40,
                              color: Color(0xFF555555),
                            ),
                            Text(
                              'รางวัล',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF555555),
                                  fontFamily: "Prompt",
                                  letterSpacing: 1),
                            ),
                          ],
                        ),
                      ),
                      // ช่องว่างสำหรับตรงกลาง
                      const SizedBox(
                          width: 80), // เว้นช่องว่างตรงกลางสำหรับไอคอนใหญ่
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CashPage(),
                            ),
                          );
                        },
                        child: const Column(
                          children: [
                            Icon(
                              Icons.attach_money,
                              size: 40,
                              color: Color(0xFF555555),
                            ),
                            Text(
                              'ขึ้นเงิน',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF555555),
                                  fontFamily: "Prompt",
                                  letterSpacing: 1),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfilePage(),
                            ),
                          );
                        },
                        child: const Column(
                          children: [
                            Icon(
                              Icons.person,
                              size: 40,
                              color: Color(0xFF555555),
                            ),
                            Text(
                              'โปรไฟล์',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF555555),
                                  fontFamily: "Prompt",
                                  letterSpacing: 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: -40, // วางตำแหน่งไอคอนให้อยู่เหนือขอบของ Container
                    left: 140, // ปรับตำแหน่งเพื่อให้ไอคอนอยู่ตรงกลาง
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LottoPage(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF777777),
                          border: Border.all(
                            color: const Color(0xFF666666),
                            width: 5, // ขนาดของเส้นขอบ
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(15), // ระยะห่างจากขอบไอคอน
                          child: Icon(
                            Icons.local_activity_sharp,
                            size: 50,
                            color:
                                Color(0xFFFFFFFF), // เปลี่ยนสีของไอคอนได้ที่นี่
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
