import 'package:flutter/material.dart';
import 'package:lotto_application/pages/login.dart';
import 'package:lotto_application/pages/user/drawer.dart';
import 'package:lotto_application/pages/user/lotto.dart';
import 'package:lotto_application/pages/user/main.dart';
import 'package:lotto_application/pages/user/profile.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({super.key});

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
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
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: GestureDetector(
              onTap: () {
                // ฟังก์ชันเมื่อกดปุ่ม back
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 38.0,
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
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
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
                          'เลขรางวัล',
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF54B799), // สีพื้นหลังสีเขียว
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Icon(
                          Icons.emoji_events, // ไอคอนของเหรียญรางวัล
                          size: 55.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                          width:
                              10.0), // ระยะห่างระหว่างไอคอนกับหมายเลขรางวัล
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color:
                                  const Color(0xFFD9D9D9), // สีพื้นหลังของช่องหมายเลข
                              borderRadius: BorderRadius.circular(3.0),
                              border: Border.all(
                                color: const Color(0xFF139D51), // สีขอบของช่องหมายเลข
                                width: 10.0,
                              ),
                            ),
                            child: Row(
                              children: [
                                for (var digit in "167892".split(''))
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Text(
                                      digit,
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1E1E1E),
                                          fontFamily: "Prompt",
                                          letterSpacing: 1),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Text(
                              'เงินรางวัล 5,000 บาท',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E1E1E),
                                  fontFamily: "Prompt",
                                  letterSpacing: 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 70,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color:
                              const Color(0xFF54B799), // สีพื้นหลังสีเขียว
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Center(
                          child: Text(
                            '2',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF),
                                fontFamily: "Prompt",
                                letterSpacing: 1),
                          ),
                        ),
                      ),
                      const SizedBox(
                          width:
                              10.0), // ระยะห่างระหว่างไอคอนกับหมายเลขรางวัล
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color: const Color(
                                  0xFFD9D9D9), // สีพื้นหลังของช่องหมายเลข
                              borderRadius: BorderRadius.circular(3.0),
                              border: Border.all(
                                color: const Color(
                                    0xFF139D51), // สีขอบของช่องหมายเลข
                                width: 10.0,
                              ),
                            ),
                            child: Row(
                              children: [
                                for (var digit in "167892".split(''))
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Text(
                                      digit,
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1E1E1E),
                                          fontFamily: "Prompt",
                                          letterSpacing: 1),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Text(
                              'เงินรางวัล 4,000 บาท',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E1E1E),
                                  fontFamily: "Prompt",
                                  letterSpacing: 1),
                            ),
                          ),
                          
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 70,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color:
                              const Color(0xFF54B799), // สีพื้นหลังสีเขียว
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Center(
                          child: Text(
                            '3',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF),
                                fontFamily: "Prompt",
                                letterSpacing: 1),
                          ),
                        ),
                      ),
                      const SizedBox(
                          width:
                              10.0), // ระยะห่างระหว่างไอคอนกับหมายเลขรางวัล
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color: const Color(
                                  0xFFD9D9D9), // สีพื้นหลังของช่องหมายเลข
                              borderRadius: BorderRadius.circular(3.0),
                              border: Border.all(
                                color: const Color(
                                    0xFF139D51), // สีขอบของช่องหมายเลข
                                width: 10.0,
                              ),
                            ),
                            child: Row(
                              children: [
                                for (var digit in "167892".split(''))
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Text(
                                      digit,
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1E1E1E),
                                          fontFamily: "Prompt",
                                          letterSpacing: 1),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Text(
                              'เงินรางวัล 3,000 บาท',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E1E1E),
                                  fontFamily: "Prompt",
                                  letterSpacing: 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 70,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color:
                              const Color(0xFF54B799), // สีพื้นหลังสีเขียว
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Center(
                          child: Text(
                            '4',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF),
                                fontFamily: "Prompt",
                                letterSpacing: 1),
                          ),
                        ),
                      ),
                      const SizedBox(
                          width:
                              10.0), // ระยะห่างระหว่างไอคอนกับหมายเลขรางวัล
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color: const Color(
                                  0xFFD9D9D9), // สีพื้นหลังของช่องหมายเลข
                              borderRadius: BorderRadius.circular(3.0),
                              border: Border.all(
                                color: const Color(
                                    0xFF139D51), // สีขอบของช่องหมายเลข
                                width: 10.0,
                              ),
                            ),
                            child: Row(
                              children: [
                                for (var digit in "167892".split(''))
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Text(
                                      digit,
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1E1E1E),
                                          fontFamily: "Prompt",
                                          letterSpacing: 1),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Text(
                              'เงินรางวัล 2,000 บาท',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E1E1E),
                                  fontFamily: "Prompt",
                                  letterSpacing: 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 70,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color:
                              const Color(0xFF54B799), // สีพื้นหลังสีเขียว
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Center(
                          child: Text(
                            '5',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF),
                                fontFamily: "Prompt",
                                letterSpacing: 1),
                          ),
                        ),
                      ),
                      const SizedBox(
                          width:
                              10.0), // ระยะห่างระหว่างไอคอนกับหมายเลขรางวัล
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color: const Color(
                                  0xFFD9D9D9), // สีพื้นหลังของช่องหมายเลข
                              borderRadius: BorderRadius.circular(3.0),
                              border: Border.all(
                                color: const Color(
                                    0xFF139D51), // สีขอบของช่องหมายเลข
                                width: 10.0,
                              ),
                            ),
                            child: Row(
                              children: [
                                for (var digit in "167892".split(''))
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Text(
                                      digit,
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1E1E1E),
                                          fontFamily: "Prompt",
                                          letterSpacing: 1),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Text(
                              'เงินรางวัล 1,000 บาท',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E1E1E),
                                  fontFamily: "Prompt",
                                  letterSpacing: 1),
                            ),
                          ),
                        ],
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
                      const Column(
                        children: [
                          Icon(
                            Icons.emoji_events,
                            size: 40,
                            color: Color(0xFF54B799),
                          ),
                          Text(
                            'รางวัล',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF54B799),
                                fontFamily: "Prompt",
                                letterSpacing: 1),
                          ),
                        ],
                      ),
                      // ช่องว่างสำหรับตรงกลาง
                      const SizedBox(
                          width: 80), // เว้นช่องว่างตรงกลางสำหรับไอคอนใหญ่
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DrawerPage(),
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
