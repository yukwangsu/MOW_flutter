import 'package:flutter/material.dart';
import 'package:flutter_mow/widgets/search_place.dart';
import 'package:flutter_mow/widgets/select_button.dart';
import 'package:flutter_svg/svg.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final TextEditingController searchController = TextEditingController();
  String selectedOrder = '거리순'; // Initially set to '거리순'
  int order = 1;
  String locationType = '';

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height; //화면 높이

    return MaterialApp(
      home: Scaffold(
        // resizeToAvoidBottomInset: false, //키보드가 올라와도 화면이 그대로 유지
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
              initialChildSize: 132 / screenHeight, // 초기 크기를 132px로 설정
              minChildSize: 132 / screenHeight, // 최소 크기를 132px로 설정
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
                    padding: const EdgeInsets.only(top: 4.0),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //bottom sheet 바
                          const Bar(),
                          const SizedBox(height: 4),
                          //검색창
                          Search(
                            searchController: searchController,
                            order: order,
                            locationType: locationType,
                          ),
                          const SizedBox(height: 20),
                          //카테고리 선택
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                SelectButton(
                                  height: 32,
                                  padding: 14,
                                  bgColor: const Color(0xFFFFFCF8),
                                  radius: 1000,
                                  text: '편집',
                                  textColor: const Color(0xFF6B4D38),
                                  textSize: 14.0,
                                  borderColor: const Color(0xFFAD7541),
                                  borderWidth: 1.0,
                                  borderOpacity: 1.0,
                                  onPress: () {},
                                ),
                                const SizedBoxWidth10(),
                                SelectButton(
                                  height: 32,
                                  padding: 14,
                                  bgColor: const Color(0xFFFFFCF8),
                                  radius: 1000,
                                  text: selectedOrder, // Dynamic button text
                                  textColor: const Color(0xFF6B4D38),
                                  textSize: 14.0,
                                  borderColor: const Color(0xFFAD7541),
                                  borderWidth: 1.0,
                                  borderOpacity: 0.4,
                                  svgIconPath:
                                      'assets/icons/search_place_order_icon.svg',
                                  onPress: () {
                                    // ***거리순 클릭시 BottomSheet 올라오게 처리***
                                    showModalBottomSheet(
                                      context: context,
                                      // shape를 사용해서 BorderRadius 설정.
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(25.0),
                                        ),
                                      ),
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 180.0,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              buildOrderList(context, '거리순', 1),
                                              const ListBorderLine(), //bottom sheet 경계선
                                              buildOrderList(context, '별점순', 2),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                const SizedBoxWidth10(),
                                SelectButton(
                                  height: 32,
                                  padding: 14,
                                  bgColor: const Color(0xFFFFFCF8),
                                  radius: 1000,
                                  text: locationType.isEmpty
                                      ? '공간구분'
                                      : locationType,
                                  textColor: const Color(0xFF6B4D38),
                                  textSize: 14.0,
                                  borderColor: const Color(0xFFAD7541),
                                  borderWidth: 1.0,
                                  borderOpacity: 0.4,
                                  svgIconPath: 'assets/icons/down_icon.svg',
                                  onPress: () {
                                    showModalBottomSheet(
                                      context: context,
                                      // shape를 사용해서 BorderRadius 설정.
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(25.0),
                                        ),
                                      ),
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 350.0,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              buildPlaceList(context, '모든 공간'),
                                              const ListBorderLine(), //bottom sheet 경계선
                                              buildPlaceList(context, '카페'),
                                              const ListBorderLine(),
                                              buildPlaceList(context, '도서관'),
                                              const ListBorderLine(),
                                              buildPlaceList(context, '스터디카페'),
                                              const ListBorderLine(),
                                              buildPlaceList(
                                                  context, '기타 작업 공간'),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
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

  Widget buildOrderList(
      BuildContext context, String listContent, int orderContent) {
    return ListTile(
      contentPadding: EdgeInsets.zero, // default Padding을 0으로 설정
      title: Text(
        listContent,
        style: TextStyle(
          color:
              (order == orderContent) ? const Color(0xFF6B4D38) : Colors.black,
          fontSize: 16.0,
          fontWeight:
              (order == orderContent) ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      onTap: () {
        setState(() {
          selectedOrder = listContent;
          order = orderContent;
        });
        Navigator.pop(context);
      },
    );
  }

  Widget buildPlaceList(BuildContext context, String listContent) {
    return ListTile(
      contentPadding: EdgeInsets.zero, // default Padding을 0으로 설정
      title: Text(
        listContent,
        style: TextStyle(
          color: (locationType == listContent)
              ? const Color(0xFF6B4D38)
              : Colors.black,
          fontSize: 16.0,
          fontWeight:
              (locationType == listContent) ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      onTap: () {
        setState(() {
          locationType = listContent;
        });
        //Navigator.of(context).pop()이 ModalBottomSheet 내의 context에만 영향을 주어,
        //다른 화면으로 돌아가지 않고, ModalBottomSheet만 닫는다.
        Navigator.of(context).pop();
      },
    );
  }
}

class ListBorderLine extends StatelessWidget {
  const ListBorderLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 1.0,
      decoration: const BoxDecoration(
        color: Color(0xFFE4E3E2),
      ),
    );
  }
}

class SizedBoxWidth10 extends StatelessWidget {
  const SizedBoxWidth10({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 10.0,
    );
  }
}

class Search extends StatelessWidget {
  const Search({
    super.key,
    required this.searchController,
    required this.order,
    required this.locationType,
  });

  final TextEditingController searchController;
  final int order;
  final String locationType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: SearchPlace(
              borderColor: const Color(0xFF6B4D38),
              controller: searchController,
              order: order,
              locationType: locationType,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          SvgPicture.asset('assets/icons/circle_icon.svg'),
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  const Bar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        width: 50,
        height: 6,
        decoration: BoxDecoration(
          color: const Color(0xFF8A5E34),
          borderRadius: BorderRadius.circular(1000.0),
        ),
      ),
    );
  }
}
