import 'package:app/data/source/local/model/jenisProgram.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/components/jenisProgram/cardJenisProgramKD.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JenisProgramKD extends StatelessWidget {
  JenisProgramKD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(
        title: "Jenis Program",
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30.sp,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: listJenisProgram.length,
                  itemBuilder: (buildContext, index) {
                    return Column(
                      children: [
                        CardJenisProgramKD(
                            nama: listJenisProgram[index].nama,
                            deskripsi: listJenisProgram[index].deskripsi),
                        SizedBox(
                          height: 20.sp,
                        ),
                      ],
                    );
                  }),
              SizedBox(
                height: 62.sp,
              )
            ],
          ),
        ),
      ),
    );
  }
}
