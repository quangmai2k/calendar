import 'package:calendar/common/style.dart';
import 'package:flutter/material.dart';

import '../utils.dart';
import 'calendar.dart';

enum DisplayOption { Day, Weeks, Month }

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateTime focusDay = DateTime.now();
  DateTime _selectedDay = DateTime(2024, 03, 11);
  DisplayOption displayOption = DisplayOption.Day;
  Map<DateTime, List<dynamic>> _events = {
    DateTime(2024, 3, 1): ['Event 1', 'Event 2'],
    DateTime(2024, 3, 10): ['Event 3'],
    DateTime(2024, 3, 15): ['Event 4'],
  };

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

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
      ),
      body: Padding(
        padding: paddingBox,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              // Stack(
              //   children: [
              //     TableCalendar(
              //       rowHeight: 90,
              //       calendarFormat: CalendarFormat.month,
              //       firstDay: DateTime(2022),
              //       focusedDay: focusDay,
              //       lastDay: DateTime(2026),
              //       currentDay: DateTime.now(),
              //       onPageChanged: (focusedDay) {
              //         focusDay = focusedDay;
              //       },

              //       eventLoader: _getEventsForDay,
              //       // headerVisible: false,
              //       calendarStyle: const CalendarStyle(
              //           defaultDecoration: BoxDecoration(border: Border.symmetric(vertical: BorderSide(width: 1))),
              //           markersAlignment: Alignment.bottomCenter,
              //           outsideDaysVisible: true,),
              //       calendarBuilders: CalendarBuilders(
              //         markerBuilder: (context, day, events) => events.isNotEmpty
              //             ? Positioned(
              //                 bottom: 1,
              //                 child: Container(
              //                   decoration: BoxDecoration(
              //                     shape: BoxShape.circle,
              //                     color: Colors.red, // Màu sắc của chấm chấm
              //                   ),
              //                   width: 5, // Độ rộng của chấm chấm
              //                   height: 5, // Chiều cao của chấm chấm
              //                 ),
              //               )
              //             : null,
              //       ),
              //       headerStyle: const HeaderStyle(
              //           titleCentered: true,
              //           headerMargin: EdgeInsets.only(left: 180, bottom: 15),
              //           formatButtonVisible: false,
              //           leftChevronIcon:
              //               Icon(Icons.chevron_left_outlined, size: 12),
              //           rightChevronIcon:
              //               Icon(Icons.chevron_right_outlined, size: 12),
              //           titleTextStyle:
              //               TextStyle(fontFamily: sfProFont, fontSize: 12)),
              //       selectedDayPredicate: (day) {
              //         // Example of how to mark only one day as selected
              //         return isSameDay(_selectedDay, day);
              //       },
              //       onDaySelected: (selectedDay, focusedDay) {
              //         setState(() {
              //           _selectedDay = selectedDay;
              //           focusDay = focusedDay; // Update _focusedDay as well
              //         });
              //       },
              //     ),
              //     Positioned(
              //       top: 20,
              //       left: 0,
              //       child: Row(
              //         children: [
              //           Container(
              //             child: TextButton(
              //               onPressed: () {
              //                 changeDisplayOption(DisplayOption.Day);
              //               },
              //               style: displayOption == DisplayOption.Day
              //                   ? bgBtnActive
              //                   : bgBtnNoActive,
              //               child: Text(
              //                 "Day",
              //                 style: displayOption == DisplayOption.Day
              //                     ? textBtnActive
              //                     : textBtnNoActive,
              //               ),
              //             ),
              //           ),
              //           Container(
              //             padding: const EdgeInsets.symmetric(horizontal: 3),
              //             margin: const EdgeInsets.symmetric(horizontal: 3),
              //             decoration: const BoxDecoration(
              //                 border: Border.symmetric(
              //                     vertical: BorderSide(
              //                         width: 1, color: Colors.black26))),
              //             child: TextButton(
              //                 onPressed: () {
              //                   changeDisplayOption(DisplayOption.Weeks);
              //                 },
              //                 style: displayOption == DisplayOption.Weeks
              //                     ? bgBtnActive
              //                     : bgBtnNoActive,
              //                 child: Text(
              //                   "Weeks",
              //                   style: displayOption == DisplayOption.Weeks
              //                       ? textBtnActive
              //                       : textBtnNoActive,
              //                 )),
              //           ),
              //           TextButton(
              //               onPressed: () {
              //                 changeDisplayOption(DisplayOption.Month);
              //               },
              //               style: displayOption == DisplayOption.Month
              //                   ? bgBtnActive
              //                   : bgBtnNoActive,
              //               child: Text(
              //                 "Month",
              //                 style: displayOption == DisplayOption.Month
              //                     ? textBtnActive
              //                     : textBtnNoActive,
              //               )),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              CalendarTest()
              // TableEventsExample()
            ],
          ),
        ),
      ),
    );
  }
}
