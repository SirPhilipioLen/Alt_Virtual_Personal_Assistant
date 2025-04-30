import 'package:flutter/material.dart';

class SmartHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Home'),
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
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        children: [
          _buildDeviceControl(
            icon: Icons.lightbulb,
            title: 'Lights',
            subtitle: 'Control lights',
            onPressed: () {
              _showLightsSettingsPopup(context);
            },
          ),
          _buildDeviceControl(
            icon: Icons.ac_unit,
            title: 'Air Conditioner',
            subtitle: 'Adjust temperature',
            onPressed: () {
              _showAirConditionerSettingsPopup(context);
            },
          ),
          _buildDeviceControl(
            icon: Icons.coffee,
            title: 'Coffee Machine',
            subtitle: 'Schedule coffee brewing',
            onPressed: () {
              _showCoffeeMachineSettingsPopup(context);
            },
          ),
          _buildDeviceControl(
            icon: Icons.tv,
            title: 'TV',
            subtitle: 'Power on/off TV',
            onPressed: () {
              _showTVSettingsPopup(context);
            },
          ),
          _buildDeviceControl(
            icon: Icons.radio,
            title: 'Radio',
            subtitle: 'Power on/off radio',
            onPressed: () {
              _showRadioSettingsPopup(context);
            },
          ),
          _buildDeviceControl(
            icon: Icons.kitchen,
            title: 'Refrigerator',
            subtitle: 'Monitor refrigerator status',
            onPressed: () {
              _showRefrigeratorSettingsPopup(context);
            },
          ),
          _buildDeviceControl(
            icon: Icons.security,
            title: 'Alarm System',
            subtitle: 'Arm/disarm alarm system',
            onPressed: () {
              _showAlarmSystemSettingsPopup(context);
            },
          ),
          // Add more device controls as needed
        ],
      ),
    );
  }

  void _showLightsSettingsPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double brightness = 50.0;
        Color selectedColor = Colors.white;

        return AlertDialog(
          title: Text('Lights Settings'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text('Brightness'),
                  Expanded(
                    child: Slider(
                      value: brightness,
                      min: 0.0,
                      max: 100.0,
                      onChanged: (value) {
                        brightness = value;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Color'),
                  SizedBox(width: 16),
                  Container(
                    width: 30,
                    height: 30,
                    color: selectedColor,
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      _showColorPicker(context, selectedColor);
                    },
                    child: Text('Select Color'),
                  ),
                ],
              ),
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

  void _showColorPicker(BuildContext context, Color selectedColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Color Picker'),
          content: Text('Color Picker goes here'),
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

  void _showAirConditionerSettingsPopup(BuildContext context) {
    // Implement the Air Conditioner settings popup
  }

  void _showCoffeeMachineSettingsPopup(BuildContext context) {
    // Implement the Coffee Machine settings popup
  }

  void _showTVSettingsPopup(BuildContext context) {
    // Implement the TV settings popup
  }

  void _showRadioSettingsPopup(BuildContext context) {
    // Implement the Radio settings popup
  }

  void _showRefrigeratorSettingsPopup(BuildContext context) {
    // Implement the Refrigerator settings popup
  }

  void _showAlarmSystemSettingsPopup(BuildContext context) {
    // Implement the Alarm System settings popup
  }

  // Implement similar methods for other device settings

  Widget _buildDeviceControl({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onPressed,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: IconButton(
        icon: Icon(Icons.settings),
        onPressed: onPressed,
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
                  'Welcome to the Smart Home Page!',
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