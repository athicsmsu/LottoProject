import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // เพิ่ม import นี้สำหรับ TextInputFormatter
import 'package:lotto_application/pages/login.dart';
import 'package:lotto_application/pages/user/cash.dart';
import 'package:lotto_application/pages/user/lotto.dart';
import 'package:lotto_application/pages/user/main.dart';
import 'package:lotto_application/pages/user/reward.dart';

class MoneyPage extends StatefulWidget {
  const MoneyPage({super.key});

  @override
  State<MoneyPage> createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  TextEditingController phoneCtl = TextEditingController();
  TextEditingController moneyCtl = TextEditingController();
  bool isApplePaySelected = false;
  bool isPayPalSelected = false;

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
                            child: Image.asset(
                              'assets/images/LottoLogo.jpg',
                              width: 80, // กำหนดความกว้างของรูปภาพ
                              height: 80, // กำหนดความสูงของรูปภาพ
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'คุณ ยงยอด แสนดี',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF54B799),
                                  fontFamily: "Prompt",
                                  letterSpacing: 1),
                            ),
                            Text(
                              '21.00 บาท',
                              style: TextStyle(
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
                    padding: const EdgeInsets.only(bottom: 50,top: 10),
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
                              ? Color(0xFF54B799)
                              : Color(0xFFD9D9D9), // สีของเส้นขอบเมื่อเลือก
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
                                  ? Color(0xFF54B799)
                                  : Color(0xFF555555), // สีของข้อความเมื่อเลือก
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: _onPayPalTapped,
                    child: Container(
                      width: 400,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isPayPalSelected
                              ? Color(0xFF54B799)
                              : Color(0xFFD9D9D9), // สีของเส้นขอบเมื่อเลือก
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
                                  ? Color(0xFF54B799)
                                  : Color(0xFF555555), // สีของข้อความเมื่อเลือก
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
                      log(phoneCtl.text.replaceAll('-', ''));
                      log(moneyCtl.text.replaceAll(',', ''));
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