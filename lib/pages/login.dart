import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lotto_application/config/config.dart';
import 'package:lotto_application/models/Req/MemberLoginPostReq.dart';
import 'package:lotto_application/models/Res/MemberLoginPostRes.dart';
import 'package:lotto_application/pages/admin/main.dart';
import 'package:lotto_application/pages/forgotpassword.dart';
import 'package:lotto_application/pages/register.dart';
import 'package:lotto_application/pages/user/main.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_application/shared/app_data.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GetStorage storage = GetStorage();
  MemberProfile user = MemberProfile();
  TextEditingController phoneCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();
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
    try {
      String userStatus = storage.read('userStatus');
      user.id = storage.read('id');
      user.fullname = storage.read('name');
      user.phone = storage.read('phone');
      user.image = storage.read('image');
      user.email = storage.read('email');
      user.wallet_balance = storage.read('walletBalance');
      context.read<Appdata>().user = user;
      if (userStatus == 'member') {
        context.read<Appdata>().page = 'mainUser';
        SchedulerBinding.instance.addPostFrameCallback((_) {
         Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainUserPage(),
              ));
        });
      } else if (userStatus == 'admin') {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainAdminPage(),
              ));
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        log('ถอยกลับไม่ได้นะ');
      },
      child: MaterialApp(
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
          backgroundColor: const Color(0xFF024B3F),
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 50),
                  child: Container(
                      width: 180, // กำหนดความกว้าง
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFD9D9D9), // สีของกรอบ
                          width: 10, // ความหนาของกรอบ
                        ),
                      ),
                      child: ClipOval(
                          child: Image.asset('assets/images/LottoLogo.jpg',
                              width: 160, // กำหนดความกว้างของรูปภาพ
                              height: 160, // กำหนดความสูงของรูปภาพ
                              fit: BoxFit
                                  .cover))), // ปรับขนาดรูปภาพให้เต็มพื้นที่
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            'หมายเลขโทรศัพท์',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: "Prompt",
                                letterSpacing: 1),
                          ),
                        ),
                        TextField(
                          controller: phoneCtl,
                          keyboardType: TextInputType.phone,
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
                          inputFormatters: const [
                            // LengthLimitingTextInputFormatter(
                            //     10), // จำกัดตัวเลขที่ป้อนได้สูงสุด 10 ตัว
                          ],
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
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
                        obscureText: true,
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
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 42),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              register();
                            },
                            child: const Text('สมัครสมาชิก',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF54B799),
                                    fontFamily: "Prompt",
                                    letterSpacing: 1))),
                        FilledButton(
                            onPressed: () => login(),
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  const Size(160, 44)), // กำหนดขนาดของปุ่ม
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFF139D51)), // สีพื้นหลังของปุ่ม
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(25.0), // ทำให้ขอบมน
                              )),
                            ),
                            child: const Text('เข้าสู่ระบบ',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: "Prompt",
                                    letterSpacing: 1))),
                      ],
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      forgotPassword();
                    },
                    child: const Text('ลืมรหัสผ่าน?',
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
    );
  }

  void register() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RegisterPage(),
        ));
  }

  login() async {
    if (phoneCtl.text.isEmpty || passwordCtl.text.isEmpty) {
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
            'โปรดใส่หมายเลขโทรศัพท์หรือรหัสผ่าน',
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
      var phone = phoneCtl.text;
      var password = passwordCtl.text;
      var data = MemberLoginPostReq(phone: phone, password: password);
      try {
        var value = await http.post(Uri.parse('$url/member/login'),
            headers: {"Content-Type": "application/json; charset=utf-8"},
            body: jsonEncode(data));
        var member = memberLoginPostResFromJson(value.body);
        log(member.type);
        if (member.type == 'member') {
          context.read<Appdata>().page = 'mainUser';
          user.id = member.id;
          user.fullname = member.name;
          user.phone = member.phone;
          user.image = member.image;
          user.email = member.email;
          if (member.walletBalance is int) {
            // ถ้า member.money เป็น int แปลงเป็น double
            user.wallet_balance = (member.walletBalance as int).toDouble();
          } else if (member.walletBalance is double) {
            // ถ้า member.money เป็น double กำหนดค่าโดยตรง
            user.wallet_balance = member.walletBalance;
          }

          storage.write('userStatus', member.type);
          storage.write('id', member.id);
          storage.write('name', member.name);
          storage.write('phone', member.phone);
          storage.write('image', member.image);
          storage.write('email', member.email);
          context.read<Appdata>().user = user; //อันตรายห้ามลืม
          storage.write('walletBalance', user.wallet_balance);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainUserPage(),
              ));
        } else if (member.type == 'admin') {
          context.read<Appdata>().page = 'mainAdmin';
          user.id = member.id;
          user.fullname = member.name;
          user.phone = member.phone;
          user.image = member.image;
          user.email = member.email;
          if (member.walletBalance is int) {
            // ถ้า member.money เป็น int แปลงเป็น double
            user.wallet_balance = (member.walletBalance as int).toDouble();
          } else if (member.walletBalance is double) {
            // ถ้า member.money เป็น double กำหนดค่าโดยตรง
            user.wallet_balance = member.walletBalance;
          }

          storage.write('userStatus', member.type);
          storage.write('id', member.id);
          storage.write('name', member.name);
          storage.write('phone', member.phone);
          storage.write('image', member.image);
          storage.write('email', member.email);
          context.read<Appdata>().user = user;
          storage.write('walletBalance', user.wallet_balance);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainAdminPage(),
              ));
        }
      } catch (eee) {
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
              'หมายเลขโทรศัพท์หรือรหัสผ่านไม่ถูกต้อง',
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
        log(eee.toString());
      }
    }
  }

  forgotPassword() {
    context.read<Appdata>().user = user;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ForgotPasswordPage(),
        ));
  }
}
