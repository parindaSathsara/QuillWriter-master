import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quilwriterfinal/Models/books.dart';
import 'package:quilwriterfinal/Models/database.dart';
import 'package:quilwriterfinal/Models/favourite.dart';
import 'package:quilwriterfinal/Models/user.dart';
import 'package:quilwriterfinal/View/books_profile.dart';
import 'package:quilwriterfinal/View/login.dart';
import 'package:quilwriterfinal/View/mainscreen.dart';
import 'package:quilwriterfinal/View/message.dart';

class Presenter {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Database _database = Database();

  Future<void> insertUser(
      String email, String fullname, String password, String userid) async {
    Users _newUser =
        Users(email: email, fullname: fullname, password: password);

    await _database.addUser(_newUser, userid);
  }

  Future<void> insertBooks(
      String bookname,
      String author,
      String authorid,
      String coverImage,
      String bookdescription,
      String bookcategory,
      context) async {
    Books _newBook = Books(
      bookname: bookname,
      author: author,
      authorid: authorid,
      coverImage: coverImage,
      bookdescription: bookdescription,
      bookcontent: "",
      bookcategory: bookcategory,
    );

    await _database.addBook(_newBook, context);
  }

  Future<void> updateBooks(
      String author,
      String authorid,
      String bookcontent,
      String bookname,
      String coverImage,
      String bookdescription,
      String bookcategory,
      String docid,
      context) async {
    Books _updateBook = Books(
        bookname: bookname,
        bookdescription: bookdescription,
        coverImage: coverImage,
        author: author,
        authorid: authorid,
        bookcontent: bookcontent,
        bookcategory: bookcategory);

    await _database.updateBook(_updateBook, docid, context);
  }

  Future<void> updateUser(String fullname, String email, String password,String docid) async {
    Users _updateBook = Users(
      fullname: fullname,
      email: email,
      password: password,
    );

    await _database.updateUser(_updateBook, docid);
  }

  Future<void>addFavourite(String bookid, String userid) async{
    Favourite fav=Favourite(
      bookid: bookid,
      userid: userid
    );


    await _database.favourite(fav);
  }

  Future<void> deleteBooks(String docid) async {
    await _database.deleteBook(docid);
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  void login (String email,String password,context) async {
    try{
      final user= await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MainBookScreen();
            },
          ),
        );
      }
    }
    on FirebaseAuthException catch (e){

      String error="Error while login. Please try again.";
      if(e.code.toString()=="invalid-email"){
        error="Please enter a valid email address";
      }
      else if(e.code.toString()=="user-not-found"){
        error="The email you entered is incorrect. Please try again.";
      }
      else if(e.code.toString()=="wrong-password"){
        error="The password you entered is incorrect. Please try again.";
      }


      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error),
        backgroundColor: Colors.red,
      ));
      print(e.code.toString());
    }
  }


  void update(String fullname,String email,String password,String imgUrl,context) async {
    try {
      await _auth.currentUser.updateDisplayName(fullname);
      await _auth.currentUser.updateEmail(email);
      await _auth.currentUser.updatePassword(password);
      await _auth.currentUser.updatePhotoURL(imgUrl);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BooksProfile();
          },
        ),
      );
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            CustomDialog(
              title: "User updated successfully",
              description: "User updated Successfully",
              buttonText: "Okay",
            ),
      );
    }
    on FirebaseAuthException catch(e){

      print(e.code.toString());

      if(e.code.toString()=="requires-recent-login"){

        _auth.signOut();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LoginPage();
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please login again & try to update profile"),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

}
