import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String title;   
  String text = "No Value Entered"; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
             // borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
           //  borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                // begin: Alignment.topRight,
                // end: Alignment.bottomLeft,
              
               // colors: [Colors.black54, Color.fromRGBO(0, 41, 102, 1)]
                colors: [Colors.black54, Color.fromRGBO(21, 34, 56, 1)]
               
              )
            ),

        child: Column(
          children: <Widget>[
          Container(
            // decoration: BoxDecoration(
            //           gradient: LinearGradient(
            //             //colors: [Colors.black54, Color.fromRGBO(0, 41, 102, 1)]
            //             colors: [Colors.black54, Color.fromRGBO(21, 34, 56, 1)]
            //           ),
            //         ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
               
                  Container(
                   
                    
                    height: 30,
                    width: 50,
                    child: IconButton(
                      onPressed: () {
                       // Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios,),
                      iconSize: 24,
                      color: Colors.black54,
                    ),
                    // decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.black54),
                    //     borderRadius: BorderRadius.all(Radius.circular(10)),
                    //     ),
                  ),
                  // SizedBox(width: 80),
                  // IconButton(
                  //   icon:Icon(Icons.menu) , 
                  //   //icon:Icon(Icons.arrow_forward_ios_outlined) ,
                  //   onPressed: () {},
                  //   ),
                  Text(
                    'Edit Profile ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                    color: Colors.white70,
                    ),
                  ),
                  Container(height: 24, width: 90)
                ],
              ),
            ),
          ),
          Container(
          //   decoration: BoxDecoration(
          //    // borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          //  //  borderRadius: BorderRadius.circular(30),
          //     gradient: LinearGradient(
          //       // begin: Alignment.topRight,
          //       // end: Alignment.bottomLeft,
              
          //       //colors: [Colors.black54, Color.fromRGBO(0, 41, 102, 1)]
          //       colors: [Colors.black54, Color.fromRGBO(21, 34, 56, 1)]
          //     )
          //   ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Padding(
                //    padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
                //    child: Row(
                //      children: [
                //        IconButton(
                //                 //  alignment: Alignment.bottomRight,
                //                   icon: Icon(
                //                 //  alignment: Alignment.center,
                //                   Icons.circle,
                //                   size: 20,
                //                   color: Colors.blue,
                //                   ),
                //                  onPressed: () {},
                //                  ),
                //                  Text('Last Seen',
                //                  style: TextStyle(
                //                    fontWeight: FontWeight.bold,
                //              //      color: Colors.white70,
                //                  ),
                //                  ),
                //      ],
                //    ),
                //  ),
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
                //  Padding(
                //    padding: const EdgeInsets.fromLTRB(60, 90, 0, 0),
                //    child: IconButton(
                //             //  alignment: Alignment.bottomRight,
                //               icon: Icon(
                //             //  alignment: Alignment.center,
                //               Icons.message,
                //               size: 45,
                //               color: Colors.blue,
                //               ),
                //              onPressed: () {},
                //              ),
                //  )

              ],
            ),
          ),
        
   
        
          
         Flexible(
                  child: Expanded(child: 
            Container(
              
              // decoration: BoxDecoration(
              
              //   gradient: LinearGradient(
                  
              //     colors: [Colors.black54, Color.fromRGBO(21, 34, 56, 1)]
              //   )
              // ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                    child: Container(
                      height: 80,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                           // keyboardType: TextInputType.text,
                            decoration: InputDecoration(labelText: 'Username'), 
                    
                             onChanged: (value) => title = value,
                          //   'Email:', style: TextStyle(
                          //   fontWeight: FontWeight.bold,
                          // //  color: Colors.white70,
                          //   ),
                            ),
                        ),
                      ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),
                    ),
                  ),
                  Flexible(
                                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                      child: Container(
                        height: 80,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(labelText: 'Bio'), 
                      
                               onChanged: (value) => title = value,
                          //     'Bio:', style: TextStyle(
                          //     fontWeight: FontWeight.bold,
                          //  //   color: Colors.white70,
                          //     ),
                              ),
                          ),
                        ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container( height: 70, width: 200,
                        child: Align(child: Text('Save', style: TextStyle(color: Colors.white70, fontSize: 20),),),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30),)
                        ),
                      ),
                    ),
                  )
                  
                  //   decoration: InputDecoration(labelText: 'Bio'), 
                    
                  //                onChanged: (value) => title = value,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                  //   child: Container(
                  //     height: 60,
                  //     child: Align(
                  //       alignment: Alignment.centerLeft,
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Row(
                  //           children: [
                  //             Text('Mutual Friend:', style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               //color: Colors.white70,
                  //               ),),
                  //             SizedBox(width: 5),
                  //             Text('6', style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               color: Colors.white70,
                  //               ),),
                  //           ],
                  //         ),
                  //       ),
                  //     ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                  //   child: Container(
                  //     height: 60,
                  //     child: Align(
                  //       alignment: Alignment.centerLeft,
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Row(
                  //           children: [
                  //             Text('Mutual Group:', style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //            //   color: Colors.white70,
                  //               ),),
                  //              SizedBox(width: 5),
                  //             Text('6', style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               color: Colors.white70,
                  //               ),),
                  //           ],
                  //         ),
                  //       ),
                  //     ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),
                  //   ),
                  // ),
                  //  Padding(
                  //   padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                  //   child: Container(
                  //     height: 60,
                  //     child: Align(
                  //       alignment: Alignment.centerLeft,
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Row(
                  //           children: [
                  //             Text('Ideas Count:', style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //              // color: Colors.white70,
                  //               ),),
                  //              SizedBox(width: 5),
                  //             Text('10', style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               color: Colors.white70,
                  //               ),),
                  //           ],
                  //         ),
                  //       ),
                  //     ), decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(width: 1.0, color: Colors.white70)),
                  //   ),
                  // ),
                 
                ],
              ),
            ),
            ),
         )
        ],

        ),
      ),
      
    );
  }
}