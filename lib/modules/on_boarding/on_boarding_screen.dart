import 'package:e_commerce_abdalla/modules/login/LoginScreen.dart';
import 'package:e_commerce_abdalla/shared/component/component.dart';
import 'package:e_commerce_abdalla/shared/network/local/cashHelper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ModelBoarding {
  final String image;
  final String Title;
  final String body;

  ModelBoarding({
    this.image,
    this.Title,
    this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {


  List<ModelBoarding> myBoarding = [
    ModelBoarding(
      image: 'assets/image/shop2.png',
      Title: 'Title Screen 1',
      body: 'body Screen 1',
    ),
    ModelBoarding(
      image: 'assets/image/shop1.png',
      Title: 'Title Screen 2',
      body: 'body Screen 2',
    ),
    ModelBoarding(
      image: 'assets/image/shop1.png',
      Title: 'Title Screen 3',
      body: 'body Screen 3',
    ),
  ];

  var pageController = PageController();
  bool isLast=false;

  void sumbit(){
    CashHelper.putData(key: 'onBoarding', value: true).then((value){
      print(value);
      if(value)
      navigateToToFinish(context, LoginScreen());
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){ sumbit(); }, child: Text('Skip',)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
                  onPageChanged: (index){
                    if(index==myBoarding.length-1){
                      setState(() {
                        isLast=true;
                      });
                    }else{
                      setState(() {
                        isLast=false;
                      });
                    }
                  },
              controller: pageController,
              itemBuilder: (context, index) =>
                  buildBoardingItem(myBoarding[index]),
              itemCount: 3,
            )),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.blue,
                    dotColor: Colors.grey,
                    spacing: 5,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 20,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                     if(isLast){
                       sumbit();
                     }else{
                       pageController.nextPage(
                           duration: Duration(milliseconds: 750),
                           curve: Curves.fastLinearToSlowEaseIn);
                     }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column buildBoardingItem(ModelBoarding model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image.asset(model.image)),
        SizedBox(
          height: 30,
        ),
        Text(
          model.Title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          model.body,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
