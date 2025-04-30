import 'package:flutter/material.dart';

class WebPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      child: Scaffold(
        appBar: null, // Remove the app bar
        body: Column(
          children: [
            AppBar(
              title: Text('Web'),
              actions: [
              IconButton(
                icon: Icon(Icons.help_outline),
                onPressed: () {
                  _showInformationDialog(context);
                },
            padding: EdgeInsets.only(right: 16.0),
          ),
        ],
              elevation: 0, // Remove the app bar shadow
            ),
            Expanded(
              child: Container(
                color: Color.fromARGB(255, 41, 41, 41), // Placeholder color
                child: Center(
                  child: Text(
                    'Web Content',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            Container(
              color: Color.fromARGB(255, 70, 70, 70), // Placeholder color
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        filled: true,
                        fillColor: Color.fromARGB(255, 20, 20, 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Handle search button click
                    },
                    child: Text('Search'),
                  ),
                ],
              ),
            ),
          ],
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
                  'Welcome to the Web Search Page!',
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