import 'package:flutter/material.dart';
import 'package:lotto_application/pages/admin/main.dart';
import 'package:lotto_application/pages/admin/profile.dart';
import 'package:lotto_application/pages/admin/setting.dart';

const List<String> list = <String>['ทั้งหมด', 'ขายไปแล้ว'];

class AdwardAdminPage extends StatefulWidget {
  const AdwardAdminPage({super.key});

  @override
  State<AdwardAdminPage> createState() => _AdwardAdminPageState();
}

class _AdwardAdminPageState extends State<AdwardAdminPage> {
  String dropdownValue = list.first;
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
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color:
                                  const Color(0xFF54B799), // สีพื้นหลังสีเขียว
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Icon(
                              Icons.emoji_events, // ไอคอนของเหรียญรางวัล
                              size: 55.0,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                              width:
                                  10.0), // ระยะห่างระหว่างไอคอนกับหมายเลขรางวัล
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: const Color(
                                      0xFFD9D9D9), // สีพื้นหลังของช่องหมายเลข
                                  borderRadius: BorderRadius.circular(3.0),
                                  border: Border.all(
                                    color: const Color(
                                        0xFF139D51), // สีขอบของช่องหมายเลข
                                    width: 10.0,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    for (var digit in "167892".split(''))
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Text(
                                          digit,
                                          style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1E1E1E),
                                              fontFamily: "Prompt",
                                              letterSpacing: 1),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: Text(
                                  'เงินรางวัล 5,000 บาท',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E1E1E),
                                      fontFamily: "Prompt",
                                      letterSpacing: 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 70,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color:
                                  const Color(0xFF54B799), // สีพื้นหลังสีเขียว
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Center(
                              child: Text(
                                '2',
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: "Prompt",
                                    letterSpacing: 1),
                              ),
                            ),
                          ),
                          const SizedBox(
                              width:
                                  10.0), // ระยะห่างระหว่างไอคอนกับหมายเลขรางวัล
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: const Color(
                                      0xFFD9D9D9), // สีพื้นหลังของช่องหมายเลข
                                  borderRadius: BorderRadius.circular(3.0),
                                  border: Border.all(
                                    color: const Color(
                                        0xFF139D51), // สีขอบของช่องหมายเลข
                                    width: 10.0,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    for (var digit in "167892".split(''))
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Text(
                                          digit,
                                          style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1E1E1E),
                                              fontFamily: "Prompt",
                                              letterSpacing: 1),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: Text(
                                  'เงินรางวัล 4,000 บาท',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E1E1E),
                                      fontFamily: "Prompt",
                                      letterSpacing: 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 70,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color:
                                  const Color(0xFF54B799), // สีพื้นหลังสีเขียว
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Center(
                              child: Text(
                                '3',
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: "Prompt",
                                    letterSpacing: 1),
                              ),
                            ),
                          ),
                          const SizedBox(
                              width:
                                  10.0), // ระยะห่างระหว่างไอคอนกับหมายเลขรางวัล
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: const Color(
                                      0xFFD9D9D9), // สีพื้นหลังของช่องหมายเลข
                                  borderRadius: BorderRadius.circular(3.0),
                                  border: Border.all(
                                    color: const Color(
                                        0xFF139D51), // สีขอบของช่องหมายเลข
                                    width: 10.0,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    for (var digit in "167892".split(''))
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Text(
                                          digit,
                                          style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1E1E1E),
                                              fontFamily: "Prompt",
                                              letterSpacing: 1),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: Text(
                                  'เงินรางวัล 3,000 บาท',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E1E1E),
                                      fontFamily: "Prompt",
                                      letterSpacing: 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 70,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color:
                                  const Color(0xFF54B799), // สีพื้นหลังสีเขียว
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Center(
                              child: Text(
                                '4',
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: "Prompt",
                                    letterSpacing: 1),
                              ),
                            ),
                          ),
                          const SizedBox(
                              width:
                                  10.0), // ระยะห่างระหว่างไอคอนกับหมายเลขรางวัล
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: const Color(
                                      0xFFD9D9D9), // สีพื้นหลังของช่องหมายเลข
                                  borderRadius: BorderRadius.circular(3.0),
                                  border: Border.all(
                                    color: const Color(
                                        0xFF139D51), // สีขอบของช่องหมายเลข
                                    width: 10.0,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    for (var digit in "167892".split(''))
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Text(
                                          digit,
                                          style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1E1E1E),
                                              fontFamily: "Prompt",
                                              letterSpacing: 1),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: Text(
                                  'เงินรางวัล 2,000 บาท',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E1E1E),
                                      fontFamily: "Prompt",
                                      letterSpacing: 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 70,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color:
                                  const Color(0xFF54B799), // สีพื้นหลังสีเขียว
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Center(
                              child: Text(
                                '5',
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: "Prompt",
                                    letterSpacing: 1),
                              ),
                            ),
                          ),
                          const SizedBox(
                              width:
                                  10.0), // ระยะห่างระหว่างไอคอนกับหมายเลขรางวัล
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: const Color(
                                      0xFFD9D9D9), // สีพื้นหลังของช่องหมายเลข
                                  borderRadius: BorderRadius.circular(3.0),
                                  border: Border.all(
                                    color: const Color(
                                        0xFF139D51), // สีขอบของช่องหมายเลข
                                    width: 10.0,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    for (var digit in "167892".split(''))
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Text(
                                          digit,
                                          style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1E1E1E),
                                              fontFamily: "Prompt",
                                              letterSpacing: 1),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: Text(
                                  'เงินรางวัล 1,000 บาท',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E1E1E),
                                      fontFamily: "Prompt",
                                      letterSpacing: 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Color(0xFF139D51), // สีพื้นหลังของปุ่ม
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_drop_down,
                                  color: Colors.white),
                              elevation: 16,
                              style: const TextStyle(color: Colors.white),
                              dropdownColor: Color(0xFF54B799),
                              underline: Container(),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                              items: list
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      FilledButton(onPressed:  ()=> _dialogBuilder(context), 
                      child: Text("ออกผลรางวัล"))
                      ],
                    )
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
                      const Column(
                        children: [
                          Icon(
                            Icons.emoji_events,
                            size: 40,
                            color: Color(0xFF54B799),
                          ),
                          Text(
                            'รางวัล',
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
          content: const Text("ต้องการสุ่มรางวัลใหม่ใช่หรือไม่"),
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
                      content: const Text('สุ่มรางวัลใหม่เรียบร้อยแล้ว'),
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

