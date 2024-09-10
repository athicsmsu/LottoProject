import 'package:flutter/material.dart';
import 'package:lotto_application/config/config.dart';
import 'package:lotto_application/models/Res/LottoAllGetRes.dart';
import 'package:lotto_application/pages/admin/adward.dart';
import 'package:lotto_application/pages/admin/profile.dart';
import 'package:lotto_application/pages/admin/setting.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_application/shared/app_data.dart';

class MainAdminPage extends StatefulWidget {
  const MainAdminPage({super.key});

  @override
  State<MainAdminPage> createState() => _MainAdminPageState();
}

class _MainAdminPageState extends State<MainAdminPage> {
  List<LottoAllGetRes> LottoAll = [];
  late Future<void> loadData;
  String url = '';
  String namebutton = '';
  late MemberProfile user;
  
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
            ),
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        FilledButton(
                          onPressed: loadDataAsync,
                          style: FilledButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF54B799), // สีพื้นหลังของปุ่ม
                            foregroundColor: Colors.white, // สีของข้อความบนปุ่ม
                          ),
                          child: const Text("ทั้งหมด"),
                        ),
                        FilledButton(
                          onPressed: lotteryBuy,
                          style: FilledButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF54B799), // สีพื้นหลังของปุ่ม
                            foregroundColor: Colors.white, // สีของข้อความบนปุ่ม
                          ),
                          child: const Text("ขายแล้ว"),
                        ),
                        FilledButton(
                          onPressed: lotteryNotSlod,
                          style: FilledButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF54B799), // สีพื้นหลังของปุ่ม
                            foregroundColor: Colors.white, // สีของข้อความบนปุ่ม
                          ),
                          child: const Text("ยังไม่ขาย"),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // สีพื้นหลัง
                          border: Border.all(
                            color: const Color(0xFF54B799), // สีของเส้นขอบ
                            width: 2.0, // ความหนาของเส้นขอบ
                          ),
                        ),
                        child: SizedBox(
                          width: 400,
                          height: 600,
                          child: FutureBuilder<void>(
                            future: loadData,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text("Error: ${snapshot.error}"));
                              } else if (LottoAll.isEmpty) {
                                return const Padding(
                                  padding: EdgeInsets.only(bottom: 150),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 250),
                                      Center(
                                          child: Icon(Icons.error,
                                              size: 100,
                                              color: Color.fromARGB(
                                                  255, 106, 106, 106))),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Center(
                                          child: Text(
                                            'ไม่มีตัวเลขในระบบ',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 106, 106, 106),
                                                fontFamily: "Prompt",
                                                letterSpacing: 1),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, // Number of columns
                                    crossAxisSpacing: 8.0,
                                    mainAxisSpacing: 8.0,
                                  ),
                                  itemCount: LottoAll.length,
                                  itemBuilder: (context, index) {
                                    if (namebutton == 'ทั้งหมด') {
                                      final lotto = LottoAll[index];
                                      return Card(
                                        color: const Color(0xFF139D51),
                                        elevation: 5,
                                        child: Center(
                                          child: Text(
                                            lotto.lotteryNumber
                                                .toString(), // Adjust based on your model
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontFamily: "Prompt",
                                                letterSpacing: 1),
                                          ),
                                        ),
                                      );
                                    } else if (namebutton == 'ยังไม่ขาย') {
                                      final lotto = LottoAll[index];
                                      return Card(
                                        color: Color.fromARGB(255, 255, 77, 70),
                                        elevation: 5,
                                        child: Center(
                                          child: Text(
                                            lotto.lotteryNumber
                                                .toString(), // Adjust based on your model
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontFamily: "Prompt",
                                                letterSpacing: 1),
                                          ),
                                        ),
                                      );
                                    }
                                    else if (namebutton == 'ขายไปแล้ว') {
                                      final lotto = LottoAll[index];
                                      return Card(
                                        color: Color.fromARGB(255, 31, 190, 204),
                                        elevation: 5,
                                        child: Center(
                                          child: Text(
                                            lotto.lotteryNumber
                                                .toString(), // Adjust based on your model
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontFamily: "Prompt",
                                                letterSpacing: 1),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    
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
                    const Column(
                      children: [
                        Icon(
                          Icons.home,
                          size: 40,
                          color: Color(0xFF54B799),
                        ),
                        Text(
                          'หน้าหลัก',
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
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    int check = 0;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(Icons.warning_amber, color: Colors.red),
          content: const Text("ต้องการสร้างตัวเลขใหม่ใช่หรือไม่"),
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
                      content: const Text('สร้างตัวเลขใหม่เรียบร้อยแล้ว'),
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

  Future<void> loadDataAsync() async {
    namebutton = "ทั้งหมด";
    var value = await Configuration.getConfig();
    url = value['apiEndpoint'];
    var data = await http.get(Uri.parse('$url/lottery/all'));
    LottoAll = lottoAllGetResFromJson(data.body);
    setState(() {});
  }

  Future<void> lotteryNotSlod() async {
    namebutton = "ยังไม่ขาย";
    var value = await Configuration.getConfig();
    url = value['apiEndpoint'];
    var data = await http.get(Uri.parse('$url/lottery/allnotSold'));
    LottoAll = lottoAllGetResFromJson(data.body);
    setState(() {});
  }

  Future<void> lotteryBuy() async {
    namebutton = "ขายไปแล้ว";
    var value = await Configuration.getConfig();
    url = value['apiEndpoint'];
    var data = await http.get(Uri.parse('$url/lottery/allBuy'));
    LottoAll = lottoAllGetResFromJson(data.body);
    setState(() {});
  }
}
