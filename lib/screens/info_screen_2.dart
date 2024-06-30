import 'package:flutter/material.dart';
import 'package:flutter_mow/screens/info_screen_1.dart';
import 'package:flutter_mow/widgets/appbar_back.dart';
import 'package:flutter_mow/widgets/button_main.dart';
import 'package:flutter_mow/widgets/button_white.dart';
import 'package:flutter_mow/widgets/text_start.dart';
import 'package:flutter_mow/widgets/input_text.dart';

class InfoScreen2 extends StatelessWidget {
  InfoScreen2({super.key});

  final TextEditingController nameController = TextEditingController();

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
                text: 'MOW',
              ),
              const TextStart(
                text: '닉네임은 무엇인가요 ?',
              ),
              const SizedBox(
                height: 60,
              ),
              InputText(
                label: '닉네임을 입력해주세요',
                labelColor: const Color(0xFFC3C3C3),
                borderColor: const Color(0xFFCCD1DD),
                obscureText: false,
                controller: nameController,
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
                    print('your name is ${nameController.text}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InfoScreen1(),
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
