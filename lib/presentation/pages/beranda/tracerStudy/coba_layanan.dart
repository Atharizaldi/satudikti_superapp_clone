import 'package:app/presentation/pages/beranda/sinta/component/layanan.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/tracer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TracerCobaLayanan extends StatefulWidget {
  const TracerCobaLayanan({Key? key}) : super(key: key);

  @override
  State<TracerCobaLayanan> createState() => _TracerCobaLayananState();
}

class _TracerCobaLayananState extends State<TracerCobaLayanan> {
  late TracerBloc _tracerBloc;
  @override
  Widget build(BuildContext context) {
    _tracerBloc = BlocProvider.of<TracerBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('appbar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            layanan(context),
            BlocBuilder<TracerBloc, TracerState>(
              builder: ((context, state) {
                if (state is TracerConfigInitial) {
                  return Text('bisaaaaa');
                } else if (state is TracerConfigLoadedState) {
                  return Text('loadedddddddddd');
                }
                return Container();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
