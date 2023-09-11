import 'package:app/injection.dart' as di;
import 'package:app/presentation/pages/beranda/sister/ceksister.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/kuesioner/kuesioner_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CekBima extends StatefulWidget {
  // late final List<Text> article;
  // late final List<Text> citation;
  // late final List<Text> citedDocument;
  // late final List<Text> hIndex;
  // late final List<Text> i10Index;
  // late final List<Text> gIndex;
  const CekBima({
    Key? key,
  }) : super(key: key);

  @override
  State<CekBima> createState() => _CekBimaState();
}

class _CekBimaState extends State<CekBima> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          title: Text("Cek BIMAap"),
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                        create: (context) => di.locator<KuesionerTracerBloc>(),
                        child: CekSister()),
                  ),
                );
              },
              child: Text("ASD")),
        ));
  }
}
