import 'package:bp_track/widgets/delete_account.dart';
import 'package:bp_track/widgets/height.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bp_track/models/models.dart';
import 'package:bp_track/services/database_service.dart';
import 'package:bp_track/utils/constants.dart';
import 'package:bp_track/widgets/notifications.dart';

import '../widgets/sex.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            navigatorKey.currentState!.pop();
          },
        ),
      ),
      body: StreamProvider<Preferences>.value(
        initialData: Preferences.empty(),
        value: db.streamPreferences(user!.uid),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[Sex(), Height(), Notifications(), DeleteAccount()],
            ),
          ),
        ),
      ),
    );
  }
}
