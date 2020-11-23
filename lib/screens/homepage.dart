import 'package:flutter/material.dart';
import 'package:notes_app/database_helper.dart';
import 'package:notes_app/drawer.dart';
import '../screens/taskpage.dart';
import '../drawer.dart';
import '../widget.dart';
import '../widgets.dart';



class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();

}

class _HomepageState extends State<Homepage> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.contain,
          height: 32,
        ),
            Container(
                padding: const EdgeInsets.all(8.0),),
                new RichText(text: new TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    new TextSpan(text: 'The ',
                    style: new TextStyle( color: Colors.amber,
                        fontWeight: FontWeight.bold
                        ,fontSize: 22)),
                    new TextSpan(text: 'Achievers', style: new TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue)),
                  ],
                ),
                ),
        ],
    ),
      ),

    
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 24.0
          ),
          color:Color(0xff6f6f6),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 32.0,
                    ),
                    child: Image(
                      image:AssetImage(
                        ''
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getTasks(),
                      builder: (context, snapshot) {
                        return ScrollConfiguration(
                          behavior: NoGlowBehaviour(),
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Taskpage(
                                        task: snapshot.data[index],
                                      ),
                                    ),
                                  ).then(
                                        (value) {
                                      setState(() {});
                                    },
                                  );
                                },
                                child: TaskCardWidget(
                                  title: snapshot.data[index].title,
                                  desc: snapshot.data[index].description,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            )
                ],
              ),
              Positioned(
                bottom: 24.0,
                  right: 0.0,
                  child: GestureDetector(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Taskpage(
                            task: null,
                          )),
                      ).then((value) {
                        setState(() {});
                      });
                    },
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                       gradient: LinearGradient(
                         colors: [Color(0xff7349fe),Color(0xff643fdb)],
                         begin: Alignment(0.0,-1.0),
                         end: Alignment(0.0, 1.0)
                       ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),

                    child: Image(
                      image: AssetImage("assets/images/add_icon.png"),
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
