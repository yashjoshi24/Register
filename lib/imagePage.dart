import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'formPage.dart';

class addImage extends StatefulWidget {
  String collect ='';
  
  addImage({Key key, this.collect}): super(key: key);
  @override
  _addImageState createState() => _addImageState(collect);
}

class _addImageState extends State<addImage> {
  String collect='';
  String name ='';
  bool flag= false;
  _addImageState(String col){
    collect = col;

  }

  File profileImage;
  AssetImage pro = AssetImage('assets/images/unnamed.png');
  Future getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      profileImage = image;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(
            child: ListView(
              children: <Widget>[
                //Image.file(profileImage),
                SizedBox(height: 40.0,),
                Container(
                     height: 250.0,
                     //width: 80.0,
                   
                     child: func(),
                 ),
                 
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                     child: Container(
                      height: 60.0,
                      child: RaisedButton.icon(
                        
                        onPressed: (){
                       getImage();
                        },
                        icon: Icon(Icons.photo_library,color: Colors.white,),
                        label: Text(
                       "Pick from Gallery",
                       style: GoogleFonts.openSans(
                         fontSize: 18,color: Colors.white
                       ),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    onChanged: (String str){
                      name =str;
                    },
                    decoration: new InputDecoration(
                                labelText: '*  name',
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                    )
                  ),
                ),
                  Padding(

                    padding: const EdgeInsets.all(20.0),
                    child: FloatingActionButton(
                     // backgroundColor: Colors.red,
            onPressed: () async {
              setState(() {
                flag= true;
              });
              var profileImgURL;
              var firebaseStorageRef = FirebaseStorage.instance.ref().child("team");
              if(profileImage != null){
                var eventImgRef = firebaseStorageRef.child(name
                );
                StorageUploadTask imgUpload = eventImgRef.putFile(profileImage);
                StorageTaskSnapshot tempSnapshot = await imgUpload.onComplete;
                profileImgURL = await tempSnapshot.ref.getDownloadURL();
              }
              print(profileImgURL);
              
              Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=> SecondPage(imageURL: profileImgURL.toString(),
          collect: collect, name: name,
          ))
        );
            },
            child: showProgress(),
        ),
                  ),

              ],
            ),
          ),
    );

  }
  Widget func(){
    if (profileImage!=null)
    return Image.file(profileImage);
    else
    return GestureDetector(child: Container(child: Image(image: pro), 
    height: 30.0,
    ),onTap:()=> getImage(),);
  }
  Widget showProgress(){
    if (flag)
    return CircularProgressIndicator(
      backgroundColor: Colors.white,
      // value: 0.5,
    );
    else
    return Icon(Icons.done);
  }
}