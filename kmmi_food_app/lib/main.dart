import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kmmi_food_app/data/commons/memory_repository.dart';
import 'package:kmmi_food_app/data/mock_service/mock_service.dart';
import 'package:kmmi_food_app/ui/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MemoryRepository(), lazy: false),
        FutureProvider<Response?>(
          create: (_) async {
            final MockService service = MockService();
            service.create();
            return service.getMockDatas();
          },
          initialData: null,
        )
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
