import 'package:flutter/material.dart';
import '../model/task.dart';
import '../widgets.dart';
import '../model/todo.dart';
import '../database_helper.dart';

class Taskpage extends StatefulWidget {

  final Task task;
  Taskpage({@required this.task});

  @override
  _TaskpageState createState() => _TaskpageState();
}

class _TaskpageState extends State<Taskpage> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  int _taskId =0;
  String _taskTitle ="";
  String _taskDescription="";

  FocusNode _titleFocus;
  FocusNode _descriptionFocus;
  FocusNode _todoFocus;

  bool _contentvisible = false;

  @override
  void initState() {
if(widget.task != null){
  _contentvisible = true;
  _taskTitle =widget.task.title;
  _taskDescription= widget.task.description;
  _taskId = widget.task.id;

}
  _titleFocus =FocusNode();
  _descriptionFocus = FocusNode();
  _todoFocus = FocusNode();
    super.initState();
  }
  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _todoFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
         child: Stack(
           children: [
             Column(
               crossAxisAlignment:CrossAxisAlignment.start ,
               children: [
                   Padding(
                     padding: EdgeInsets.only(
                       top: 24.0,
                       bottom: 6.0,
                     ),
                     child: Row(
                       children: [
                         InkWell(

                         onTap: (){
                   Navigator.pop(context);
                   },
                           child: Padding(
                             padding: const EdgeInsets.all(24.0),
                             child: Image(
                               image: AssetImage(
                                 'assets/images/back_arrow_icon.png'
                               ),
                             ),
                           ),
                         ),
                         Expanded(child: TextField(
                           focusNode: _titleFocus,
                           onSubmitted: (value)async{
                           //  print("Faild value: $value");

                             if(value != "") {
                               if(widget.task == null){
                                 Task _newTask= Task(title:value);
                                _taskId = await _dbHelper.insertTask(_newTask);
                                setState(() {
                              _contentvisible= true;
                              _taskTitle = value;
                                });

                               }else
                                await _dbHelper.updateTaskTitle(_taskId,value);
                               print ("Task updated");
                             }
                           },
                           controller: TextEditingController()..text =_taskTitle,
                           decoration: InputDecoration(
                             hintText: "Enter Task Title",
                             border: InputBorder.none,
                           ),
                           style: TextStyle(
                             fontSize: 26.0,
                             fontWeight: FontWeight.bold,
                             color: Color(0xff211551),
                           ),
                         ),),
                       ],
                     ),
                   ),
                 Visibility(
                   visible: _contentvisible,
                   child: Padding(
                     padding: EdgeInsets.only(
                       bottom: 12.0
                     ),
                     child: TextField(
                       focusNode: _descriptionFocus,
                          onSubmitted: (value)async{
                         if(value !=""){
                           if(_taskId != 0){
                              await   _dbHelper.updateTaskDescription(_taskId, value);
                              _taskDescription =value;
                           }
                         }
                         _todoFocus.requestFocus();
                          },
                       controller: TextEditingController()..text = _taskDescription,
                          decoration: InputDecoration(
                            hintText: "Enter Description for your Task...",
                                border:InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 24.0,
                            )
                          ),
                             ),
                   ),
                 ),

                Visibility(
                  visible: _contentvisible,
                  child: FutureBuilder(
                   initialData: [],
                    future: _dbHelper.getTodo(_taskId),
                    builder: (context, snapshot){
                     return Expanded(
                       child: ListView.builder(
                         itemCount: snapshot.data.length,
                         itemBuilder:(context,index){
                           return GestureDetector(
                             onTap: () async{
                                 if(snapshot.data[index].isDone ==0){
                             await  _dbHelper.updateTodoDone(snapshot.data[index].id, 1);
                                 }else{
                             await    _dbHelper.updateTodoDone(snapshot.data[index].id, 0);
                                 }
                                 setState(() {

                                 });
                             },
                             child: TodoWidget(
                               text: snapshot.data[index].title,
                               isDone:snapshot.data[index].isDone ==0? false : true,
                             ),
                           );
                         },
                       ),
                     );
                    },
                  ),
                ),
                Visibility(
                  visible: _contentvisible,
                  child: Padding(
                    padding:EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 20.0,
                          height: 20.0,
                          margin: EdgeInsets.only(
                              right: 12.0
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:BorderRadius.circular(6.0),
                            border:  Border.all(
                              color: Color(0xff86829d),
                              width: 1.5,
                            ),
                          ),
                          child: Image(
                            image: AssetImage(
                              "assets/images/check_icon.png",
                            ),
                          ),
                        ),
                        Expanded(
                            child: TextField(
                              focusNode: _todoFocus,
                      controller: TextEditingController()..text= "",
                      onSubmitted: (value) async{
                        if(value != "") {
                          if(_taskId != 0){
                            DatabaseHelper _dbHelper = DatabaseHelper();
                            Todo _newTodo= Todo(
                                title:value,
                                    isDone:0,
                              taskId: _taskId,
                            );
                            await _dbHelper.insertTodo(_newTodo);
                           setState(() {});
                           _todoFocus.requestFocus();
                          }else {
                            print("This task doesn't exist");
                          }
                          _descriptionFocus.requestFocus();
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Enter your text....",
                        border: InputBorder.none,
                      ),
                    )),
                      ],
                    ),
                  ),
                )
                   ],
             ),
             Visibility(
               visible: _contentvisible,
               child: Positioned(
                 bottom: 24.0,
                 right: 24.0,
                 child: GestureDetector(
                   onTap:() async{
                      if(_taskId !=0){
                        await _dbHelper.deleteTask(_taskId);
                        Navigator.pop(context);
                      }
                   },
                   child: Container(
                     width: 60.0,
                     height: 60.0,
                     decoration: BoxDecoration(
                       color: Color(0xfffe3577),
                       borderRadius: BorderRadius.circular(20.0),
                     ),

                     child: Image(
                       image: AssetImage("assets/images/delete_icon.png"),
                     ),
                   ),
                 ),
               ),
             ),
           ],
         ),
        ),
      ),
    );
  }
}
