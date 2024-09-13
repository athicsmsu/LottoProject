import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lotto_application/config/config.dart';
import 'package:lotto_application/models/Res/LottoAllGetRes.dart';
import 'package:lotto_application/models/Res/RewardLottoGetRes.dart';
import 'package:lotto_application/pages/admin/main.dart';
import 'package:lotto_application/pages/admin/profile.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_application/pages/admin/setting.dart';
import 'package:lotto_application/pages/login.dart';

List<String> list = <String>['ทั้งหมด', 'ขายไปแล้ว'];

class AdwardAdminPage extends StatefulWidget {
  const AdwardAdminPage({super.key});

  @override
  State<AdwardAdminPage> createState() => _AdwardAdminPageState();
}

class _AdwardAdminPageState extends State<AdwardAdminPage> {
  String dropdownValue = list.first;
  late Future<void> loadData;
  List<RewardLottoGetRes> rewardLotto = [];
  List<String> lottoList = [];
  String url = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData = loadDataAsync();
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
                    FutureBuilder(
                        future: loadData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text("Error: ${snapshot.error}"));
                          } else if (rewardLotto.isEmpty) {
                            // ignore: prefer_const_constructors
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 150),
                              child: const Column(
                                children: [
                                  SizedBox(height: 250),
                                  Center(
                                      child: Icon(Icons.error,
                                          size: 100, color: Colors.white)),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Center(
                                      child: Text(
                                        'ไม่มีรายการรางวัลที่ออก',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontFamily: "Prompt",
                                            letterSpacing: 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: rewardLotto
                                    .map(
                                      (reward) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                color: const Color(
                                                    0xFF54B799), // สีพื้นหลังสีเขียว
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: reward.prizeStatus != 1
                                                  ? Center(
                                                      child: Container(
                                                        width: 55,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          reward.prizeStatus
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 40,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xFFFFFFFF),
                                                            fontFamily:
                                                                "Prompt",
                                                            letterSpacing: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : const Icon(
                                                      Icons
                                                          .emoji_events, // ไอคอนของเหรียญรางวัล
                                                      size: 55.0,
                                                      color: Colors.white,
                                                    ),
                                            ),
                                            const SizedBox(
                                                width:
                                                    10.0), // ระยะห่างระหว่างไอคอนกับหมายเลขรางวัล
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 320,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12.0,
                                                      vertical: 8.0),
                                                  decoration: BoxDecoration(
                                                    color: const Color(
                                                        0xFFD9D9D9), // สีพื้นหลังของช่องหมายเลข
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3.0),
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xFF139D51), // สีขอบของช่องหมายเลข
                                                      width: 10.0,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      for (var digit in lottoList[
                                                              reward.prizeStatus -
                                                                  1]
                                                          .split(''))
                                                        Text(
                                                          digit,
                                                          style: const TextStyle(
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xFF1E1E1E),
                                                              fontFamily:
                                                                  "Prompt",
                                                              letterSpacing: 1),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 15),
                                                  child: Text(
                                                    'เงินรางวัล ${reward.prizeAmount} บาท',
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                        fontFamily: "Prompt",
                                                        letterSpacing: 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            );
                          }
                        }),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 80),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color:
                                  const Color(0xFF139D51), // สีพื้นหลังของปุ่ม
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 2.5),
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_drop_down,
                                    color: Colors.white),
                                elevation: 16,
                                style: const TextStyle(color: Colors.white),
                                dropdownColor: const Color(0xFF54B799),
                                underline: Container(),
                                onChanged: (String? value) {
                                  setState(() {
                                    dropdownValue = value!;
                                  });
                                },
                                items: list.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          FilledButton(
                              onPressed: () => _dialogBuilder(context),
                              child: const Text("ออกผลรางวัล"))
                        ],
                      ),
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

  Future<void> _callSoldOutApi() async {
    // เรียก API สำหรับ "ขายไปแล้ว"
    try {
      // แสดงข้อความเมื่อเรียก API
      log("Calling Sold Out API");

      // ดึงค่า config จาก Configuration
      var value = await Configuration.getConfig();
      var url = value['apiEndpoint'];

      // ส่ง POST request ไปยัง API
      var response = await http.post(
        Uri.parse('$url/Ldraw/randomSold'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: jsonEncode({}), // ส่งข้อมูลที่จำเป็นไปยัง API ถ้ามี
      );

      // เช็คสถานะของ response
      if (response.statusCode == 200) {
        // ถ้าการเรียก API สำเร็จ (status code 200)
        log('API call succeeded: ${response.body}');
      } else {
        // ถ้าเกิดข้อผิดพลาด
        log('Failed to call API: ${response.statusCode}');
      }

      loadDataAsync();
    } catch (e) {
      // จับข้อผิดพลาดและแสดง error
      log('Error occurred: $e');
    }
  }

  Future<void> _callAllApi() async {
    // เรียก API สำหรับ "ทั้งหมด"
    try {
      // แสดงข้อความเมื่อเรียก API
      log("Calling All Out API");

      // ดึงค่า config จาก Configuration
      var value = await Configuration.getConfig();
      var url = value['apiEndpoint'];

      // ส่ง POST request ไปยัง API
      var response = await http.post(
        Uri.parse('$url/Ldraw/randomAll'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: jsonEncode({}), // ส่งข้อมูลที่จำเป็นไปยัง API ถ้ามี
      );

      // เช็คสถานะของ response
      if (response.statusCode == 200) {
        // ถ้าการเรียก API สำเร็จ (status code 200)
        log('API call succeeded: ${response.body}');
      } else {
        // ถ้าเกิดข้อผิดพลาด
        log('Failed to call API: ${response.statusCode}');
      }
      loadDataAsync();
    } catch (e) {
      // จับข้อผิดพลาดและแสดง error
      log('Error occurred: $e');
    }
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(Icons.warning_amber, color: Colors.red),
          content: const Text("ต้องการสุ่มรางวัลใหม่ใช่หรือไม่"),
          actions: <Widget>[
            TextButton(
              child: const Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('ตกลง'),
              onPressed: () {
                Navigator.of(context).pop();
                if (dropdownValue == "ขายไปแล้ว") {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('สำเร็จ'),
                      content: const Text('Random Number Sold complete'),
                      actions: [
                        FilledButton(
                          onPressed: () async {
                            await _callSoldOutApi();
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'ปิด',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                if (dropdownValue == "ทั้งหมด") {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('สำเร็จ'),
                      content: const Text('Random Number All complete'),
                      actions: [
                        FilledButton(
                          onPressed: () async {
                            await _callAllApi();
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'ปิด',
                            style: TextStyle(
                              color: Colors.white,
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

  Future<void> loadDataAsync() async {
    var value = await Configuration.getConfig();
    url = value['apiEndpoint'];
    var data = await http.get(Uri.parse('$url/Ldraw/all'));
    rewardLotto = rewardLottoGetResFromJson(data.body);

    for (var i = 0; i < rewardLotto.length; i++) {
      var lotto = await http
          .get(Uri.parse('$url/lottery?id=${rewardLotto[i].lotteryId}'));
      List<LottoAllGetRes> numLotto = lottoAllGetResFromJson(lotto.body);
      lottoList.add(numLotto.first.lotteryNumber.toString());
    }
    setState(() {});
  }
}
