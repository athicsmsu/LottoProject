import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lotto_application/config/config.dart';
import 'package:lotto_application/models/Req/ClaimPrizePutReq.dart';
import 'package:lotto_application/models/Res/LottoAllGetRes.dart';
import 'package:lotto_application/models/Res/MyLottoWinGetRes.dart';
import 'package:lotto_application/pages/login.dart';
import 'package:lotto_application/pages/widgets/menuUser.dart';
import 'package:lotto_application/shared/app_data.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ClaimPrizePage extends StatefulWidget {
  const ClaimPrizePage({super.key});

  @override
  State<ClaimPrizePage> createState() => _ClaimPrizePageState();
}

class _ClaimPrizePageState extends State<ClaimPrizePage> {
  GetStorage storage = GetStorage();
  late MemberProfile user;
  MenuUser menu = const MenuUser();
  List<MyLottoWinGetRes> myLottoWinList = [];
  List<LottoAllGetRes> numLottoList = [];
  late Future<void> loadData;
  String url = '';
  String status = 'canClaim';

  @override
  void initState() {
    super.initState();
    loadData = loadDataAsync();
    user = context.read<Appdata>().user;
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
        backgroundColor: const Color(0xFFFFFFFF),
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
        body: Stack(children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
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
                            'รายการเลขที่ขึ้นรางวัลได้',
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
                  FutureBuilder(
                    future: loadData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Column(
                          children: [
                            SizedBox(height: 150),
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
                      } else if (myLottoWinList.isEmpty) {
                        return Column(
                          children: [
                            const SizedBox(height: 150),
                            Center(
                              child: Image.asset(
                                'assets/images/box-important.png',
                                width: 100, // กำหนดความกว้างของรูปภาพ
                                height: 100, // กำหนดความสูงของรูปภาพ
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Text(
                                  'ไม่มีรายการที่สามารถขึ้นเงินได้',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF444444),
                                      fontFamily: "Prompt",
                                      letterSpacing: 1),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 100),
                          child: Column(
                            children: myLottoWinList
                                .map((wonlotto) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),
                                          child: Text(
                                            'รางวัลที่ ${wonlotto.prizeStatus.toString()}', // แสดงค่าของ winnub จากแต่ละรายการใน WonLottoList
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF1E1E1E),
                                                fontFamily: "Prompt",
                                                letterSpacing: 1),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Container(
                                            width:
                                                400, // Adjust the width according to your needs
                                            height:
                                                155, // Adjust the height according to your needs
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              border: Border.all(
                                                color: const Color(
                                                    0xFF000000), // Border color
                                                width: 2, // Border width
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                                  child: Stack(
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/elephant.png', // รูปช้างที่อยู่ด้านหลัง
                                                        width:
                                                            70, // กำหนดขนาดของรูปช้าง
                                                        height: 80,
                                                        fit: BoxFit
                                                            .cover, // ครอบคลุมขนาดของกรอบ
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 40,
                                                                top: 20),
                                                        child: Container(
                                                          width:
                                                              70, // กำหนดขนาดของโลโก้
                                                          height: 70,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape: BoxShape
                                                                .circle, // กำหนดให้เป็นวงกลม
                                                            border: Border.all(
                                                              color: Colors
                                                                  .black, // สีของขอบ
                                                              width:
                                                                  2, // ความหนาของขอบ
                                                            ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5), // สีของเงา
                                                                spreadRadius:
                                                                    2, // การกระจายของเงา
                                                                blurRadius:
                                                                    5, // ความเบลอของเงา
                                                                offset: const Offset(
                                                                    0,
                                                                    3), // การขยับของเงา (x, y)
                                                              ),
                                                            ],
                                                            image:
                                                                const DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/images/LottoLogo.jpg'), // รูปลอตเตอรี่
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 90,
                                                                left: 20),
                                                        child: Text(
                                                          '80',
                                                          style: TextStyle(
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xFF1E1E1E),
                                                              fontFamily:
                                                                  "Prompt",
                                                              letterSpacing: 1),
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 110,
                                                                left: 20),
                                                        child: Text(
                                                          'บาท',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xFF444444),
                                                              fontFamily:
                                                                  "Prompt",
                                                              letterSpacing: 1),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 5,
                                                                  vertical:
                                                                      2.5),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                0xFFDAE924), // สีพื้นหลังของช่องหมายเลข
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3.0),
                                                          ),
                                                          child: Text(
                                                            numLottoList[myLottoWinList
                                                                    .indexOf(
                                                                        wonlotto)]
                                                                .lotteryNumber
                                                                .toString(), // Display the lottery number
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 30,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                              letterSpacing:
                                                                  2.5,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 60),
                                                          child: Image.asset(
                                                            'assets/images/qrcode.png',
                                                            width: 60,
                                                            height: 60,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 70),
                                                          child: Image.asset(
                                                            'assets/images/animal.png',
                                                            width:
                                                                150, // Adjust the size according to your needs
                                                            height:
                                                                150, // Adjust the size according to your needs
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 90,
                                                                  left: 75),
                                                          child: FilledButton(
                                                            onPressed: () {
                                                              if (status ==
                                                                  'canClaim') {
                                                                dialog(
                                                                    wonlotto
                                                                        .drawId,
                                                                    wonlotto
                                                                        .prizeAmount);
                                                              }
                                                            },
                                                            style: ButtonStyle(
                                                              minimumSize:
                                                                  MaterialStateProperty.all(
                                                                      const Size(
                                                                          100,
                                                                          30)), // กำหนดขนาดของปุ่ม
                                                              backgroundColor:
                                                                  MaterialStateProperty.all(
                                                                      const Color(
                                                                          0xFF005A24)), // สีพื้นหลังของปุ่ม
                                                              shape:
                                                                  MaterialStateProperty
                                                                      .all(
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              25.0), // ทำให้ขอบมน
                                                                  side:
                                                                      const BorderSide(
                                                                    color: Color(
                                                                        0xFF00A94F), // กำหนดสีขอบเป็น #00A94F
                                                                    width:
                                                                        2.0, // ความหนาของขอบ
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            child: const Text(
                                                              'ขึ้นรางวัล',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color(
                                                                    0xFFFFFFFF),
                                                                fontFamily:
                                                                    "Prompt",
                                                                letterSpacing:
                                                                    1,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width:
                                                      40, // Adjust according to your needs
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xFF005A24),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(6.0),
                                                      bottomRight:
                                                          Radius.circular(6.0),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ))
                                .toList(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          menu,
        ]),
      ),
    );
  }

  Future<void> loadDataAsync() async {
    // await Future.delayed(const Duration(seconds: 2));
    try {
      var value = await Configuration.getConfig();
      url = value['apiEndpoint'];
      var data = await http
          .get(Uri.parse('$url/Ldraw/checkPrize?member_id=${user.id}'));
      if (data.body == 'No lottery draw found for the given lottery_ids' ||
          data.body == 'No lottery found for this member') {
        myLottoWinList = [];
        setState(() {});
        return;
      } else {
        numLottoList = [];
        myLottoWinList = myLottoWinGetResFromJson(data.body);
        for (var i = 0; i < myLottoWinList.length; i++) {
          var lotto = await http
              .get(Uri.parse('$url/lottery?id=${myLottoWinList[i].lotteryId}'));
          List<LottoAllGetRes> numLotto = lottoAllGetResFromJson(lotto.body);
          numLottoList.add(numLotto.first);
        }
        setState(() {
          status = 'canClaim';
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  claimPrize(int drawId, int money) async {
    var data = ClaimPrizePutReq(drawId: drawId, memberId: user.id);
    try {
      var value = await http.put(Uri.parse('$url/member/claimPrize'),
          headers: {"Content-Type": "application/json; charset=utf-8"},
          body: jsonEncode(data));
      log(value.body);
      showDialog(
        context: context,
        barrierDismissible: false,
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
            'เงินรางวัลเข้ากระเป๋าของคุณแล้ว',
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
      user.wallet_balance = user.wallet_balance + money;
      storage.write('walletBalance', user.wallet_balance);
      loadDataAsync();
    } catch (e) {
      log(e.toString());
    }
  }

  dialog(int drawId, int money) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0), // ทำให้มุมโค้งมน
        ),
        title: const Text('ยืนยันการขึ้นเงินรางวัล',
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
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '$money ฿',
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00A94F),
                          fontFamily: "Prompt",
                          letterSpacing: 5),
                    ),
                  ),
                ),
              ],
            ),
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
                    status = 'Claim';
                    claimPrize(drawId, money);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
