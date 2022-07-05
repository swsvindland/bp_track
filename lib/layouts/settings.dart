import 'package:bp_track/widgets/delete_account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bp_track/services/database_service.dart';
import 'package:bp_track/utils/constants.dart';


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
      body: const Padding(
          padding: EdgeInsets.all(24),
          child: Align(
            alignment: Alignment.topCenter,
            child: DeleteAccount(),
          )
        ),
    );
  }
}
