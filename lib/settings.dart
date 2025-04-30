import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = ThemeData.light();

  ThemeData get themeData => _themeData;

  void setThemeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData.brightness == Brightness.light) {
      setThemeData(ThemeData.dark());
    } else {
      setThemeData(ThemeData.light());
    }
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
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
          _buildCategoryHeader('Personalization'),
          _buildPersonalizationSettings(context),
          _buildCategoryHeader('Language'),
          _buildLanguageSettings(),
          _buildCategoryHeader('Accessibility'),
          _buildAccessibilitySettings(),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPersonalizationSettings(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('Theme'),
          subtitle: Text('Choose your app theme'),
          onTap: () {
            _showThemeDialog(context);
          },
        ),
        ListTile(
          title: Text('Background Image'),
          subtitle: Text('Set a custom background image'),
          onTap: () {
            // Navigate to background image settings
          },
        ),
        // Add more personalization settings
      ],
    );
  }

  Widget _buildLanguageSettings() {
    return Column(
      children: [
        ListTile(
          title: Text('Language'),
          subtitle: Text('Choose your app language'),
          onTap: () {
            // Navigate to language settings
          },
        ),
        // Add more language settings
      ],
    );
  }

  Widget _buildAccessibilitySettings() {
    return Column(
      children: [
        ListTile(
          title: Text('Colorblind Mode'),
          subtitle: Text('Enable colorblind mode'),
          trailing: Switch(
            value: false, // Replace with actual value from your state
            onChanged: (value) {
              // Update colorblind mode state
            },
          ),
        ),
        ListTile(
          title: Text('Color Filters'),
          subtitle: Text('Adjust color representation'),
          onTap: () {
            // Navigate to color filters settings
          },
        ),
        ListTile(
          title: Text('Colorblind Simulator'),
          subtitle: Text('Simulate colorblind experience'),
          onTap: () {
            // Navigate to colorblind simulator screen
          },
        ),
        ListTile(
          title: Text('Color Descriptions'),
          subtitle: Text('Provide alternative color descriptions'),
          onTap: () {
            // Navigate to color descriptions settings
          },
        ),
        // Add more accessibility settings
      ],
    );
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Theme'),
          content: Text('Select your preferred theme'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                Navigator.of(context).pop();
              },
              child: Text('Toggle Theme'),
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
                  'Welcome to the Settings Page!',
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