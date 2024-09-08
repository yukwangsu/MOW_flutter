import 'package:flutter/material.dart';
import 'package:flutter_mow/screens/map/edit_tag.dart';
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
  // bool isNormalMode = true;
  // bool isEditMode = false;
  final TextEditingController searchController = TextEditingController();
  String selectedOrder = '거리순'; // Initially set to '거리순'
  int order = 1;
  String locationType = '';

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height; //화면 높이

    return Scaffold(
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
            builder: (BuildContext context, ScrollController scrollController) {
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
                    buildNormalMode(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildNormalMode() {
    return Column(
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
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditTag(),
                    ),
                  );
                },
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
                svgIconPath: 'assets/icons/search_place_order_icon.svg',
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                text: locationType.isEmpty ? '공간구분' : locationType,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildPlaceList(context, '모든 공간'),
                            const ListBorderLine(), //bottom sheet 경계선
                            buildPlaceList(context, '카페'),
                            const ListBorderLine(),
                            buildPlaceList(context, '도서관'),
                            const ListBorderLine(),
                            buildPlaceList(context, '스터디카페'),
                            const ListBorderLine(),
                            buildPlaceList(context, '기타 작업 공간'),
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
    );
  }

  // Widget buildEditMode() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         //bottom sheet 바
  //         const Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Bar(),
  //           ],
  //         ),
  //         const SizedBox(height: 4),
  //         const SizedBoxHeight10(),
  //         Column(
  //           //돌아가기 아이콘
  //           children: [
  //             GestureDetector(
  //               onTap: () {
  //                 setState(() {
  //                   isNormalMode = true;
  //                   isEditMode = false;
  //                 });
  //               },
  //               child: SvgPicture.asset('assets/icons/back_icon.svg'),
  //             ),
  //           ],
  //         ),
  //         // 스크롤 시작 부분 *** 실패 ***
  //         SingleChildScrollView(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               const SizedBox(
  //                 height: 28.0,
  //               ),
  //               const Padding(
  //                 padding: EdgeInsets.symmetric(horizontal: 4.0),
  //                 child: Row(
  //                   children: [
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           '태그 편집',
  //                           style: TextStyle(
  //                             fontSize: 22,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           height: 12.0,
  //                         ),
  //                         Text(
  //                           '검색에 이용할 태그들을 선택해주세요!',
  //                           style: TextStyle(
  //                             fontSize: 16,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 48.0,
  //               ),
  //               const Row(
  //                 children: [
  //                   Expanded(
  //                     child: SingleChildScrollView(
  //                       scrollDirection: Axis.horizontal,
  //                       child: Row(
  //                         children: [
  //                           SelectButtonWidget(
  //                             textContent: '# 공간이 넓어요',
  //                           ),
  //                           //버튼 사이 빈 공간
  //                           SizedBoxWidth6(),
  //                           SelectButtonWidget(
  //                             textContent: '# 좌석이 많아요',
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBoxHeight10(),
  //               const Row(
  //                 children: [
  //                   SelectButtonWidget(
  //                     textContent: '# 콘센트가 많아요',
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(
  //                 height: 16.0,
  //               ),
  //               // 작업 편의 tab
  //               Padding(
  //                 padding: const EdgeInsets.only(
  //                     top: 12.0, bottom: 12.0, right: 12.0),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     const Text(
  //                       '작업 편의',
  //                       style: TextStyle(
  //                         fontSize: 16, //임의 수정
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     SvgPicture.asset('assets/icons/dropdown_up.svg'),
  //                   ],
  //                 ),
  //               ),
  //               // 작업 편의 tags
  //               const Padding(
  //                 padding: EdgeInsets.only(top: 8.0, bottom: 24.0),
  //                 child: Column(
  //                   children: [
  //                     Row(
  //                       children: [
  //                         Expanded(
  //                           child: SingleChildScrollView(
  //                             scrollDirection: Axis.horizontal,
  //                             child: Row(
  //                               children: [
  //                                 SelectButtonWidget(
  //                                   textContent: '# 한산해요',
  //                                 ),
  //                                 SizedBoxWidth6(),
  //                                 SelectButtonWidget(
  //                                   textContent: '# 의자가 편해요',
  //                                 ),
  //                                 SizedBoxWidth6(),
  //                                 SelectButtonWidget(
  //                                   textContent: '# 책상이 넓어요',
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               // 분위기 tab
  //               Padding(
  //                 padding: const EdgeInsets.only(
  //                     top: 12.0, bottom: 12.0, right: 12.0),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     const Text(
  //                       '분위기',
  //                       style: TextStyle(
  //                         fontSize: 16, //임의 수정
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     SvgPicture.asset('assets/icons/dropdown_up.svg'),
  //                   ],
  //                 ),
  //               ),
  //               // 분위기 tags
  //               const Padding(
  //                 padding: EdgeInsets.only(top: 8.0, bottom: 24.0),
  //                 child: Column(
  //                   children: [
  //                     Row(
  //                       children: [
  //                         SelectButtonWidget(
  //                           textContent: '# 뷰가 좋아요',
  //                         ),
  //                         SizedBoxWidth6(),
  //                         SelectButtonWidget(
  //                           textContent: '# 조용해요',
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBoxHeight10(),
  //                     Row(
  //                       children: [
  //                         SelectButtonWidget(
  //                           textContent: '# 아늑해요',
  //                         ),
  //                         SizedBoxWidth6(),
  //                         SelectButtonWidget(
  //                           textContent: '# 인테리어가 깔끔해요',
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBoxHeight10(),
  //                     Row(
  //                       children: [
  //                         SelectButtonWidget(
  //                           textContent: '# 어두워요',
  //                         ),
  //                         SizedBoxWidth6(),
  //                         SelectButtonWidget(
  //                           textContent: '# 밝아요',
  //                         ),
  //                         SizedBoxWidth6(),
  //                         SelectButtonWidget(
  //                           textContent: '# 다시 오고 싶어요',
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBoxHeight10(),
  //                     Row(
  //                       children: [
  //                         SelectButtonWidget(
  //                           textContent: '# 음악이 좋아요',
  //                         ),
  //                         SizedBoxWidth6(),
  //                         SelectButtonWidget(
  //                           textContent: '# 대화하기 좋아요',
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBoxHeight10(),
  //                     Row(
  //                       children: [
  //                         SelectButtonWidget(
  //                           textContent: '# 감각적이에요',
  //                         ),
  //                         SizedBoxWidth6(),
  //                         SelectButtonWidget(
  //                           textContent: '# 혼자 작업하기 좋아요',
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBoxHeight10(),
  //                     Row(
  //                       children: [
  //                         SelectButtonWidget(
  //                           textContent: '# 회의하기에 좋아요',
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               // 메뉴 tab
  //               Padding(
  //                 padding: const EdgeInsets.only(
  //                     top: 12.0, bottom: 12.0, right: 12.0),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     const Text(
  //                       '메뉴',
  //                       style: TextStyle(
  //                         fontSize: 16, //임의 수정
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     SvgPicture.asset('assets/icons/dropdown_up.svg'),
  //                   ],
  //                 ),
  //               ),
  //               // 메뉴 tags
  //               const Padding(
  //                 padding: EdgeInsets.only(top: 8.0, bottom: 24.0),
  //                 child: Column(
  //                   children: [
  //                     Row(
  //                       children: [
  //                         SelectButtonWidget(
  //                           textContent: '# 저렴해요',
  //                         ),
  //                         SizedBoxWidth6(),
  //                         SelectButtonWidget(
  //                           textContent: '# 매뉴가 다양해요',
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBoxHeight10(),
  //                     Row(
  //                       children: [
  //                         SelectButtonWidget(
  //                           textContent: '# 커피가 맛있어요',
  //                         ),
  //                         SizedBoxWidth6(),
  //                         SelectButtonWidget(
  //                           textContent: '# 디저트가 맛있어요',
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               // 서비스 tab
  //               Padding(
  //                 padding: const EdgeInsets.only(
  //                     top: 12.0, bottom: 12.0, right: 12.0),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     const Text(
  //                       '서비스',
  //                       style: TextStyle(
  //                         fontSize: 16, //임의 수정
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     SvgPicture.asset('assets/icons/dropdown_up.svg'),
  //                   ],
  //                 ),
  //               ),
  //               // 서비스 tags
  //               const Padding(
  //                 padding: EdgeInsets.only(top: 8.0, bottom: 24.0),
  //                 child: Column(
  //                   children: [
  //                     Row(
  //                       children: [
  //                         SelectButtonWidget(
  //                           textContent: '# 친절해요',
  //                         ),
  //                         SizedBoxWidth6(),
  //                         SelectButtonWidget(
  //                           textContent: '# 와이파이가 잘 터져요',
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBoxHeight10(),
  //                     Row(
  //                       children: [
  //                         SelectButtonWidget(
  //                           textContent: '# 에어컨이 잘 나와요',
  //                         ),
  //                         SizedBoxWidth6(),
  //                         SelectButtonWidget(
  //                           textContent: '# 오래 작업하기 좋아요',
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               // 기타 tab
  //               Padding(
  //                 padding: const EdgeInsets.only(
  //                     top: 12.0, bottom: 12.0, right: 12.0),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     const Text(
  //                       '기타',
  //                       style: TextStyle(
  //                         fontSize: 16, //임의 수정
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     SvgPicture.asset('assets/icons/dropdown_up.svg'),
  //                   ],
  //                 ),
  //               ),
  //               // 기타 tags
  //               const Padding(
  //                 padding: EdgeInsets.only(top: 8.0, bottom: 24.0),
  //                 child: Column(
  //                   children: [
  //                     Row(
  //                       children: [
  //                         SelectButtonWidget(
  //                           textContent: '# 화장실이 깨끗해요',
  //                         ),
  //                         SizedBoxWidth6(),
  //                         SelectButtonWidget(
  //                           textContent: '# 찾아가기 편해요',
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBoxHeight10(),
  //                     Row(
  //                       children: [
  //                         SelectButtonWidget(
  //                           textContent: '# 무료로 이용이 가능해요',
  //                         ),
  //                         SizedBoxWidth6(),
  //                         SelectButtonWidget(
  //                           textContent: '# 주차가 가능해요',
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBoxHeight10(),
  //                     Row(
  //                       children: [
  //                         SelectButtonWidget(
  //                           textContent: '# 24시간 운영이에요',
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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

class SelectButtonWidget extends StatelessWidget {
  const SelectButtonWidget({
    super.key,
    required this.textContent,
  });

  final String textContent;

  @override
  Widget build(BuildContext context) {
    return SelectButton(
      height: 32.0,
      padding: 14.0,
      bgColor: Colors.white,
      radius: 1000,
      text: textContent,
      textColor: const Color(0xFF6B4D38),
      textSize: 14.0,
      borderWidth: 1.0,
      borderColor: const Color(0xFFAD7541),
      borderOpacity: 0.4,
      onPress: () {},
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

class SizedBoxHeight10 extends StatelessWidget {
  const SizedBoxHeight10({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 10.0,
    );
  }
}

class SizedBoxWidth6 extends StatelessWidget {
  const SizedBoxWidth6({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 6.0,
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
