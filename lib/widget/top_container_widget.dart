import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopContainer extends StatelessWidget {

  final IconData? iconData;
 final  Color? colors;

  final String? title;
  final String? subtitle;
//  final Function()? ontap;

   TopContainer({this.iconData, this.title, this.colors, this.subtitle}) ;

  @override
  Widget build(BuildContext context) {
    return     Container(
        margin: EdgeInsets.symmetric(horizontal: 5, ),
        width: 120,
        height: 100,

        decoration: BoxDecoration(
            color: colors,
            // border: Border.all(
            //   color: Colors.black12,
            // ),
            borderRadius: BorderRadius.all(Radius.circular(20))


        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(

              iconData,
              size: 23,
              color: Colors.white,
            ),

            Text(
              title!,
              maxLines: 3,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white
              ),
            ),
            SizedBox(height: 5,),
            Text(
              subtitle!,

              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white
              ),
            ),
          ],
        ));
  }
}
