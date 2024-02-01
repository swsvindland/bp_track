import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../services/database_service.dart';
import '../utils/constants.dart';
import '../utils/helper.dart';
import 'input.dart';

class CheckInForm extends StatefulWidget {
  const CheckInForm({super.key});

  @override
  State<CheckInForm> createState() => _CheckInState();
}

class _CheckInState extends State<CheckInForm> {
  final db = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  final systolicController = TextEditingController();
  final diastolicController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    systolicController.dispose();
    diastolicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    submit() async {
      if (user == null) return;

      await db.addWeighIn(user.uid, int.parse(systolicController.text),
          int.parse(diastolicController.text));
    }

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Input(
              label: AppLocalizations.of(context)!.systolic,
              controller: systolicController,
              validator: checkInValidator),
          Input(
              label: AppLocalizations.of(context)!.diastolic,
              controller: diastolicController,
              validator: checkInValidator),
          FilledButton(
              onPressed: () async {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  await submit();
                  navigatorKey.currentState!.pop();
                }
              },
              child: Text(AppLocalizations.of(context)!.submit),
          ),
        ],
      ),
    );
  }
}
