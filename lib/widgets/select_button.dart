import 'package:flutter/material.dart';

class SelectButton extends StatelessWidget {
  final double height;
  final double padding;
  final Color bgColor;
  final double radius;
  final String text;
  final Color textColor;
  final Function onPress;

  const SelectButton({
    super.key,
    required this.height,
    required this.padding,
    required this.bgColor,
    required this.radius,
    required this.text,
    required this.textColor,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextButton(
        onPressed: () => onPress(), // 함수를 호출하지 않고 참조를 전달
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: padding,
          ), // 텍스트와 버튼 사이 거리
          minimumSize: Size(0, height), // 최소 높이 설정
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius), // 테두리 반경 설정
          ),
          splashFactory: NoSplash.splashFactory, // 스플래시 효과 제거
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w400,
            fontFamily: 'SF_Pro',
            color: textColor,
          ),
        ),
      ),
    );
  }
}
