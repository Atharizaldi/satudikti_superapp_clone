import 'package:app/common/dateFormat.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopularCard extends StatelessWidget {
  final String gambarBerita, judulBerita, tanggal;
  final VoidCallback function;

  const PopularCard(
      {Key? key,
      required this.gambarBerita,
      required this.judulBerita,
      required this.tanggal,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FormatDate formatDate = new FormatDate();
    return GestureDetector(
        onTap: this.function,
        child: Container(
          height: 183,
          width: 163,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  height: 112,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image:
                            this.gambarBerita == 'assets/default-con/berita.png'
                                ? AssetImage('assets/default-con/berita.png')
                                    as ImageProvider
                                : NetworkImage(this.gambarBerita.toString()),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                judulBerita,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  color: blue2,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                formatDate.formatDate(tanggal),
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: neutralCaption),
              )
            ],
          ),
        ));
  }
}
