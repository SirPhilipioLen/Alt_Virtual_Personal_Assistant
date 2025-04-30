import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'calendar.dart';
import 'clock.dart';
import 'contacts.dart';
import 'eshop.dart';
import 'help.dart';
import 'home.dart';
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

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.lightBlue, // Change the primary color to indigo
            accentColor: Colors.indigoAccent, // Change the accent color to indigo
            brightness: Brightness.dark, // Set the brightness to dark
            cardColor: Color.fromARGB(255, 20, 20, 20),
          ).copyWith(
            secondary: Colors.indigoAccent, // Change the color of the selected tile
          ),
        ),
        home: MyHomePage(),
      ),
    );
  }
}


class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomePage();
        break;
      case 9:
        page = NewsPage();
        break;
      case 5:
        page = CalendarPage();
        break;
      case 4:
        page = MailPage();
        break;
      case 2:
        page = ContactsPage();
        break;
      case 7:
        page = ClockPage();
        break;
      case 12:
        page = EshopPage();
        break;
      case 15:
        page = HelpPage();
        break;
      case 3:
        page = MessagingPage();
        break;
      case 11:
        page = MusicPage();
        break;
      case 1:
        page = PhonePage();
        break;
      case 14:
        page = SettingsPage();
        break;
      case 13:
        page = SmartHomePage();
        break;
      case 6:
        page = TasksPage();
        break;
      case 10:
        page = WeatherPage();
        break;
      case 8:
        page = WebPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 200, // Adjust the width of the drawer as needed
            color: Color.fromARGB(255, 20, 20, 20), // Set the background color of the drawer to black
            child: ListView.builder(
              padding: EdgeInsets.only(top: 5), // Add padding above the first tile
              itemCount: 16,
              itemBuilder: (context, index) {
                final tileInfo = _getTileInfo(index);
                return ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(left: 16), // Add padding to the left of the title
                    child: Text(
                      tileInfo.title,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: selectedIndex == index
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).textTheme.subtitle1!.color,
                          ),
                    ),
                  ),
                  leading: Icon(
                    tileInfo.icon,
                    color: selectedIndex == index
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).iconTheme.color,
                  ),
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  selected: selectedIndex == index, // Highlight the selected tile
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 30, 30, 36),
              child: page,
            ),
          ),
        ],
      ),
    );
  }

  TileInfo _getTileInfo(int index) {
    switch (index) {
      case 0:
        return TileInfo(
          title: 'Home',
          icon: Icons.home_filled,
        );
      case 9:
        return TileInfo(
          title: 'News',
          icon: Icons.newspaper,
        );
      case 5:
        return TileInfo(
          title: 'Calendar',
          icon: Icons.calendar_month,
        );
      case 4:
        return TileInfo(
          title: 'Mail',
          icon: Icons.mail,
        );
      case 2:
        return TileInfo(
          title: 'Contacts',
          icon: Icons.contacts
        );
      case 7:
        return TileInfo(
          title: 'Clock',
          icon: Icons.alarm
        );
      case 12:
        return TileInfo(
          title: 'E-shop',
          icon: Icons.shopping_cart
        );
      case 15:
        return TileInfo(
          title: 'Help',
          icon: Icons.help
        );
      case 3:
        return TileInfo(
          title: 'Messaging',
          icon: Icons.message
        );
      case 11:
        return TileInfo(
          title: 'Music',
          icon: Icons.library_music
        );
      case 1:
        return TileInfo(
          title: 'Phone',
          icon: Icons.phone
        );
      case 14:
        return TileInfo(
          title: 'Settings',
          icon: Icons.settings
        );
      case 13:
        return TileInfo(
          title: 'Smart Home',
          icon: Icons.power_settings_new
        );
      case 6:
        return TileInfo(
          title: 'Tasks',
          icon: Icons.task
        );
      case 10:
        return TileInfo(
          title: 'Weather',
          icon: Icons.thunderstorm_rounded
        );
      case 8:
        return TileInfo(
          title: 'Web',
          icon: Icons.search
        );
      default:
        throw UnimplementedError('no tile info for $index');
    }
  }
}

class TileInfo {
  final String title;
  final IconData icon;

  TileInfo({required this.title, required this.icon});
}
