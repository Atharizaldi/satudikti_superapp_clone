import 'package:app/injection.dart' as di;
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/tracer_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/component/appBarWidgetTracerStudy.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/scrolledContent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../component/constant.dart';
import '../../../component/customSliverBar.dart';

class TracerStudyPage extends StatefulWidget {
  const TracerStudyPage({Key? key}) : super(key: key);

  @override
  State<TracerStudyPage> createState() => _TracerStudyPageState();
}

class _TracerStudyPageState extends State<TracerStudyPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => di.locator<TracerBloc>()
          ..add(TracerConfigEvent(
            moduleId: 14,
          )),
        child: BlocBuilder<TracerBloc, TracerState>(builder: (context, state) {
          return Container(
            decoration: BoxDecoration(gradient: sliverBgGradient),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: CustomSliverBar(
                  expandedHeight: 260.w,
                  appBarTitle: "Tracer Study",
                  header: FlexibleSpaceBar(
                    background: appBarWidgetTracerStudy(context),
                  ),
                  child: ScrolledContent(),
                )),
          );
        }));
  }
}
