import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DropDown extends StatefulWidget {
  const DropDown({super.key});

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
                  ? 'assets/icons/dropdown_up.svg' // Icon when expanded
                  : 'assets/icons/dropdown_up.svg', // Icon when collapsed
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
            items: <String>['대학생', '직장인', '디자이너', '개발자', '직접입력']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 11.0), // 22px total height spacing
                  child: Text(value),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedValue = newValue!;
              });
            },
          ),
        ),
      ),
    );
  }
}
