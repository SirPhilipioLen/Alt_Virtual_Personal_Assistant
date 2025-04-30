import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhonePage extends StatefulWidget {
  @override
  _PhonePageState createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  String _phoneNumber = '';
  List<String> callHistory = [
    'John Doe - (123) 456-7890',
    'Jane Smith - (987) 654-3210',
    'Michael Johnson - (555) 123-4567',
    'Sarah Williams - (111) 222-3333',
  ];

  FocusNode _focusNode = FocusNode();

  void _addNumber(String digit) {
    setState(() {
      _phoneNumber += digit;
    });
  }

  void _clearNumber() {
    setState(() {
      if (_phoneNumber.isNotEmpty) {
        _phoneNumber = _phoneNumber.substring(0, _phoneNumber.length - 1);
      }
    });
  }

  void _makeCall() {
    // Implement your call functionality here
    // You can use the _phoneNumber variable to make the call
    // For simplicity, we'll just print the phone number to the console
    print('Making call to $_phoneNumber');

    // Add the current call to the call history
    final callInfo = 'Unknown - $_phoneNumber';
    setState(() {
      callHistory.insert(0, callInfo);
    });
  }

  void _handleKeyEvent(RawKeyEvent event) {
  if (event.runtimeType == RawKeyDownEvent) {
    final RawKeyEventDataWindows data = event.data as RawKeyEventDataWindows;
    final isNumpadDigit = data.keyCode >= 96 && data.keyCode <= 105;
    final isTopRowDigit = data.keyCode >= 48 && data.keyCode <= 57;
    final isBackspace = data.logicalKey.keyId == 8;

    if (isNumpadDigit || isTopRowDigit) {
      final digit = String.fromCharCode(data.keyCode);
      _addNumber(digit);
    } else if (isBackspace) {
      _clearNumber();
    }
  }
}

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone'),
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
            child: _buildDialer(),
          ),
          VerticalDivider(),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    'Recent Calls',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(child: _buildCallHistory()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialer() {
  return Container(
    padding: EdgeInsets.fromLTRB(16, 32, 16, 32), // Adjust the bottom padding here
    child: RawKeyboardListener(
      focusNode: _focusNode,
      onKey: _handleKeyEvent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Set the spacing between the elements
        children: [
          Text(
            _phoneNumber,
            style: TextStyle(fontSize: 24),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDialButton('1'),
                  _buildDialButton('2'),
                  _buildDialButton('3'),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDialButton('4'),
                  _buildDialButton('5'),
                  _buildDialButton('6'),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDialButton('7'),
                  _buildDialButton('8'),
                  _buildDialButton('9'),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDialButton('*'),
                  _buildDialButton('0'),
                  _buildDialButton('#'),
                ],
              ),
            ],
          ),
          SizedBox(height: 100), // Add spacing here
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _clearNumber,
                child: Icon(Icons.backspace),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  minimumSize: Size(48, 48),
                  shape: CircleBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: _makeCall,
                child: Icon(Icons.call),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  minimumSize: Size(48, 48),
                  shape: CircleBorder(),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}


  Widget _buildDialButton(String digit) {
  return SizedBox(
    width: 48,
    height: 48,
    child: ElevatedButton(
      onPressed: () => _addNumber(digit),
      child: Text(digit, style: TextStyle(fontSize: 20)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: CircleBorder(),
      ),
    ),
  );
}


  Widget _buildCallHistory() {
    return ListView.builder(
      itemCount: callHistory.length,
      itemBuilder: (context, index) {
        final call = callHistory[index];
        return ListTile(
          title: Text(call),
          subtitle: Text('Today, 10:30 AM'),
          leading: GestureDetector(
            onTap: () {
              // Handle call history item tap
              print('Call history item tapped: $call');
            },
            child: Icon(Icons.call),
          ),
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
                  'Welcome to the Phone Page!',
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