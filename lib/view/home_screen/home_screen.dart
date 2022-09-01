import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_notable/constants/constant.dart';
import 'package:hive_notable/view/add_note_screen/add_note_screen.dart';
import 'package:intl/intl.dart';
import '../../constants/size_extention.dart';
import '../../models/note.dart';
import '../note_detail_screen/note_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget _gridCell({required BuildContext context ,
  required Note note,
  required int index,
  }) {
    return InkWell(
      onTap: (){
        Navigator.push(context , MaterialPageRoute(builder: (context) => NoteDetailScreen(index: index,),),);
      },
      child: Padding(
        padding:  EdgeInsets.all(5.0.rSp),
        child: Card(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.rSp),
            borderSide: BorderSide.none,
          ),
          color: kLightGrey,
          child: Padding(
            padding: EdgeInsets.all(10.rSp),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(note.title ,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: kYellowColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 18.rSp,
                ),
                ),
                SizedBox(height: 4.rh,),
                Text(
                  DateFormat.MMMMEEEEd().format(note.date,
                ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(height: 8.rh,),
                Text(note.text,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,

                ),
              ],
          ),
            ),),

        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScreenSizes.screenWidth = size.width;
    ScreenSizes.screenHeight = size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Notable!',
            style: TextStyle(
              fontSize: 22.rSp,
              fontFamily: 'Satisfy',
            ),
          ),
          centerTitle: true,
        ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box('notes').listenable(),
          builder: (context, Box<dynamic> notes, _) {
            return GridView.builder(
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 500 ? 4 : 2,
              ),
              itemBuilder: (context, index) {
                // get from model
                final note = notes.getAt(index);
                return _gridCell(
                    context: context,
                    note: note, index: index);
              },
              itemCount: notes.length,
            );
          },
        ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: kYellowColor,
      onPressed: () {
        Navigator.pushNamed(context, AddNoteScreen.id);
      },
      child:  Icon(CupertinoIcons.add,),
    ),
    );
  }
}
