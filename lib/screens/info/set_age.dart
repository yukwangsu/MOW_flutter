import 'package:flutter/material.dart';
import 'package:flutter_mow/screens/info/set_sex.dart';
import 'package:flutter_mow/widgets/appbar_back.dart';
import 'package:flutter_mow/widgets/button_main.dart';
import 'package:flutter_mow/widgets/input_digit.dart';
import 'package:flutter_mow/widgets/text_start.dart';

class SetAge extends StatelessWidget {
  final String email;
  final String passwd;
  final String name;

  SetAge({
    super.key,
    required this.email,
    required this.passwd,
    required this.name,
  });

  final TextEditingController ageController = TextEditingController();

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
                text: '000님의',
              ),
              const TextStart(
                text: '나이가 궁금해요 !',
              ),
              const SizedBox(
                height: 60,
              ),
              InputDigit(
                label: '나이를 입력해주세요',
                labelColor: const Color(0xFFC3C3C3),
                borderColor: const Color(0xFFCCD1DD),
                obscureText: false,
                controller: ageController,
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
                    print(
                        'info[email: $email, passwd: $passwd, name: $name, age: ${ageController.text}]');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SetSex(
                          email: email,
                          passwd: passwd,
                          name: name,
                          age: int.tryParse(ageController.text),
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
