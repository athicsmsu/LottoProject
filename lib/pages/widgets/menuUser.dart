import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lotto_application/config/config.dart';
import 'package:lotto_application/models/Res/MyLottoWinGetRes.dart';
import 'package:lotto_application/pages/user/claimprize.dart';
import 'package:lotto_application/pages/user/profile.dart';
import 'package:lotto_application/pages/user/reward.dart';
import 'package:lotto_application/pages/user/lotto.dart';
import 'package:lotto_application/pages/user/main.dart';
import 'package:lotto_application/shared/app_data.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MenuUser extends StatefulWidget {
  const MenuUser({super.key});

  @override
  State<MenuUser> createState() => _MenuUserState();
}

class _MenuUserState extends State<MenuUser> {
  int colorMain = 0xFF555555;
  int colorReward = 0xFF555555;
  int colorLottoWin = 0xFF555555;
  int colorProfile = 0xFF555555;
  int colorLotto = 0xFF777777;
  int colorLotto2 = 0xFF666666;
  var page = '';
  late Future<void> loadData;
  String url = '';
  late MemberProfile user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page = context.read<Appdata>().page;
    user = context.read<Appdata>().user;
    if (page == 'mainUser') {
      colorMain = 0xFF54B799;
    } else if (page == 'RewardPage') {
      colorReward = 0xFF54B799;
    } else if (page == 'LottoWinPage') {
      colorLottoWin = 0xFF54B799;
    } else if (page == 'ProfilePage') {
      colorProfile = 0xFF54B799;
    } else if (page == 'LottoPage') {
      colorLotto = 0xFF54B799;
      colorLotto2 = 0xFF125B4D;
    }
    // log(page);
    loadData = loadDataAsync();
  }

  @override
  Widget build(BuildContext context) {
    var align = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2.5),
        width: 400,
        height: 70,
        decoration: const BoxDecoration(
          color: Color(0xFFD9D9D9), // สีพื้นหลัง
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ), // ขอบมนที่ด้านบน
        ),
        child: Stack(
          clipBehavior: Clip.none, // อนุญาตให้มีการวางซ้อนออกนอกขอบ Container
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (page != 'mainUser') {
                      context.read<Appdata>().page = 'mainUser';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainUserPage(),
                        ),
                      );
                    }
                    setState(() {});
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.home,
                        size: 40,
                        color: Color(colorMain),
                      ),
                      Text(
                        'หน้าหลัก',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(colorMain),
                            fontFamily: "Prompt",
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (page != 'RewardPage') {
                      context.read<Appdata>().page = 'RewardPage';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RewardPage(),
                        ),
                      );
                    }
                    setState(() {});
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        size: 40,
                        color: Color(colorReward),
                      ),
                      Text(
                        'รางวัล',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(colorReward),
                            fontFamily: "Prompt",
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                ),
                // ช่องว่างสำหรับตรงกลาง
                const SizedBox(width: 80), // เว้นช่องว่างตรงกลางสำหรับไอคอนใหญ่
                GestureDetector(
                  onTap: () {
                    if (page != 'LottoWinPage') {
                      context.read<Appdata>().page = 'LottoWinPage';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ClaimPrizePage(),
                        ),
                      );
                    }
                  },
                  child: Stack(
                    clipBehavior: Clip
                        .none, // Allow the notification to overflow the icon
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.attach_money,
                            size: 40,
                            color: Color(colorLottoWin),
                          ),
                          Text(
                            'ขึ้นเงิน',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(colorLottoWin),
                                fontFamily: "Prompt",
                                letterSpacing: 1),
                          ),
                        ],
                      ),
                      if (context.read<Appdata>().notificationCount > 0)
                        Positioned(
                          right:
                              -5, // Adjust this based on the positioning you need
                          top:
                              -10, // Adjust this to place the badge above the icon
                          child: Container(
                            padding: const EdgeInsets.all(
                                2), // Padding inside the badge
                            decoration: BoxDecoration(
                              color:
                                  Colors.red, // Background color of the badge
                              borderRadius:
                                  BorderRadius.circular(12), // Circular badge
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 24, // Minimum width for the badge
                              minHeight: 24, // Minimum height for the badge
                            ),
                            child: Center(
                              child: Text(
                                '${context.read<Appdata>().notificationCount}', // The number to display in the badge
                                style: const TextStyle(
                                  color: Colors
                                      .white, // Text color inside the badge
                                  fontSize: 12, // Text size
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (page != 'ProfilePage') {
                      context.read<Appdata>().page = 'ProfilePage';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        size: 40,
                        color: Color(colorProfile),
                      ),
                      Text(
                        'โปรไฟล์',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(colorProfile),
                            fontFamily: "Prompt",
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: -40, // วางตำแหน่งไอคอนให้อยู่เหนือขอบของ Container
              left: 140, // ปรับตำแหน่งเพื่อให้ไอคอนอยู่ตรงกลาง
              child: GestureDetector(
                onTap: () {
                  if (page != 'LottoPage') {
                    context.read<Appdata>().page = 'LottoPage';
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LottoPage(),
                      ),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(colorLotto),
                    border: Border.all(
                      color: Color(colorLotto2),
                      width: 5, // ขนาดของเส้นขอบ
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15), // ระยะห่างจากขอบไอคอน
                    child: Icon(
                      Icons.local_activity_sharp,
                      size: 50,
                      color: Color(0xFFFFFFFF), // เปลี่ยนสีของไอคอนได้ที่นี่
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return align;
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
        context.read<Appdata>().notificationCount = 0;
        setState(() {});
        return;
      } else {
        context.read<Appdata>().notificationCount =
            myLottoWinGetResFromJson(data.body).length;
        setState(() {});
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
