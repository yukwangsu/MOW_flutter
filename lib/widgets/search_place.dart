import 'package:flutter/material.dart';

class SearchPlace extends StatelessWidget {
  final Color borderColor;
  final TextEditingController controller; //입력값 controller

  const SearchPlace({
    super.key,
    required this.borderColor,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        controller: controller, //입력값 controller
        cursorColor: Colors.black, // 커서 색깔
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
              width: 1, // 테두리 두께 설정
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor, // 클릭 시 색상 변경
              width: 1, // 테두리 두께 설정
            ),
            borderRadius: BorderRadius.circular(12), // 테두리 모서리 둥글게 설정
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          isDense: true,
        ),
      ),
    );
  }
}
