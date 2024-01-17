import 'package:flutter/material.dart';
import 'package:p_ramdom/component/number_row.dart';
import 'package:p_ramdom/constant/color.dart';

class SettingsScreen extends StatefulWidget {
  final int maxNumber;

  const SettingsScreen({required this.maxNumber, super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double maxNumber = 1000;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // pop을 통해 삭제된 세팅스크린 위젯은 다시 생성할 떄, 홈스크린에 있는 데이터를 다시 세팅스크린에 데이터를 넘겨줌
    maxNumber = widget.maxNumber.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Body(
                maxNumber: maxNumber,
              ),
              _Footer(
                maxNumber: maxNumber,
                onChanged: onSlideChanged,
                onPressed: onButton,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSlideChanged(double val) {
    setState(() {
      maxNumber = val;
    });
  }

  void onButton() {
    Navigator.of(context).pop(maxNumber.toInt());
  }
}

class _Body extends StatelessWidget {
  final double maxNumber;

  const _Body({required this.maxNumber, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(number: maxNumber.toInt())
    );
  }
}

class _Footer extends StatelessWidget {
  final double maxNumber;
  final ValueChanged<double>? onChanged;
  final VoidCallback onPressed;

  const _Footer(
      {required this.maxNumber,
      required this.onChanged,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
          value: maxNumber,
          min: 1000,
          max: 1000000,
          onChanged: onChanged,
        ),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: RED_COLOR,
          ),
          child: Text(
            '저장!',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
