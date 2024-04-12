import 'package:calendar/common/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:path/path.dart';
import 'package:collection/collection.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class CalendarTest extends StatefulWidget {
  const CalendarTest({super.key});

  @override
  State<CalendarTest> createState() => _CalendarTestState();
}

class _CalendarTestState extends State<CalendarTest> {
  static const String dbName = 'calendar';
  static const String tableName = 'events';
  static const String columnId = 'id';
  static const String columnEventNote = 'event';
  static const String columnStart = 'startTime';
  static const String columnEnd = 'endTime';
  static const String columnColor = 'color';
  static const String columnIsAllDay = 'isAllDay';
  late CalendarController controller;
  Future<void> addEvent() async {
    // Khởi tạo `databaseFactoryFfi`
    sqfliteFfiInit();

    // Gán `databaseFactoryFfi` cho `databaseFactory`
    databaseFactory = databaseFactory;
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

// Delete the database
    // await deleteDatabase(path);

// open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('''
        CREATE TABLE $tableName(
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnEventNote TEXT,
          $columnStart INTERGER,
          $columnEnd INTERGER,
          $columnColor TEXT,
          $columnIsAllDay INTERGER
        )
      ''');
    });
    int start = DateTime.now().add(Duration(hours: 1)).millisecondsSinceEpoch;
    int end = DateTime.now().add(Duration(hours: 3)).millisecondsSinceEpoch;
// Insert some records in a transaction
    await database.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO $tableName($columnEventNote, $columnStart, $columnEnd,$columnColor) VALUES("Đi ăn tối", $start, $end,"ED9389")');
      print('inserted1: $id1');
    });

    List<Map> list = await database.rawQuery('SELECT * FROM Test');
    List<Map> expectedList = [
      {'name': 'updated name', 'id': 1, 'value': 9876, 'num': 456.789},
      {'name': 'another name', 'id': 2, 'value': 12345678, 'num': 3.1416}
    ];
    print(list);
    print(expectedList);
    assert(const DeepCollectionEquality().equals(list, expectedList));
    await database.close();
  }

  final CalendarController _controller = CalendarController();
  String _dayFormat = 'EEE', _dateFormat = 'dd';
  void viewChanged(ViewChangedDetails viewChangedDetails) {
    if (_controller.view == CalendarView.month) {
      SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
        if (_dayFormat != 'EEEEE' || _dateFormat != 'dd') {
          setState(() {
            _dayFormat = 'EEEEE';
            _dateFormat = 'dd';
          });
        } else {
          return;
        }
      });
    } else {
      SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
        if (_dayFormat != 'EEE' || _dateFormat != 'dd') {
          setState(() {
            _dayFormat = 'EEE';
            _dateFormat = 'dd';
          });
        } else {
          return;
        }
      });
    }
  }

  @override
  initState() {
    controller = CalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: SfCalendar(
        firstDayOfWeek: 1,
        todayHighlightColor: Color(0xFFECBA99),
        headerHeight: 0,
        selectionDecoration: BoxDecoration(
          color: Colors.transparent, // Đặt màu trong suốt cho ô được chọn
          border: null, // Đường viền cho ô được chọn
        ),
        controller: controller,
        view: CalendarView.month,
        dataSource: MeetingDataSource(_getDataSource()),
        cellBorderColor: Colors.transparent,
        initialSelectedDate: DateTime.now(),
        monthCellBuilder: (BuildContext context, MonthCellDetails details) {
          if (details.date.day == controller.selectedDate!.day &&
              details.date.month == controller.selectedDate!.month &&
              details.date.year == controller.selectedDate!.year) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFECBA99), shape: BoxShape.circle),
                  ),
                ),
                Center(
                  child: Text(
                    details.date.day.toString(),
                    style: textCalendarInMonth,
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text(
                details.date.day.toString(),
                style: textCalendarInMonth,
              ),
            );
          }
        },
        onViewChanged: viewChanged,
        timeSlotViewSettings: TimeSlotViewSettings(
            dateFormat: _dateFormat, dayFormat: _dayFormat),
        monthViewSettings: const MonthViewSettings(
            monthCellStyle: MonthCellStyle(),
            appointmentDisplayMode: MonthAppointmentDisplayMode.indicator),
      ),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));

    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
