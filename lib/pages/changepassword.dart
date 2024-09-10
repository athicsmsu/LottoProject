import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lotto_application/config/config.dart';
import 'package:lotto_application/models/Req/ChangePasswordPutReq.dart';
import 'package:lotto_application/shared/app_data.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  TextEditingController passwordCtl = TextEditingController();
  TextEditingController confirmpasswordCtl = TextEditingController();
   String url = '';
   late MemberProfile user;
   
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                    "เปลี่ยนรหัสผ่าน",
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
                        'รหัสผ่าน',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "Prompt",
                            letterSpacing: 1),
                      ),
                    ),
                    TextField(
                      controller: passwordCtl,
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
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12,top: 12),
                      child: Text(
                        'ยืนยันรหัสผ่าน',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "Prompt",
                            letterSpacing: 1),
                      ),
                    ),
                    TextField(
                      controller: confirmpasswordCtl,
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
                              onPressed: () => dialog(),
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
  
  dialog() {
    if (passwordCtl.text.trim().isEmpty ||
        passwordCtl.text.trim().isEmpty) {
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
            'รหัสผ่านไม่ถูกต้อง',
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
    } else if (confirmpasswordCtl.text != passwordCtl.text) {
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
            'รหัสผ่านไม่ตรงกัน',
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
    } else {
      save();
    }
  }

  void save() async {
    var value = await Configuration.getConfig();
    url = value['apiEndpoint'];
    var data = ChangePasswordPutReq(memberId: user.id, password: passwordCtl.text);
    try {
      var value = await http.put(Uri.parse('$url/member?id=${user.id}'),
          headers: {"Content-Type": "application/json; charset=utf-8"},
          body: jsonEncode(data));
      log(value.body);
      // var member = memberRegisterPostResFromJson(value.body);
      // log(member.affectedRow.toString());
      // log(member.lastIdx.toString());
    } catch (eee) {
      log("Edit Error $eee");
    }
    Navigator.of(context).pop();
  }
}