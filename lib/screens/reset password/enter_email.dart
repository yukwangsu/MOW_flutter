import 'package:flutter/material.dart';
import 'package:flutter_mow/screens/reset%20password/enter_code.dart';
import 'package:flutter_mow/widgets/appbar_back.dart';
import 'package:flutter_mow/widgets/button_main.dart';
import 'package:flutter_mow/widgets/text_start.dart';
import 'package:flutter_mow/widgets/input_text.dart';

class EnterEmail extends StatefulWidget {
  const EnterEmail({super.key});

  @override
  State<EnterEmail> createState() => _EnterEmailState();
}

class _EnterEmailState extends State<EnterEmail> {
  final TextEditingController idController = TextEditingController();

  bool isEmailExisted = true;
  double buttonOpacity = 0.5;
  bool bottonWork = false;

  @override
  void initState() {
    super.initState();
    idController.addListener(_checkEmailInput);
  }

  @override
  void dispose() {
    idController.removeListener(_checkEmailInput);
    idController.dispose();
    super.dispose();
  }

  void _checkEmailInput() {
    if (idController.text.contains('@')) {
      bottonWork = true;
      setState(() {
        buttonOpacity = 1.0;
      });
    } else {
      bottonWork = false;
      setState(() {
        buttonOpacity = 0.5;
      });
    }
  }

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
                text: '가입시 사용한',
              ),
              const TextStart(
                text: '이메일을 입력해주세요.',
              ),
              const SizedBox(
                height: 60,
              ),
              InputText(
                label: '이메일 입력',
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
                  text: '인증코드 받기',
                  bgcolor: Colors.white,
                  textColor: const Color(0xFF6B4D38),
                  borderColor: const Color(0xFF6B4D38),
                  opacity: buttonOpacity,
                  onPress: () {
                    if (bottonWork) {
                      print('send email to ${idController.text}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EnterCode(),
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
