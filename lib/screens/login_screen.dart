import 'package:flutter/material.dart';
import 'package:flutter_mow/screens/info_screen_1.dart';
import 'package:flutter_mow/screens/signup/signup_1.dart';
import 'package:flutter_mow/widgets/button_main.dart';
import 'package:flutter_mow/widgets/input_bottom.dart';
import 'package:flutter_mow/widgets/sub_text.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //아이디, 비밀번호 text controller 선언
  final TextEditingController idController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  late bool isIdWrong = false;

  idCorrect() {
    setState(() {
      isIdWrong = false;
    });
  }

  idWrong() {
    setState(() {
      isIdWrong = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                  SvgPicture.asset('assets/icons/login_cat.svg'),
                  const SizedBox(
                    height: 30,
                  ),
                  InputBottom(
                    label: '아이디',
                    labelColor: const Color(0xFF6B4D38),
                    borderColor: const Color(0xFF6B4D38),
                    obscureText: false,
                    controller: idController,
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  InputBottom(
                    label: '비밀번호',
                    labelColor: const Color(0xFF6B4D38),
                    borderColor: const Color(0xFF6B4D38),
                    obscureText: true,
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  //아이디, 비밀번호 오류시 에러 메세지
                  Row(
                    children: [
                      SubText(
                        text: '아이디 혹은 비밀번호가 맞지 않습니다.',
                        textColor:
                            isIdWrong ? const Color(0xFFFF2E2E) : Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //로그인 버튼
                  ButtonMain(
                    text: '로그인',
                    bgcolor: const Color(0xFF6B4D38),
                    textColor: Colors.white,
                    borderColor: const Color(0xFF6B4D38),
                    onPress: () {
                      print('login id: ${idController.text}');
                      print('login pw: ${passwordController.text}');
                      // 아이디, 비밀번호 확인
                      if (idController.text == 'ididid') {
                        idCorrect();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InfoScreen1(),
                          ),
                        );
                      } else {
                        idWrong();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //비밀번호 찾기 버튼
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          '비밀번호 찾기',
                          style: TextStyle(
                            color: Color(0xFFC3C3C3),
                            fontSize: 14,
                            fontFamily: 'SF_Pro',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 1,
                        height: 20,
                        color: const Color(0xFFD9D9D9),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      //회원가입 버튼
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUp1(),
                            ),
                          );
                        },
                        child: const Text(
                          '회원가입',
                          style: TextStyle(
                            color: Color(0xFFC3C3C3),
                            fontSize: 14,
                            fontFamily: 'SF_Pro',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Expanded: 최대로 키우기
                      Expanded(
                        child: Container(
                          height: 1,
                          color: const Color(0xFFD9D9D9),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: Text(
                          '소셜 로그인',
                          style: TextStyle(
                            color: Color(0xFFC3C3C3),
                            fontSize: 14,
                            fontFamily: 'SF_Pro',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: const Color(0xFFD9D9D9),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Image.asset('assets/images/google.png'),
                      ),
                      const SizedBox(
                        width: 22,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Image.asset('assets/images/kakao.png'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
