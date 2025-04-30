import 'package:flutter/material.dart';

enum WeatherCondition {
  sunny,
  thunder,
  overcast,
  rainy,
}

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<WeatherDay> weatherDays = [
    WeatherDay(
      day: 'Monday',
      minTemp: 20,
      maxTemp: 30,
      rainChance: 0.2,
      windSpeed: 10,
      condition: WeatherCondition.sunny,
    ),
    WeatherDay(
      day: 'Tuesday',
      minTemp: 18,
      maxTemp: 28,
      rainChance: 0.4,
      windSpeed: 8,
      condition: WeatherCondition.thunder,
    ),
    WeatherDay(
      day: 'Wednesday',
      minTemp: 22,
      maxTemp: 32,
      rainChance: 0.1,
      windSpeed: 12,
      condition: WeatherCondition.overcast,
    ),
    WeatherDay(
      day: 'Thursday',
      minTemp: 19,
      maxTemp: 29,
      rainChance: 0.3,
      windSpeed: 9,
      condition: WeatherCondition.rainy,
    ),
    WeatherDay(
      day: 'Friday',
      minTemp: 21,
      maxTemp: 31,
      rainChance: 0.2,
      windSpeed: 11,
      condition: WeatherCondition.sunny,
    ),
    WeatherDay(
      day: 'Saturday',
      minTemp: 17,
      maxTemp: 27,
      rainChance: 0.5,
      windSpeed: 7,
      condition: WeatherCondition.thunder,
    ),
    WeatherDay(
      day: 'Sunday',
      minTemp: 23,
      maxTemp: 33,
      rainChance: 0.2,
      windSpeed: 10,
      condition: WeatherCondition.overcast,
    ),
  ];
  int selectedDayIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: Text('Weather'),
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
            controller: _tabController,
            indicatorColor: Theme.of(context).indicatorColor, // Use the default tab indicator color
            labelPadding: EdgeInsets.zero, // Remove the padding around the label
            tabs: [
              Tab(
                iconMargin: EdgeInsets.zero, // Remove the margin around the icon
                icon: Icon(Icons.cloud),
                text: 'Weather Updates',
              ),
              Tab(
                iconMargin: EdgeInsets.zero, // Remove the margin around the icon
                icon: Icon(Icons.traffic),
                text: 'Traffic Updates',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildWeatherUpdates(),
                _buildTrafficUpdates(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherUpdates() {
    return ListView.builder(
      itemCount: weatherDays.length,
      itemBuilder: (context, index) {
        WeatherDay weatherDay = weatherDays[index];
        bool isSelected = index == selectedDayIndex;

        IconData weatherIcon;
        Color weatherIconColor;
        switch (weatherDay.condition) {
          case WeatherCondition.sunny:
            weatherIcon = Icons.wb_sunny;
            weatherIconColor = Colors.yellow;
            break;
          case WeatherCondition.thunder:
            weatherIcon = Icons.flash_on;
            weatherIconColor = Colors.lightBlueAccent;
            break;
          case WeatherCondition.overcast:
            weatherIcon = Icons.cloud;
            weatherIconColor = Colors.grey;
            break;
          case WeatherCondition.rainy:
            weatherIcon = Icons.beach_access;
            weatherIconColor = Colors.blue;
            break;
        }

        return ListTile(
          tileColor: isSelected ? Color.fromARGB(255, 70, 70, 70) : null,
          onTap: () {
            setState(() {
              selectedDayIndex = index;
            });
            _showWeatherDetailsPopup(context, weatherDay);
          },
          leading: Icon(
            weatherIcon,
            color: weatherIconColor,
          ),
          title: Text(weatherDay.day),
          subtitle: Text('Temperature: ${weatherDay.minTemp}°C - ${weatherDay.maxTemp}°C'),
        );
      },
    );
  }

  Widget _buildTrafficUpdates() {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.traffic),
          title: Text('Road Closure'),
          subtitle: Text('Route: Highway 123'),
        ),
        ListTile(
          leading: Icon(Icons.traffic),
          title: Text('Heavy Traffic'),
          subtitle: Text('Location: Downtown'),
        ),
      ],
    );
  }

  void _showWeatherDetailsPopup(BuildContext context, WeatherDay weatherDay) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(weatherDay.day),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Min Temperature: ${weatherDay.minTemp}°C'),
              Text('Max Temperature: ${weatherDay.maxTemp}°C'),
              Text('Rain Chance: ${weatherDay.rainChance}'),
              Text('Wind Speed: ${weatherDay.windSpeed} km/h'),
            ],
          ),
          actions: [
            ElevatedButton(
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
}

class WeatherDay {
  String day;
  double minTemp;
  double maxTemp;
  double rainChance;
  double windSpeed;
  WeatherCondition condition;

  WeatherDay({
    required this.day,
    required this.minTemp,
    required this.maxTemp,
    required this.rainChance,
    required this.windSpeed,
    required this.condition,
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
                  'Welcome to the Weather Page!',
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