import 'package:clear/src/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Intropage extends StatefulWidget {
  Intropage({Key key}) : super(key: key);

  @override
  _IntropageState createState() => _IntropageState();
}

class _IntropageState extends State<Intropage> {
  List<Slide> slides = new List();
  Function goToTab;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addSlide1();
    addSlide2();
    addSlide3();
  }

  addSlide1() async {
    return slides.add(
      new Slide(
        title: "SCHOOL",
        styleTitle: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.",
        styleDescription: TextStyle(
          color: Color(0xfffe9c8f),
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
        ),
        pathImage: "images/photo_school.png",
      ),
    );
  }

  addSlide2() async {
    return slides.add(
      new Slide(
        title: "MUSEUM",
        styleTitle: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Ye indulgence unreserved connection alteration appearance",
        styleDescription: TextStyle(
          color: Color(0xfffe9c8f),
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
        ),
        pathImage: "images/photo_museum.png",
      ),
    );
  }

  addSlide3() async {
    return slides.add(
      new Slide(
        title: "COFFEE SHOP",
        styleTitle: TextStyle(
          color: Color(0xff3da4ab),
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        description:
            "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        styleDescription: TextStyle(
            color: Color(0xfffe9c8f),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "images/photo_coffee_shop.png",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      colorSkipBtn: Color(0x33ffcc5c),
      highlightColorSkipBtn: Color(0xffffcc5c),

      // Next button
      renderNextBtn: this.renderNextBtn(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: Color(0x33ffcc5c),
      highlightColorDoneBtn: Color(0xffffcc5c),

      // Dot indicator
      colorDot: Color(0xffffcc5c),
      sizeDot: 13.0,
      // typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

      // Tabs
      listCustomTabs: this.renderListCustomTabs(),
      backgroundColorAllSlides: Colors.white,
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },

      // Show or hide status bar
      shouldHideStatusBar: true,

      // On tab change completed
      onTabChangeCompleted: this.onTabChangeCompleted,
    );
  }

  Future<void> onDonePress() async {
    // Back to the first tab
    // this.goToTab(0);
    SharedPreferences preference = await SharedPreferences.getInstance();

    await preference.setBool('seen', true);
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new HomePage()));
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Color(0xffffcc5c),
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Color(0xffffcc5c),
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Color(0xffffcc5c),
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                currentSlide.pathImage,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.contain,
              )),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  // @override
  // Widget build(BuildContext context) {
  //   return new IntroSlider(
  //     // List slides
  //     slides: this.slides,

  //     // Skip button
  //     renderSkipBtn: this.renderSkipBtn(),
  //     colorSkipBtn: Color(0x33ffcc5c),
  //     highlightColorSkipBtn: Color(0xffffcc5c),

  //     // Next button
  //     renderNextBtn: this.renderNextBtn(),

  //     // Done button
  //     renderDoneBtn: this.renderDoneBtn(),
  //     onDonePress: this.onDonePress,
  //     colorDoneBtn: Color(0x33ffcc5c),
  //     highlightColorDoneBtn: Color(0xffffcc5c),

  //     // Dot indicator
  //     colorDot: Color(0xffffcc5c),
  //     sizeDot: 13.0,
  //     // typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

  //     // Tabs
  //     listCustomTabs: this.renderListCustomTabs(),
  //     backgroundColorAllSlides: Colors.white,
  //     refFuncGoToTab: (refFunc) {
  //       this.goToTab = refFunc;
  //     },

  //     // Show or hide status bar
  //     shouldHideStatusBar: true,

  //     // On tab change completed
  //     onTabChangeCompleted: this.onTabChangeCompleted,
  //   );
  // }
}