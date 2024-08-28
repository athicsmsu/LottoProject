import 'package:flutter/material.dart';
import 'package:lotto_application/pages/login.dart';
import 'package:lotto_application/pages/user/cash.dart';
import 'package:lotto_application/pages/user/main.dart';
import 'package:lotto_application/pages/user/profile.dart';
import 'package:lotto_application/pages/user/reward.dart';

class LottoPage extends StatefulWidget {
  const LottoPage({super.key});

  @override
  State<LottoPage> createState() => _LottoPageState();
}

class _LottoPageState extends State<LottoPage> {
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
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(230.0), // ปรับความสูงของ AppBar
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(16.0), // ปรับขอบให้มนที่มุมล่าง
            ),
            child: AppBar(
              automaticallyImplyLeading: false, // ปิดการแสดงผล leading default
              flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 30),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                          child: const Align(
                            alignment: Alignment.topLeft,
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 38.0,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.power_settings_new,
                          color: Colors.white,
                          size: 40,
                        ),
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 20),
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
                            'ค้นหา',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF),
                                fontFamily: "Prompt",
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 80.0, // ปรับความสูงของ Container ตามต้องการ
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFF00A94F), // พื้นหลังสีเขียว
                      borderRadius: BorderRadius.circular(8.0), // มุมโค้งมน
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: 55,
                              margin: const EdgeInsets.all(8.0), // ระยะห่างรอบๆ
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: const Color(
                                    0xFFD9D9D9), // สีพื้นหลังของตัวเลข
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: const Color(0xFF005A24), // สีกรอบ
                                  width: 5.0, // ความหนาของกรอบ
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Text('1',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  Text('4',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  Text('5',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  Text('8',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  Text('7',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  Text('4',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.white, // สีพื้นหลังของไอคอนค้นหา
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.search, color: Color(0xFF00A94F),size: 30,),
                            onPressed: () {
                              // ฟังก์ชันค้นหา
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Stack(children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
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
                            'รายการเลขที่ซื้อได้',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF444444),
                                fontFamily: "Prompt",
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainUserPage(),
                            ),
                          );
                        },
                        child: const Column(
                          children: [
                            Icon(
                              Icons.home,
                              size: 40,
                              color: Color(0xFF555555),
                            ),
                            Text(
                              'หน้าหลัก',
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
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF54B799),
                        border: Border.all(
                          color: const Color(0xFF125B4D),
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
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
