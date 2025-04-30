import 'package:flutter/material.dart';

Widget _buildTrendingCards() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Card(
          child: Container(
            color: Color.fromARGB(255, 20, 20, 20),
            height: 150, // Adjust the height of the trending cards
            child: Center(
              child: Text(
                'Trending News 1', // Replace with your filler title
                style: TextStyle(
                  fontSize: 20, // Adjust the font size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      SizedBox(width: 16), // Adjust the spacing between the cards
      Expanded(
        child: Card(
          child: Container(
            color: Color.fromARGB(255, 20, 20, 20),
            height: 150, // Adjust the height of the trending cards
            child: Center(
              child: Text(
                'Trending News 2', // Replace with your filler title
                style: TextStyle(
                  fontSize: 20, // Adjust the font size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          
          title: Text('News'),
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
              Tab(text: 'World'),
              Tab(text: 'Sports'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Color.fromARGB(255, 30, 30, 50), // Set your desired background color
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SizedBox(height: 32), // Adjust the spacing from the top
                        _buildTrendingCards(),
                        SizedBox(height: 32), // Adjust the spacing between the sections
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Latest News', // Replace with your section title
                            style: TextStyle(
                              fontSize: 24, // Adjust the font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 16), // Adjust the spacing between the title and cards
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 7,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Container(
                                color: Color.fromARGB(255, 20, 20, 20),
                                width: double.infinity, // Adjust the width of the latest news cards
                                height: 80, // Adjust the height of the latest news cards
                                child: ListTile(
                                  leading: Icon(Icons.article), // Replace with your desired icon or image
                                  title: Text(
                                    'Latest News ${index + 1}', // Replace with your filler title
                                    style: TextStyle(
                                      fontSize: 16, // Adjust the font size
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text('Subtitle'), // Replace with your subtitle or additional information
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Color.fromARGB(255, 30, 50, 50), // Set your desired background color
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SizedBox(height: 32), // Adjust the spacing from the top
                        _buildTrendingCards(),
                        SizedBox(height: 32), // Adjust the spacing between the sections
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Latest News', // Replace with your section title
                            style: TextStyle(
                              fontSize: 24, // Adjust the font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 16), // Adjust the spacing between the title and cards
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 7,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Container(
                                color: Color.fromARGB(255, 20, 20, 20),
                                width: double.infinity, // Adjust the width of the latest news cards
                                height: 80, // Adjust the height of the latest news cards
                                child: ListTile(
                                  leading: Icon(Icons.article), // Replace with your desired icon or image
                                  title: Text(
                                    'Latest News ${index + 1}', // Replace with your filler title
                                    style: TextStyle(
                                      fontSize: 16, // Adjust the font size
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text('Subtitle'), // Replace with your subtitle or additional information
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
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
                  'Welcome to the News Page!',
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