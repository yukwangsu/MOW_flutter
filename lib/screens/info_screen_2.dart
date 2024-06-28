import 'package:flutter/material.dart';
import 'package:flutter_mow/screens/info_screen_1.dart';
import 'package:flutter_mow/widgets/appbar_back.dart';
import 'package:flutter_mow/widgets/button_white.dart';
import 'package:flutter_mow/widgets/text_start.dart';
import 'package:flutter_mow/widgets/input_text.dart';

class InfoScreen2 extends StatelessWidget {
  const InfoScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarBack(),
      resizeToAvoidBottomInset: false, //키보드가 올라와도 화면이 그대로 유지
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
              ),
              TextStart(
                text: 'MOW',
              ),
              TextStart(
                text: '닉네임은 무엇인가요 ?',
              ),
              SizedBox(
                height: 60,
              ),
              InputText(
                label: '닉네임을 입력해주세요',
                labelColor: Color(0xFFC3C3C3),
                borderColor: Color(0xFFCCD1DD),
                obscureText: false,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 27),
            child: Column(
              children: [
                ButtonWhite(
                  text: '다음',
                  bgcolor: Colors.white,
                  textColor: Color(0xFF6B4D38),
                  borderColor: Color(0xFF6B4D38),
                  nextPage: InfoScreen1(),
                ),
                SizedBox(
                  height: 68,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
