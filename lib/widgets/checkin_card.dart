import 'package:bp_track/models/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/colors.dart';

class CheckInCard extends StatelessWidget {
  const CheckInCard({Key? key, required this.data}) : super(key: key);
  final BloodPressure data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ListTile(
          title: Text(
            DateFormat.MMMMd(Localizations.localeOf(context).languageCode)
                .format(data.date),
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 20, color: textPrimary),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '${AppLocalizations.of(context)!.systolic}: ${data.systolic}\t\t\t'),
              Text(
                  '${AppLocalizations.of(context)!.diastolic}: ${data.diastolic}\t\t\t'),
            ],
          ),
        ),
      ),
    );
  }
}
