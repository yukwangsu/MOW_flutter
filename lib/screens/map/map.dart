import 'package:flutter/material.dart';
import 'package:flutter_mow/widgets/search_place.dart';
import 'package:flutter_svg/svg.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightGreen,
        body: Stack(
          children: [
            //추후 지도 화면으로 수정 필요
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/login_cat.svg'),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text('지도 준비중 ...')
                ],
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.154, // 처음 보여지는 크기 (1.0 = 전체 화면)
              minChildSize: 0.154, // 최소 크기
              maxChildSize: 0.936, // 최대 크기
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFFE4E3E2), // 경계선 색상
                      width: 1.0, // 경계선 두께
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5.0,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: ListView(
                    controller: scrollController,
                    // ***ListView 에도 padding이 있다.***
                    padding: const EdgeInsets.only(top: 4.0),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //bottom sheet 바
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Container(
                              width: 50,
                              height: 6,
                              decoration: BoxDecoration(
                                color: const Color(0xFF8A5E34),
                                borderRadius: BorderRadius.circular(1000.0),
                              ),
                            ),
                          ),
                          //빈공간
                          const SizedBox(
                            height: 4,
                          ),
                          //검색창
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SearchPlace(
                                    borderColor: const Color(0xFF6B4D38),
                                    controller: searchController,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                SvgPicture.asset(
                                    'assets/icons/circle_icon.svg'),
                              ],
                            ),
                          )
                          //카테고리
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
