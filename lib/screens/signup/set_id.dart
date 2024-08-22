import 'package:flutter/material.dart';
import 'package:flutter_mow/screens/signup/enter_code.dart';
import 'package:flutter_mow/services/signup_service.dart';
import 'package:flutter_mow/widgets/appbar_back.dart';
import 'package:flutter_mow/widgets/button_main.dart';
import 'package:flutter_mow/widgets/sub_text.dart';
import 'package:flutter_mow/widgets/text_start.dart';
import 'package:flutter_mow/widgets/input_text.dart';

class SignUpSetId extends StatefulWidget {
  const SignUpSetId({super.key});

  @override
  State<SignUpSetId> createState() => _SignUpSetIdState();
}

class _SignUpSetIdState extends State<SignUpSetId> {
  final TextEditingController idController = TextEditingController();

  bool isEmailExisted = false;

  emailExisted() {
    setState(() {
      isEmailExisted = true;
    });
  }

  emailNotExisted() {
    setState(() {
      isEmailExisted = false;
    });
  }

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
                borderColor: isEmailExisted
                    ? const Color(0xFFFF2E2E)
                    : const Color(0xFFCCD1DD),
                obscureText: false,
                controller: idController,
              ),
              if (isEmailExisted) ...[
                const Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 31,
                        ),
                        SubText(
                            text: '이미 존재하는 이메일입니다.',
                            textColor: Color(0xFFFF2E2E)),
                      ],
                    ),
                  ],
                ),
              ]
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
                  onPress: () async {
                    print('send email to ${idController.text}');
                    bool success = await SignupService.checkEmail(
                      idController.text,
                    );
                    if (success) {
                      emailNotExisted();
                      //context.mounted: mounted는 StatefulWidget의 State 객체가 위젯 트리에 연결(mounted)되어 있는지를 나타내는 속성이다.
                      //context.mounted는 현재의 BuildContext가 여전히 유효한 상태인지, 즉 State가 아직도 위젯 트리에 연결되어 있는지를 확인하는 데 사용된다.
                      if (!context.mounted) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpEnterCode(
                            email: idController.text,
                          ),
                        ),
                      );
                    } else {
                      emailExisted();
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
