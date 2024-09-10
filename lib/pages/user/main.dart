import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lotto_application/config/config.dart';
import 'package:lotto_application/models/Res/LottoAllGetRes.dart';
import 'package:lotto_application/pages/login.dart';
import 'package:lotto_application/pages/user/lotto.dart';
import 'package:lotto_application/pages/user/money.dart';
import 'package:lotto_application/pages/user/mylotto.dart';
import 'package:lotto_application/pages/widgets/menuUser.dart';
import 'package:lotto_application/shared/app_data.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MainUserPage extends StatefulWidget {
  const MainUserPage({super.key});

  @override
  State<MainUserPage> createState() => _MainUserPageState();
}

class _MainUserPageState extends State<MainUserPage> {
  MenuUser menu = const MenuUser();
  int numnews = 1;
  String hideMoneytxt = 'ดูยอดเงิน';
  List<LottoAllGetRes> purchaseList = []; // ลิสต์สำหรับเก็บรายการสั่งซื้อ

  String url = '';
  String nummoney = 'XX.XX';
  String txtPhone = '';
  late MemberProfile user;

  late Future<void> loadData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = context.read<Appdata>().user;
    txtPhone = user.phone;
    if (txtPhone.length >= 10) {
      // ตรวจสอบความยาวของ text ว่ามีความยาว 10 ตัวขึ้นไป
      String part1 = txtPhone.substring(0, 3); // 3 ตัวแรก
      String part2 = txtPhone.substring(3, 6); // 3 ตัวถัดไป
      String part3 =
          'X' * (txtPhone.length - 6); // เติม X ให้ครบตามความยาวที่เหลือ

      txtPhone = '$part1-$part2-$part3';
    } else {
      // กรณีที่ความยาวน้อยกว่า 10
      txtPhone = txtPhone.padRight(10, '0'); // เติม 0 ให้ครบ 10 ตัว
      String part1 = txtPhone.substring(0, 3);
      String part2 = txtPhone.substring(3, 6);
      String part3 =
          'X' * (txtPhone.length - 6); // เติม X ให้ครบตามความยาวที่เหลือ

      txtPhone = '$part1-$part2-$part3';
    }
    loadData = loadDataAsync();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        log('can not back');
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
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child:
                  // Container(
                  //   width: 50, // กำหนดความกว้าง
                  //   height: 50,
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     border: Border.all(
                  //       color: const Color(0xFFD9D9D9), // สีของกรอบ
                  //       width: 5, // ความหนาของกรอบ
                  //     ),
                  //   ),
                  //   child: ClipOval(
                  //     child: user.image != null
                  //         ? Image.network(
                  //             user.image!,
                  //             width: 40, // กำหนดความกว้างของรูปภาพ
                  //             height: 40, // กำหนดความสูงของรูปภาพ
                  //             fit: BoxFit.cover,
                  //           )
                  //         : const SizedBox(
                  //             width: 40,
                  //             height: 40,
                  //             child:
                  //                 CircularProgressIndicator(), // แสดง Loading เมื่อไม่มีรูป
                  //           ),
                  //   ),
                  // ),
                  Container(
                width: 50, // กำหนดความกว้าง
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFD9D9D9), // สีของกรอบ
                    width: 5, // ความหนาของกรอบ
                  ),
                ),
                child: ClipOval(
                  child: user.image != null
                      ? Image.network(
                          user.image!,
                          width: 40, // กำหนดความกว้างของรูปภาพ
                          height: 40, // กำหนดความสูงของรูปภาพ
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child; // รูปภาพโหลดเสร็จแล้ว
                            } else {
                              return const SizedBox(
                                width: 40,
                                height: 40,
                                child:
                                    CircularProgressIndicator(), // แสดง Loader เมื่อกำลังโหลด
                              );
                            }
                          },
                        )
                      : const SizedBox(
                          width: 40,
                          height: 40,
                          child:
                              CircularProgressIndicator(), // แสดง Loader เมื่อไม่มีรูป
                        ),
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
          body: Stack(children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.chevron_left_outlined,
                              color: Colors.white,
                              size: 55,
                            ), // ปุ่มที่อยู่ขวามือ
                            onPressed: () {
                              if (numnews > 1) {
                                numnews = numnews - 1;
                              }
                              setState(() {});
                            },
                          ),
                          Container(
                            width: 290, // กำหนดความกว้างของ Container
                            height: 200, // กำหนดความสูงของ Container
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(16.0), // ทำให้ขอบมน
                              // สามารถเพิ่มสีพื้นหลังหรือลักษณะขอบได้หากต้องการ
                            ),
                            clipBehavior: Clip
                                .hardEdge, // ใช้เพื่อให้รูปภาพถูกครอบตามขอบมนของ Container
                            child: ClipRect(
                              child: Image.asset(
                                'assets/images/news$numnews.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.chevron_right_outlined,
                              color: Colors.white,
                              size: 55,
                            ), // ปุ่มที่อยู่ขวามือ
                            onPressed: () {
                              // ฟังก์ชันเมื่อกดปุ่ม settings
                              if (numnews < 3) {
                                numnews = numnews + 1;
                              }
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            'เช็คยอดเงิน',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: "Prompt",
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Container(
                      width: 400, // กำหนดความกว้างของ Container
                      height: 70, // กำหนดความสูงของ Container
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0), // ทำให้ขอบมน
                        color: const Color(0xFFD9D9D9), // กำหนดสีพื้นหลัง
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.5, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.fullname,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF555555),
                                      fontFamily: "Prompt",
                                      letterSpacing: 1),
                                ),
                                Text(
                                  txtPhone,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF777777),
                                      fontFamily: "Prompt",
                                      letterSpacing: 1),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  nummoney,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E1E1E),
                                      fontFamily: "Prompt",
                                      letterSpacing: 1),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (nummoney != "XX.XX") {
                                      nummoney = "XX.XX";
                                      hideMoneytxt = "ดูยอดเงิน";
                                    } else {
                                      nummoney = user.wallet_balance.toString();
                                      hideMoneytxt = "ซ่อนยอดเงิน";
                                    }
                                    setState(() {});
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        hideMoneytxt,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF00A950),
                                            fontFamily: "Prompt",
                                            letterSpacing: 1),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(Icons.remove_red_eye_outlined,
                                          color: Color(0xFF00A950))
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FilledButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MoneyPage(),
                              ));
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                              const Size(125, 50)), // กำหนดขนาดของปุ่ม
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF139D51)), // สีพื้นหลังของปุ่ม
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // ทำให้ขอบมน
                          )),
                        ),
                        child: const Text('เติมเงิน',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF),
                                fontFamily: "Prompt",
                                letterSpacing: 1))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 10, // กำหนดความกว้างของ Container
                          height: 40, // กำหนดความสูงของ Container
                          color: const Color(0xFF54B799), // กำหนดสีพื้นหลัง
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<Appdata>().page = "MyLotto";
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyLottoPage(),
                                ));
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'รายการของคุณ',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: "Prompt",
                                  letterSpacing: 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FutureBuilder(
                      future: loadData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Column(
                            children: [
                              Center(
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Column(
                              children: [
                                SizedBox(height: 150),
                                Text(
                                  'เกิดข้อผิดพลาดในการโหลดข้อมูล',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF444444),
                                      fontFamily: "Prompt",
                                      letterSpacing: 1),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Row(
                            children: [
                              ...purchaseList
                                  .map((purchase) => Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: GestureDetector(
                                          onTap: () {
                                            context.read<Appdata>().page =
                                                "MyLotto";
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MyLottoPage(),
                                                ));
                                          },
                                          child: ClipOval(
                                            child: Image.asset(
                                              'assets/images/LottoLogo.jpg',
                                              width:
                                                  70, // กำหนดความกว้างของรูปภาพ
                                              height:
                                                  70, // กำหนดความสูงของรูปภาพ
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              const SizedBox(
                                  width: 5), // เว้นระยะระหว่าง widget
                              Container(
                                width: 70, // กำหนดขนาดของ Container
                                height: 70,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF54B799)
                                      .withOpacity(0.5), // สีพื้นหลังใส
                                  shape: BoxShape
                                      .circle, // ทำให้ Container มีขอบมน
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<Appdata>().page = "LottoPage";
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LottoPage(),
                                        ));
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white.withOpacity(0.5),
                                    size: 60,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            menu,
          ]),
        ),
      ),
    );
  }

  Future<void> loadDataAsync() async {
    await Future.delayed(const Duration(seconds: 1));
    var value = await Configuration.getConfig();
    url = value['apiEndpoint'];
    var data = await http.get(Uri.parse('$url/lottery/allnotClaim?id=${user.id}'));
    purchaseList = lottoAllGetResFromJson(data.body);
  }
}
