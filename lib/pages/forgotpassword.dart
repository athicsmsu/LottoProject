import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lotto_application/config/config.dart';
import 'package:lotto_application/models/Res/MemberCheckGetRes.dart';
import 'package:lotto_application/pages/otpconfirm.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_application/shared/app_data.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailCtl = TextEditingController();
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
      home: Scaffold(
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
          },
        )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 195, horizontal: 25),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 44),
                  child: Text(
                    "ลืมรหัสผ่าน",
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
                        'โปรดกรอกอีเมลของคุณ',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "Prompt",
                            letterSpacing: 1),
                      ),
                    ),
                    TextField(
                      controller: emailCtl,
                      keyboardType: TextInputType.emailAddress,
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
                              onPressed: () => emailCheck(),
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(160, 44)), // กำหนดขนาดของปุ่ม
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(
                                        0xFF139D51)), // สีพื้นหลังของปุ่ม
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(25.0), // ทำให้ขอบมน
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  emailCheck() {
    log("ยืนยัน");
    for (var member in users) {
      if (member.email == emailCtl.text) {
        user.id = member.memberId;
        context.read<Appdata>().user = user; //อันตรายห้ามลืม
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OtpConfirmPage(),
            ));
        return;
      }
    }
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
          'ไม่พบอีเมล',
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

  Future<void> loadDataAsync() async {
    var value = await Configuration.getConfig();
    url = value['apiEndpoint'];
    var result = await http.get(Uri.parse('$url/member/all'));
    users = memberCheckGetResFromJson(result.body);
  }
}
