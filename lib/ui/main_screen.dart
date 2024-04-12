import 'package:calendar/common/style.dart';
import 'package:calendar/ui/new_event.dart';
import 'package:flutter/material.dart';

import 'calendar.dart';

enum DisplayOption { Day, Weeks, Month }

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateTime focusDay = DateTime.now();
  DisplayOption displayOption = DisplayOption.Day;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void changeDisplayOption(DisplayOption dis) {
    setState(() {
      displayOption = dis;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Image(
                          height: 20,
                          image: AssetImage("assets/images/ring.png"))),
                ],
              ),
            ),
            const Expanded(
              child: Text(
                "Calendar",
                textAlign: TextAlign.center,
                style: textCalendar,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Image(
                          height: 20,
                          image: AssetImage("assets/images/setting.png"))),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewEventScreen()));
                    },
                    icon: const Image(
                        height: 17.5,
                        image: AssetImage("assets/images/add.png")),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      body: const Padding(
        padding: paddingBox,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              CalendarTest()
            ],
          ),
        ),
      ),
    );
  }
}
