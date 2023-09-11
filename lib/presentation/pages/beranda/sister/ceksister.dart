import 'package:app/injection.dart' as di;
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/kuesioner/kuesioner_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/kuesioner/kuesioner_event.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/hasilpengisiankuesioner_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CekSister extends StatefulWidget {
  const CekSister({Key? key}) : super(key: key);

  @override
  State<CekSister> createState() => _CekSisterState();
}

class _CekSisterState extends State<CekSister> {
  TextEditingController namaPerguruanTinggiController =
      new TextEditingController();
  Map<String, String> selectedPTObject = {"kodePT": ""};

  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ASDSADSDSAD"),
        ),
        body: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) => di
                                .locator<KuesionerTracerBloc>()
                              ..add(GetAnswer(
                                  id: "f59c6e3c-5170-430e-ac1a-7dbfe0bcc580")),
                            child: HasilPengisianKuesionerPage(),
                          )));
            },
            child: Center(child: Text("ASD"))));
  }
}
