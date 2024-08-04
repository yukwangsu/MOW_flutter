import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DropDown extends StatefulWidget {
  final TextEditingController controller; //입력값 controller

  const DropDown({
    super.key,
    required this.controller,
  });

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String _selectedValue = '직장인';
  bool _isExpanded = false; // State to track whether the dropdown is expanded
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller.text = _selectedValue;
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // Dropdown gained focus
        setState(() {
          _isExpanded = true;
        });
      } else {
        // Dropdown lost focus
        setState(() {
          _isExpanded = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Background color for the dropdown button
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color:
              const Color(0xFFCCD1DD), // Border color for the dropdown button
          width: 2.0,
        ),
      ),
      child: Focus(
        focusNode: _focusNode,
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            value: _selectedValue,
            icon: SvgPicture.asset(
              _isExpanded
                  ? 'assets/icons/dropdown_down.svg'
                  : 'assets/icons/dropdown_up.svg', // 반대?
            ),
            isExpanded: true,
            buttonPadding: const EdgeInsets.only(left: 4.0, right: 16.0),
            dropdownMaxHeight: 260, // Maximum height of the dropdown menu
            dropdownDecoration: BoxDecoration(
              color: Colors.white, // Background color for the dropdown menu
              border: Border.all(
                color: const Color(
                    0xFFCCD1DD), // Border color for the dropdown menu
                width: 2.0, // Border width for the dropdown menu
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0), // Radius for all corners
              ),
              boxShadow: const [], // Remove shadow by setting an empty list
            ),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'SF_Pro',
              color: Colors.black, // Text color in the dropdown menu
            ),
            //직접입력 수정 필요
            items: <String>['대학생', '직장인', '디자이너', '개발자', '직접입력']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0), // 패딩?
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
          ),
        ),
      ),
    );
  }
}
