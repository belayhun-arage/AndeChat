

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            profileView() // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget profileView() {
    return Column(

      children: <Widget>[
        Container(
          decoration: BoxDecoration(
                    gradient: LinearGradient(
                      //colors: [Colors.black54, Color.fromRGBO(0, 41, 102, 1)]
                      colors: [Colors.black54, Color.fromRGBO(21, 34, 56, 1)]
                    ),
                  ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
             
                Container(
                 
                  
                  height: 30,
                  width: 50,
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 24,
                    color: Colors.black54,
                  ),
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.black54),
                  //     borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     ),
                ),
                Text(
                  'Profile ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                  color: Colors.white70,
                  ),
                ),
                Container(height: 24, width: 24)
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
           // borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
         //  borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              // begin: Alignment.topRight,
              // end: Alignment.bottomLeft,
            
              //colors: [Colors.black54, Color.fromRGBO(0, 41, 102, 1)]
              colors: [Colors.black54, Color.fromRGBO(21, 34, 56, 1)]
            )
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                 padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
                 child: Row(
                   children: [
                     IconButton(
                              //  alignment: Alignment.bottomRight,
                                icon: Icon(
                              //  alignment: Alignment.center,
                                Icons.circle,
                                size: 20,
                                color: Colors.blue,
                                ),
                               onPressed: () {},
                               ),
                               Text('Last Seen',
                               style: TextStyle(
                                 fontWeight: FontWeight.bold,
                           //      color: Colors.white70,
                               ),
                               ),
                   ],
                 ),
               ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  
                  children: [
                    Stack(
                      children: <Widget>[
                        
                        CircleAvatar(
                          radius: 70,
                          child: ClipOval(
                            child: Image.asset(
                              'images/img.jpg',
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 1,
                            right: 1,
                            child: Container(
                              height: 40,
                              width: 40,
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadius.all(Radius.circular(20))),
                            ),
                            
                            ),
                            
                      ],
                    ),
                   
                  ],
                  
                ),
              ),
               Padding(
                 padding: const EdgeInsets.fromLTRB(60, 90, 0, 0),
                 child: IconButton(
                          //  alignment: Alignment.bottomRight,
                            icon: Icon(
                          //  alignment: Alignment.center,
                            Icons.message,
                            size: 45,
                            color: Colors.blue,
                            ),
                           onPressed: () {},
                           ),
               )

            ],
          ),
        ),
      
        Container(
          decoration: BoxDecoration(
           
            gradient: LinearGradient(
            
            colors: [Colors.black54, Color.fromRGBO(21, 34, 56, 1)]
            )
          ),

            child: Center(
              child: Container(
                child: Column(
        children: [ Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('id:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
             //   color: Colors.white70,
              ),
              ),
              Text('0125632',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
           //     color: Colors.white70,
              ),
              ),
            ],
          ),
           SizedBox(
              height: 17,
            ),
          Text(
            'Faniman',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
       
        ],
                ),
              ),
            ),
          ),
      
        
       Expanded(child: 
        Container(
          
          decoration: BoxDecoration(
          
            gradient: LinearGradient(
              
              colors: [Colors.black54, Color.fromRGBO(21, 34, 56, 1)]
            )
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                child: Container(
                  height: 60,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                      //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Email:', style: TextStyle(
                            fontWeight: FontWeight.bold,
                          //  color: Colors.white70,
                            ),),
                            SizedBox(width: 5),
                            Text('faniman@gmail.com', style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                           ),
                           ),
                        ],
                      ),
                    ),
                  ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                child: Container(
                  height: 60,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Bio:', style: TextStyle(
                            fontWeight: FontWeight.bold,
                         //   color: Colors.white70,
                            ),),
                        ),
                        Text('This Is Faniman',
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                        ),
                        SizedBox(width: 180,),
                        IconButton(
                          //alignment: Alignment.center,
                          color: Colors.white,
                          icon: Icon(
                            Icons.edit), onPressed: () {},
                            ),
                      ],
                    ),
                  ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                child: Container(
                  height: 60,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Mutual Friend:', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            //color: Colors.white70,
                            ),),
                          SizedBox(width: 5),
                          Text('6', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                            ),),
                        ],
                      ),
                    ),
                  ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                child: Container(
                  height: 60,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Mutual Group:', style: TextStyle(
                            fontWeight: FontWeight.bold,
                         //   color: Colors.white70,
                            ),),
                           SizedBox(width: 5),
                          Text('6', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                            ),),
                        ],
                      ),
                    ),
                  ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),
                ),
              ),
               Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                child: Container(
                  height: 60,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Ideas Count:', style: TextStyle(
                            fontWeight: FontWeight.bold,
                           // color: Colors.white70,
                            ),),
                           SizedBox(width: 5),
                          Text('10', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                            ),),
                        ],
                      ),
                    ),
                  ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),
                ),
              ),
             
            ],
          ),
        ),
        )
      ],
    );

   
  }
}

// class HeaderCurvedContainer extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     // TODO: implement paint
//     Paint paint = Paint()..color = Color(0xff555555);
//     Path path = Path()
//       ..relativeLineTo(0, 150)
//       ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
//       ..relativeLineTo(0, -150)
//       ..close();
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     // TODO: implement shouldRepaint
//     return false;
//   }
//}
