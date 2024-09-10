import 'package:flutter/material.dart';
import 'package:flutter_mow/widgets/appbar_back.dart';
import 'package:flutter_mow/widgets/select_button.dart';
import 'package:flutter_svg/svg.dart';

class EditTag extends StatefulWidget {
  const EditTag({
    super.key,
  });

  @override
  State<EditTag> createState() => _EditTagState();
}

class _EditTagState extends State<EditTag> {
  List<bool> isTagOpen = [false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppbarBack(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 28.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '태그 편집',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            '검색에 이용할 태그들을 선택해주세요!',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // *** 이하 Scroll ***
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 24.0,
                    ),
                    const TagListWidget(
                      tagContent1: '# 공간이 넓어요',
                      tagContent2: '# 좌석이 많아요',
                    ),
                    const SizedBoxHeight10(),
                    const TagListWidget(
                      tagContent1: '# 콘센트가 많아요',
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),

                    // 작업 편의 tab
                    tagTitle(
                      '작업 편의',
                      0,
                    ),
                    // 작업 편의 tags
                    if (isTagOpen[0]) ...[
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 24.0),
                        child: TagListWidget(
                          tagContent1: '# 한산해요',
                          tagContent2: '# 의자가 편해요',
                          tagContent3: '# 책상이 넓어요',
                        ),
                      ),
                    ],

                    // 분위기 tab
                    tagTitle(
                      '분위기',
                      1,
                    ),
                    // 분위기 tags
                    if (isTagOpen[1]) ...[
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 24.0),
                        child: Column(
                          children: [
                            TagListWidget(
                              tagContent1: '# 뷰가 좋아요',
                              tagContent2: '# 조용해요',
                            ),
                            SizedBoxHeight10(),
                            TagListWidget(
                              tagContent1: '# 아늑해요',
                              tagContent2: '# 인테리어가 깔끔해요',
                            ),
                            SizedBoxHeight10(),
                            TagListWidget(
                              tagContent1: '# 어두워요',
                              tagContent2: '# 밝아요',
                              tagContent3: '# 다시 오고 싶어요',
                            ),
                            SizedBoxHeight10(),
                            TagListWidget(
                              tagContent1: '# 음악이 좋아요',
                              tagContent2: '# 대화하기 좋아요',
                            ),
                            SizedBoxHeight10(),
                            TagListWidget(
                              tagContent1: '# 감각적이에요',
                              tagContent2: '# 혼자 작업하기 좋아요',
                            ),
                            SizedBoxHeight10(),
                            TagListWidget(
                              tagContent1: '# 회의하기에 좋아요',
                            ),
                          ],
                        ),
                      ),
                    ],

                    // 메뉴 tab
                    tagTitle(
                      '메뉴',
                      2,
                    ),
                    // 메뉴 tags
                    if (isTagOpen[2]) ...[
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 24.0),
                        child: Column(
                          children: [
                            TagListWidget(
                              tagContent1: '# 저렴해요',
                              tagContent2: '# 매뉴가 다양해요',
                            ),
                            SizedBoxHeight10(),
                            TagListWidget(
                              tagContent1: '# 커피가 맛있어요',
                              tagContent2: '# 디저트가 맛있어요',
                            ),
                          ],
                        ),
                      ),
                    ],

                    // 서비스 tab
                    tagTitle(
                      '서비스',
                      3,
                    ),
                    // 서비스 tags
                    if (isTagOpen[3]) ...[
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 24.0),
                        child: Column(
                          children: [
                            TagListWidget(
                              tagContent1: '# 친절해요',
                              tagContent2: '# 와이파이가 잘 터져요',
                            ),
                            SizedBoxHeight10(),
                            TagListWidget(
                              tagContent1: '# 에어컨이 잘 나와요',
                              tagContent2: '# 오래 작업하기 좋아요',
                            ),
                          ],
                        ),
                      ),
                    ],

                    // 기타 tab
                    tagTitle(
                      '기타',
                      4,
                    ),
                    // 기타 tags
                    if (isTagOpen[4]) ...[
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 24.0),
                        child: Column(
                          children: [
                            TagListWidget(
                              tagContent1: '# 화장실이 깨끗해요',
                              tagContent2: '# 찾아가기 편해요',
                            ),
                            SizedBoxHeight10(),
                            TagListWidget(
                              tagContent1: '# 무료로 이용이 가능해요',
                              tagContent2: '# 주차가 가능해요',
                            ),
                            SizedBoxHeight10(),
                            TagListWidget(
                              tagContent1: '# 24시간 운영이에요',
                            ),
                          ],
                        ),
                      ),
                    ],

                    //마지막 여백
                    const SizedBox(
                      height: 72.0,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tagTitle(String title, int numberOfTag) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, right: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16, //임의 수정
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isTagOpen[numberOfTag] = !isTagOpen[numberOfTag];
              });
            },
            child: SvgPicture.asset(isTagOpen[numberOfTag]
                ? 'assets/icons/dropdown_up_padding.svg'
                : 'assets/icons/dropdown_down_padding.svg'),
          ),
        ],
      ),
    );
  }
}

class TagTitle extends StatelessWidget {
  const TagTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, right: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16, //임의 수정

              fontWeight: FontWeight.bold,
            ),
          ),
          SvgPicture.asset('assets/icons/dropdown_up.svg'),
        ],
      ),
    );
  }
}

class TagListWidget extends StatelessWidget {
  const TagListWidget({
    super.key,
    required this.tagContent1,
    this.tagContent2,
    this.tagContent3,
  });

  final String tagContent1;
  final String? tagContent2;
  final String? tagContent3;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // tag Content 1
                    SelectButtonWidget(
                      textContent: tagContent1,
                    ),
                    if (tagContent2 != null) ...[
                      const SizedBoxWidth6(),
                      // tag Content 2
                      SelectButtonWidget(
                        textContent: tagContent2!,
                      ),
                      if (tagContent3 != null) ...[
                        const SizedBoxWidth6(),
                        // tag Content 3
                        SelectButtonWidget(
                          textContent: tagContent3!,
                        ),
                      ]
                    ]
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
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
