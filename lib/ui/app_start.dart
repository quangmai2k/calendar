import 'package:calendar/common/style.dart';
import 'package:calendar/ui/main_screen.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int index = 0;
  String urlStepImage = "assets/images/SlideStep1.png";
  String urlBannerImage1 = "assets/images/Calendar.png";
  String urlBannerImage2 = "assets/images/Schedule.png";
  String urlBannerImage3 = "assets/images/Focus.png";
  @override
  void initState() {
    super.initState();
  }

  void nextScreen() {
    setState(() {
      index++;
      if (index == 1) {
        urlStepImage = "assets/images/SlideStep2.png";
      }
    });
  }

  void nextToMainScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => MainScreen()), // Chuyển sang màn hình chính
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double containerTop = screenSize.height * 3 / 5;
    double containerBottom = screenSize.height * 2 / 5;
    return Column(
      children: [
        Container(
          height: containerTop,
          color: const Color(0xFFF6EFEA),
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: index == 0
                  ? Image(
                      height: 280,
                      image: AssetImage(urlBannerImage1),
                      key: UniqueKey(),
                    )
                  : index == 1
                      ? Image(
                          height: 280,
                          image: AssetImage(urlBannerImage2),
                          key: UniqueKey(),
                        )
                      : Image(
                          height: 280,
                          image: AssetImage(urlBannerImage3),
                          key: UniqueKey(),
                        ),
            ),
          ),
        ),
        SizedBox(
            height: containerBottom,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 2000),
                      curve: Curves.easeInOut,
                      child: index == 0
                          ? Column(
                              key: UniqueKey(),
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                SelectableText("Welcome to",
                                    style: textStartScreen28),
                                Text("Calendar-planner",
                                    style: textStartScreen28),
                              ],
                            )
                          : index == 1
                              ? Center(
                                  child: Text("Plan a Schedule",
                                      key: UniqueKey(),
                                      textAlign: TextAlign.center,
                                      style: textStartScreen32),
                                )
                              : Center(
                                  child: Text("Keep Focus",
                                      key: UniqueKey(),
                                      textAlign: TextAlign.center,
                                      style: textStartScreen32),
                                )),
                  index == 2
                      ? Row(
                          children: [
                            Expanded(
                                child: Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              height: 65,
                              child: TextButton(
                                onPressed: nextToMainScreen,
                                style: ButtonStyle(
                                  shape: MaterialStatePropertyAll<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          40), // Điều chỉnh giá trị border radius ở đây
                                    ),
                                  ),
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Color(0xFFF4983C)),
                                ),
                                child: const Text(
                                  "STARTED",
                                  style: textBtnStartScreen2,
                                ),
                              ),
                            ))
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image(height: 6, image: AssetImage(urlStepImage)),
                            SizedBox(
                              height: 44,
                              width: 90,
                              child: TextButton(
                                onPressed: nextScreen,
                                style: ButtonStyle(
                                  shape: MaterialStatePropertyAll<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          13), // Điều chỉnh giá trị border radius ở đây
                                    ),
                                  ),
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Color(0xFFF4983C)),
                                ),
                                child: const Text(
                                  "Next",
                                  style: textBtnStartScreen1,
                                ),
                              ),
                            )
                          ],
                        )
                ],
              ),
            ))
      ],
    );
  }
}
