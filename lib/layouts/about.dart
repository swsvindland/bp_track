import 'package:flutter/material.dart';
import 'package:bp_track/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(AppLocalizations.of(context)!.about),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            navigatorKey.currentState!.pop();
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.aboutPageCredits,
                style: const TextStyle(fontSize: 16),
              ),
              const Text(
                'Sam Svindland',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(
                height: 45,
              ),
              Text(
                AppLocalizations.of(context)!.aboutPageVersion,
                style: const TextStyle(fontSize: 16),
              ),
              const Text(
                '2.0.0',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
