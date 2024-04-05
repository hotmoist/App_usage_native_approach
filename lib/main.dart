import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  static const platform =
      MethodChannel("com.example.app_usage_data_retreive/app_data");
  String data = 'no data';

  Future<void> _getAppData() async {
    String appData;
    try {
      final String result = await platform.invokeMethod("getAppUsageStats");
      appData = 'App data: $result';
    } on PlatformException catch (e) {
      appData = "Failed to get app data: '${e.message}'";
    }
    setState(() {
      data = appData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: Text('App data native approach')),
      body: SingleChildScrollView(
          child: Center(
        child: Text(data),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _getAppData,
        child: Icon(Icons.account_tree_outlined),
      ),
    ));
  }
}
