import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quilwriterfinal/Presenter/main_presenter.dart';
import 'package:quilwriterfinal/View/add_book.dart';
import 'package:quilwriterfinal/View/book_read.dart';
import 'package:quilwriterfinal/View/books_profile.dart';

import 'package:quilwriterfinal/View/signup.dart';
import 'package:quilwriterfinal/Styles/colors.dart';
import 'package:quilwriterfinal/View/splashscreen.dart';

class MainBookScreen extends StatefulWidget {
  static String id = "User";

  const MainBookScreen({Key key}) : super(key: key);

  @override
  _MainBookScreenState createState() => _MainBookScreenState();
}

class _MainBookScreenState extends State<MainBookScreen> {



  FirebaseFirestore _db = FirebaseFirestore.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String name;
  String category;

  bool check = true;
  bool sort = false;



  Widget space = MainBookScreen();

  Presenter _presenter=Presenter();

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, SplashScreen.id);
  }
  bool connectioncheck;
  void checkConnection() async{
    connectioncheck=await _presenter.hasNetwork();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnection();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Color(0xfffff8ee),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50.0),
              child: Image(
                width: 220.0,
                height: 220.0,
                image: AssetImage('assets/images/Logo.png'),
              ),
            ),
            ListTile(
              leading: Image(
                image: AssetImage('assets/images/emotionalicon.png'),
                width: 25.0,
                color: Colors.black45,
              ),
              title: Text("Emotional"),
              selectedTileColor: Colors.black54,
              onTap: () {
                Navigator.pop(context);
                setState(
                  () {
                    category = "Emotional";
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite_border_outlined),
              title: Text("Love"),
              onTap: () {
                Navigator.pop(context);

                setState(
                  () {
                    category = "Love";
                  },
                );
              },
            ),
            ListTile(
              leading: Image(
                image: AssetImage('assets/images/comedy.png'),
                width: 25.0,
                color: Colors.black45,
              ),
              title: Text("Funny"),
              onTap: () {
                Navigator.pop(context);

                setState(
                  () {
                    category = "Funny";
                  },
                );
              },
            ),
            ListTile(
              leading: Image(
                image: AssetImage('assets/images/wishes.png'),
                width: 25.0,
                color: Colors.black45,
              ),
              title: Text("Wishes"),
              onTap: () {
                Navigator.pop(context);

                setState(
                  () {
                    category = "Wishes";
                  },
                );
              },
            ),
            ListTile(
              leading: Image(
                image: AssetImage('assets/images/sympathy.png'),
                width: 25.0,
                color: Colors.black45,
              ),
              title: Text("Sympathy"),
              onTap: () {
                Navigator.pop(context);

                setState(
                  () {
                    category = "Sympathy";
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.animation),
              title: Text("Other"),
              onTap: () {
                Navigator.pop(context);

                setState(
                  () {
                    category = "Other";
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.menu_book),
              title: Text("All Books"),
              onTap: () {
                Navigator.pop(context);

                setState(
                  () {
                    category = "";
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/header.jpg"),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.greenAccent),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 30,
                right: 30,
                top: 50,
                bottom: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 25,
                    ),
                    onPressed: () => _scaffoldKey.currentState.openDrawer(),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 25,
                    ),
                    onPressed: () {
                      logout();
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.account_circle_sharp,
                      color: Colors.white,
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return BooksProfile();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 40.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.93,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.83,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xfffff8ee),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 30.0,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Hello ",
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          FirebaseAuth
                                              .instance.currentUser.displayName
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      width: 100,
                                      height: 7,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: greenLight,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.0,
                                    ),
                                    Container(
                                      child: TextField(
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        onChanged: (value) {
                                          setState(() {
                                            name = value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Search...',
                                          labelText: 'Search',
                                          prefixIcon: Icon(Icons.search),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Discover Books",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: StreamBuilder(
                                    stream: (name != "" && name != null)
                                        ? _db
                                            .collection('books')
                                            .where('bookname',
                                                isGreaterThanOrEqualTo: name)
                                            .where('bookname',
                                                isLessThan: name + 'z')
                                            .snapshots()
                                        : ((name != "" && name != null) &&
                                                (category != "" &&
                                                    category != null))
                                            ? _db
                                                .collection('books')
                                                .where('bookname',
                                                    isGreaterThanOrEqualTo:
                                                        name)
                                                .where('bookname',
                                                    isLessThan: name + 'z')
                                                .where('bookcategory',
                                                    isGreaterThanOrEqualTo:
                                                        category)
                                                .where('bookcategory',
                                                    isLessThan: category + 'z')
                                                .snapshots()
                                            : (category != "" &&
                                                    category != null)
                                                ? _db
                                                    .collection('books')
                                                    .where('bookcategory',
                                                        isGreaterThanOrEqualTo:
                                                            category)
                                                    .where('bookcategory',
                                                        isLessThan:
                                                            category + 'z')
                                                    .snapshots()
                                                : _db
                                                    .collection("books")
                                                    .orderBy('bookname',
                                                        descending: sort)
                                                    .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.data == null) {
                                        return SpinKitThreeBounce(
                                          size: 20.0,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return DecoratedBox(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: index.isEven
                                                    ? Color(0XFF5e9b43)
                                                    : Color(0XFFe4a61f),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                      return ListView.builder(
                                        itemCount: snapshot.data.docs.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          //print(snapshot.data.docs.elementAt(index).id);
                                          //var row = index + 1;
                                          String title = snapshot.data.docs
                                              .elementAt(index)['bookname'];
                                          String author = snapshot.data.docs
                                              .elementAt(index)['author'];
                                          String imageUrl = snapshot.data.docs
                                              .elementAt(index)['coverImage'];
                                          String content = snapshot.data.docs
                                              .elementAt(index)['bookcontent'];

                                          String id = snapshot.data.docs
                                              .elementAt(index)
                                              .id;

                                          return Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      top: 10,
                                                      left: 5,
                                                    ),
                                                    height: 140,
                                                    width: 100,
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            boxShadow: <
                                                                BoxShadow>[
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.2),
                                                                blurRadius: 5,
                                                                offset: Offset(
                                                                    2, 3),
                                                                spreadRadius: 1,
                                                              )
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child: (connectioncheck == true)
                                                                ? Image.network(
                                                              imageUrl,
                                                              fit: BoxFit.cover,
                                                              height: 140.0,
                                                            )
                                                                : Image(
                                                              image: AssetImage(
                                                                "assets/images/bookico.png"
                                                              ),
                                                              height: 140.0,
                                                              fit: BoxFit.cover,
                                                            )

                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 20.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                title,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 2,
                                                              ),
                                                              Text(
                                                                author,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        Material(
                                                          color: Colors
                                                              .transparent,
                                                          child: InkWell(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                            onTap: () =>
                                                                Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        BookRead(
                                                                  title: title,
                                                                  imgUrl:
                                                                      imageUrl,
                                                                  author:
                                                                      author,
                                                                  content:
                                                                      content,
                                                                  bookid: id,
                                                                ),
                                                              ),
                                                            ),
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          10.0,
                                                                      horizontal:
                                                                          5.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .book_outlined,
                                                                    color:
                                                                        greenLight,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                10.0),
                                                                    child: Text(
                                                                        "Read",
                                                                        style: TextStyle(
                                                                            color:
                                                                                greenLight,
                                                                            fontWeight:
                                                                                FontWeight.w600)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget BookFetch(String hidden) {
  return Container(
    child: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/"),
      )),
    ),
  );
}


