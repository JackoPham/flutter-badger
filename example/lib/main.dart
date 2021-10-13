import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_badger/flutter_badger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _appBadgeSupported = 'Unknown';

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    String appBadgeSupported;
    try {
      bool res = await FlutterBadger.isAppBadgeSupported();
      if (res) {
        appBadgeSupported = 'Supported';
      } else {
        appBadgeSupported = 'Not supported';
      }
    } on PlatformException {
      appBadgeSupported = 'Failed to get badge support.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _appBadgeSupported = appBadgeSupported;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Badge supported: $_appBadgeSupported\n'),
              ElevatedButton(
                child: const Text('Add badge'),
                onPressed: () {
                  _addBadge();
                },
              ),
              ElevatedButton(
                  child: const Text('Remove badge'),
                  onPressed: () {
                    _removeBadge();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void _addBadge() {
    FlutterBadger.updateBadgeCount(1);
  }

  void _removeBadge() {
    FlutterBadger.removeBadge();
  }
}
