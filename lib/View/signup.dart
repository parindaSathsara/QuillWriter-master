import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quilwriterfinal/Presenter/main_presenter.dart';
import 'package:quilwriterfinal/Styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:quilwriterfinal/View/books_profile.dart';
import 'package:quilwriterfinal/View/login.dart';
import 'package:quilwriterfinal/View/mainscreen.dart';
import 'package:quilwriterfinal/View/message.dart';

class SignupPage extends StatefulWidget {

  final bool userUpdate;



  SignupPage({this.userUpdate});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  PickedFile _image;
  bool imageLoding = false;
  String imgUrl;
  Presenter mainPresenter=Presenter();
  String userid;

  final fullname = TextEditingController();

  final email = TextEditingController();

  final password = TextEditingController();

  FirebaseAuth auth=FirebaseAuth.instance;
  bool newreg=true;
  bool loadup=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.userUpdate==true){
      loadup=true;
      newreg=false;
      imgUrl = auth.currentUser.photoURL;
      fullname.text=auth.currentUser.displayName;
      email.text=auth.currentUser.email;
    }
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Create Account,",
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Sign up to get started!",
                        style: TextStyle(fontSize: 20, color: Colors.grey.shade400),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[

                      Visibility(
                        visible: newreg,
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          width: 150,
                          height: 150,
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.circular(150),
                            child: (_image != null)
                                ? Image.file(
                              File(_image.path),
                              fit: BoxFit.cover,
                            )
                                : Icon(
                              Icons.image,
                              size: 150,
                            ),
                          ),
                        ),
                      ),


                      Visibility(
                        visible: loadup,
                        child:Container(
                          margin: EdgeInsets.only(top: 20),
                          width: 150,
                          height: 150,
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.circular(150),
                            child:(_image != null)
                                ? Image.file(
                              File(_image.path),
                              fit: BoxFit.cover,
                            )
                                : (imgUrl != null)
                                ? Image.network(
                              imgUrl,
                              fit: BoxFit.cover,
                            ) : Icon(
                              Icons.camera_alt_outlined,
                              size: 150,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        //this is used to provide space between icons
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [

                          IconButton(
                            icon: Icon(
                              Icons.image_search,
                              size: 28,
                              color: brown,
                            ),
                            onPressed: () {
                              uploadImage();
                            },
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 40.0,
                      ),

                      TextFormField(
                        controller: fullname,
                        textCapitalization: TextCapitalization.words,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          labelStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w600),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: greenLight),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: email,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Email ID",
                          labelStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w600),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: greenLight),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: password,
                        obscureText: true,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w600),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: greenLight),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      Visibility(
                        visible: loadup,
                        child: Container(
                          height: 50,
                          child: FlatButton(
                            onPressed: () async {
                              print(imgUrl);

                              if(imgUrl!=null){
                                if (_formKey.currentState.validate()) {
                                  mainPresenter.update(fullname.text,email.text,password.text,imgUrl,context);
                                  mainPresenter.updateUser(fullname.text, email.text, password.text, _auth.currentUser.uid);
                                }
                              }
                              else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Please upload profile image"),
                                  backgroundColor: Colors.red,
                                ));
                              }



                            },
                            padding: EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    greenAccent,
                                    greenYellow,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                constraints: BoxConstraints(
                                    minHeight: 50, maxWidth: double.infinity),
                                child: Text(
                                  "Update User",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Visibility(
                        visible: newreg,
                        child: Container(
                          height: 50,
                          child: FlatButton(
                            onPressed: () async {

                              if (_formKey.currentState.validate()) {
                                _register();
                              }
                            },
                            padding: EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    greenAccent,
                                    greenYellow,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                constraints: BoxConstraints(
                                    minHeight: 50, maxWidth: double.infinity),
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                  Visibility(
                    visible: newreg,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "I'm already a member.",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              " Sign in.",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: greenLight),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _register() async {
    User user;
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      user = userCredential.user;
      await user.updateProfile(displayName: fullname.text,photoURL: imgUrl);
      await user.reload();
      user = _auth.currentUser;
      print(user.uid);
      mainPresenter.insertUser(email.text, fullname.text, password.text,user.uid);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginPage();
          },
        ),
      );

    } on FirebaseAuthException catch (e) {

      String error=e.toString();
      if (e.code == 'weak-password') {
        error="The password provided is too weak";
      } else if (e.code == 'email-already-in-use') {
        error="The account already exists for that email";
      }
      else if(e.code == 'invalid-email'){
        error="The email provided is invalid. Please enter valid email & try again.";
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error),
        backgroundColor: Colors.red,
      ));

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }

  }






  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;
    //Check Permissions
    //Select Image
    image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      image != null ? imageLoding = true : imageLoding = false;
    });
    var file = File(image.path);
    //Upload to Firebase
    var imagename = Random().nextInt(10000).toString();
    var snapshot =
    await _storage.ref().child('folderName/$imagename').putFile(file);
    var downloadUrl = await snapshot.ref.getDownloadURL();
    //print(downloadUrl);
    setState(() {
      imgUrl = downloadUrl;
      imageLoding = false;
      _image = image;
    });
  }

}


