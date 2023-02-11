import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hopleaders/screens/signInScreen.dart';

import '../models/businessLayer/base.dart';

class IntroScreen extends Base {


  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends BaseState {
  PageController? _pageController;
  int _currentIndex = 0;
  List<String> _imageUrl = [
    'assets/slide1.jpg',
    'assets/slide2.jpg',
    'assets/slide3.jpg',
  ];

  _IntroScreenState() : super();

  @override
  Widget build(BuildContext context) {
    List<IntroSH> _titles = [
      IntroSH(heading: 'The Seven (7) Pillars of the Cell System',
          title: 'Every Roof of a Pillar is a potenal cell as long as it'
         ' can boast of at least 2 or 3 persons in the cell meeting.'
       ),
      IntroSH(heading: 'Cell Classification',title: '1. New Cell - Cell that are just Starng with at least 2 or'
         ' 3 actual/potenal members and has at least 2 months to mature.'),
      IntroSH(heading: 'Cell Membership Parcipation,',title: 'p1. Must be at least 95% available for all cell meengs and church services.')
    ];

    return WillPopScope(
      onWillPop: () {
        return promptExit();
      },
      child: sc(
        Scaffold(
            body: PageView.builder(
                itemCount: _imageUrl.length,
                controller: _pageController,
                onPageChanged: (index) {
                  _currentIndex = index;
                  setState(() {});
                },
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image.asset(
                          _imageUrl[index],
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.31),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: DotsIndicator(
                            dotsCount: _titles.length,
                            position: _currentIndex.toDouble(),
                            onTap: (i) {
                              index = i.toInt();
                              _pageController!.animateToPage(index,
                                  duration: Duration(microseconds: 1),
                                  curve: Curves.easeInOut);
                            },
                            decorator: DotsDecorator(
                              activeSize: const Size(30, 10),
                              size: const Size(17, 10),
                              activeShape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                              activeColor: Theme.of(context).primaryColor,
                              color: Theme.of(context).primaryColorLight,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: BottomSheet(
                            enableDrag: false,
                            onClosing: () {},
                            builder: (BuildContext context) {
                              return Container(
                                margin: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                height:
                                MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        _titles[index].heading??"",
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle2,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 10, right: 10),
                                      child: Text(
                                        _titles[index].title??"",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle1,
                                      ),
                                    ),
                                    index == 0 || index == 1
                                        ? Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                elevation:
                                                MaterialStateProperty
                                                    .all(0),
                                                backgroundColor:
                                                MaterialStateProperty
                                                    .all(Colors
                                                    .transparent)),
                                            onPressed: () {},
                                            child: Text('')),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              _pageController!
                                                  .animateToPage(
                                                  _currentIndex + 1,
                                                  duration: Duration(
                                                      microseconds:
                                                      1),
                                                  curve: Curves
                                                      .easeInOut);
                                            },
                                            child: Text(
                                              'Next',style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                elevation:
                                                MaterialStateProperty
                                                    .all(0),
                                                backgroundColor:
                                                MaterialStateProperty
                                                    .all(Colors
                                                    .transparent)),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignInScreen(

                                                        )),
                                              );
                                            },
                                            child: Text(
                                              "Skip",
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .subtitle2,
                                            ))
                                      ],
                                    )
                                        : ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignInScreen(
                                                  )),
                                        );
                                      },
                                      child: Text(
                                        'Get Started',style: TextStyle(color: Colors.white)
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      )
                    ],
                  );
                })),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }
}

class IntroSH {
  String? heading;
  String? title;

  IntroSH({this.heading, this.title});
}

