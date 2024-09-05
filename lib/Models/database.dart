import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quilwriterfinal/Models/books.dart';
import 'package:quilwriterfinal/Models/favourite.dart';
import 'package:quilwriterfinal/Models/user.dart';
import 'package:quilwriterfinal/View/message.dart';
import 'package:quilwriterfinal/View/writebook.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

class Database {


  Future<void> addUser(Users users, String userid) async {
    print(users.toMap());

    var userdata = users.toMap();

    _firestore.collection('users').doc(userid).set(userdata);
  }

  Future<void> addBook(Books books, context) async {
    var bookdata = books.toBookMap();

    DocumentReference docRef =
        await _firestore.collection('books').add(bookdata);
    print("Document id is " + docRef.id);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return BookWrite(
              bookid: docRef.id, bookcontent: "", title: books.bookname);
        },
      ),
    );



    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: books.bookname + " book added successfully",
        description: "Book Added Successfully",
        buttonText: "Okay",
      ),
    );
  }

  Future<void> updateBookContent(content, String docid) async {
    _firestore.collection('books').doc(docid).update({'bookcontent': content});
  }

  Future<void> favourite(Favourite favourite) async {
    var fav = favourite.toFavouriteMap();

    var collection = FirebaseFirestore.instance.collection('favourite');
    collection.add(fav);
  }

  Future<void> updateBook(Books books, String docid, context) async {
    var bookdata = books.toBookMap();
    _firestore.collection('books').doc(docid).update(bookdata);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return BookWrite(
              bookid: docid,
              bookcontent: books.bookcontent,
              title: books.bookname);
        },
      ),
    );
  }

  Future<void> updateUser(Users users, String docid) async {
    var userdata = users.toMap();
    _firestore.collection('users').doc(docid).update(userdata);

    await auth.currentUser.updateDisplayName(users.fullname);
    await auth.currentUser.updateEmail(users.email);
    await auth.currentUser.updatePassword(users.password);
  }



  Future<void> deleteBook(String docid) async {
    _firestore.collection('books').doc(docid).delete();
  }



}
