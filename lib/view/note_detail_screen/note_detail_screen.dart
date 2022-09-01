import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_notable/constants/constant.dart';
import 'package:hive_notable/constants/size_extention.dart';
import 'package:intl/intl.dart';

class NoteDetailScreen extends StatelessWidget {
  final int index ;
   NoteDetailScreen({Key? key, required this.index}) : super(key: key);

  final _notes = Hive.box('notes');
  @override
  Widget build(BuildContext context) {
    final note = _notes.getAt(index);
    return  Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.all(10.rSp),
            child: InkWell(
                onTap: (){
                  try{
                    _notes.deleteAt(index);
                    Navigator.pop(context);
                  }catch (e){
                    print(e);
                  }
                },
                child: Icon(Icons.delete_outline,),),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.rSp , vertical: 10.rSp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(note.title,
              style: TextStyle(
                fontSize: 24.rSp,
                color: kYellowColor,
                fontWeight: FontWeight.w800,
              ),
              ),
              SizedBox(height: 10.rh,),
              Text(DateFormat.MMMMEEEEd().format(note.date),
              style: Theme.of(context).textTheme.caption,
              ) ,
              SizedBox(height: 10.rh,),

              Text(note.text,
              style: TextStyle(
                fontSize: 18.rSp,
              ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
