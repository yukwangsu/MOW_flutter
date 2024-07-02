import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputDigit extends StatelessWidget {
  final String label;
  final Color labelColor;
  final Color borderColor;
  final bool obscureText;
  final TextEditingController controller; //입력값 controller

  const InputDigit({
    super.key,
    required this.label,
    required this.labelColor,
    required this.borderColor,
    required this.obscureText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27),
      child: TextField(
        controller: controller, //입력값 controller
        cursorColor: Colors.black, // 커서 색깔
        obscureText: obscureText, // 항상 보이게 하는가, 안 보이게 하는가
        keyboardType: TextInputType.number, // 숫자 키보드 타입
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly, // 숫자만 입력 가능하게
        ],
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
              width: 2, // 테두리 두께 설정
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor, // 클릭 시 색상 변경
              width: 2, // 테두리 두께 설정
            ),
            borderRadius: BorderRadius.circular(12), // 테두리 모서리 둥글게 설정
          ),
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.never, // 라벨이 떠오르지 않게 설정
          labelStyle: TextStyle(
            color: labelColor, // 라벨 색상 설정
            fontFamily: 'SF_Pro',
            fontSize: 16,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
          isDense: true,
        ),
      ),
    );
  }
}
