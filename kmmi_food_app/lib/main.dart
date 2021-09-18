import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kmmi_food_app/home_page.dart';
import 'package:kmmi_food_app/ui/main_screen.dart';
import 'package:provider/provider.dart';

import 'data/repository/memory_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MemoryRepository()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreen(),
      ),
    );
  }
}
