import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lotto_application/pages/login.dart';
import 'package:lotto_application/pages/user/lottowin.dart';
import 'package:lotto_application/pages/user/main.dart';
import 'package:lotto_application/pages/user/profile.dart';
import 'package:lotto_application/pages/user/reward.dart';
import 'package:lotto_application/shared/app_data.dart';
import 'package:provider/provider.dart';

class LottoPage extends StatefulWidget {
  const LottoPage({super.key});

  @override
  State<LottoPage> createState() => _LottoPageState();
}

class _LottoPageState extends State<LottoPage> {

  TextEditingController numLottoCtl = TextEditingController();
  List<String> lottoList = []; // ลิสต์สำหรับเก็บรายการสั่งซื้อ
  late Future<void> loadData;
  late MemberProfile user;
  String uname = '';

  @override
  void initState() {
    //super.initState();
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
                      color: const Color(0xFF00A94F), // พื้นหลังสีเขียว
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
                              child: TextField(
                                controller: numLottoCtl,
                                maxLength: 6,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing:
                                      24.0, // ระยะห่างระหว่างตัวเลขแต่ละตัว
                                ),
                                decoration: const InputDecoration(
                                  counterText: '', // ซ่อนตัวนับจำนวนตัวอักษร
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                  border: InputBorder.none, // ไม่มีกรอบใน
                                  filled: true,
                                  fillColor: Color(
                                      0xFFD9D9D9), // สีพื้นหลังของตัวเลข
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(6), // จำกัดตัวเลขที่ป้อนได้สูงสุด 6 ตัว
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
                            icon: const Icon(
                              Icons.search,
                              color: Color(0xFF00A94F),
                              size: 30,
                            ),
                            onPressed: () {
                              // ฟังก์ชันค้นหา
                              log('num lotto : ${numLottoCtl.text}');
                              setState(() {
                                
                              });
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                        IconButton(
                          icon: const Icon(
                            Icons.refresh_rounded,
                            color: Color(0xFF444444),
                            size: 40,
                          ),
                          onPressed: () {
                            // ฟังก์ชันเมื่อกดปุ่ม settings
                           log('refresh lotto list');
                          },
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
                      } else if (lottoList.isEmpty) {
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
                                  'ยังไม่มีรายการเลขในระบบ',
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
                            children: lottoList
                                .map((purchase) => Padding(
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
                                                        purchase, // Display the lottery number
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
                                    ))
                                .toList(),
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
                              builder: (context) => const LottoWinPage(),
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
  Future<void> loadDataAsync() async {
    await Future.delayed(const Duration(seconds: 2));
    // var value = await Configuration.getConfig();
    // url = value['apiEndpoint'];
    // //call api /trips
    // var data = await http.get(Uri.parse('$url/users/${widget.idx}'));
    // trip = tripGetByIdResponseFromJson(data.body);
    lottoList.add("145874");
    lottoList.add("145875");
    // purchaseList.add("145874");
    // purchaseList.add("145874");
  }
}
