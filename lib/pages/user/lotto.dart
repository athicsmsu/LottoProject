import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lotto_application/config/config.dart';
import 'package:lotto_application/models/Req/AddOrderPostReq.dart';
import 'package:lotto_application/models/Res/AddOrderPostRes.dart';
import 'package:lotto_application/models/Res/LottoAllGetRes.dart';
import 'package:lotto_application/pages/login.dart';
import 'package:lotto_application/pages/user/money.dart';
import 'package:lotto_application/pages/widgets/menuUser.dart';
import 'package:lotto_application/shared/app_data.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class LottoPage extends StatefulWidget {
  const LottoPage({super.key});

  @override
  State<LottoPage> createState() => _LottoPageState();
}

class _LottoPageState extends State<LottoPage> {
  GetStorage storage = GetStorage();
  MenuUser menu = const MenuUser();
  TextEditingController numLottoCtl = TextEditingController();
  List<LottoAllGetRes> lottoList = []; // ลิสต์สำหรับเก็บรายการLotto
  late Future<void> loadData;
  String url = '';
  late MemberProfile user;
  String uname = '';
  String status = 'canBuy';

  @override
  void initState() {
    super.initState();
    loadData = loadDataAsync();
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
                          GetStorage storage = GetStorage();
                          storage.erase();
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
                                  color: Color(0xFF000000),
                                  fontFamily: "Prompt",
                                  letterSpacing:
                                      24.0, // ระยะห่างระหว่างตัวเลขแต่ละตัว
                                ),
                                decoration: const InputDecoration(
                                  counterText: '', // ซ่อนตัวนับจำนวนตัวอักษร
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                  border: InputBorder.none, // ไม่มีกรอบใน
                                  filled: true,
                                  fillColor:
                                      Color(0xFFD9D9D9), // สีพื้นหลังของตัวเลข
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(
                                      6), // จำกัดตัวเลขที่ป้อนได้สูงสุด 6 ตัว
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
                              findLotto();
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
                            // ฟังก์ชันเมื่อกดปุ่ม refresh
                            loadDataAsync();
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
                                  'ไม่มีเลขรายการในระบบ',
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
                                .map((lotto) => GestureDetector(
                                      onTap: () {
                                        if (status == 'canBuy') {
                                          dialog(lotto.lotteryId,
                                              lotto.lotteryNumber);
                                        }
                                      },
                                      child: Padding(
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
                                                              left: 40,
                                                              top: 20),
                                                      child: Container(
                                                        width:
                                                            70, // กำหนดขนาดของโลโก้
                                                        height: 70,
                                                        decoration:
                                                            BoxDecoration(
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
                                                              color: Colors
                                                                  .black
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
                                                            color: Color(
                                                                0xFF1E1E1E),
                                                            fontFamily:
                                                                "Prompt",
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
                                                            color: Color(
                                                                0xFF444444),
                                                            fontFamily:
                                                                "Prompt",
                                                            letterSpacing: 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 5,
                                                                vertical: 2.5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xFFDAE924), // สีพื้นหลังของช่องหมายเลข
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      3.0),
                                                        ),
                                                        child: Text(
                                                          lotto.lotteryNumber
                                                              .toString(), // Display the lottery number
                                                          style:
                                                              const TextStyle(
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
                                                            const EdgeInsets
                                                                .only(top: 60),
                                                        child: Image.asset(
                                                          'assets/images/qrcode.png',
                                                          width: 60,
                                                          height: 60,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 70),
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
                                                  borderRadius:
                                                      BorderRadius.only(
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
    var value = await Configuration.getConfig();
    url = value['apiEndpoint'];
    var data = await http.get(Uri.parse('$url/lottery/allnotSold'));
    lottoList = lottoAllGetResFromJson(data.body);
    status = 'canBuy';
    setState(() {});
  }

  void findLotto() async {
    var value = await Configuration.getConfig();
    url = value['apiEndpoint'];
    var data = await http
        .get(Uri.parse('$url/lottery/number?number=${numLottoCtl.text}'));
    if (numLottoCtl.text.isEmpty) {
      loadDataAsync();
    } else if (data.body.isEmpty) {
      lottoList = [];
    } else {
      lottoList = lottoAllGetResFromJson(data.body);
    }
    setState(() {});
  }

  void dialog(int idLotto, int numLotto) {
    if (user.wallet_balance < 80) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // ทำให้มุมโค้งมน
          ),
          title: const Text('ยอดเงินไม่เพียงพอ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000),
                  fontFamily: "Prompt",
                  letterSpacing: 1)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: const Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.cancel,
                        color: Color(0xFFFF3D00), size: 80.0)),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFE84C1B),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'ยกเลิก',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFFFFF),
                          fontFamily: "Prompt",
                          letterSpacing: 1),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF33CA7A),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'เติมเงิน',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFFFFF),
                          fontFamily: "Prompt",
                          letterSpacing: 1),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MoneyPage(),
                          ));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // ทำให้มุมโค้งมน
          ),
          title: const Text('ยืนยันการสั่งซื้อ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000),
                  fontFamily: "Prompt",
                  letterSpacing: 1)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFC6C6C6), // สีพื้นหลังของตัวเลข
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          numLotto.toString(),
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFFFFF),
                              fontFamily: "Prompt",
                              letterSpacing: 5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFE84C1B),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'ยกเลิก',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFFFFF),
                          fontFamily: "Prompt",
                          letterSpacing: 1),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF33CA7A),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'ตกลง',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFFFFF),
                          fontFamily: "Prompt",
                          letterSpacing: 1),
                    ),
                    onPressed: () {
                      status = 'Buy';
                      AddOrder(idLotto);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }

  void AddOrder(int numLotto) async {
    var value = await Configuration.getConfig();
    url = value['apiEndpoint'];
    AddOrderPostReq orderPostReq =
        AddOrderPostReq(lotteryId: numLotto, memberId: user.id);
    var data = await http.post(Uri.parse('$url/Lorder/purchase'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: jsonEncode(orderPostReq));
    var responseBody = addOrderPostResFromJson(data.body);
    if (responseBody.message == 'การสั่งซื้อลอตเตอรี่สำเร็จ') {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text(
            'สำเร็จ',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF139D51),
                fontFamily: "Prompt",
                letterSpacing: 1),
          ),
          content: const Text(
            'ขอให้คุณโชคดี',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E1E),
                fontFamily: "Prompt",
                letterSpacing: 1),
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color(0xFF139D51)), // เปลี่ยนสีพื้นหลังที่นี่
              ),
              child: const Text('ปิด',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                      fontFamily: "Prompt",
                      letterSpacing: 1)),
            ),
          ],
        ),
      );
      user.wallet_balance =
          double.parse((user.wallet_balance - 80).toStringAsFixed(2));
      storage.write('walletBalance', user.wallet_balance);
    } else {
      log(responseBody.message);
    }
    loadDataAsync();
    setState(() {});
  }
}
