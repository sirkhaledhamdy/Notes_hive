import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_notable/constants/constant.dart';
import 'package:hive_notable/constants/size_extention.dart';

import '../../models/note.dart';

class AddNoteScreen extends StatelessWidget {
  static const String id = "add_note_screen";
  AddNoteScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  void _submit(BuildContext context){
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
       //handle submission
      final notes = Hive.box('notes');
      final note = Note(title: _titleController.text.trim() , text: _bodyController.text.trim() , date: DateTime.now(),);
      notes.add(note);
      Navigator.pop(context);

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Note',
          style: TextStyle(
            fontFamily: 'Satisfy',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.all(16.0.rSp),
                child: TextFormField(
                  cursorColor: kYellowColor,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                  ),
                  controller: _titleController,
                  validator: (value) => value != null && value.trim().length > 0 ? null : 'Field cannot be empty',
                ),
              ),
              Divider(),
              Padding(
                padding:  EdgeInsets.all(16.0.rSp),
                child: TextFormField(
                  cursorColor: kYellowColor,
                  maxLines: 10,
                  validator: (value) => value != null && value.trim().length > 0 ? null : 'Field cannot be empty',
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Body',
                  ),
                  controller: _bodyController,
                ),
              ),

              SizedBox(height: 20.rSp,),
              Container(
                margin: EdgeInsets.all(16.rSp),
                width: double.infinity,
                height: 50.rSp,
                constraints: BoxConstraints(
                  maxWidth: 500.rSp,
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kYellowColor),
                    foregroundColor: MaterialStateProperty.all(kDarkGrey),
                  ),
                  onPressed: () => _submit(context) ,  child: Text('Add Note',),),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
