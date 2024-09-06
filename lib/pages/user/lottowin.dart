import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lotto_application/pages/login.dart';
import 'package:lotto_application/pages/user/lotto.dart';
import 'package:lotto_application/pages/user/main.dart';
import 'package:lotto_application/pages/user/profile.dart';
import 'package:lotto_application/pages/user/reward.dart';
import 'package:lotto_application/shared/app_data.dart';
import 'package:provider/provider.dart';

class LottoWinPage extends StatefulWidget {
  const LottoWinPage({super.key});

  @override
  State<LottoWinPage> createState() => _LottoWinPageState();
}

class _LottoWinPageState extends State<LottoWinPage> {
  List<String> wonLottoList = []; // ลิสต์สำหรับเก็บรายการที่ถูกรางวัล
  late Future<void> loadData;
  late MemberProfile user;
  
  @override
  void initState() {
    super.initState();
    loadData = loadDataAsync();
    user = context.read<Appdata>().user;
    log(user.id.toString());
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20),
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
                            'รายการเลขที่ขึ้นรางวัลได้',
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
                  FutureBuilder(
                    future: loadData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Column(
                          children: [
                            SizedBox(height: 150),
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                            'เกิดข้อผิดพลาดในการโหลดข้อมูล',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF444444),
                                fontFamily: "Prompt",
                                letterSpacing: 1),
                          ),
                        );
                      } else if (wonLottoList.isEmpty) {
                        return Column(
                          children: [
                            const SizedBox(height: 150),
                            Center(
                              child: Image.asset(
                                'assets/images/box-important.png',
                                width: 100, // กำหนดความกว้างของรูปภาพ
                                height: 100, // กำหนดความสูงของรูปภาพ
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Text(
                                  'ไม่มีรายการที่สามารถขึ้นเงินได้',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF444444),
                                      fontFamily: "Prompt",
                                      letterSpacing: 1),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 100),
                          child: Column(
                            children: wonLottoList
                                .map((wonlotto) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      child: Text(
                                        'รางวัลที่ 5', // แสดงค่าของ winnub จากแต่ละรายการใน WonLottoList
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF1E1E1E),
                                            fontFamily: "Prompt",
                                            letterSpacing: 1),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Container(
                                        width:
                                            400, // Adjust the width according to your needs
                                        height:
                                            155, // Adjust the height according to your needs
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: const Color(
                                                0xFF000000), // Border color
                                            width: 2, // Border width
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                              child: Stack(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/elephant.png', // รูปช้างที่อยู่ด้านหลัง
                                                    width:
                                                        70, // กำหนดขนาดของรูปช้าง
                                                    height: 80,
                                                    fit: BoxFit
                                                        .cover, // ครอบคลุมขนาดของกรอบ
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 40, top: 20),
                                                    child: Container(
                                                      width:
                                                          70, // กำหนดขนาดของโลโก้
                                                      height: 70,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape
                                                            .circle, // กำหนดให้เป็นวงกลม
                                                        border: Border.all(
                                                          color: Colors
                                                              .black, // สีของขอบ
                                                          width:
                                                              2, // ความหนาของขอบ
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5), // สีของเงา
                                                            spreadRadius:
                                                                2, // การกระจายของเงา
                                                            blurRadius:
                                                                5, // ความเบลอของเงา
                                                            offset: const Offset(
                                                                0,
                                                                3), // การขยับของเงา (x, y)
                                                          ),
                                                        ],
                                                        image:
                                                            const DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/LottoLogo.jpg'), // รูปลอตเตอรี่
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 90, left: 20),
                                                    child: Text(
                                                      '80',
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Color(0xFF1E1E1E),
                                                          fontFamily: "Prompt",
                                                          letterSpacing: 1),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 110, left: 20),
                                                    child: Text(
                                                      'บาท',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Color(0xFF444444),
                                                          fontFamily: "Prompt",
                                                          letterSpacing: 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 5,
                                                          vertical: 2.5),
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFFDAE924), // สีพื้นหลังของช่องหมายเลข
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3.0),
                                                      ),
                                                      child: Text(
                                                        wonlotto, // Display the lottery number
                                                        style: const TextStyle(
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          letterSpacing: 10.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 60),
                                                      child: Image.asset(
                                                        'assets/images/qrcode.png',
                                                        width: 60,
                                                        height: 60,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 70),
                                                      child: Image.asset(
                                                        'assets/images/animal.png',
                                                        width:
                                                            150, // Adjust the size according to your needs
                                                        height:
                                                            150, // Adjust the size according to your needs
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 90,left: 75),
                                                      child: FilledButton(
                                                        onPressed: () =>
                                                            claimlotto(),
                                                        style: ButtonStyle(
                                                          minimumSize:
                                                              MaterialStateProperty
                                                                  .all(const Size(
                                                                      100,
                                                                      30)), // กำหนดขนาดของปุ่ม
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(const Color(
                                                                      0xFF005A24)), // สีพื้นหลังของปุ่ม
                                                          shape:
                                                              MaterialStateProperty
                                                                  .all(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25.0), // ทำให้ขอบมน
                                                              side:
                                                                  const BorderSide(
                                                                color: Color(
                                                                    0xFF00A94F), // กำหนดสีขอบเป็น #00A94F
                                                                width:
                                                                    2.0, // ความหนาของขอบ
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          'ขึ้นรางวัล',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Color(0xFFFFFFFF),
                                                            fontFamily: "Prompt",
                                                            letterSpacing: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width:
                                                  40, // Adjust according to your needs
                                              decoration: const BoxDecoration(
                                                color: Color(0xFF005A24),
                                                borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(6.0),
                                                  bottomRight:
                                                      Radius.circular(6.0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )).toList(),
                          ),
                        );
                      }
                    },
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
                              builder: (context) => MainUserPage(),
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
                      const Column(
                        children: [
                          Icon(
                            Icons.attach_money,
                            size: 40,
                            color: Color(0xFF54B799),
                          ),
                          Text(
                            'ขึ้นเงิน',
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

  Future<void> loadDataAsync() async {
    await Future.delayed(const Duration(seconds: 2));
    // var value = await Configuration.getConfig();
    // url = value['apiEndpoint'];
    // //call api /trips
    // var data = await http.get(Uri.parse('$url/users/${widget.idx}'));
    // trip = tripGetByIdResponseFromJson(data.body);
    wonLottoList.add("145874");
    // purchaseList.add("145874");
    // purchaseList.add("145874");
  }

  claimlotto() {
    log('claim');
  }
}
