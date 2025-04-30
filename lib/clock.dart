import 'package:flutter/material.dart';

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  List<Alarm> alarms = [
    Alarm(
      name: 'Alarm 1',
      time: TimeOfDay(hour: 8, minute: 0),
      isRecurring: true,
      isOn: true,
    ),
    Alarm(
      name: 'Alarm 2',
      time: TimeOfDay(hour: 9, minute: 30),
      isRecurring: false,
      isOn: true,
    ),
    Alarm(
      name: 'Alarm 3',
      time: TimeOfDay(hour: 12, minute: 15),
      isRecurring: true,
      isOn: true,
    ),
  ];
  List<Reminder> reminders = [
    Reminder(
      name: 'Reminder 1',
      time: TimeOfDay(hour: 10, minute: 0),
    ),
    Reminder(
      name: 'Reminder 2',
      time: TimeOfDay(hour: 14, minute: 30),
    ),
  ];
  TimeOfDay? selectedTime;
  TextEditingController alarmNameController = TextEditingController();

  void _addAlarm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Alarm'),
                leading: Icon(Icons.alarm),
                onTap: () {
                  Navigator.of(context).pop();
                  _showAlarmDialog(context);
                },
              ),
              ListTile(
                title: Text('Reminder'),
                leading: Icon(Icons.notifications),
                onTap: () {
                  Navigator.of(context).pop();
                  _showReminderDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAlarmDialog(BuildContext context) {
    TimeOfDay? selectedTime;
    String alarmName = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Alarm'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Time picker
              InkWell(
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      selectedTime = pickedTime;
                    });
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.access_time),
                    SizedBox(width: 8),
                    Text(
                      selectedTime?.format(context) ?? 'Select Time',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              // Alarm name input
              TextField(
                onChanged: (value) {
                  alarmName = value;
                },
                decoration: InputDecoration(labelText: 'Alarm Name'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                // Create a new alarm object
                Alarm newAlarm = Alarm(
                  time: selectedTime!,
                  name: alarmName,
                  isRecurring: false,
                  isOn: true,
                );

                // Add the new alarm to the list
                setState(() {
                  alarms.add(newAlarm);
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showReminderDialog(BuildContext context) {
    TimeOfDay? selectedTime;
    String reminderName = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Reminder'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Time picker
              InkWell(
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      selectedTime = pickedTime;
                    });
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.access_time),
                    SizedBox(width: 8),
                    Text(
                      selectedTime?.format(context) ?? 'Select Time',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              // Reminder name input
              TextField(
                onChanged: (value) {
                  reminderName = value;
                },
                decoration: InputDecoration(labelText: 'Reminder Name'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                // Create a new reminder object
                Reminder newReminder = Reminder(
                  time: selectedTime!,
                  name: reminderName,
                );

                // Add the new reminder to the list
                setState(() {
                  reminders.add(newReminder);
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addReminder(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Alarm'),
                leading: Icon(Icons.alarm),
                onTap: () {
                  Navigator.of(context).pop();
                  _showAlarmDialog(context);
                },
              ),
              ListTile(
                title: Text('Reminder'),
                leading: Icon(Icons.notifications),
                onTap: () {
                  Navigator.of(context).pop();
                  _showReminderDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _editAlarm(BuildContext context, Alarm alarm) {
    selectedTime = alarm.time;
    alarmNameController.text = alarm.name;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Alarm'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: selectedTime!,
                  );
                  if (pickedTime != null) {
                    setState(() {
                      selectedTime = pickedTime;
                    });
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.access_time),
                    SizedBox(width: 8),
                    Text(
                      selectedTime!.format(context),
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              TextField(
                controller: alarmNameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  alarm.time = selectedTime!;
                  alarm.name = alarmNameController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteAlarm(int index) {
    setState(() {
      alarms.removeAt(index);
    });
  }

  void _editReminder(BuildContext context, Reminder reminder) {
    selectedTime = reminder.time;
    alarmNameController.text = reminder.name;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Reminder'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: selectedTime!,
                  );
                  if (pickedTime != null) {
                    setState(() {
                      selectedTime = pickedTime;
                    });
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.access_time),
                    SizedBox(width: 8),
                    Text(
                      selectedTime!.format(context),
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              TextField(
                controller: alarmNameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  reminder.time = selectedTime!;
                  reminder.name = alarmNameController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteReminder(int index) {
    setState(() {
      reminders.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Clock'),
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
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Alarms'),
                Tab(text: 'Reminders'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildAlarmsTab(),
                  _buildRemindersTab(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Builder(
          builder: (context) {
            if (DefaultTabController.of(context).index == 0) {
              return FloatingActionButton(
                onPressed: () => _addAlarm(context),
                child: Icon(Icons.add),
              );
            } else {
              return FloatingActionButton(
                onPressed: () => _addReminder(context),
                child: Icon(Icons.add),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildAlarmsTab() {
    return ListView.builder(
      itemCount: alarms.length,
      itemBuilder: (context, index) {
        Alarm alarm = alarms[index];
        return ListTile(
          leading: Icon(Icons.alarm),
          title: Text(alarm.name),
          subtitle: Text(alarm.time.format(context)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Switch(
                value: alarm.isOn,
                onChanged: (value) {
                  setState(() {
                    alarm.isOn = value;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteAlarm(index),
              ),
            ],
          ),
          onTap: () {
            _editAlarm(context, alarm);
          },
        );
      },
    );
  }

  Widget _buildRemindersTab() {
    return ListView.builder(
      itemCount: reminders.length,
      itemBuilder: (context, index) {
        Reminder reminder = reminders[index];
        return ListTile(
          leading: Icon(Icons.notifications),
          title: Text(reminder.name),
          subtitle: Text(reminder.time.format(context)),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteReminder(index),
          ),
          onTap: () {
            _editReminder(context, reminder);
          },
        );
      },
    );
  }
}

class Alarm {
  TimeOfDay time;
  String name;
  bool isRecurring;
  bool isOn;

  Alarm({
    required this.time,
    required this.name,
    this.isRecurring = false,
    this.isOn = false,
  });
}

class Reminder {
  String name;
  TimeOfDay time;

  Reminder({
    required this.name,
    required this.time,
  });
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
                  'Welcome to the Clock Page!',
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