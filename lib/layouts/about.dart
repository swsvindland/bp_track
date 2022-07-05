import 'package:flutter/material.dart';
import 'package:bp_track/utils/constants.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('About'),
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
            children: const <Widget>[
              Text(
                'Designed and Built by',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                'Sam Svindland',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              SizedBox(
                height: 45,
              ),
              Text(
                'Version',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                '1.0.0',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
