// import 'package:flutter/material.dart';
// import 'package:flutter_mow/screens/map/edit_tag.dart';
// import 'package:flutter_mow/services/search_service.dart';
// import 'package:flutter_mow/widgets/select_button.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({
//     super.key,
//   });

//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   final TextEditingController searchController = TextEditingController();
//   String selectedOrder = '거리순'; // Initially set to '거리순'
//   int order = 1;
//   String locationType = '';
//   List<String> taggedList = [];
//   List<String> appliedSearchTags = [];

//   @override
//   void initState() {
//     super.initState();
//     loadTaggedList(); // 시작 시 태그 리스트 불러옴
//     loadAppliedSearchTags(); // 시작 시 검색 태그 불러옴
//   }

//   // 검색 태그 저장
//   Future<void> saveAppliedSearchTags() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('appliedSearchTags', appliedSearchTags);
//   }

//   // 검색 태그 불러오기
//   Future<void> loadAppliedSearchTags() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       appliedSearchTags = prefs.getStringList('appliedSearchTags') ??
//           []; // 저장된 리스트가 없으면 빈 리스트 사용
//     });
//   }

//   // 검색 태그 수정
//   void toogleAppliedSearchTags(String tagContent) async {
//     if (appliedSearchTags.contains(tagContent)) {
//       appliedSearchTags.remove(tagContent);
//     } else {
//       appliedSearchTags.add(tagContent);
//     }
//     // 스토리지에 저장
//     await saveAppliedSearchTags();
//     // 수정이 완료되면 setState
//     setState(() {});
//   }

//   // 태그 리스트 불러오기
//   Future<void> loadTaggedList() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       taggedList =
//           prefs.getStringList('taggedList') ?? []; // 저장된 리스트가 없으면 빈 리스트 사용
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height; //화면 높이

