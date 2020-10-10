import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'formPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'imagePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _myActivity;
  String _myActivityResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        //_myActivityResult = _myActivity;
        print(_myActivityResult);
        print(_myActivity);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context)=> SecondPage(collect: _myActivity))
        // );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => addImage(collect: _myActivity)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 20.0,
        title: Text(
          'Register Yourself',
          style: GoogleFonts.robotoCondensed(color: Colors.black),
        ),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                child: DropDownFormField(
                  titleText: 'Your  Designation',
                  hintText: 'Please choose one',
                  value: _myActivity,
                  onSaved: (value) {
                    setState(() {
                      _myActivity = value;
                      _myActivityResult = 'You are ' + _myActivity;

                      // _saveForm();
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _myActivity = value;
                      _myActivityResult = 'You are ' + _myActivity;
                      // _saveForm();
                    });
                  },
                  dataSource: [
                    {
                      "display": "Head",
                      "value": "Head",
                    },
                    {
                      "display": "Core Team Member",
                      "value": "Core Team Member",
                    },
                    {
                      "display": "Senior Team Member",
                      "value": "Senior Team Member",
                    },
                    {
                      "display": "Junior Team Member",
                      "value": "Junior Team Member",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(_myActivityResult),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: FloatingActionButton.extended(
                  label: Text(
                    'Next',
                    style: GoogleFonts.robotoCondensed(
                        color: Colors.white, fontSize: 20.0),
                  ),
                  onPressed: _saveForm,
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
