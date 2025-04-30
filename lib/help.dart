import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Help'),
          actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showInformationDialog(context);
            },
            padding: EdgeInsets.only(right: 16.0),
          ),
        ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'Instructions'),
              Tab(text: 'Troubleshooting'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildInstructionsTab(),
            _buildTroubleshootingTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showContactSupportDialog(context);
          },
          child: Icon(Icons.mail),
        ),
      ),
    );
  }

  Widget _buildInstructionsTab() {
    return ListView(
      children: [
        _buildInstructionItem(
          question: 'How to open a page through the home chat?',
          answer: ('To open a page through the home chat you type in a key-word related to the page you wish to open.\n'
          'Here\'s a list of key-words you can use and which page they open:\n'          
          '\n\tPhone Page:\n\tcalendar\n\tmeeting\n\trendezvous\n\tevent'
          '\n\nContacts Page:\n\tcontact\n\tpeople\n\tperson'
          '\n\nMessaging Page:\n\tmessage\n\tmessaging\n\tchat'
          '\n\nMail Page:\n\tmail'
          '\n\nCalendar Page:\n\tcalendar\n\tmeeting\n\trendezvous\n\tevent'
          '\n\nTasks Page:\n\ttask'
          '\n\nClock Page:\n\tclock\n\talarm\n\tremind\n\ttime'
          '\n\nCalendar Page:\n\tcalendar\n\tmeeting\n\trendezvous\n\tevent'
          '\n\nWeb Search Page:\n\tsearch\n\tweb\n\tnet\n\tgoogle'
          '\n\News Page:\n\tnews\n\tsport'
          '\n\nWeather Page:\n\tweather\n\tsun\n\train\n\tthunder\n\tcloud\n\tovercast\n\ttraffic'
          '\n\nCalendar Page:\n\tcalendar\n\tmeeting\n\trendezvous\n\tevent'
          '\n\nMusic Page:\n\tmusic\n\tsong\n\talbumb\n\tartist\n\tplay\n\tlisten'
          '\n\nE-shop Page:\n\tshop\n\tbuy\n\tcart\n\tpurchase'
          '\n\nSmart Home Page:\n\thome\n\tsmart\n\tlight\n\tair\n\tac\n\tcoffee\n\ttv\n\tradio\n\tfridge\n\trefrigerator'
          '\n\nSettings Page:\n\tsetting\n\ttheme\n\tlanguage\n\tchange\n\tcolor\n\tpersonalization\n\taccessibility\n\tset'
          '\n\nHelp Page:\n\thelp\n\ttrouble\n\tquestion\n\tinstruction\n\tsupport\n'),
        ),
        _buildInstructionItem(
          question: 'What are the system requirements?',
          answer: 'System requirements:\n\nOperating System: Windows\nStorage: At least 200MB available space\n',
        ),
        // Add more instruction items
      ],
    );
  }

  Widget _buildInstructionItem({required String question, required String answer}) {
  return ExpansionTile(
    title: Text(question),
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            answer,
            textAlign: TextAlign.left,
          ),
        ),
      ),
    ],
  );
}

  Widget _buildTroubleshootingTab() {
    return ListView(
      children: [
        _buildTroubleshootingItem(
          problem: 'App crashes on startup',
          solution: '\nTry reinstalling the app or restart your device.\n',
        ),
        _buildTroubleshootingItem(
          problem: 'The Calendar doesn\'t go to a previous month',
          solution: '\nTry going to a different page and then back to the Calendar page.\n',
        ),
        _buildTroubleshootingItem(
          problem: 'When I drag the calendar, the indicator stays on the current month.',
          solution: '\nThe dragging feature on the Calendar page is buggy. Try using the arrows instead.\n',
        ),
        // Add more troubleshooting items
      ],
    );
  }

  Widget _buildTroubleshootingItem({required String problem, required String solution}) {
  return ExpansionTile(
    title: Text(problem),
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            solution,
            textAlign: TextAlign.left,
          ),
        ),
      ),
    ],
  );
}

  void _showContactSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Contact Support'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "User's Email"),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(labelText: 'Message'),
                maxLines: null,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Send email functionality
                _emailController.clear();
                _messageController.clear();
                Navigator.of(context).pop();
              },
              child: Text('Send'),
            ),
            TextButton(
              onPressed: () {
                _emailController.clear();
                _messageController.clear();
                Navigator.of(context).pop();
              },
              child: Text('Discard'),
            ),
          ],
        );
      },
    );
  }
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
                  'Welcome to the Help Page!',
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