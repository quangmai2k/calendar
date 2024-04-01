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
    if (_controller.view == CalendarView.day) {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      dataSource: MeetingDataSource(_getDataSource()),
      cellBorderColor: Colors.transparent,
      initialSelectedDate: DateTime.now(),
      monthCellBuilder: (context, details) {
        return Padding(
          padding: const EdgeInsets.all(4.0), // Padding between cells
          child: Container(
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(8), // Optional: Border radius for cells
              // border: Border.all(color: Colors.grey), // Border around cells
            ),
            child: Center(
              child: Text(
                details.date.day.toString(),
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        );
      },
      onViewChanged: viewChanged,
      allowedViews: const [
        CalendarView.day,
        CalendarView.week,
        CalendarView.workWeek,
        CalendarView.month
      ],
      timeSlotViewSettings:
          TimeSlotViewSettings(dateFormat: _dateFormat, dayFormat: _dayFormat),
      monthViewSettings: const MonthViewSettings(
          monthCellStyle: MonthCellStyle(),
          appointmentDisplayMode: MonthAppointmentDisplayMode.indicator),
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
