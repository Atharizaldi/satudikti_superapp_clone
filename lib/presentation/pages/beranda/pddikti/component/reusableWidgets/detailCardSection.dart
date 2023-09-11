import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';

class DetailCardSection extends StatelessWidget {
  final double height;
  final Widget card;

  const DetailCardSection({Key? key, required this.height, required this.card})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: whiteBgPage,
          ),
          Center(child: card),
        ],
      ),
    );
  }
}
