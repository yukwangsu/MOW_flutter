// import 'package:flutter/material.dart';
// import 'package:flutter_mow/screens/info/set_job.dart';
// import 'package:flutter_mow/widgets/appbar_back.dart';
// import 'package:flutter_mow/widgets/button_main.dart';
// import 'package:flutter_mow/widgets/select_button.dart';
// import 'package:flutter_mow/widgets/text_start.dart';

// class SetMbti extends StatefulWidget {
//   const SetMbti({super.key});

//   @override
//   State<SetMbti> createState() => _SetMbtiState();
// }

// class _SetMbtiState extends State<SetMbti> {
//   late String mbti = '';

//   setINTJ() {
//     setState(() {
//       mbti = 'INTJ';
//     });
//   }

//   setINTP() {
//     setState(() {
//       mbti = 'INTP';
//     });
//   }

//   setENTJ() {
//     setState(() {
//       mbti = 'ENTJ';
//     });
//   }

//   setENTP() {
//     setState(() {
//       mbti = 'ENTP';
//     });
//   }
  
//   set() {
//     setState(() {
//       mbti = 'INFJ';
//     });
//   }

//   set() {
//     setState(() {
//       mbti = 'INFP';
//     });
//   }

//   set() {
//     setState(() {
//       mbti = 'ENFJ';
//     });
//   }

//   set() {
//     setState(() {
//       mbti = 'ENFP';
//     });
//   }

//   set() {
//     setState(() {
//       mbti = 'ISTJ';
//     });
//   }

//   set() {
//     setState(() {
//       mbti = 'ISFJ';
//     });
//   }

//   set() {
//     setState(() {
//       mbti = 'ESTJ';
//     });
//   }

//   set() {
//     setState(() {
//       mbti = 'ESFJ';
//     });
//   }

//   set() {
//     setState(() {
//       mbti = '';
//     });
//   }

//   set() {
//     setState(() {
//       mbti = '';
//     });
//   }

//   set() {
//     setState(() {
//       mbti = '';
//     });
//   }

//   set() {
//     setState(() {
//       mbti = '';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: const AppbarBack(),
//       resizeToAvoidBottomInset: false, //키보드가 올라와도 화면이 그대로 유지
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 25,
//               ),
//               const TextStart(
//                 text: '000님의',
//               ),
//               const TextStart(
//                 text: '성별이 궁금해요 !',
//               ),
//               const SizedBox(
//                 height: 60,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 27),
//                 child: Row(
//                   children: [
//                     SelectButton(
//                       height: 49,
//                       padding: 26,
//                       bgColor: sex == 1
//                           ? const Color(0xFF6B4D38)
//                           : const Color(0xFFFFFCF8),
//                       radius: 1000,
//                       text: '남자',
//                       textColor:
//                           sex == 1 ? Colors.white : const Color(0xFF6B4D38),
//                       onPress: () {
//                         selectMan();
//                       },
//                     ),
//                     const SizedBox(
//                       width: 6,
//                     ),
//                     SelectButton(
//                       height: 49,
//                       padding: 26,
//                       bgColor: sex == 2
//                           ? const Color(0xFF6B4D38)
//                           : const Color(0xFFFFFCF8),
//                       radius: 1000,
//                       text: '여자',
//                       textColor:
//                           sex == 2 ? Colors.white : const Color(0xFF6B4D38),
//                       onPress: () {
//                         selectWoman();
//                       },
//                     ),
//                     const SizedBox(
//                       width: 6,
//                     ),
//                     SelectButton(
//                       height: 49,
//                       padding: 26,
//                       bgColor: sex == 3
//                           ? const Color(0xFF6B4D38)
//                           : const Color(0xFFFFFCF8),
//                       radius: 1000,
//                       text: '선택안함',
//                       textColor:
//                           sex == 3 ? Colors.white : const Color(0xFF6B4D38),
//                       onPress: () {
//                         selectNone();
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 27),
//             child: Column(
//               children: [
//                 ButtonMain(
//                   text: '다음',
//                   bgcolor: Colors.white,
//                   textColor: const Color(0xFF6B4D38),
//                   borderColor: const Color(0xFF6B4D38),
//                   onPress: () {
//                     if (sex > 0) {
//                       if (sex == 1) {
//                         print('남자');
//                       } else if (sex == 2) {
//                         print('여자');
//                       } else {
//                         print('선택안함');
//                       }
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => SetJob(),
//                         ),
//                       );
//                     }
//                   },
//                 ),
//                 const SizedBox(
//                   height: 68,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
