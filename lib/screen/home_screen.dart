import 'dart:math';

import 'package:flutter/material.dart';
import 'package:p_ramdom/component/number_row.dart';
import 'package:p_ramdom/constant/color.dart';
import 'package:p_ramdom/screen/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int maxNumber = 1000;
  List<int> randomNumbers = [
    123,
    456,
    789,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(
                callbackFunction: onSettingsPop,
              ),
              _Body(randomNumbers: randomNumbers),
              _Footer(callback: onRandomeNumberGenerate)
            ],
          ),
        ),
      ),
    );
  }

  void onSettingsPop() async {
    // 넘어간 페이지에서 넘겨준 데이터를 받아올 수 있음
    final int? result = await Navigator.of(context).push<int>(
      MaterialPageRoute(builder: (BuildContext context) {
        return SettingsScreen(
          maxNumber: maxNumber,
        );
      }),
    );

    if (result != null) {
      setState(() {
        maxNumber = result;
      });
    }
  }

  void onRandomeNumberGenerate() {
    final rand = Random();

    final Set<int> newNumbers = {};

    while (newNumbers.length != 3) {
      final number = rand.nextInt(maxNumber);
      newNumbers.add(number);
    }
    setState(() {
      randomNumbers = newNumbers.toList();
    });
  }
}

class _Header extends StatelessWidget {
  final VoidCallback callbackFunction;

  const _Header({required this.callbackFunction, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "랜덤숫자 생성기",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        IconButton(
          onPressed: callbackFunction,
          icon: Icon(
            Icons.settings,
            color: RED_COLOR,
          ),
        )
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> randomNumbers;

  const _Body({required this.randomNumbers, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: randomNumbers
          .asMap()
          .entries
          .map((x) => Padding(
                padding: EdgeInsets.only(bottom: x.key == 2 ? 0 : 16.0),
                child: NumberRow(number: x.value),
              ))
          .toList(),
    ));
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback callback;

  const _Footer({required this.callback, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: RED_COLOR),
        onPressed: callback,
        child: Text('생성하기!'),
      ),
    );
  }
}
