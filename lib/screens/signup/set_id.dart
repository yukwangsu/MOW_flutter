import 'package:flutter/material.dart';
import 'package:flutter_mow/screens/signup/enter_code.dart';
import 'package:flutter_mow/widgets/appbar_back.dart';
import 'package:flutter_mow/widgets/button_main.dart';
import 'package:flutter_mow/widgets/text_start.dart';
import 'package:flutter_mow/widgets/input_text.dart';

class SignUpSetId extends StatelessWidget {
  SignUpSetId({super.key});

  final TextEditingController idController = TextEditingController();

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
                text: '아이디를',
              ),
              const TextStart(
                text: '알려주세요!',
              ),
              const SizedBox(
                height: 60,
              ),
              InputText(
                label: 'mow@mow.com',
                labelColor: const Color(0xFFC3C3C3),
                borderColor: const Color(0xFFCCD1DD),
                obscureText: false,
                controller: idController,
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
                    print('send email to ${idController.text}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpEnterCode(
                          email: idController.text,
                        ),
                      ),
                    );
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