//     return Scaffold(
//       // resizeToAvoidBottomInset: false, //키보드가 올라와도 화면이 그대로 유지
//       backgroundColor: Colors.lightGreen,
//       body: Stack(
//         children: [
//           //추후 지도 화면으로 수정 필요
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SvgPicture.asset('assets/icons/login_cat.svg'),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 const Text('지도 준비중 ...')
//               ],
//             ),
//           ),
//           DraggableScrollableSheet(
//             initialChildSize: 132 / screenHeight, // 초기 크기를 132px로 설정
//             minChildSize: 132 / screenHeight, // 최소 크기를 132px로 설정
//             maxChildSize: 0.936, // 최대 크기
//             builder: (BuildContext context, ScrollController scrollController) {
//               return Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border.all(
//                     color: const Color(0xFFE4E3E2), // 경계선 색상
//                     width: 1.0, // 경계선 두께
//                   ),
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(25.0),
//                     topRight: Radius.circular(25.0),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 5.0,
//                       offset: const Offset(0, -4),
//                     ),
//                   ],
//                 ),
//                 child: ListView(
//                   controller: scrollController,
//                   padding: const EdgeInsets.only(top: 0.0),
//                   children: [
//                     buildNormalMode(),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildNormalMode() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         //bottom sheet 바
//         const SizedBox(height: 4),
//         const Bar(),
//         const SizedBox(height: 4),
//         //검색창
//         searchBar(
//           searchController,
//         ),
//         const SizedBox(height: 20),
//         //카테고리, 태그 선택
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 SelectButton(
//                   height: 32,
//                   padding: 14,
//                   bgColor: const Color(0xFFFFFCF8),
//                   radius: 1000,
//                   text: '편집',
//                   textColor: const Color(0xFF6B4D38),
//                   textSize: 14.0,
//                   borderColor: const Color(0xFFAD7541),
//                   borderWidth: 1.0,
//                   borderOpacity: 1.0,
//                   onPress: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const EditTag(),
//                       ),
//                     ).then((_) {
//                       // *** 이 화면으로 돌아왔을 때 loadTaggedList를 호출 ***
//                       loadTaggedList();
//                       loadAppliedSearchTags();
//                     });
//                   },
//                 ),
//                 const SizedBoxWidth10(),
//                 SelectButton(
//                   height: 32,
//                   padding: 14,
//                   bgColor: const Color(0xFFFFFCF8),
//                   radius: 1000,
//                   text: selectedOrder, // Dynamic button text
//                   textColor: const Color(0xFF6B4D38),
//                   textSize: 14.0,
//                   borderColor: const Color(0xFFAD7541),
//                   borderWidth: 1.0,
//                   borderOpacity: 0.4,
//                   svgIconPath: 'assets/icons/search_place_order_icon.svg',
//                   onPress: () {
//                     // ***거리순 클릭시 BottomSheet 올라오게 처리***
//                     showModalBottomSheet(
//                       context: context,
//                       // shape를 사용해서 BorderRadius 설정.
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.vertical(
//                           top: Radius.circular(25.0),
//                         ),
//                       ),
//                       builder: (BuildContext context) {
//                         return Container(
//                           height: 180.0,
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20.0, vertical: 20.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               buildOrderList(context, '거리순', 1),
//                               const ListBorderLine(), //bottom sheet 경계선
//                               buildOrderList(context, '별점순', 2),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//                 const SizedBoxWidth10(),
//                 SelectButton(
//                   height: 32,
//                   padding: 14,
//                   bgColor: const Color(0xFFFFFCF8),
//                   radius: 1000,
//                   text: locationType.isEmpty ? '공간구분' : locationType,
//                   textColor: const Color(0xFF6B4D38),
//                   textSize: 14.0,
//                   borderColor: const Color(0xFFAD7541),
//                   borderWidth: 1.0,
//                   borderOpacity: 0.4,
//                   svgIconPath: 'assets/icons/down_icon.svg',
//                   onPress: () {
//                     showModalBottomSheet(
//                       context: context,
//                       // shape를 사용해서 BorderRadius 설정.
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.vertical(
//                           top: Radius.circular(25.0),
//                         ),
//                       ),
//                       builder: (BuildContext context) {
//                         return Container(
//                           height: 350.0,
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20.0, vertical: 20.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               buildPlaceList(context, '모든 공간'),
//                               const ListBorderLine(), //bottom sheet 경계선
//                               buildPlaceList(context, '카페'),
//                               const ListBorderLine(),
//                               buildPlaceList(context, '도서관'),
//                               const ListBorderLine(),
//                               buildPlaceList(context, '스터디카페'),
//                               const ListBorderLine(),
//                               buildPlaceList(context, '기타 작업 공간'),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//                 for (int n = 0; n < taggedList.length; n++) ...[
//                   const SizedBoxWidth10(),
//                   tagButtonWidget(taggedList[n]),
//                 ]
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 20.0,
//         ),
//         //[임시]
//         // placeList('영등포 도서관', '도서관', 4.3, 23, '서울 영등포구 영등포로', 281.5),
//         showWorkspace(
//           searchController,
//           order,
//           locationType,
//           appliedSearchTags,
//         ),
//       ],
//     );
//   }

//   Widget showWorkspace(
//     TextEditingController controller, // 입력값 controller
//     int order,
//     String locationType,
//     List<String> appliedSearchTags,
//   ) {
//     return FutureBuilder<List<dynamic>?>(
//       future: SearchService.searchPlace(
//         controller.text,
//         order,
//         locationType,
//         appliedSearchTags,
//       ), // 비동기 데이터 호출
//       builder: (BuildContext context, AsyncSnapshot<List<dynamic>?> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           // 데이터가 로드 중일 때 로딩 표시
//           return const CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           // 오류가 발생했을 때
//           return Text('Error: ${snapshot.error}');
//         } else {
//           // 데이터가 성공적으로 로드되었을 때
//           final workspaceList = snapshot.data;
//           print('----------rebuild showWorkspace search result----------');
//           print('workspaceList: $workspaceList');
//           print('your keyword: ${controller.text}');
//           print('your order: $order');

//           return Column(
//             children: [
//               for (int i = 0; i < workspaceList!.length; i++) ...[
//                 placeList(
//                   workspaceList[i]['workspaceName'],
//                   workspaceList[i]['workspaceType'],
//                   workspaceList[i]['starscore'],
//                   workspaceList[i]['reviewCnt'],
//                   workspaceList[i]['location'],
//                   workspaceList[i]['distance'],
//                 )
//               ],
//             ],
//           );
//         }
//       },
//     );
//   }

//   Widget placeList(
//     String name,
//     String category,
//     double score,
//     int reviewCnt,
//     String address,
//     double distance,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Column(
//         children: [
//           // place list
//           Column(
//             children: [
//               Row(
//                 children: [
//                   //가게 이미지
//                   Container(
//                     decoration: const BoxDecoration(color: Colors.black),
//                     width: 80.0,
//                     height: 80.0,
//                   ),
//                   const SizedBox(
//                     width: 14.0,
//                   ),
//                   //가게 정보
//                   Expanded(
//                     child: Column(
//                       children: [
//                         //가게 정보 첫번째 줄: 이름, 카테고리
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 //가게 이름
//                                 Text(
//                                   name.length > 10 //가게 이름 크기 제한
//                                       ? '${name.substring(0, 10)}...'
//                                       : name,
//                                   // name,
//                                   style: Theme.of(context).textTheme.bodyLarge,
//                                 ),
//                                 const SizedBoxWidth10(),
//                                 //가게 카테고리
//                                 Text(
//                                   category.length > 8 //가게 카테고리 크기 제한
//                                       ? '${category.substring(0, 8)}...'
//                                       : category,
//                                   // category,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleSmall!
//                                       .copyWith(color: const Color(0xFFC3C3C3)),
//                                 ),
//                               ],
//                             ),
//                             SvgPicture.asset('assets/icons/unsave_icon.svg'),
//                           ],
//                         ),
//                         const SizedBox(height: 4.0),
//                         // 가게 정보 두번째 줄: 별점, 리뷰
//                         Row(
//                           children: [
//                             // 별점
//                             for (int i = 0; i < score.round(); i++) ...[
//                               SvgPicture.asset(
//                                   'assets/icons/star_fill_icon.svg'),
//                             ],
//                             for (int i = 0; i < 5 - score.round(); i++) ...[
//                               SvgPicture.asset(
//                                   'assets/icons/star_unfill_icon.svg'),
//                             ],
//                             const SizedBox(
//                               width: 8.0,
//                             ),
//                             // 리뷰 개수
//                             Text(
//                               '($reviewCnt)',
//                               style: Theme.of(context).textTheme.titleSmall,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 12.0),
//                         // 가게 정보 세번째 줄: 위치, 거리, 연락처
//                         Row(
//                           children: [
//                             // 주소
//                             Text(
//                               address.substring(0, 7),
//                               style: Theme.of(context).textTheme.titleSmall,
//                             ),
//                             const SizedBox(
//                               width: 4.0,
//                             ),
//                             SvgPicture.asset(
//                                 'assets/icons/dropdown_down_padding.svg'),
//                             const SizedBox(
//                               width: 4.0,
//                             ),
//                             // 거리
//                             Text(
//                               '${distance.round()}m',
//                               style: Theme.of(context).textTheme.titleSmall,
//                             ),
//                             const SizedBox(
//                               width: 16.0,
//                             ),
//                             Text(
//                               '연락처',
//                               style: Theme.of(context).textTheme.titleSmall,
//                             ),
//                             const SizedBox(
//                               width: 4.0,
//                             ),
//                             SvgPicture.asset(
//                                 'assets/icons/dropdown_down_padding.svg'),
//                           ],
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               //list padding
//               const SizedBox(
//                 height: 24.0,
//               ),
//               const ListBorderLine(),
//               const SizedBox(
//                 height: 24.0,
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget buildOrderList(
//       BuildContext context, String listContent, int orderContent) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero, // default Padding을 0으로 설정
//       title: Text(
//         listContent,
//         style: TextStyle(
//           color:
//               (order == orderContent) ? const Color(0xFF6B4D38) : Colors.black,
//           fontSize: 16.0,
//           fontWeight:
//               (order == orderContent) ? FontWeight.w600 : FontWeight.w400,
//         ),
//       ),
//       onTap: () {
//         setState(() {
//           selectedOrder = listContent;
//           order = orderContent;
//         });
//         Navigator.pop(context);
//       },
//     );
//   }

//   Widget buildPlaceList(BuildContext context, String listContent) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero, // default Padding을 0으로 설정
//       title: Text(
//         listContent,
//         style: TextStyle(
//           color: (locationType == listContent)
//               ? const Color(0xFF6B4D38)
//               : Colors.black,
//           fontSize: 16.0,
//           fontWeight:
//               (locationType == listContent) ? FontWeight.w600 : FontWeight.w400,
//         ),
//       ),
//       onTap: () {
//         setState(() {
//           locationType = listContent;
//         });
//         //Navigator.of(context).pop()이 ModalBottomSheet 내의 context에만 영향을 주어,
//         //다른 화면으로 돌아가지 않고, ModalBottomSheet만 닫는다.
//         Navigator.of(context).pop();
//       },
//     );
//   }

//   Widget searchBar(
//     TextEditingController searchController,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: searchBox(
//               const Color(0xFF6B4D38),
//               searchController,
//             ),
//           ),
//           const SizedBox(
//             width: 8,
//           ),
//           SvgPicture.asset('assets/icons/circle_icon.svg'),
//         ],
//       ),
//     );
//   }

//   //검색창
//   Widget searchBox(
//     Color borderColor,
//     TextEditingController controller, // 입력값 controller
//   ) {
//     return SizedBox(
//       height: 38.0,
//       // *** FutureBuilder를 사용하여 데이터를 로드함 ***
//       child: TextField(
//         controller: controller, // 입력값 controller
//         cursorColor: Colors.black, // 커서 색깔
//         decoration: InputDecoration(
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: borderColor,
//               width: 1, // 테두리 두께 설정
//             ),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: borderColor, // 클릭 시 색상 변경
//               width: 1, // 테두리 두께 설정
//             ),
//             borderRadius: BorderRadius.circular(12), // 테두리 모서리 둥글게 설정
//           ),
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//           // 아이콘 추가
//           suffixIcon: GestureDetector(
//             onTap: () async {
//               // 돋보기 클릭시 setState를 통해 workspace를 다시 불러온다.
//               setState(() {});
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(7.0),
//               child: SvgPicture.asset(
//                 'assets/icons/search_icon.svg',
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget tagButtonWidget(String tagName) {
//     return SelectButton(
//       height: 32.0,
//       padding: 14.0,
//       bgColor: appliedSearchTags.contains(tagName)
//           ? const Color(0xFF6B4D38)
//           : Colors.white,
//       radius: 1000,
//       text: tagName,
//       textColor: appliedSearchTags.contains(tagName)
//           ? Colors.white
//           : const Color(0xFF6B4D38),
//       textSize: 14.0,
//       borderWidth: appliedSearchTags.contains(tagName) ? null : 1.0,
//       borderColor:
//           appliedSearchTags.contains(tagName) ? null : const Color(0xFFAD7541),
//       borderOpacity: appliedSearchTags.contains(tagName) ? null : 0.4,
//       onPress: () {
//         toogleAppliedSearchTags(tagName);
//       },
//     );
//   }
// }

// class ListBorderLine extends StatelessWidget {
//   const ListBorderLine({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.maxFinite,
//       height: 1.0,
//       decoration: const BoxDecoration(
//         color: Color(0xFFE4E3E2),
//       ),
//     );
//   }
// }

// class SizedBoxHeight24 extends StatelessWidget {
//   const SizedBoxHeight24({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return const SizedBox(
//       height: 24.0,
//     );
//   }
// }

// class SizedBoxWidth10 extends StatelessWidget {
//   const SizedBoxWidth10({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return const SizedBox(
//       width: 10.0,
//     );
//   }
// }

// class SizedBoxHeight10 extends StatelessWidget {
//   const SizedBoxHeight10({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return const SizedBox(
//       height: 10.0,
//     );
//   }
// }

// class SizedBoxWidth6 extends StatelessWidget {
//   const SizedBoxWidth6({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return const SizedBox(
//       width: 6.0,
//     );
//   }
// }

// class Bar extends StatelessWidget {
//   const Bar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 4.0),
//           child: Container(
//             width: 50,
//             height: 6,
//             decoration: BoxDecoration(
//               color: const Color(0xFF8A5E34),
//               borderRadius: BorderRadius.circular(1000.0),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

//기존 코드 ^

//new
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomSheetExample(),
    );
  }
}

class BottomSheetExample extends StatefulWidget {
  const BottomSheetExample({super.key});

  @override
  State<BottomSheetExample> createState() => _BottomSheetExampleState();
}

class _BottomSheetExampleState extends State<BottomSheetExample> {
  double _bottomSheetHeight = 132; // 초기 높이 (132픽셀)
  bool _isAtTopOfListView = true; // ListView가 스크롤의 맨 위에 있는지 여부

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomSheet with Gesture and Scroll Control'),
      ),
      body: Stack(
        children: [
          const Center(
            child: Text('Main Content'),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (_isAtTopOfListView) {
                  setState(() {
                    // 드래그할 때 BottomSheet의 높이를 조정
                    _bottomSheetHeight -= details.primaryDelta!;

                    // 최소 높이는 132픽셀, 최대 높이는 화면 높이의 90%
                    _bottomSheetHeight =
                        _bottomSheetHeight.clamp(132, screenHeight * 0.9);
                  });
                }
              },
              child: Container(
                height: _bottomSheetHeight,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 20,
                          width: 40,
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('두번째 버튼 클릭');
                          },
                          child: Container(
                            height: 20,
                            width: 40,
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification notification) {
                          if (notification is ScrollUpdateNotification) {
                            // 스크롤이 맨 위로 도달했는지 확인
                            if (notification.metrics.pixels <=
                                notification.metrics.minScrollExtent) {
                              _isAtTopOfListView = true;
                            } else {
                              _isAtTopOfListView = false;
                            }
                          }
                          return true;
                        },
                        child: ListView.builder(
                          itemCount: 30,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text('Item $index'),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



//수정 코드 v

// import 'package:flutter/material.dart';
// import 'package:flutter_mow/screens/map/edit_tag.dart';
// import 'package:flutter_mow/services/search_service.dart';
// import 'package:flutter_mow/widgets/select_button.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({
//     super.key,
//   });

//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   final TextEditingController searchController = TextEditingController();
//   final DraggableScrollableController _draggableController =
//       DraggableScrollableController();
//   String selectedOrder = '거리순'; // Initially set to '거리순'
//   int order = 1;
//   String locationType = '';
//   List<String> taggedList = [];
//   List<String> appliedSearchTags = [];

//   @override
//   void dispose() {
//     searchController.dispose();
//     _draggableController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {});
//     loadTaggedList(); // 시작 시 태그 리스트 불러옴
//     loadAppliedSearchTags(); // 시작 시 검색 태그 불러옴
//   }

//   // 검색 태그 저장
//   Future<void> saveAppliedSearchTags() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('appliedSearchTags', appliedSearchTags);
//   }

//   // 검색 태그 불러오기
//   Future<void> loadAppliedSearchTags() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       appliedSearchTags = prefs.getStringList('appliedSearchTags') ??
//           []; // 저장된 리스트가 없으면 빈 리스트 사용
//     });
//   }

//   // 검색 태그 수정
//   void toogleAppliedSearchTags(String tagContent) async {
//     if (appliedSearchTags.contains(tagContent)) {
//       appliedSearchTags.remove(tagContent);
//     } else {
//       appliedSearchTags.add(tagContent);
//     }
//     // 스토리지에 저장
//     await saveAppliedSearchTags();
//     // 수정이 완료되면 setState
//     setState(() {});
//   }

//   // 태그 리스트 불러오기
//   Future<void> loadTaggedList() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       taggedList =
//           prefs.getStringList('taggedList') ?? []; // 저장된 리스트가 없으면 빈 리스트 사용
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height; //화면 높이

//     return Scaffold(
//       // resizeToAvoidBottomInset: false, //키보드가 올라와도 화면이 그대로 유지
//       backgroundColor: Colors.lightGreen,
//       body: Stack(
//         children: [
//           //추후 지도 화면으로 수정 필요
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SvgPicture.asset('assets/icons/login_cat.svg'),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 const Text('지도 준비중 ...')
//               ],
//             ),
//           ),
//           DraggableScrollableSheet(
//             snap: true,
//             controller: _draggableController,
//             initialChildSize: 132 / screenHeight, // 초기 크기
//             minChildSize: 132 / screenHeight, // 최소 크기를 132px로 설정
//             maxChildSize: 0.936, // 최대 크기
//             builder: (BuildContext context, ScrollController scrollController) {
//               return Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border.all(
//                     color: const Color(0xFFE4E3E2), // 경계선 색상
//                     width: 1.0, // 경계선 두께
//                   ),
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(25.0),
//                     topRight: Radius.circular(25.0),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 5.0,
//                       offset: const Offset(0, -4),
//                     ),
//                   ],
//                 ),
//                 // 스크롤 수정?
//                 // child: ListView(
//                 //   controller: scrollController,
//                 //   padding: const EdgeInsets.only(top: 4.0),
//                 //   children: [
//                 //     buildNormalMode(),
//                 //   ],
//                 // ),
//                 child: buildNormalMode(scrollController),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildNormalMode(
//     ScrollController scrollController,
//   ) {
//     return Stack(
//       children: [
//         GestureDetector(
//           onVerticalDragUpdate: (details) {
//             if (details.primaryDelta! < -10) {
//               _draggableController.animateTo(0.936,
//                   duration: const Duration(milliseconds: 500),
//                   curve: Curves.easeInOut);
//             }
//           },
//           onTap: () {
//             _draggableController.animateTo(0.936,
//                 duration: const Duration(milliseconds: 500),
//                 curve: Curves.easeInOut);
//           },
//           child: Positioned(
//             top: 0.0,
//             left: 0.0,
//             right: 0.0,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 //bottom sheet 바
//                 const SizedBox(height: 4), const Bar(),
//                 const SizedBox(height: 4),
//                 //검색창
//                 searchBar(
//                   searchController,
//                 ),
//                 const SizedBox(height: 20),
//                 //카테고리, 태그 선택
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: [
//                         SelectButton(
//                           height: 32,
//                           padding: 14,
//                           bgColor: const Color(0xFFFFFCF8),
//                           radius: 1000,
//                           text: '편집',
//                           textColor: const Color(0xFF6B4D38),
//                           textSize: 14.0,
//                           borderColor: const Color(0xFFAD7541),
//                           borderWidth: 1.0,
//                           borderOpacity: 1.0,
//                           onPress: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const EditTag(),
//                               ),
//                             ).then((_) {
//                               // *** 이 화면으로 돌아왔을 때 loadTaggedList를 호출 ***
//                               loadTaggedList();
//                               loadAppliedSearchTags();
//                             });
//                           },
//                         ),
//                         const SizedBoxWidth10(),
//                         SelectButton(
//                           height: 32,
//                           padding: 14,
//                           bgColor: const Color(0xFFFFFCF8),
//                           radius: 1000,
//                           text: selectedOrder, // Dynamic button text
//                           textColor: const Color(0xFF6B4D38),
//                           textSize: 14.0,
//                           borderColor: const Color(0xFFAD7541),
//                           borderWidth: 1.0,
//                           borderOpacity: 0.4,
//                           svgIconPath:
//                               'assets/icons/search_place_order_icon.svg',
//                           onPress: () {
//                             // ***거리순 클릭시 BottomSheet 올라오게 처리***
//                             showModalBottomSheet(
//                               context: context,
//                               // shape를 사용해서 BorderRadius 설정.
//                               shape: const RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.vertical(
//                                   top: Radius.circular(25.0),
//                                 ),
//                               ),
//                               builder: (BuildContext context) {
//                                 return Container(
//                                   height: 180.0,
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 20.0, vertical: 20.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       buildOrderList(context, '거리순', 1),
//                                       const ListBorderLine(), //bottom sheet 경계선
//                                       buildOrderList(context, '별점순', 2),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                         ),
//                         const SizedBoxWidth10(),
//                         SelectButton(
//                           height: 32,
//                           padding: 14,
//                           bgColor: const Color(0xFFFFFCF8),
//                           radius: 1000,
//                           text: locationType.isEmpty ? '공간구분' : locationType,
//                           textColor: const Color(0xFF6B4D38),
//                           textSize: 14.0,
//                           borderColor: const Color(0xFFAD7541),
//                           borderWidth: 1.0,
//                           borderOpacity: 0.4,
//                           svgIconPath: 'assets/icons/down_icon.svg',
//                           onPress: () {
//                             showModalBottomSheet(
//                               context: context,
//                               // shape를 사용해서 BorderRadius 설정.
//                               shape: const RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.vertical(
//                                   top: Radius.circular(25.0),
//                                 ),
//                               ),
//                               builder: (BuildContext context) {
//                                 return Container(
//                                   height: 350.0,
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 20.0, vertical: 20.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       buildPlaceList(context, '모든 공간'),
//                                       const ListBorderLine(), //bottom sheet 경계선
//                                       buildPlaceList(context, '카페'),
//                                       const ListBorderLine(),
//                                       buildPlaceList(context, '도서관'),
//                                       const ListBorderLine(),
//                                       buildPlaceList(context, '스터디카페'),
//                                       const ListBorderLine(),
//                                       buildPlaceList(context, '기타 작업 공간'),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                         ),
//                         for (int n = 0; n < taggedList.length; n++) ...[
//                           const SizedBoxWidth10(),
//                           tagButtonWidget(taggedList[n]),
//                         ]
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         //[임시]
//         // placeList('영등포 도서관', '도서관', 4.3, 23, '서울 영등포구 영등포로', 281.5),

//         //작업공간 보여주기
//         Padding(
//           padding: const EdgeInsets.only(
//             top: 114.0,
//           ),
//           child: showWorkspace(
//             scrollController,
//             searchController,
//             order,
//             locationType,
//             appliedSearchTags,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget showWorkspace(
//     ScrollController scrollController,
//     TextEditingController controller, // 입력값 controller
//     int order,
//     String locationType,
//     List<String> appliedSearchTags,
//   ) {
//     return FutureBuilder<List<dynamic>?>(
//       future: SearchService.searchPlace(
//         controller.text,
//         order,
//         locationType,
//         appliedSearchTags,
//       ), // 비동기 데이터 호출
//       builder: (BuildContext context, AsyncSnapshot<List<dynamic>?> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           // 데이터가 로드 중일 때 로딩 표시
//           return const Column(
//             children: [
//               SizedBox(
//                 height: 20.0,
//               ),
//               Center(
//                 child: CircularProgressIndicator(
//                   color: Color(0xFFAD7541),
//                 ),
//               ),
//             ],
//           );
//         } else if (snapshot.hasError) {
//           // 오류가 발생했을 때
//           return Text('Error: ${snapshot.error}');
//         } else {
//           // 데이터가 성공적으로 로드되었을 때
//           final workspaceList = snapshot.data;
//           print('----------rebuild showWorkspace search result----------');
//           print('workspaceList: $workspaceList');
//           print('your keyword: ${controller.text}');
//           print('your order: $order');

//           // 데이터가 없을 경우 처리
//           if (workspaceList == null || workspaceList.isEmpty) {
//             return const Center(
//               child: Text('해당 공간이 없습니다.'),
//             );
//           }

//           // *** ListView.builder로 변경 ***
//           return ListView.builder(
//             controller: scrollController,
//             itemCount: workspaceList.length,
//             itemBuilder: (BuildContext context, int index) {
//               return placeList(
//                 workspaceList[index]['workspaceName'],
//                 workspaceList[index]['workspaceType'],
//                 workspaceList[index]['starscore'],
//                 workspaceList[index]['reviewCnt'],
//                 workspaceList[index]['location'],
//                 workspaceList[index]['distance'],
//               );
//             },
//           );
//         }
//       },
//     );
//   }

//   Widget placeList(
//     String name,
//     String category,
//     double score,
//     int reviewCnt,
//     String address,
//     double distance,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Column(
//         children: [
//           // place list
//           Column(
//             children: [
//               Row(
//                 children: [
//                   //가게 이미지
//                   Container(
//                     decoration: const BoxDecoration(color: Colors.black),
//                     width: 80.0,
//                     height: 80.0,
//                   ),
//                   const SizedBox(
//                     width: 14.0,
//                   ),
//                   //가게 정보
//                   Expanded(
//                     child: Column(
//                       children: [
//                         //가게 정보 첫번째 줄: 이름, 카테고리
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 //가게 이름
//                                 Text(
//                                   name.length > 10 //가게 이름 크기 제한
//                                       ? '${name.substring(0, 10)}...'
//                                       : name,
//                                   // name,
//                                   style: Theme.of(context).textTheme.bodyLarge,
//                                 ),
//                                 const SizedBoxWidth10(),
//                                 //가게 카테고리
//                                 Text(
//                                   category.length > 8 //가게 카테고리 크기 제한
//                                       ? '${category.substring(0, 8)}...'
//                                       : category,
//                                   // category,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleSmall!
//                                       .copyWith(color: const Color(0xFFC3C3C3)),
//                                 ),
//                               ],
//                             ),
//                             SvgPicture.asset('assets/icons/unsave_icon.svg'),
//                           ],
//                         ),
//                         const SizedBox(height: 4.0),
//                         // 가게 정보 두번째 줄: 별점, 리뷰
//                         Row(
//                           children: [
//                             // 별점
//                             for (int i = 0; i < score.round(); i++) ...[
//                               SvgPicture.asset(
//                                   'assets/icons/star_fill_icon.svg'),
//                             ],
//                             for (int i = 0; i < 5 - score.round(); i++) ...[
//                               SvgPicture.asset(
//                                   'assets/icons/star_unfill_icon.svg'),
//                             ],
//                             const SizedBox(
//                               width: 8.0,
//                             ),
//                             // 리뷰 개수
//                             Text(
//                               '($reviewCnt)',
//                               style: Theme.of(context).textTheme.titleSmall,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 12.0),
//                         // 가게 정보 세번째 줄: 위치, 거리, 연락처
//                         Row(
//                           children: [
//                             // 주소
//                             Text(
//                               address.substring(0, 7),
//                               style: Theme.of(context).textTheme.titleSmall,
//                             ),
//                             const SizedBox(
//                               width: 4.0,
//                             ),
//                             SvgPicture.asset(
//                                 'assets/icons/dropdown_down_padding.svg'),
//                             const SizedBox(
//                               width: 4.0,
//                             ),
//                             // 거리
//                             Text(
//                               '${distance.round()}m',
//                               style: Theme.of(context).textTheme.titleSmall,
//                             ),
//                             const SizedBox(
//                               width: 16.0,
//                             ),
//                             Text(
//                               '연락처',
//                               style: Theme.of(context).textTheme.titleSmall,
//                             ),
//                             const SizedBox(
//                               width: 4.0,
//                             ),
//                             SvgPicture.asset(
//                                 'assets/icons/dropdown_down_padding.svg'),
//                           ],
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               //list padding
//               const SizedBox(
//                 height: 24.0,
//               ),
//               const ListBorderLine(),
//               const SizedBox(
//                 height: 24.0,
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget buildOrderList(
//       BuildContext context, String listContent, int orderContent) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero, // default Padding을 0으로 설정
//       title: Text(
//         listContent,
//         style: TextStyle(
//           color:
//               (order == orderContent) ? const Color(0xFF6B4D38) : Colors.black,
//           fontSize: 16.0,
//           fontWeight:
//               (order == orderContent) ? FontWeight.w600 : FontWeight.w400,
//         ),
//       ),
//       onTap: () {
//         setState(() {
//           selectedOrder = listContent;
//           order = orderContent;
//         });
//         Navigator.pop(context);
//       },
//     );
//   }

//   Widget buildPlaceList(BuildContext context, String listContent) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero, // default Padding을 0으로 설정
//       title: Text(
//         listContent,
//         style: TextStyle(
//           color: (locationType == listContent)
//               ? const Color(0xFF6B4D38)
//               : Colors.black,
//           fontSize: 16.0,
//           fontWeight:
//               (locationType == listContent) ? FontWeight.w600 : FontWeight.w400,
//         ),
//       ),
//       onTap: () {
//         setState(() {
//           locationType = listContent;
//         });
//         //Navigator.of(context).pop()이 ModalBottomSheet 내의 context에만 영향을 주어,
//         //다른 화면으로 돌아가지 않고, ModalBottomSheet만 닫는다.
//         Navigator.of(context).pop();
//       },
//     );
//   }

//   Widget searchBar(
//     TextEditingController searchController,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: searchBox(
//               const Color(0xFF6B4D38),
//               searchController,
//             ),
//           ),
//           const SizedBox(
//             width: 8,
//           ),
//           SvgPicture.asset('assets/icons/circle_icon.svg'),
//         ],
//       ),
//     );
//   }

//   //검색창
//   Widget searchBox(
//     Color borderColor,
//     TextEditingController controller, // 입력값 controller
//   ) {
//     return SizedBox(
//       height: 38.0,
//       // *** FutureBuilder를 사용하여 데이터를 로드함 ***
//       child: TextField(
//         controller: controller, // 입력값 controller
//         cursorColor: Colors.black, // 커서 색깔
//         decoration: InputDecoration(
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: borderColor,
//               width: 1, // 테두리 두께 설정
//             ),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: borderColor, // 클릭 시 색상 변경
//               width: 1, // 테두리 두께 설정
//             ),
//             borderRadius: BorderRadius.circular(12), // 테두리 모서리 둥글게 설정
//           ),
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//           // 아이콘 추가
//           suffixIcon: GestureDetector(
//             onTap: () async {
//               // 돋보기 클릭시 setState를 통해 workspace를 다시 불러온다.
//               setState(() {});
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(7.0),
//               child: SvgPicture.asset(
//                 'assets/icons/search_icon.svg',
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget tagButtonWidget(String tagName) {
//     return SelectButton(
//       height: 32.0,
//       padding: 14.0,
//       bgColor: appliedSearchTags.contains(tagName)
//           ? const Color(0xFF6B4D38)
//           : Colors.white,
//       radius: 1000,
//       text: tagName,
//       textColor: appliedSearchTags.contains(tagName)
//           ? Colors.white
//           : const Color(0xFF6B4D38),
//       textSize: 14.0,
//       borderWidth: appliedSearchTags.contains(tagName) ? null : 1.0,
//       borderColor:
//           appliedSearchTags.contains(tagName) ? null : const Color(0xFFAD7541),
//       borderOpacity: appliedSearchTags.contains(tagName) ? null : 0.4,
//       onPress: () {
//         toogleAppliedSearchTags(tagName);
//       },
//     );
//   }
// }

// class ListBorderLine extends StatelessWidget {
//   const ListBorderLine({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.maxFinite,
//       height: 1.0,
//       decoration: const BoxDecoration(
//         color: Color(0xFFE4E3E2),
//       ),
//     );
//   }
// }

// class SizedBoxHeight24 extends StatelessWidget {
//   const SizedBoxHeight24({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return const SizedBox(
//       height: 24.0,
//     );
//   }
// }

// class SizedBoxWidth10 extends StatelessWidget {
//   const SizedBoxWidth10({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return const SizedBox(
//       width: 10.0,
//     );
//   }
// }

// class SizedBoxHeight10 extends StatelessWidget {
//   const SizedBoxHeight10({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return const SizedBox(
//       height: 10.0,
//     );
//   }
// }

// class SizedBoxWidth6 extends StatelessWidget {
//   const SizedBoxWidth6({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return const SizedBox(
//       width: 6.0,
//     );
//   }
// }

// class Bar extends StatelessWidget {
//   const Bar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 4.0),
//           child: Container(
//             width: 50,
//             height: 6,
//             decoration: BoxDecoration(
//               color: const Color(0xFF8A5E34),
//               borderRadius: BorderRadius.circular(1000.0),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
