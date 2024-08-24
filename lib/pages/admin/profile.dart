import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lotto_application/pages/admin/adward.dart';
import 'package:lotto_application/pages/admin/main.dart';
import 'package:lotto_application/pages/admin/setting.dart';
import 'package:lotto_application/pages/login.dart';

class ProfileAdminPage extends StatefulWidget {
  const ProfileAdminPage({super.key});

  @override
  State<ProfileAdminPage> createState() => _ProfileAdminPageState();
}

class _ProfileAdminPageState extends State<ProfileAdminPage> {
  TextEditingController nameCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  TextEditingController phoneCtl = TextEditingController();

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
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
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
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 10),
                      child: FilledButton(
                          onPressed: () => save(),
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
                          ChangePassword();
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

  save() {
    log(nameCtl.text);
    log(emailCtl.text);
    log(phoneCtl.text);

    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: const Text('สำเร็จ'),
    //     content: const Text('บันทึกข้อมูลเรียบร้อย'),
    //     actions: [
    //       FilledButton(
    //         onPressed: () {
    //           Navigator.pop(context);
    //         },
    //         child: const Text(
    //           'ปิด',
    //           style: TextStyle(
    //             color: Colors.white, // Set the text color to white
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }

  void ChangePassword() {}
}
