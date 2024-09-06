import 'package:flutter/material.dart';
import 'package:flutter_mow/services/search_service.dart';
import 'package:flutter_svg/svg.dart';

class SearchPlace extends StatefulWidget {
  final Color borderColor;
  final TextEditingController controller; //입력값 controller
  final int order;

  const SearchPlace({
    super.key,
    required this.borderColor,
    required this.controller,
    required this.order,
  });

  @override
  State<SearchPlace> createState() => _SearchPlaceState();
}

class _SearchPlaceState extends State<SearchPlace> {
  @override
  Widget build(BuildContext context) {
    //화면이 build되는 순간 데이터를 가져옴
    Future<List<dynamic>?> result =
        SearchService.searchPlace(widget.controller.text, widget.order);
    print('----------search result----------');
    print('result: $result');
    print('your keyword: ${widget.controller.text}');
    print('your order: ${widget.order}');
    return SizedBox(
      height: 38.0,
      child: TextField(
        controller: widget.controller, //입력값 controller
        cursorColor: Colors.black, // 커서 색깔
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor,
              width: 1, // 테두리 두께 설정
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor, // 클릭 시 색상 변경
              width: 1, // 테두리 두께 설정
            ),
            borderRadius: BorderRadius.circular(12), // 테두리 모서리 둥글게 설정
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          //아이콘 추가
          suffixIcon: GestureDetector(
            onTap: () async {
              //await 필수
              List? result = await SearchService.searchPlace(
                  widget.controller.text, widget.order);
              print('----------search result----------');
              print('result: $result');
              print('your keyword: ${widget.controller.text}');
              print('your order: ${widget.order}');
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
