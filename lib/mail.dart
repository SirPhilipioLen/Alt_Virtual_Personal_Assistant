import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MailPage extends StatefulWidget {
  @override
  _MailPageState createState() => _MailPageState();
}

class _MailPageState extends State<MailPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mail'),
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
            flex: 1,
            child: ListView(
              children: [
                ListTile(
                  title: Text('Inbox'),
                  onTap: () {
                    setState(() {
                      _tabController.index = 0;
                    });
                  },
                  tileColor: _tabController.index == 0 ? Colors.indigoAccent : null,
                ),
                ListTile(
                  title: Text('Drafts'),
                  onTap: () {
                    setState(() {
                      _tabController.index = 1;
                    });
                  },
                  tileColor: _tabController.index == 1 ? Colors.indigoAccent : null,
                ),
                ListTile(
                  title: Text('Sent Mail'),
                  onTap: () {
                    setState(() {
                      _tabController.index = 2;
                    });
                  },
                  tileColor: _tabController.index == 2 ? Colors.indigoAccent : null,
                ),
              ],
            ),
          ),
          VerticalDivider(),
          Expanded(
            flex: 3,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildEmailList(receivedEmails),
                _buildEmailList(draftEmails),
                _buildEmailList(sentEmails),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNewMailPopup(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmailList(List<Email> emails) {
    return ListView.builder(
      itemCount: emails.length,
      itemBuilder: (context, index) {
        final email = emails[index];
        return ListTile(
          title: Text(email.subject),
          subtitle: Text(email.sender),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EmailDetailsPage(email: email),
              ),
            );
          },
        );
      },
    );
  }

  void _showNewMailPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('New Mail', style: TextStyle(fontSize: 18)),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'From:',
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'To:',
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Subject:',
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Message:',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                    ),
                    maxLines: null,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.indigoAccent),
                      child: Text('Discard'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Send email logic
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.indigoAccent),
                      child: Text('Send'), 
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Email {
  final String sender;
  final String subject;
  final String message;

  Email({
    required this.sender,
    required this.subject,
    required this.message,
  });
}

final List<Email> receivedEmails = [
  Email(
    sender: 'John Doe',
    subject: 'Hello',
    message: 'This is a text example.',
  ),
  Email(
    sender: 'Jane Smith',
    subject: 'Meeting',
    message: 'This is a text example.',
  ),
  Email(
    sender: 'Bob Johnson',
    subject: 'Updates',
    message: 'This is a text example.',
  ),
];

final List<Email> draftEmails = [
  Email(
    sender: 'John Doe',
    subject: 'Draft Email',
    message: 'This is a text example.',
  ),
];

final List<Email> sentEmails = [
  Email(
    sender: 'Jane Smith',
    subject: 'Sent Email',
    message: 'This is a text example.',
  ),
];

class EmailDetailsPage extends StatelessWidget {
  final Email email;

  const EmailDetailsPage({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(email.subject),
      ),
      body: FocusScope(
        node: FocusScopeNode(),
        child: RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: (RawKeyEvent event) {
            if (event.logicalKey == LogicalKeyboardKey.escape) {
              Navigator.pop(context);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'From: ${email.sender}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'To: You',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Subject: ${email.subject}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Text(
                      email.message,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
                  'Welcome to the Mail Page!',
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