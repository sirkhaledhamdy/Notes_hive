import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_notable/constants/constant.dart';
import 'package:hive_notable/models/note.dart';
import 'package:hive_notable/view/add_note_screen/add_note_screen.dart';
import 'package:hive_notable/view/home_screen/home_screen.dart';



Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  runApp(const Notable());
}

class Notable extends StatelessWidget {
  const Notable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notable!',
      theme: ThemeData.dark().copyWith(
        appBarTheme:
          const  AppBarTheme(
            backgroundColor: kDarkGrey, centerTitle: false, elevation: 0,
          ),
        scaffoldBackgroundColor: kDarkGrey,
      ) ,
      routes: {
        AddNoteScreen.id: (context) =>   AddNoteScreen(),
      },
      home: FutureBuilder(future: Hive.openBox('notes'),
        builder: (context ,snapshots) {
        if (snapshots.connectionState == ConnectionState.done) {
          if(snapshots.hasError) {
            return const Scaffold(
              backgroundColor: kDarkGrey,
              body: Center(child: Text('An Error Occurred',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kRedColor,
              ),
              ),),
            );
          }
          return const HomeScreen();
        } else {
          return Scaffold(
            backgroundColor: kDarkGrey,
            body: const Center(child: CircularProgressIndicator(
              color: kYellowColor,
            ),),
          );
        }
      },),
    );
  }
}


