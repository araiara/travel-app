import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/provider/travel_provider.dart';
import 'package:travel_app/screens/travel_list_screen.dart';

void main() {
  runApp(TravelApp());
}

class TravelApp extends StatelessWidget {
  const TravelApp({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => TravelProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: TravelListScreen(),
      ),
    );
  }
}
