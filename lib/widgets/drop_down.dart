import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DropDown extends StatefulWidget {
  final TextEditingController controller;

  const DropDown({
    super.key,
    required this.controller,
  });

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String _selectedValue = '직장인';
  bool _isDropdownOpened = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: const Color(0xFFCCD1DD),
          width: 2.0,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          value: _selectedValue,
          icon: SvgPicture.asset(
            _isDropdownOpened
                ? 'assets/icons/dropdown_up.svg'
                : 'assets/icons/dropdown_down.svg',
          ),
          isExpanded: true,
          buttonPadding: const EdgeInsets.only(left: 4.0, right: 16.0),
          dropdownMaxHeight: 260,
          dropdownDecoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFFCCD1DD),
              width: 2.0,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
            boxShadow: const [],
          ),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'SF_Pro',
            color: Colors.black,
          ),
          items: <String>['대학생', '직장인', '디자이너', '개발자', '기타']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Text(value),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedValue = newValue!;
              widget.controller.text = _selectedValue;
            });
          },
          //현재 dropdown이 열여있는지 닫혀있는지 확인
          onMenuStateChange: (bool isOpen) {
            setState(() {
              _isDropdownOpened = isOpen;
            });
          },
        ),
      ),
    );
  }
}
