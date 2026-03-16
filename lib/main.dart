import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'DB/app_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await AppDatabase.deleteDatabaseManually();
  await AppDatabase.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Storage',

      theme: ThemeData(
        brightness: Brightness.dark,

        // Base
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF5F6F86),
          surface: Color(0xFF121212),
        ),

        scaffoldBackgroundColor: const Color(0xFF121212),

        inputDecorationTheme: const InputDecorationTheme(
          // Cor do Label do TextField
          labelStyle: TextStyle(
            color: Color(0xFF5F6F86),
          ),

          // Ghost text in TextField
          hintStyle: TextStyle(
            color: Color(0xFF7F8A99),
          ),

          // Input line when unfocused
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF5F6F86),
            ),
          ),

          // Input line when focused
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF8FA4C7),
              width: 2,
            ),
          ),
        ),
      ),

      home: const HomePage(),
    );
  }
}
