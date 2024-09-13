import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lotto_application/config/config.dart';
import 'package:lotto_application/models/Res/LottoAllGetRes.dart';
import 'package:lotto_application/pages/widgets/menuUser.dart';
import 'package:lotto_application/shared/app_data.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MyLottoPage extends StatefulWidget {
  const MyLottoPage({super.key});

  @override
  State<MyLottoPage> createState() => _MyLottoPageState();
}

class _MyLottoPageState extends State<MyLottoPage> {
  MenuUser menu = const MenuUser();
  List<LottoAllGetRes> purchaseList = []; // ลิสต์สำหรับเก็บรายการสั่งซื้อ
  late Future<void> loadData;
  String url = '';
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
          preferredSize: const Size.fromHeight(200.0), // ปรับความสูงของ AppBar
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(16.0), // ปรับขอบให้มนที่มุมล่าง
            ),
            child: AppBar(
              automaticallyImplyLeading: false, // ปิดการแสดงผล leading default
              flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .min, // ปรับขนาดของ Row ให้พอดีกับเนื้อหาภายใน
                      children: [
                        Container(
                          width: 90, // กำหนดความกว้าง
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFD9D9D9), // สีของกรอบ
                              width: 5, // ความหนาของกรอบ
                            ),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              user.image,
                              width: 80, // กำหนดความกว้างของรูปภาพ
                              height: 80, // กำหนดความสูงของรูปภาพ
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'คุณ ${user.fullname}',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF54B799),
                                  fontFamily: "Prompt",
                                  letterSpacing: 1),
                            ),
                            Text(
                              '${user.wallet_balance} บาท',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFD9D9D9),
                                  fontFamily: "Prompt",
                                  letterSpacing: 1),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(), // เพิ่มระยะห่างด้านล่างของ Container
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
                            'เลขรายการของคุณทั้งหมด',
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
                          child: Column(
                            children: [
                              SizedBox(height: 150),
                              Text(
                                'เกิดข้อผิดพลาดในการโหลดข้อมูล',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF444444),
                                    fontFamily: "Prompt",
                                    letterSpacing: 1),
                              ),
                            ],
                          ),
                        );
                      } else if (purchaseList.isEmpty) {
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
                                  'คุณยังไม่มีรายการที่ซื้อ',
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
                            children: purchaseList
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
                                                        purchase.lotteryNumber.toString(), // Display the lottery number
                                                        style: const TextStyle(
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          letterSpacing: 2.5,
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
          menu,
        ]),
      ),
    );
  }

  Future<void> loadDataAsync() async {
    await Future.delayed(const Duration(seconds: 1));
    var value = await Configuration.getConfig();
    url = value['apiEndpoint'];
    var data = await http.get(Uri.parse('$url/lottery/allnotClaim?id=${user.id}'));
    purchaseList = lottoAllGetResFromJson(data.body);
  }
}
