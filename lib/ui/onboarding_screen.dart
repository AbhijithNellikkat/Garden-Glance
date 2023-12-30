import 'package:flutter/material.dart';
import 'package:garden_glance/constants.dart';
import 'package:garden_glance/ui/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController(initialPage: 0);

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22, top: 20),
            child: InkWell(
              onTap: () {},
              child: const Text(
                'Skip',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: pageController,
            children: [
              OnboardingCreatePageWidget(
                image: 'assets/images/plant-one.png',
                onboardingTitle: Constants.titleOne,
                onboardingdescription: Constants.descriptionOne,
              ),
              OnboardingCreatePageWidget(
                image: 'assets/images/plant-two.png',
                onboardingTitle: Constants.titleTwo,
                onboardingdescription: Constants.descriptionTwo,
              ),
              OnboardingCreatePageWidget(
                image: 'assets/images/plant-three.png',
                onboardingTitle: Constants.titleThree,
                onboardingdescription: Constants.descriptionThree,
              ),
            ],
          ),
          Positioned(
            bottom: 80,
            left: 30,
            child: Row(
              children: buildIndicator(currentIndex),
            ),
          ),
          Positioned(
            bottom: 60,
            right: 30,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Constants.primaryColor, shape: BoxShape.circle),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    if (currentIndex < 2) {
                      currentIndex++;
                      if (currentIndex < 3) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ));
                    }
                  });
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget indicator(bool isActive) {
  return AnimatedContainer(
    duration: const Duration(
      milliseconds: 300,
    ),
    height: 10.0,
    width: isActive ? 20 : 8,
    margin: const EdgeInsets.only(right: 5.0),
    decoration: BoxDecoration(
        color: Constants.primaryColor, borderRadius: BorderRadius.circular(5)),
  );
}

List<Widget> buildIndicator(int currentIndex) {
  List<Widget> indicators = [];
  for (int i = 0; i < 3; i++) {
    if (currentIndex == i) {
      indicators.add(indicator(true));
    } else {
      indicators.add(indicator(false));
    }
  }
  return indicators;
}

class OnboardingCreatePageWidget extends StatelessWidget {
  final String image;
  final String onboardingTitle;
  final String onboardingdescription;

  const OnboardingCreatePageWidget({
    super.key,
    required this.image,
    required this.onboardingTitle,
    required this.onboardingdescription,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 350,
            child: Image.asset(image),
          ),
          const SizedBox(height: 20),
          Text(
            onboardingTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: Constants.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            onboardingdescription,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
