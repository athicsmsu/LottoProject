import 'package:flutter/material.dart';
import 'package:lotto_application/pages/login.dart';
import 'package:lotto_application/pages/widgets/menuUser.dart';
import 'package:lotto_application/shared/app_data.dart';
import 'package:provider/provider.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({super.key});

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  MenuUser menu = const MenuUser();
  late Future<void> loadData;
  late MemberProfile user;

  @override
  void initState() {
    super.initState();
    user = context.read<Appdata>().user;
  }
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
          menu,
        ]),
      ),
    );
  }
}
