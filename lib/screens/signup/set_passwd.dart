import 'package:flutter/material.dart';
import 'package:flutter_mow/screens/info/hi.dart';
import 'package:flutter_mow/services/signup_service.dart';
import 'package:flutter_mow/widgets/appbar_back.dart';
import 'package:flutter_mow/widgets/button_main.dart';
import 'package:flutter_mow/widgets/set_passwd.dart';
import 'package:flutter_mow/widgets/text_start.dart';

class SignUpSetPw extends StatelessWidget {
  final String email;

  SignUpSetPw({
    super.key,
    required this.email,
  });

  final TextEditingController passwdController = TextEditingController();
  final TextEditingController sameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppbarBack(),
      resizeToAvoidBottomInset: false, //키보드가 올라와도 화면이 그대로 유지
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              const TextStart(
                text: '비밀번호를',
              ),
              const TextStart(
                text: '알려주세요 \u{1f92b}',
              ),
              const SizedBox(
                height: 60,
              ),
              SetPasswd(
                label: '비밀번호 입력',
                labelColor: const Color(0xFFC3C3C3),
                borderColor: const Color(0xFFCCD1DD),
                obscureText: true,
                controller: passwdController,
                controllerSame: sameController,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27),
            child: Column(
              children: [
                ButtonMain(
                  text: '다음',
                  bgcolor: Colors.white,
                  textColor: const Color(0xFF6B4D38),
                  borderColor: const Color(0xFF6B4D38),
                  onPress: () {
                    if (passwdController.text == sameController.text) {
                      print('your email: $email');
                      print('your passwd: ${passwdController.text}');
                      SignupService.signup(
                        email,
                        passwdController.text,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InfoHi(
                            email: email,
                            passwd: passwdController.text,
                          ),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(
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
