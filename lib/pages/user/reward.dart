import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lotto_application/config/config.dart';
import 'package:lotto_application/models/Res/LottoAllGetRes.dart';
import 'package:lotto_application/models/Res/RewardLottoGetRes.dart';
import 'package:lotto_application/pages/login.dart';
import 'package:lotto_application/pages/widgets/menuUser.dart';
import 'package:lotto_application/shared/app_data.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class RewardPage extends StatefulWidget {
  const RewardPage({super.key});

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  MenuUser menu = const MenuUser();
  List<RewardLottoGetRes> rewardLotto = [];
  List<String> lottoList = [];
  late Future<void> loadData;
  late MemberProfile user;
  String url = '';

  @override
  void initState() {
    super.initState();
    user = context.read<Appdata>().user;
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                          'เลขรางวัล',
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
                    } else if (rewardLotto.isEmpty) {
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
                                'ไม่มีรายการรางวัลที่ออก',
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
                      return Column(
                        children: rewardLotto
                            .map(
                              (reward) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
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
                                                alignment: Alignment.center,
                                                child: Text(
                                                  reward.prizeStatus.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 40,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFFFFFFFF),
                                                    fontFamily: "Prompt",
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
                                          width:
                                              300, // กำหนดความกว้างของกรอบทั้งหมดให้เท่ากัน
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 8.0),
                                          decoration: BoxDecoration(
                                            color: const Color(
                                                0xFFD9D9D9), // สีพื้นหลังของช่องหมายเลข
                                            borderRadius:
                                                BorderRadius.circular(3.0),
                                            border: Border.all(
                                              color: const Color(
                                                  0xFF139D51), // สีขอบของช่องหมายเลข
                                              width: 10.0,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceEvenly, // กระจายตัวเลขให้มีช่องว่างเท่ากัน
                                            children: [
                                              for (var digit in lottoList[
                                                      reward.prizeStatus - 1]
                                                  .split(''))
                                                Text(
                                                  digit,
                                                  style: const TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFF1E1E1E),
                                                      fontFamily: "Prompt",
                                                      letterSpacing: 1),
                                                ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 15),
                                          child: Text(
                                            'เงินรางวัล ${reward.prizeAmount} บาท',
                                            style: const TextStyle(
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
                            )
                            .toList(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          menu,
        ]),
      ),
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
