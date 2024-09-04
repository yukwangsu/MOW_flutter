import 'package:flutter/material.dart';
import 'package:flutter_mow/services/search_service.dart';
import 'package:flutter_svg/svg.dart';

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
      height: 38.0,
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
          //아이콘 추가
          suffixIcon: GestureDetector(
            onTap: () {
              print('----------search result----------');
              var result = SearchService.searchPlace(controller.text);
              print('result: $result');
              print('your keyword: ${controller.text}');
            },
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: SvgPicture.asset(
                'assets/icons/search_icon.svg',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
