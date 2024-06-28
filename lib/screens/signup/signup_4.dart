import 'package:flutter/material.dart';
import 'package:flutter_mow/screens/info_screen_1.dart';
import 'package:flutter_mow/widgets/appbar_back.dart';
import 'package:flutter_mow/widgets/button_white.dart';
import 'package:flutter_mow/widgets/set_passwd.dart';
import 'package:flutter_mow/widgets/text_start.dart';

class SignUp4 extends StatelessWidget {
  const SignUp4({super.key});

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
                text: '비밀번호를',
              ),
              TextStart(
                text: '알려주세요 \u{1f92b}',
              ),
              SizedBox(
                height: 60,
              ),
              SetPasswd(
                label: '비밀번호 입력',
                labelColor: Color(0xFFC3C3C3),
                borderColor: Color(0xFFCCD1DD),
                obscureText: true,
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
