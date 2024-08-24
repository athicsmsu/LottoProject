import 'package:flutter/material.dart';
import 'package:lotto_application/pages/admin/adward.dart';
import 'package:lotto_application/pages/admin/main.dart';
import 'package:lotto_application/pages/admin/profile.dart';

class SettingAdminPage extends StatefulWidget {
  const SettingAdminPage({super.key});

  @override
  State<SettingAdminPage> createState() => _SettingAdminPageState();
}

class _SettingAdminPageState extends State<SettingAdminPage> {
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
          backgroundColor: Colors.white,
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
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
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
                                'reset system',
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
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              'จำนวนตัวเลข',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: "Prompt",
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.black, // สีของเส้น
                        thickness: 2, // ความหนาของเส้น
                        height: 20, // ระยะห่างระหว่าง Text กับ Divider
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Table(
                          border: TableBorder.all(),
                          children: <TableRow>[
                            TableRow(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 190, 190, 190),
                              ),
                              children: <Widget>[
                                Center(
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment
                                        .center, // จัดให้อยู่กลางแนวตั้ง
                                    child: const Text(
                                      "ทั้งหมด",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "Prompt",
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment
                                        .center, // จัดให้อยู่กลางแนวตั้ง
                                    child: const Text(
                                      "ขายไปแล้ว",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "Prompt",
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment
                                        .center, // จัดให้อยู่กลางแนวตั้ง
                                    child: const Text(
                                      "ยังไม่ขาย",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "Prompt",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: <Widget>[
                                Center(
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment
                                        .center, // จัดให้อยู่กลางแนวตั้ง
                                    child: const Text(
                                      "xxxxxx",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "Prompt",
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment
                                        .center, // จัดให้อยู่กลางแนวตั้ง
                                    child: const Text(
                                      "xxxxxx",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "Prompt",
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment
                                        .center, // จัดให้อยู่กลางแนวตั้ง
                                    child: const Text(
                                      "xxxxxx",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "Prompt",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              'เลขรางวัลปัจจุบัน',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: "Prompt",
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.black, // สีของเส้น
                        thickness: 2, // ความหนาของเส้น
                        height: 20, // ระยะห่างระหว่าง Text กับ Divider
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Table(
                          border: TableBorder.all(),
                          children: <TableRow>[
                            TableRow(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 190, 190, 190),
                              ),
                              children: <Widget>[
                                Center(
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment
                                        .center, // จัดให้อยู่กลางแนวตั้ง
                                    child: const Text(
                                      "#",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "Prompt",
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment
                                        .center, // จัดให้อยู่กลางแนวตั้ง
                                    child: const Text(
                                      "ผลที่ออก",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "Prompt",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: <Widget>[
                                Center(
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment
                                        .center, // จัดให้อยู่กลางแนวตั้ง
                                    child: const Text(
                                      "รางวัลที่ 1",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "Prompt",
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment
                                        .center, // จัดให้อยู่กลางแนวตั้ง
                                    child: const Text(
                                      "xxxxxx",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "Prompt",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: <Widget>[
                                Center(
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment
                                        .center, // จัดให้อยู่กลางแนวตั้ง
                                    child: const Text(
                                      "รางวัลที่ 2",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "Prompt",
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment
                                        .center, // จัดให้อยู่กลางแนวตั้ง
                                    child: const Text(
                                      "xxxxxx",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "Prompt",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: <Widget>[
                                Center(
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment
                                        .center, // จัดให้อยู่กลางแนวตั้ง
                                    child: const Text(
                                      "รางวัลที่ 3",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "Prompt",
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment
                                        .center, // จัดให้อยู่กลางแนวตั้ง
                                    child: const Text(
                                      "xxxxxx",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "Prompt",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: <Widget>[
                                Center(
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment
                                        .center, // จัดให้อยู่กลางแนวตั้ง
                                    child: const Text(
                                      "รางวัลที่ 4",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "Prompt",
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment
                                        .center, // จัดให้อยู่กลางแนวตั้ง
                                    child: const Text(
                                      "xxxxxx",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "Prompt",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: <Widget>[
                                Center(
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment
                                        .center, // จัดให้อยู่กลางแนวตั้ง
                                    child: const Text(
                                      "รางวัลที่ 5",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "Prompt",
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment
                                        .center, // จัดให้อยู่กลางแนวตั้ง
                                    child: const Text(
                                      "xxxxxx",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "Prompt",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      FilledButton.icon(
                        onPressed: () => _dialogBuilder(context),
                        icon: Icon(Icons.refresh, color: Colors.white),
                        label: Text("Reset"),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.red, // เปลี่ยนสีปุ่มเป็นสีแดง
                        ),
                      )
                    ],
                  ),
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
                      const Column(
                        children: [
                          Icon(
                            Icons.settings,
                            size: 40,
                            color: Color(0xFF54B799),
                          ),
                          Text(
                            'ตั้งค่า',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF54B799),
                                fontFamily: "Prompt",
                                letterSpacing: 1),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileAdminPage(),
                            ),
                          );
                        },
                        child: const Column(
                          children: [
                            Icon(
                              Icons.person,
                              size: 40,
                              color: Color(0xFF555555),
                            ),
                            Text(
                              'โปรไฟล์',
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
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    int check = 0;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Icon(Icons.warning_amber, color: Colors.red),
          content: const Text("ต้องการรีเซ็ตระบบใหม่ใช่หรือไม่"),
          actions: <Widget>[
            TextButton(
              child: const Text('ยกเลิก'),
              onPressed: () {
                check = 0; // Set check to 0 for Disable
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('ตกลง'),
              onPressed: () {
                check = 1; // Set check to 1 for Enable
                Navigator.of(context).pop();
                // Show success dialog after closing the current dialog
                if (check == 1) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('สำเร็จ'),
                      content: const Text('ระบบได้ถูกรีเซ็ตเรียบร้อยแล้ว'),
                      actions: [
                        FilledButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'ปิด',
                            style: TextStyle(
                              color:
                                  Colors.white, // Set the text color to white
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
