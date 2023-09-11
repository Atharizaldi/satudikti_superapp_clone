import 'package:flutter/cupertino.dart';

class DetailCard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Container(
      child: 
        Container(
          margin:  EdgeInsets.fromLTRB(0, 0, 0, 16),
          padding:  EdgeInsets.fromLTRB(27.5, 30, 27.5, 30),
          width:  double.infinity,
          height:  350,
          decoration:  BoxDecoration (
            color:  Color(0xffffffff),
            borderRadius:  BorderRadius.circular(10),
            boxShadow:  [
              BoxShadow(
                color:  Color(0x14979797),
                offset:  Offset(0, 4),
                blurRadius:  7.5,
              ),
            ],
          ),
          child:
          Container(
            width:  201,
            height:  double.infinity,
            child:
            Column(
              crossAxisAlignment:  CrossAxisAlignment.center,
              children:  [

              ],
            ),
          ),
        ),
      );
  
  }

}