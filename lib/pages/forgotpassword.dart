import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lotto_application/pages/otpconfirm.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  
  TextEditingController emailCtl = TextEditingController();

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
                      padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 42),
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
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OtpConfirmPage(),
        ));
  }
}
