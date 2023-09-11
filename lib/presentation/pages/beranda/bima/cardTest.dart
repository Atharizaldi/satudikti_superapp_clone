import 'package:flutter/material.dart';

class CardTestBima extends StatelessWidget {
  const CardTestBima({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          color: Colors.amber,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('Penelitian'),
                      Text('1'),
                      Text('test3'),
                      Text('test4'),
                      Text('test5'),
                    ],
                  ),
                  Image.asset('assets/bima/psychology.png')
                ],
              ),
              Text('lihat detail'),
            ],
          ),
        ),
      ],
    );
  }
}
