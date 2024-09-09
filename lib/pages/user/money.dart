import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lotto_application/config/config.dart';
import 'package:lotto_application/models/Req/AddMoneyPutReq.dart';
import 'package:lotto_application/shared/app_data.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MoneyPage extends StatefulWidget {
  const MoneyPage({super.key});

  @override
  State<MoneyPage> createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  GetStorage storage = GetStorage();
  late MemberProfile user;
  String url = '';
  TextEditingController phoneCtl = TextEditingController();
  TextEditingController moneyCtl = TextEditingController();
  bool isApplePaySelected = true;
  bool isPayPalSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = context.read<Appdata>().user;

    var txtPhone = user.phone;
    if (txtPhone.length > 10) {
      txtPhone = txtPhone.substring(0, 10);
    }
    if (txtPhone.length > 3 && txtPhone.length <= 6) {
      txtPhone = '${txtPhone.substring(0, 3)}-${txtPhone.substring(3)}';
    } else if (txtPhone.length > 6) {
      txtPhone =
          '${txtPhone.substring(0, 3)}-${txtPhone.substring(3, 6)}-${txtPhone.substring(6, txtPhone.length)}';
    }
    phoneCtl.text = txtPhone;
  }

  void _onApplePayTapped() {
    setState(() {
      isApplePaySelected = true;
      isPayPalSelected = false;
    });
  }

  void _onPayPalTapped() {
    setState(() {
      isApplePaySelected = false;
      isPayPalSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(200.0), // ปรับความสูงของ AppBar
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(16.0), // ปรับขอบให้มนที่มุมล่าง
            ),
            child: AppBar(
              automaticallyImplyLeading: false, // ปิดการแสดงผล leading default
              flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 38.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .min, // ปรับขนาดของ Row ให้พอดีกับเนื้อหาภายใน
                      children: [
                        Container(
                          width: 90, // กำหนดความกว้าง
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFD9D9D9), // สีของกรอบ
                              width: 5, // ความหนาของกรอบ
                            ),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              user.image,
                              width: 80, // กำหนดความกว้างของรูปภาพ
                              height: 80, // กำหนดความสูงของรูปภาพ
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'คุณ ${user.fullname}',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF54B799),
                                  fontFamily: "Prompt",
                                  letterSpacing: 1),
                            ),
                            Text(
                              '${user.wallet_balance} บาท',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFD9D9D9),
                                  fontFamily: "Prompt",
                                  letterSpacing: 1),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(), // เพิ่มระยะห่างด้านล่างของ Container
                ],
              ),
            ),
          ),
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
                            'เติมเงิน',
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
                  const Text(
                    'เบอร์มือถือ : ',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF555555),
                        fontFamily: "Prompt",
                        letterSpacing: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      controller: phoneCtl,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(
                          fontFamily:
                              'Prompt', // เปลี่ยนฟอนต์ของข้อความใน TextField
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                          color: Color(0xFF555555)),
                      textAlign:
                          TextAlign.right, // จัดข้อความให้เริ่มที่ด้านขวา
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(
                                0xFFD9D9D9), // สีของเส้นใต้เมื่อ TextField ไม่ถูกเลือก
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(
                                0xFF54B799), // สีของเส้นใต้เมื่อ TextField ถูกเลือก
                          ),
                        ),
                        hintText:
                            'กรอกเบอร์โทรศัพท์', // ข้อความแนะนำใน TextField
                        hintStyle: TextStyle(
                          color: Color(0xFF555555), // สีของข้อความแนะนำ
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        PhoneNumberFormatter(), // เพิ่ม Formatter ที่กำหนดเอง
                      ],
                    ),
                  ),
                  const Text(
                    'จำนวน : ',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF555555),
                        fontFamily: "Prompt",
                        letterSpacing: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50, top: 10),
                    child: TextField(
                      controller: moneyCtl,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(
                          fontFamily:
                              'Prompt', // เปลี่ยนฟอนต์ของข้อความใน TextField
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                          color: Color(0xFF54B799)),
                      textAlign:
                          TextAlign.right, // จัดข้อความให้เริ่มที่ด้านขวา
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(
                                0xFFD9D9D9), // สีของเส้นใต้เมื่อ TextField ไม่ถูกเลือก
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(
                                0xFF54B799), // สีของเส้นใต้เมื่อ TextField ถูกเลือก
                          ),
                        ),
                        hintText: '0.00 บาท', // ข้อความแนะนำใน TextField
                        hintStyle: TextStyle(
                          color: Color(0xFF555555), // สีของข้อความแนะนำ
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                      ],
                      onTap: () {
                        moneyCtl.text = moneyCtl.text.replaceAll(' บาท', '');
                      },
                      onChanged: _updateText,
                      onSubmitted: (value) {
                        moneyCtl.text = moneyCtl.text.replaceAll(' บาท', '');
                        if (moneyCtl.text.isNotEmpty) {
                          moneyCtl.text = "${moneyCtl.text} บาท";
                        }
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: _onApplePayTapped,
                    child: Container(
                      width: 400,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isApplePaySelected
                              ? const Color(0xFF54B799)
                              : const Color(
                                  0xFFD9D9D9), // สีของเส้นขอบเมื่อเลือก
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/images/apple_pay.png',
                            width: 50.0,
                            height: 50.0,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'ชำระผ่าน',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: isApplePaySelected
                                  ? const Color(0xFF54B799)
                                  : const Color(
                                      0xFF555555), // สีของข้อความเมื่อเลือก
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _onPayPalTapped,
                    child: Container(
                      width: 400,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isPayPalSelected
                              ? const Color(0xFF54B799)
                              : const Color(
                                  0xFFD9D9D9), // สีของเส้นขอบเมื่อเลือก
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/images/paypal.png',
                            width: 50.0,
                            height: 50.0,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'ชำระผ่าน',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: isPayPalSelected
                                  ? const Color(0xFF54B799)
                                  : const Color(
                                      0xFF555555), // สีของข้อความเมื่อเลือก
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ],
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
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
              height: 70,
              color: const Color(0xFFFFFFFF),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        ClipOval(
                          child: Container(
                            color: const Color(
                                0xFFE84C1B), // สีพื้นหลังภายใน ClipOval
                            padding: const EdgeInsets.all(
                                5.0), // เพิ่ม padding เพื่อให้มีพื้นที่สีรอบไอคอน
                            child: const Icon(
                              Icons.close,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'ยกเลิก',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                                fontFamily: "Prompt",
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      dialog(1);
                    },
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'ตกลง',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                                fontFamily: "Prompt",
                                letterSpacing: 1),
                          ),
                        ),
                        ClipOval(
                          child: Container(
                            color: const Color(
                                0xFF139D51), // สีพื้นหลังภายใน ClipOval
                            padding: const EdgeInsets.all(5.0),
                            child: const Icon(
                              Icons.done,
                              size: 40,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void _updateText(String text) {
    // ลบคำว่า "บาท" ออกก่อน
    String newText = text.replaceAll(' บาท', '');

    // ตรวจสอบว่ามีการพิมพ์เสร็จแล้วหรือไม่
    if (!newText.contains(RegExp(r'[1-9.]'))) {
      newText = ''; // กำหนดค่าเริ่มต้นหากไม่มีการพิมพ์เลข
    }

    // แยกส่วนทศนิยมและส่วนจำนวนเต็ม
    List<String> parts = newText.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';

    // รูปแบบเงิน: ตัวเลขแต่ละหลัก
    String formattedIntegerPart = '';
    for (int i = 0; i < integerPart.length; i++) {
      if (i > 0 && (integerPart.length - i) % 3 == 0) {
        formattedIntegerPart += ',';
      }
      formattedIntegerPart += integerPart[i];
    }

    // จำกัดทศนิยมที่ 2 หลัก
    if (decimalPart.length > 2) {
      decimalPart = decimalPart.substring(0, 2);
    }

    // การจัดรูปแบบรวม
    String formattedText = formattedIntegerPart;
    if (decimalPart.isNotEmpty) {
      formattedText += '.$decimalPart';
    }

    // อัปเดตข้อความใน TextField
    moneyCtl.value = moneyCtl.value.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  void dialog(int check) {
    if (phoneCtl.text.isEmpty || moneyCtl.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'ผิดพลาด',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE84C1B),
                fontFamily: "Prompt",
                letterSpacing: 1),
          ),
          content: const Text(
            'คุณกรอกข้อมูลไม่ครบ',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF000000),
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
    } else if (check == 0) {
      Navigator.of(context).pop();
    } else if(check == 1){
      addMoney();
    }
    else if (check == 2) {
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
            'เติมเงินเสร็จสิ้น',
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
                  dialog(0);
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
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'ผิดพลาด',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE84C1B),
                fontFamily: "Prompt",
                letterSpacing: 1),
          ),
          content: const Text(
            'เบอร์มือถือไม่ถูกต้อง',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF000000),
                fontFamily: "Prompt",
                letterSpacing: 1),
          ),
          actions: [
            FilledButton(
              onPressed: () {
                 _updateText(moneyCtl.text);
                if (phoneCtl.text.length > 3 && phoneCtl.text.length <= 6) {
                  phoneCtl.text = phoneCtl.text.substring(0, 3) +
                      '-' +
                      phoneCtl.text.substring(3);
                } else if (phoneCtl.text.length > 6) {
                  phoneCtl.text = phoneCtl.text.substring(0, 3) +
                      '-' +
                      phoneCtl.text.substring(3, 6) +
                      '-' +
                      phoneCtl.text.substring(6, phoneCtl.text.length);
                }
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
    }
  }

  void addMoney() async {
    moneyCtl.text = moneyCtl.text.replaceAll(' บาท', '');
    phoneCtl.text = phoneCtl.text.replaceAll('-', '');
    var value = await Configuration.getConfig();
    url = value['apiEndpoint'];
    AddMoneyPutReq addMoneyPutReq =
        AddMoneyPutReq(phone: phoneCtl.text, amount: int.parse(moneyCtl.text));
    var data = await http.put(Uri.parse('$url/member/deposit'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: jsonEncode(addMoneyPutReq));
    log(data.body);

     // แปลง data.body จาก JSON string ไปเป็น JSON object
    var responseBody = jsonDecode(data.body);
    log(responseBody['message']);
    if(responseBody['message'] == 'Funds added successfully'){
      dialog(2);
      if(phoneCtl.text == user.phone){
        user.wallet_balance = user.wallet_balance + int.parse(moneyCtl.text);
        storage.write('walletBalance', user.wallet_balance);
      } else {
        
      }
    } else {
      dialog(3);
    }
  }
}

// ปรับปรุง PhoneNumberFormatter เพื่อรองรับรูปแบบ XXX-XXX-XXXX
class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;

    // ลบขีดทั้งหมดออกก่อนการจัดรูปแบบใหม่
    text = text.replaceAll('-', '');
    // จำกัดจำนวนตัวเลขไม่เกิน 10 ตัว
    if (text.length > 10) {
      text = text.substring(0, 10);
    }

    if (text.length > 3 && text.length <= 6) {
      text = text.substring(0, 3) + '-' + text.substring(3);
    } else if (text.length > 6) {
      text = text.substring(0, 3) +
          '-' +
          text.substring(3, 6) +
          '-' +
          text.substring(6, text.length);
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
