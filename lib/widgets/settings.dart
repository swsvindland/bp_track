import 'package:bp_track/widgets/delete_account.dart';
import 'package:flutter/material.dart';

import '../services/database_service.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  final db = DatabaseService();


  @override
  Widget build(BuildContext context) {

    return const Align(
        alignment: Alignment.topCenter,
        child: DeleteAccount()
      );
  }
}
