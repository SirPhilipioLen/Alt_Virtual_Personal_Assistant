import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alt/mail.dart';
import 'package:alt/news.dart';
import 'calendar.dart';
import 'clock.dart';
import 'contacts.dart';
import 'eshop.dart';
import 'help.dart';
import 'mail.dart';
import 'msg.dart';
import 'music.dart';
import 'news.dart';
import 'phone.dart';
import 'settings.dart';
import 'smart_home.dart';
import 'tasks.dart';
import 'weather.dart';
import 'web.dart';

  class HomePage extends StatefulWidget {
    @override
    _HomePageState createState() => _HomePageState();
  }

  class _HomePageState extends State<HomePage> {
    final TextEditingController _chatController = TextEditingController();
    final FocusNode _chatFocusNode = FocusNode();
    final List<ChatMessage> _assistantMessages = [];
    final ScrollController _scrollController = ScrollController();

    void _handleSendMessage(String message) {
  // Process user message and generate assistant response
  String assistantResponse;
  if (message.toLowerCase().contains('calendar') ||
      message.toLowerCase().contains('meeting') ||
      message.toLowerCase().contains('rendezvous')||
      message.toLowerCase().contains('event')) {
    assistantResponse = 'Opening Calendar Page...';
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CalendarPage()),
    );
  } else if (message.toLowerCase().contains('news') ||
            message.toLowerCase().contains('sport')) {
    assistantResponse = 'Opening News Page...';
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewsPage()),
    );
  } else if (message.toLowerCase().contains('mail')) {
    assistantResponse = 'Opening Mail Page...';
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MailPage()),
    );
  } else if (message.toLowerCase().contains('phone') ||
            message.toLowerCase().contains('call')) {
    assistantResponse = 'Opening Phone Page...';
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PhonePage()),
    );
  } else if (message.toLowerCase().contains('contact')||
            message.toLowerCase().contains('people')||
            message.toLowerCase().contains('person')) {
    assistantResponse = 'Opening Contacts Page...';
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContactsPage()),
    );
  } else if (message.toLowerCase().contains('message') ||
            message.toLowerCase().contains('messaging')||
            message.toLowerCase().contains('chat')) {
    assistantResponse = 'Opening Messaging Page...';
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MessagingPage()),
    );
  } else if (message.toLowerCase().contains('task')) {
    assistantResponse = 'Opening Tasks Page...';
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TasksPage()),
    );
  } else if (message.toLowerCase().contains('clock') ||
            message.toLowerCase().contains('alarm')||
            message.toLowerCase().contains('remind')||
            message.toLowerCase().contains('time')) {
    assistantResponse = 'Opening Clock Page...';
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClockPage()),
    );
  } else if (message.toLowerCase().contains('search')||
            message.toLowerCase().contains('web')||
            message.toLowerCase().contains('net')||
            message.toLowerCase().contains('google')) {
    assistantResponse = 'Opening Web Search Page...';
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WebPage()),
    );
  } else if (message.toLowerCase().contains('weather')||
            message.toLowerCase().contains('sun')||
            message.toLowerCase().contains('rain')||
            message.toLowerCase().contains('thunder')||
            message.toLowerCase().contains('cloud')||
            message.toLowerCase().contains('overcast')||
            message.toLowerCase().contains('traffic')) {
    assistantResponse = 'Opening Weather Page...';
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WeatherPage()),
    );
  } else if (message.toLowerCase().contains('music')||
            message.toLowerCase().contains('song')||
            message.toLowerCase().contains('album')||
            message.toLowerCase().contains('artist')||
            message.toLowerCase().contains('play')||
            message.toLowerCase().contains('listen')) {
    assistantResponse = 'Opening Music Page...';
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MusicPage()),
    );
  } else if (message.toLowerCase().contains('shop')||
            message.toLowerCase().contains('buy')||
            message.toLowerCase().contains('cart')||
            message.toLowerCase().contains('purchase')) {
    assistantResponse = 'Opening E-shop Page...';
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EshopPage()),
    );
  } else if (message.toLowerCase().contains('home')||
            message.toLowerCase().contains('smart')||
            message.toLowerCase().contains('light')||
            message.toLowerCase().contains('air')||
            message.toLowerCase().contains('ac')||
            message.toLowerCase().contains('coffee')||
            message.toLowerCase().contains('tv')||
            message.toLowerCase().contains('radio')||
            message.toLowerCase().contains('fridge')||
            message.toLowerCase().contains('refrigerator')) {
    assistantResponse = 'Opening Smart Home Page...';
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SmartHomePage()),
    );
  } else if (message.toLowerCase().contains('setting')||
            message.toLowerCase().contains('theme')||
            message.toLowerCase().contains('language')||
            message.toLowerCase().contains('change')||
            message.toLowerCase().contains('color')||
            message.toLowerCase().contains('set')||
            message.toLowerCase().contains('personalization')||
            message.toLowerCase().contains('accessibility')) {
    assistantResponse = 'Opening Settings Page...';
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage()),
    );
  } else if (message.toLowerCase().contains('help')||
            message.toLowerCase().contains('trouble')||
            message.toLowerCase().contains('question')||
            message.toLowerCase().contains('instruction')||
            message.toLowerCase().contains('support')) {
    assistantResponse = 'Opening Help Page...';
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HelpPage()),
    );
  } else {
    assistantResponse = "Type in a key-word related to the page you want to open.\nClick on the ? icon on the top right for more info.";
  }

  // Clear the chat text field
  _chatController.clear();

  // Store the user message and assistant response
  setState(() {
    _assistantMessages.insert(
      0,
      ChatMessage(
        text: 'Alt: $assistantResponse',
        isUser: false,
      ),
    );
    _assistantMessages.insert(
      1,
      ChatMessage(
        text: 'User: $message',
        isUser: true,
      ),
    );
  });

  // Scroll to the bottom of the chat
  _scrollToBottom();

  // Request focus back to the chat text field
  _chatFocusNode.requestFocus();
}


    void _scrollToBottom() {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    @override
    void dispose() {
      _scrollController.dispose();
      super.dispose();
    }

    void _handleBackButtonPress(RawKeyEvent event) {
      // Check if the Escape key is pressed
      if (event.isKeyPressed(LogicalKeyboardKey.escape)) {
        // Go back to the homepage
        Navigator.pop(context);
      }
    }

    @override
    void initState() {
      super.initState();
      // Register a listener for the back button press event
      RawKeyboard.instance.addListener(_handleBackButtonPress);
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
        title: Text('Home'),
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
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.indigoAccent, width: 2.0),
                    ),
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('assets/blackwalltest.gif'),
                    ),
                  ),
                  SizedBox(width: 25),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\n\Hi, I'm Alt. How can I help?",
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                reverse: true,
                itemCount: _assistantMessages.length,
                itemBuilder: (context, index) {
                  final message = _assistantMessages[index];
                  return Align(
                    alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: message.isUser ? Colors.indigoAccent : Colors.grey,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        message.text,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _chatController,
                      focusNode: _chatFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Type your destination...',
                      ),
                      onSubmitted: (value) {
                        _handleSendMessage(_chatController.text);
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      _handleSendMessage(_chatController.text);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

void _showInformationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Home Page Information'),
        content: SingleChildScrollView(
          child: Container(
            width: 400.0, // Adjust the width as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to the Home Page!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'This page serves as the main screen of the application.\n',
                ),
                Text(
                  'Here, you can interact with Alt, your personal assistant, \nby entering key-words in the text field at the bottom\nand receiving responses from Alt in the chat area above.',
                ),
                Text(
                  '\nAlt is designed to open whichever page you require!\nAll you need to do is type in a key-word that is related to the page you want to view.\n\nFor example, try entering the word "meetings", which opens the Calendar page.',
                ),
                Text(
                  '\nWhen you want to return to the home page, press the left arrow button on the top left corner, or press ESC.',
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


class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}


