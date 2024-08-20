import 'package:flutter/material.dart';

class MainAdminPage extends StatefulWidget {
  const MainAdminPage({super.key});

  @override
  State<MainAdminPage> createState() => _MainAdminPageState();
}

class _MainAdminPageState extends State<MainAdminPage> {
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
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: Color(0xFF54B799), // สีพื้นหลังของปุ่ม
                        foregroundColor: Colors.white, // สีของข้อความบนปุ่ม
                      ),
                      child: const Text("ทั้งหมด"),
                    ),
                    FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: Color(0xFF54B799), // สีพื้นหลังของปุ่ม
                        foregroundColor: Colors.white, // สีของข้อความบนปุ่ม
                      ),
                      child: const Text("ขายแล้ว"),
                    ),
                    FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: Color(0xFF54B799), // สีพื้นหลังของปุ่ม
                        foregroundColor: Colors.white, // สีของข้อความบนปุ่ม
                      ),
                      child: const Text("ยังไม่ขาย"),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // สีพื้นหลัง
                    border: Border.all(
                      color: Color(0xFF54B799), // สีของเส้นขอบ
                      width: 2.0, // ความหนาของเส้นขอบ
                    ),
                  ),
                  child: const SizedBox(
                    width: 400,
                    height: 400,
                    child: Text(""),
                  ),
                ),
                FilledButton(
                  onPressed: (){},
                  style: FilledButton.styleFrom(
                    backgroundColor: Color(0xFFD9D9D9), // สีพื้นหลังของปุ่ม
                    foregroundColor: Colors.white,
                    // สีของข้อความบนปุ่ม
                  ),
                  child: const SizedBox(
                    child: Text(
                      "สร้างตัวเลข",
                      style: TextStyle(
                        color: Colors.black, // สีของข้อความ
                        // ขนาดของข้อความ
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
}
