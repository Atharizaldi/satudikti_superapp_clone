import 'package:app/presentation/component/customAppBar.dart';
import 'package:flutter/material.dart';

class MajalahPopulerSelengkapnya extends StatefulWidget {
  const MajalahPopulerSelengkapnya({Key? key}) : super(key: key);

  @override
  State<MajalahPopulerSelengkapnya> createState() =>
      _MajalahPopulerSelengkapnyaState();
}

class _MajalahPopulerSelengkapnyaState
    extends State<MajalahPopulerSelengkapnya> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Praktisi",
      ),
      body: Container(
          child: Column(
        children: [],
      )),
    );
  }
}
