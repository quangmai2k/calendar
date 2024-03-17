import 'package:calendar/common/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateTime focusDay = DateTime.now();
  DateTime _selectedDay = DateTime(2024, 03, 11);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: paddingBox,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
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
                                image:
                                    AssetImage("assets/images/setting.png"))),
                        IconButton(
                          onPressed: () {},
                          icon: const Image(
                              height: 17.5,
                              image: AssetImage("assets/images/add.png")),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.black12),
                          ),
                          child: const Text(
                            "Day",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Weeks",
                              style: TextStyle(color: Colors.black45),
                            )),
                        TextButton(
                            onPressed: () {},
                            child: const Text("Month",
                                style: TextStyle(color: Colors.black45))),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              TableCalendar(
                firstDay: DateTime(2022),
                focusedDay: focusDay,
                lastDay: DateTime(2026),
                currentDay: DateTime.now(),
                selectedDayPredicate: (day) {
                  // Example of how to mark only one day as selected
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    focusDay = focusedDay; // Update _focusedDay as well
                  });
                },
                headerVisible: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
