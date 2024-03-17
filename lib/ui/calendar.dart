// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarCustom extends StatefulWidget {
  const CalendarCustom({super.key});

  @override
  State<CalendarCustom> createState() => _CalendarCustomState();
}

class _CalendarCustomState extends State<CalendarCustom> {
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar Example'),
      ),
      body: Center(
        child: TableCalendar(
          firstDay: DateTime(2022),
          focusedDay: now,
          lastDay: DateTime(2026),
        ),
      ),
    );
  }
}
