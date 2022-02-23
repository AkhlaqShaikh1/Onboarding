import 'package:flutter/material.dart';
import 'package:onboarding/constants/constants.dart';
import 'package:onboarding/constants/themes.dart';
import 'package:onboarding/widgets/animated_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        backgroundColor: Colors.white,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(8.0),
          child: PageView(
            controller: _pageController,
            children: [
              Slide(
                title: "Boost your traffic",
                subtitle:
                    'Outreach to many social networks to improve your statistics',
                imagePath: "./assets/hero-1.png",
                onNext: nextPage,
              ),
              Slide(
                title: "Give the best solution",
                subtitle: 'We will give best solution for your business issues',
                imagePath: "./assets/hero-2.png",
                onNext: nextPage,
              ),
              Slide(
                title: "Reach the target",
                subtitle:
                    'With our help, it will be easier to achieve your goals',
                imagePath: "./assets/hero-3.png",
                onNext: nextPage,
              )
            ],
          ),
        ),
      ),
    );
  }

  nextPage() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn);
  }
}

class Slide extends StatelessWidget {
  final String imagePath;
  final String title, subtitle;
  final VoidCallback onNext;
  const Slide({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(imagePath),
          ),
          Padding(
            padding: kDefaultPadding,
            child: Column(
              children: [
                Text(
                  title,
                  style: kTitleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  subtitle,
                  style: kSubtitleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
          ProgressButton(onNext: onNext),
          const SizedBox(height: 45),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: GestureDetector(
              onTap: onNext,
              child: const Text(
                "Skip",
                style: kSubtitleStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressButton extends StatelessWidget {
  final VoidCallback onNext;
  const ProgressButton({Key? key, required this.onNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      width: 75,
      child: Stack(
        children: [
          AnimatedIndicator(
            duration: const Duration(seconds: 5),
            size: 75.0,
            callback: onNext,
          ),
          Center(
            child: GestureDetector(
              child: Container(
                height: 60,
                width: 60,
                child: const Icon(
                  Icons.navigate_next,
                  size: 30,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: blueColor,
                ),
              ),
              onTap: onNext,
            ),
          ),
        ],
      ),
    );
  }
}
