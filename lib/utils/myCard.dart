import 'package:flutter/material.dart';

class CardDigest extends StatelessWidget {


  final String? cardImage;
  final String? heading;
  final String? supportingText;
  final String? subheading;
  final String? name;
  const CardDigest({this.name, this.cardImage, this.heading,this.subheading,this.supportingText}) ;



  @override
  Widget build(BuildContext context) {
    return Card(
        shadowColor: Colors.blueGrey,
        margin: EdgeInsets.only(top: 60),
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(

                      width: 50.0,
                      height: 50.0,
                      child:  Image.asset(
                          cardImage??" "
                      ),

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),

                    ),
                    ),




                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(heading!, style: Theme.of(context).primaryTextTheme.headline6,),


                            ],),
                        ),
                      ),
                    ),



                  ],),
              ),


              Container(
                 width: 200.0,
                  child:
                    Text(subheading??" ",overflow: TextOverflow.ellipsis,maxLines: 1,),

              ),



            ],
          ),
        ));;
  }
}