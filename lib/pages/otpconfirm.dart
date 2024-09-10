import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lotto_application/config/config.dart';
import 'package:lotto_application/models/Res/MemberCheckGetRes.dart';
import 'package:lotto_application/pages/changepassword.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_application/shared/app_data.dart';
import 'package:provider/provider.dart';

class OtpConfirmPage extends StatefulWidget {
  const OtpConfirmPage({super.key});

  @override
  State<OtpConfirmPage> createState() => _OtpConfirmPageState();
}

class _OtpConfirmPageState extends State<OtpConfirmPage> {
  TextEditingController otpCtl = TextEditingController();
  List<MemberCheckGetRes> users = [];
  MemberProfile user = MemberProfile();
  late Future<void> loadData;
  String url = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Configuration.getConfig().then(
      (value) {
        url = value['apiEndpoint'];
        log(url);
      },
    ).catchError(
      (error) {
        log(error);
      },
    );
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
      home: PopScope(
        onPopInvoked: (didPop) {
          log('user');
          user.id = 0;
          context.read<Appdata>().user = user; //อันตรายห้ามลืม
        },
        child: Scaffold(
          backgroundColor: const Color(0xFF024B3F),
          appBar: AppBar(
              leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 38.0,
            ), // ปุ่ม back
            onPressed: () {
              // ฟังก์ชันเมื่อกดปุ่ม back
              Navigator.of(context).pop();
              user.id = 0;
              context.read<Appdata>().user = user; //อันตรายห้ามลืม
            },
          )),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 195, horizontal: 25),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 44),
                    child: Text(
                      "ยืนยันตัวตน",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: "Prompt",
                          letterSpacing: 1),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Text(
                          'กรอกรหัสที่ส่งไปยังอีเมลของคุณ',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: "Prompt",
                              letterSpacing: 1),
                        ),
                      ),
                      TextField(
                        controller: otpCtl,
                        keyboardType: TextInputType.emailAddress,
                        textAlign:
                            TextAlign.center, // จัดข้อความให้ตรงกลางแนวนอน
                        textAlignVertical: TextAlignVertical
                            .center, // จัดข้อความให้ตรงกลางแนวตั้ง
                        style: const TextStyle(
                          fontFamily:
                              'Prompt', // เปลี่ยนฟอนต์ของข้อความใน TextField
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFD9D9D9),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0))),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 42, vertical: 42),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  user.id = 0;
                                  context.read<Appdata>().user =
                                      user; //อันตรายห้ามลืม
                                  Navigator.of(context).pop();
                                },
                                child: const Text('ยกเลิก',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF54B799),
                                        fontFamily: "Prompt",
                                        letterSpacing: 1))),
                            FilledButton(
                                onPressed: () => OtpConfirm(),
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(160, 44)), // กำหนดขนาดของปุ่ม
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(
                                          0xFF139D51)), // สีพื้นหลังของปุ่ม
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        25.0), // ทำให้ขอบมน
                                  )),
                                ),
                                child: const Text('ยืนยัน',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFFFFFFF),
                                        fontFamily: "Prompt",
                                        letterSpacing: 1))),
                          ],
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        resend();
                      },
                      child: const Text('ส่งอีกครั้ง',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFFFFF),
                            fontFamily: "Prompt",
                            letterSpacing: 1,
                          ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  OtpConfirm() {
    if (otpCtl.text == 'OTP') {
      log("confirm");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChangePasswordPage(),
          ));
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'ผิดพลาด',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE84C1B),
                fontFamily: "Prompt",
                letterSpacing: 1),
          ),
          content: const Text(
            'รหัสไม่ถูกต้อง',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF000000),
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
    }
  }

  void resend() {
    log("resend");
  }

  Future<void> loadDataAsync() async {
    var value = await Configuration.getConfig();
    url = value['apiEndpoint'];
    var result = await http.get(Uri.parse('$url/member/all'));
    users = memberCheckGetResFromJson(result.body);
  }
}
