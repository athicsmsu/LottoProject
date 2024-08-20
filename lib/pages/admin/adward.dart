import 'package:flutter/material.dart';

class AdwardAdminPage extends StatefulWidget {
  const AdwardAdminPage({super.key});

  @override
  State<AdwardAdminPage> createState() => _AdwardAdminPageState();
}

class _AdwardAdminPageState extends State<AdwardAdminPage> {
  String? _selectedValue;
  List<String> items = ['ทั้งหมด', 'ขายไปแล้ว'];

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
        body: Container(
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: const Color(0xFF54B799),
                          ),
                          child: const Center(
                              child: Text(
                            "1",
                            style: TextStyle(
                                fontSize: 50,
                                color: Colors.white,
                                fontFamily: "Prompt"),
                          )),
                        ),
                      ),
                      Container(
                        width: 300,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF139D51), // สีของเส้นขอบ
                            width: 2.0, // ความหนาของเส้นขอบ
                          ),
                          color: const Color(0xFFD9D9D9),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "เงินรางวัล 5,000 บาท",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: "Prompt"),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: const Color(0xFF54B799),
                          ),
                          child: const Center(
                              child: Text(
                            "2",
                            style: TextStyle(
                                fontSize: 50,
                                color: Colors.white,
                                fontFamily: "Prompt"),
                          )),
                        ),
                      ),
                      Container(
                        width: 300,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF139D51), // สีของเส้นขอบ
                            width: 2.0, // ความหนาของเส้นขอบ
                          ),
                          color: const Color(0xFFD9D9D9),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "เงินรางวัล 5,000 บาท",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: "Prompt"),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: const Color(0xFF54B799),
                          ),
                          child: const Center(
                              child: Text(
                            "3",
                            style: TextStyle(
                                fontSize: 50,
                                color: Colors.white,
                                fontFamily: "Prompt"),
                          )),
                        ),
                      ),
                      Container(
                        width: 300,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF139D51), // สีของเส้นขอบ
                            width: 2.0, // ความหนาของเส้นขอบ
                          ),
                          color: const Color(0xFFD9D9D9),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "เงินรางวัล 5,000 บาท",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: "Prompt"),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: const Color(0xFF54B799),
                          ),
                          child: const Center(
                              child: Text(
                            "4",
                            style: TextStyle(
                                fontSize: 50,
                                color: Colors.white,
                                fontFamily: "Prompt"),
                          )),
                        ),
                      ),
                      Container(
                        width: 300,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF139D51), // สีของเส้นขอบ
                            width: 2.0, // ความหนาของเส้นขอบ
                          ),
                          color: const Color(0xFFD9D9D9),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "เงินรางวัล 5,000 บาท",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: "Prompt"),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: const Color(0xFF54B799),
                          ),
                          child: const Center(
                              child: Text(
                            "5",
                            style: TextStyle(
                                fontSize: 50,
                                color: Colors.white,
                                fontFamily: "Prompt"),
                          )),
                        ),
                      ),
                      Container(
                        width: 300,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF139D51), // สีของเส้นขอบ
                            width: 2.0, // ความหนาของเส้นขอบ
                          ),
                          color: const Color(0xFFD9D9D9),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0  ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "เงินรางวัล 5,000 บาท",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: "Prompt"),
                  ),
                ],
              ),
              Row(
                children: [
                  
                  Container(
                    color: Color(0xff54B799),
                    child: DropdownButton<String>(
                      value: _selectedValue,
                      hint: const Text('ทั้งหมด',style: TextStyle(
                            color:Colors.white), // สีของข้อความเมื่อยังไม่ได้เลือก
                      ),
                      dropdownColor:
                          Color(0xff54B799), // สีพื้นหลังของเมนู Dropdown
                      items: items.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                                color:
                                    Colors.white), // สีของข้อความในเมนู Dropdown
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                      style: const TextStyle(
                        color: Colors.white, // สีของข้อความบนปุ่ม Dropdown
                      ),
                    ),
                  ),
                  FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: Color(0xFF1B9EE8), // สีพื้นหลังของปุ่ม
                        foregroundColor: Colors.white, // สีของข้อความบนปุ่ม
                      ),
                      child: const Text("ออกผลรางวัล"),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
