import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _selectedDate;
  late CalendarController _calendarController;
  late ValueNotifier<DateTime> _headerNotifier;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _calendarController = CalendarController();
    _calendarController.displayDate = _selectedDate;
    _headerNotifier = ValueNotifier<DateTime>(_selectedDate);
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showInformationDialog(context);
            },
            padding: EdgeInsets.only(right: 16.0),
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: _scrollToPreviousMonth,
                      ),
                      Card(
                        child: InkWell(
                          onTap: _showMonthYearPicker,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: ValueListenableBuilder<DateTime>(
                              valueListenable: _headerNotifier,
                              builder: (context, value, child) {
                                return Text(
                                  _getFormattedMonthYear(value),
                                  style: TextStyle(fontSize: 18.0),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: _scrollToNextMonth,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SfCalendar(
                    view: CalendarView.month,
                    headerHeight: 0,
                    dataSource: MeetingDataSource(_getAppointments()),
                    controller: _calendarController,
                    onTap: (CalendarTapDetails details) {
                      if (details.targetElement == CalendarElement.calendarCell) {
                        _showAddMeetingDialog(context, details.date!);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.2, // Adjust the width as needed
            color: Color.fromARGB(255, 20, 20, 20), // Customize the color as desired
            child: ListView.builder(
              itemCount: _getAppointments().length,
              itemBuilder: (context, index) {
                final meeting = _getAppointments()[index];
                return ListTile(
                  title: Text(meeting.subject),
                  subtitle: Text('${meeting.startTime} - ${meeting.endTime}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Meeting> _getAppointments() {
    return <Meeting>[
      Meeting(
        subject: 'Meeting 1',
        startTime: DateTime.now(),
        endTime: DateTime.now().add(Duration(hours: 1)),
        color: Colors.blue,
      ),
      Meeting(
        subject: 'Meeting 2',
        startTime: DateTime.now().add(Duration(days: 1)),
        endTime: DateTime.now().add(Duration(days: 1, hours: 2)),
        color: Colors.green,
      ),
    ];
  }

  void _showAddMeetingDialog(BuildContext context, DateTime selectedDate) async {
    TimeOfDay? startTime = await showTimePicker(
      context: context,
     initialTime: TimeOfDay.now(),
    );
    if (startTime == null) return;

    // ignore: use_build_context_synchronously
    TimeOfDay? endTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (endTime == null) return;

    DateTime startDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      startTime.hour,
      startTime.minute,
    );

    DateTime endDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      endTime.hour,
      endTime.minute,
    );

    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Meeting'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text('Date: ${selectedDate.toString()}'),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Subject',
                  ),
                ),
                SizedBox(height: 16),
                ListTile(
                  title: Text('Start Time'),
                  subtitle: Text(startDateTime.toString()),
                  onTap: () async {
                    TimeOfDay? newStartTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(startDateTime),
                    );
                    if (newStartTime != null) {
                      startDateTime = DateTime(
                        startDateTime.year,
                        startDateTime.month,
                        startDateTime.day,
                        newStartTime.hour,
                        newStartTime.minute,
                      );
                    }
                  },
                ),
                SizedBox(height: 16),
                ListTile(
                  title: Text('End Time'),
                  subtitle: Text(endDateTime.toString()),
                  onTap: () async {
                    TimeOfDay? newEndTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(endDateTime),
                    );
                    if (newEndTime != null) {
                      endDateTime = DateTime(
                        endDateTime.year,
                        endDateTime.month,
                        endDateTime.day,
                        newEndTime.hour,
                        newEndTime.minute,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Save meeting details
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showMonthYearPicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _calendarController.displayDate = pickedDate;
        _headerNotifier.value = pickedDate;
        _scrollToSelectedMonth();
      });
    }
  }

  void _scrollToSelectedMonth() {
    final selectedMonthIndex = _selectedDate.month - DateTime.now().month;
    final scrollOffset = selectedMonthIndex * MediaQuery.of(context).size.width;
  }

  void _scrollToPreviousMonth() {
    final previousMonth = DateTime(_selectedDate.year, _selectedDate.month - 1);
    if (previousMonth.isBefore(DateTime.now())) {
      setState(() {
        _selectedDate = previousMonth;
        _calendarController.displayDate = _selectedDate;
        _headerNotifier.value = _selectedDate;
      });
    }
  }

  void _scrollToNextMonth() {
    final nextIndex = _selectedDate.month - DateTime.now().month + 1;
    if (nextIndex < 12) {
      setState(() {
        _selectedDate = DateTime(_selectedDate.year, DateTime.now().month + nextIndex);
        _calendarController.displayDate = _selectedDate;
        _headerNotifier.value = _selectedDate;
      });
    }
  }
}

  String _getFormattedMonthYear(DateTime date) {
    return '${_getMonthName(date.month)} ${date.year}';
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }


class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }
}

class Meeting extends Appointment {
  Meeting({
    required String subject,
    required DateTime startTime,
    required DateTime endTime,
    required Color color,
  }) : super(
          startTime: startTime,
          endTime: endTime,
          subject: subject,
          color: color,
        );
}

void _showInformationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Page Information'),
        content: SingleChildScrollView(
          child: Container(
            width: 400.0, // Adjust the width as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to the Calendar Page!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}