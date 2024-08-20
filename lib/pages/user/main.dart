import 'package:flutter/material.dart';

class MainUserPage extends StatefulWidget {
  const MainUserPage({super.key});

  @override
  State<MainUserPage> createState() => _MainUserPageState();
}

class _MainUserPageState extends State<MainUserPage> {
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
        ),
        actions: [
            IconButton(
              icon: const Icon(
                Icons.power_settings_new,
                color: Colors.white,
                size: 38.0,
              ), // ปุ่มที่อยู่ขวามือ
              onPressed: () {
                // ฟังก์ชันเมื่อกดปุ่ม settings
                print('Settings button pressed');
              },
            ),
          ],),
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
                            fit:
                                BoxFit.cover))), // ปรับขนาดรูปภาพให้เต็มพื้นที่
              ),
            ],
          ),
        ),
      ),
    );
  }
}