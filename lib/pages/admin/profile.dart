import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lotto_application/config/config.dart';
import 'package:lotto_application/models/Req/MemberEditPutReq.dart';
import 'package:lotto_application/pages/admin/adward.dart';
import 'package:lotto_application/pages/admin/main.dart';
import 'package:lotto_application/pages/admin/setting.dart';
import 'package:lotto_application/pages/changepassword.dart';
import 'package:lotto_application/pages/login.dart';
import 'package:lotto_application/shared/app_data.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProfileAdminPage extends StatefulWidget {
  const ProfileAdminPage({super.key});

  @override
  State<ProfileAdminPage> createState() => _ProfileAdminPageState();
}

class _ProfileAdminPageState extends State<ProfileAdminPage> {
  GetStorage storage = GetStorage();
  TextEditingController nameCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  TextEditingController phoneCtl = TextEditingController();
  late Future<void> loadData;
  late MemberProfile user;
  String url = '';
  @override
  void initState() {
    super.initState();
    super.initState();
    user = context.read<Appdata>().user;
    nameCtl.text = user.fullname;
    emailCtl.text = user.email;
    phoneCtl.text = user.phone;
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
          backgroundColor: const Color(0xFF024B3F),
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
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(16.0), // ทำให้มุมโค้งมน
                      ),
                      title: const Text('ต้องการออกจากระบบหรือไม่?',
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
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () {
                          log("change image");
                        },
                        child: Container(
                          width: 180, // กำหนดความกว้าง
                          height: 180,
                          child: Stack(
                            children: [
                              Container(
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
                                  child: Image.network(
                                    user.image,
                                    width: 160, // กำหนดความกว้างของรูปภาพ
                                    height: 160, // กำหนดความสูงของรูปภาพ
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // Positioned(
                              //   bottom: 0,
                              //   right: 0,
                              //   child: Container(
                              //     width: 40, // กำหนดความกว้างของวงกลมเล็ก
                              //     height: 40, // กำหนดความสูงของวงกลมเล็ก
                              //     decoration: BoxDecoration(
                              //       color:
                              //           Color(0xFF54B799), // สีพื้นหลังของวงกลมเล็ก
                              //       shape: BoxShape.circle,
                              //       border: Border.all(
                              //         color: Colors.white, // สีของกรอบวงกลมเล็ก
                              //         width: 2.5, // ความหนาของกรอบวงกลมเล็ก
                              //       ),
                              //     ),
                              //     child: const Icon(
                              //       Icons.edit, // ไอคอนที่จะแสดงในวงกลมเล็ก
                              //       color: Colors.white, // สีของไอคอน
                              //       size: 30, // ขนาดของไอคอน
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                'ชื่อ - นามสกุล',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: "Prompt",
                                    letterSpacing: 1),
                              ),
                            ),
                            TextField(
                              controller: nameCtl,
                              keyboardType: TextInputType.name,
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
                                      borderRadius:
                                          BorderRadius.circular(8.0))),
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
                              'อีเมล',
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
                        ],
                      ),
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
                                      borderRadius:
                                          BorderRadius.circular(8.0))),
                              // inputFormatters: [
                              //   LengthLimitingTextInputFormatter(
                              //       10), // จำกัดตัวเลขที่ป้อนได้สูงสุด 10 ตัว
                              // ],
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 10),
                      child: FilledButton(
                          onPressed: () => dialog(),
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
                          child: const Text('บันทึก',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: "Prompt",
                                  letterSpacing: 1))),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChangePasswordPage(),
                            ),
                          );
                        },
                        child: const Text('เปลี่ยนรหัสผ่าน',
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainAdminPage(),
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
                              builder: (context) => const AdwardAdminPage(),
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingAdminPage(),
                            ),
                          );
                        },
                        child: const Column(
                          children: [
                            Icon(
                              Icons.settings,
                              size: 40,
                              color: Color(0xFF555555),
                            ),
                            Text(
                              'ตั้งค่า',
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
                      const Column(
                        children: [
                          Icon(
                            Icons.person,
                            size: 40,
                            color: Color(0xFF54B799),
                          ),
                          Text(
                            'โปรไฟล์',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF54B799),
                                fontFamily: "Prompt",
                                letterSpacing: 1),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void save() async {
    var value = await Configuration.getConfig();
    url = value['apiEndpoint'];
    var data = MemberEditPutReq(
        memberId: user.id,
        name: nameCtl.text,
        phone: phoneCtl.text,
        image:
            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
        email: emailCtl.text);
    try {
      var value = await http.put(Uri.parse('$url/member?id=${user.id}'),
          headers: {"Content-Type": "application/json; charset=utf-8"},
          body: jsonEncode(data));
      log(value.body);
      user.fullname = nameCtl.text;
      user.phone = phoneCtl.text;
      user.image =
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
      user.email = emailCtl.text;
      context.read<Appdata>().user = user;
      storage.write('name', user.fullname);
      storage.write('phone', user.phone);
      storage.write('image', user.image);
      storage.write('email', user.email);
    } catch (eee) {
      log("Edit Error $eee");
    }
  }

  void dialog() {
    if (nameCtl.text.isEmpty ||
        emailCtl.text.isEmpty ||
        phoneCtl.text.isEmpty) {
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
            'คุณกรอกข้อมูลไม่ครบ',
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
    } else if (!GetUtils.isEmail(emailCtl.text)) {
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
            'อีเมลไม่ถูกต้อง',
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
    } else if (phoneCtl.text.trim().isEmpty) {
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
            'เบอร์โทรศัพท์ไม่ถูกต้อง',
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
    } else if (nameCtl.text.trim().isEmpty) {
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
            'ชื่อผู้ใช้ไม่ถูกต้อง',
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
      showDialog(
        context: context,
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
            'บันทึกข้อมูลเสร็จสิ้น',
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
    }
  }
}
