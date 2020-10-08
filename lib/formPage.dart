import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
class SecondPage extends StatefulWidget {
  String collect='';
  String imageURL = '';
  String name ='';
  SecondPage({Key key, this.imageURL ,this.collect, this.name}): super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState(imageURL,collect,name);
}

class _SecondPageState extends State<SecondPage> {
  String collect, imageURL , name;
  bool flag=false;
  _SecondPageState(String a, String b, String c){
    imageURL=a;
    collect=b;
    name=c;
  }
  String git = null;

  String linkedin= null;

  String chrome =null;

  String twitter = null;

  String instagram = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20.0,
        title: Text('Details',
        style: GoogleFonts.robotoCondensed(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey[200],),
      body: Container(color: Colors.grey[50],
      child: ListView(
        children: <Widget>[
          SizedBox(height: 50.0,),
          // Text('  *',style: TextStyle(color: Colors.red[800],fontSize: 20.0),),
          myText('Instagram link'),
          myText2('Git Link'),
          myText3('LinkedIn Link'),
          myText4('Twitter link'),
          myText5('Link for your own website'),
          Row(children: <Widget>[
            Text('  *',style: TextStyle(color: Colors.red[800],fontSize: 20.0),),Text( ' mandatory'),
          ]),
           Row(children: <Widget>[
            Text('  **',style: TextStyle(color: Colors.red[800],fontSize: 20.0),),Text( ' Enter Valid Links or Leave Empty'),
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Container(

                  height: 60.0,
                      //padding: EdgeInsets.all(8),
                      child: RaisedButton(
                        color: Colors.blue,
                        child: showProgress(),
                        
                        elevation: 20.0,
    
                        
                        //color: Colors.grey[200],
                        
                        onPressed: (){
                          setState(() {
                            flag= true;
                          });
                          
                          final CollectionReference users = Firestore.instance.collection(widget.collect);
                          Firestore.instance
                        .runTransaction((Transaction transaction) async {
                      CollectionReference reference =
                      Firestore.instance.collection(widget.collect);
                      await reference
                          .add({"name": widget.name, "github": git, "linkedin": linkedin, "website":chrome, "twitter":twitter , "memberImgURL":imageURL, "instagram":instagram
                          });
                          
                          Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=> ThirdPage()));

                    }
                    );
                  },//_submitForm(),
              ),
              ),
            ),
          ),
          SizedBox(height: 30.0,),
          
          
        ],
      )),
      
    );
  }

  Widget showProgress(){
    if (flag)
    return CircularProgressIndicator(
      backgroundColor: Colors.white,
    );
    else
    return Text('Submit',
    style: GoogleFonts.robotoCondensed(
      color: Colors.white,
      fontSize: 40.0),);
  }

  Widget myText(String a){
    return Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              onChanged: (String str){
                instagram =str;
              },
              decoration: new InputDecoration(
                          labelText: '**  $a',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                            ),
                          ),
              )
            ),
          );
  }

  Widget myText2(String a){
    return Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              onChanged: (String str){
                git = str;
              },
              decoration: new InputDecoration(
                          labelText: '**  $a',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                            ),
                          ),
              )
            ),
          );
  }

  Widget myText3(String a){
    return Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              onChanged: (String str){
                linkedin = str;
              },
              decoration: new InputDecoration(
                          labelText: '**  $a',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                            ),
                          ),
              )
            ),
          );
  }

  Widget myText4(String a){
    return Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              onChanged: (String str){
                twitter = str;
              },
              decoration: new InputDecoration(
                          labelText: '**  $a',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                            ),
                          ),
              )
            ),
          );
  }

  Widget myText5(String a){
    return Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              onChanged: (String str){
                chrome = str;
              },
              decoration: new InputDecoration(
                          labelText: '**  $a',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                            ),
                          ),
              )
            ),
          );
  }
}
class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: GestureDetector(
          onTap: ()=> exit(0),
                  child: Column(
            children: <Widget>[
              Padding(
              padding: const EdgeInsets.fromLTRB(20.0,100.0,20.0,50.0),
              child: Center(
                child: Text("Your Details Have Been added Successfully!",
                style: GoogleFonts.robotoCondensed(fontSize: 40.0),),
              ),
            ),

            
            Container(
              child: Icon(Icons.done,size: 200.0,color: Colors.white,),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(100.0)
              ),),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text('(Tap To exit)',style: GoogleFonts.robotoCondensed(
                  fontSize: 30.0
                ),),
              )
            ],
          ),
        ),
      ),
      
    );
  }
}