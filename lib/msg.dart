import 'package:flutter/material.dart';

class Contact {
  final String name;
  final String profilePicture;
  final String status;

  Contact({required this.name, required this.profilePicture, required this.status});
}

class Message {
  final String sender;
  final String message;
  final String time;

  Message({required this.sender, required this.message, required this.time});
}

class MessagingPage extends StatefulWidget {
  @override
  _MessagingPageState createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  List<Contact> contacts = [
    Contact(
      name: 'Johnny Doe',
      profilePicture: 'assets/johnny2.png',
      status: 'Online'
    ),
    Contact(
      name: 'Judy Smith',
      profilePicture: 'assets/judy.png',
      status: 'Away'
    ),
    Contact(
      name: 'Kerry Johnson',
      profilePicture: 'assets/kerry.png',
      status: 'Offline'
    ),
  ];

  List<Message> messages = [
    Message(
      sender: 'Johnny Doe',
      message: 'By the way, did you watch the game last night?',
      time: '9:50 AM',
    ),
    Message(
      sender: 'You',
      message: 'That sounds great!',
      time: '9:45 AM',
    ),
    Message(
      sender: 'Johnny Doe',
      message: "I'm good, thanks!",
      time: '9:40 AM',
    ),
    Message(
      sender: 'You',
      message: 'Hi, how are you?',
      time: '9:35 AM',
    ),
    Message(
      sender: 'Johnny Doe',
      message: 'Hello',
      time: '9:30 AM',
    ),   
  ];

  int selectedContactIndex = 0;
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messaging'),
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
          Container(
            width: 200,
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                Contact contact = contacts[index];
                bool isSelected = index == selectedContactIndex;
                return ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(contact.profilePicture),
                  ),
                  title: Text(
                    contact.name,
                    style: TextStyle(
                      color: isSelected ? null : null,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  tileColor: isSelected ? Colors.indigo : null,
                  subtitle: Text(contact.status),
                  onTap: () {
                    setState(() {
                      selectedContactIndex = index;
                    });
                  },
                );
              },
            ),
          ),
          VerticalDivider(),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      Message message = messages[index];
                      bool isUserMessage = message.sender == 'You';
                      return Align(
                        alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
                          decoration: BoxDecoration(
                            color: isUserMessage ? Colors.indigo : Color.fromARGB(255, 90, 90, 90),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 4.0),
                              Text(
                                message.message,
                                style: TextStyle(
                                  color: isUserMessage ? Colors.white : Colors.white,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                _formatMessageTime(message.time),
                                style: TextStyle(
                                  color: isUserMessage ? Colors.white70 : Color.fromARGB(129, 255, 255, 255),
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            border: OutlineInputBorder(),
                          ),
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: _sendMessage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatMessageTime(String time) {
    List<String> timeComponents = time.split(':');
    int hour = int.tryParse(timeComponents[0]) ?? 0;
    int minute = int.tryParse(timeComponents[1]) ?? 0;
    String formattedTime = '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    return formattedTime;
  }

  void _sendMessage() {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      setState(() {
        messages.insert(
          0,
          Message(
            sender: 'You',
            message: messageText,
            time: _getCurrentTime(),
          ),
        );
        _messageController.clear();
      });
    }
  }

  String _getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    return formattedTime;
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
                  'Welcome to the Messaging Page!',
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