import 'package:flutter/material.dart';
import 'package:lotto_application/pages/user/lottowin.dart';
import 'package:lotto_application/pages/user/profile.dart';
import 'package:lotto_application/pages/user/reward.dart';
import 'package:lotto_application/pages/user/lotto.dart';
import 'package:lotto_application/pages/user/main.dart';
import 'package:lotto_application/shared/app_data.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page = context.read<Appdata>().page;
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
                          builder: (context) => const LottoWinPage(),
                        ),
                      );
                    }
                  },
                  child: Column(
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
}
