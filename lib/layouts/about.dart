import 'package:flutter/material.dart';
import 'package:bp_track/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(AppLocalizations.of(context)!.about),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
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
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const Text(
                'Sam Svindland',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(
                height: 45,
              ),
              Text(
                AppLocalizations.of(context)!.aboutPageVersion,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const Text(
                '1.3.0',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
