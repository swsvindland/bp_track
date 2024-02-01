import 'package:bp_track/widgets/app_bar_ad.dart';
import 'package:flutter/material.dart';
import 'package:bp_track/services/database_service.dart';
import 'package:bp_track/services/sign_in.dart';
import 'package:bp_track/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/all.dart';
import '../widgets/home.dart';
import '../widgets/settings.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage>  {
  int currentPageIndex = 0;
  final db = DatabaseService();

  handleWeighIn() {
    navigatorKey.currentState!.pushNamed('/weigh-in');
  }

  handleCheckIn() {
    navigatorKey.currentState!.pushNamed('/check-in');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarAd(),
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton<Popup>(
            onSelected: (Popup result) {
              if (result == Popup.logOut) {
                signOut();
                navigatorKey.currentState!
                    .pushNamedAndRemoveUntil('/login', (route) => false);
              }
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Popup>>[
              const PopupMenuItem<Popup>(
                value: Popup.logOut,
                child: ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Log Out'),
                ),
              ),
            ].toList(),
          ),
        ],
      ),
      body: currentPageIndex == 0
          ? Home()
          : currentPageIndex == 1 ?
              All()
          : Settings(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: handleWeighIn,
        label: Text(AppLocalizations.of(context)!.checkIn),
        icon: const Icon(Icons.monitor_heart),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights),
            label: 'All',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

enum Popup { about, settings, logOut }
