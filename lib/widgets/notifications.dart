import 'package:bp_track/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bp_track/models/models.dart';
import 'package:bp_track/services/database_service.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final db = DatabaseService();
  late int start;
  late int end;
  bool set = false;

  void update(User? user, Preferences preferences) {
    preferences.setStartTime(start);
    set = false;

    db.updatePreferences(user!.uid, preferences);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final preferences = Provider.of<Preferences>(context);

    setState(() {
      if (!set) {
        start = preferences.start;
      }
    });

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('Reminder Notification'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    OutlinedButton(
                      onPressed: () async {
                        TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: const TimeOfDay(hour: 12, minute: 00),
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child ?? const Text('error'),
                            );
                          },
                        );

                        setState(() {
                          start = picked!.hour;
                          set = true;
                        });
                      },
                      child: Text('$start:00'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Button(
              onPressed: () {
                update(user, preferences);
              },
              variant: 'secondary',
              child: const Text(
                'Update',
              ),
            )
          ],
        ),
      ),
    );
  }
}
