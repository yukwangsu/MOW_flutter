import 'package:flutter/material.dart';
import 'package:flutter_mow/screens/signup/signup_4.dart';
import 'package:flutter_mow/widgets/appbar_back.dart';
import 'package:flutter_mow/widgets/button_white.dart';
import 'package:flutter_mow/widgets/text_start.dart';
import 'package:flutter_mow/widgets/input_4digit.dart';

class SignUp3 extends StatelessWidget {
  const SignUp3({super.key});

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
                text: '이메일로 전송된',
              ),
              TextStart(
                text: '인증코드를 알려주세요!',
              ),
              SizedBox(
                height: 60,
              ),
              Input4digit(),
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
                  nextPage: SignUp4(),
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
