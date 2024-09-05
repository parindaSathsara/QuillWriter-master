import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quilwriterfinal/Models/database.dart';
import 'package:quilwriterfinal/Presenter/main_presenter.dart';
import 'package:quilwriterfinal/View/add_book.dart';
import 'package:quilwriterfinal/View/book_read.dart';
import 'package:quilwriterfinal/View/mainscreen.dart';
import 'package:quilwriterfinal/View/signup.dart';
import 'package:quilwriterfinal/Styles/colors.dart';
import 'package:quilwriterfinal/View/writebook.dart';

class BooksProfile extends StatefulWidget {
  @override
  State<BooksProfile> createState() => _BooksProfileState();
}

class _BooksProfileState extends State<BooksProfile> {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  Database db = Database();
  Presenter _presenter = Presenter();

  String name;
  bool check = true;
  bool sort = false;

  bool connectioncheck = true;

  void checkConnection() async {
    connectioncheck = await _presenter.hasNetwork();
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
      body: Stack(
        children: [
          Positioned(
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/header.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
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
                    Icons.arrow_back_ios_sharp,
                    color: Colors.white,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainBookScreen(),
                      ),
                    );
                  },
                ),
                Visibility(
                  visible: connectioncheck,
                  child: IconButton(
                    icon: Icon(
                      Icons.post_add,
                      color: Colors.white,
                      size: 25,
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddBook(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 60.0),
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
                          top: MediaQuery.of(context).size.height * 0.1,
                          left: 20,
                          right: 20,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text(
                                FirebaseAuth.instance.currentUser.displayName,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: connectioncheck,
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SignupPage(userUpdate: true),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      color: greenLight,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Text("Edit Profile",
                                          style: TextStyle(
                                              color: greenLight,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            /*
                            Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                top: 10,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "TOTAL READS",
                                        style: kTitleStyle,
                                      ),
                                      Text(
                                        "FAVOURITES",
                                        style: kTitleStyle,
                                      ),
                                      Text(
                                        "REVIEWS",
                                        style: kTitleStyle,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "127",
                                        style: kSubtitleStyle,
                                      ),
                                      Text(
                                        "83",
                                        style: kSubtitleStyle,
                                      ),
                                      Text(
                                        "47",
                                        style: kSubtitleStyle,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                             */
                            SizedBox(
                              height: 40.0,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                "My Books",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: 10,
                                  left: 20,
                                  right: 20,
                                ),
                                alignment: Alignment.bottomCenter,
                                child: StreamBuilder(
                                  stream: _db
                                      .collection('books')
                                      .orderBy('authorid', descending: sort)
                                      .where('authorid',
                                          isGreaterThanOrEqualTo: FirebaseAuth
                                              .instance.currentUser.uid
                                              .toString())
                                      .where('authorid',
                                          isLessThan: FirebaseAuth
                                                  .instance.currentUser.uid
                                                  .toString() +
                                              'z')
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.data == null)
                                      return CircularProgressIndicator();
                                    return ListView.builder(
                                        itemCount: snapshot.data.docs.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          String title = snapshot.data.docs
                                              .elementAt(index)['bookname'];
                                          String author = snapshot.data.docs
                                              .elementAt(index)['author'];
                                          String authorid = snapshot.data.docs
                                              .elementAt(index)['authorid'];
                                          String content = snapshot.data.docs
                                              .elementAt(index)['bookcontent'];
                                          String description =
                                              snapshot.data.docs.elementAt(
                                                  index)['bookdescription'];
                                          String imageUrl = snapshot.data.docs
                                              .elementAt(index)['coverImage'];
                                          String bookcategory = snapshot
                                              .data.docs
                                              .elementAt(index)['bookcategory'];
                                          String id = snapshot.data.docs
                                              .elementAt(index)
                                              .id;

                                          return GestureDetector(
                                            onTap: () {

                                              if(connectioncheck==true){
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => AddBook(
                                                      id: id,
                                                      title: title,
                                                      description: description,
                                                      imgUrl: imageUrl,
                                                      isUpdate: true,
                                                      authorid: authorid,
                                                      author: author,
                                                      bookcontent: content,
                                                      bookcategory: bookcategory,
                                                    ),
                                                  ),
                                                );
                                              }
                                              else{
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
                                                );
                                              }

                                            },
                                            child: Row(
                                              children: [
                                                Column(
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
                                                                  offset:
                                                                      Offset(
                                                                          2, 3),
                                                                  spreadRadius:
                                                                      1,
                                                                )
                                                              ],
                                                            ),
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                child: (connectioncheck ==
                                                                        true)
                                                                    ? Image
                                                                        .network(
                                                                        imageUrl,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        height:
                                                                            140.0,
                                                                      )
                                                                    : Image(
                                                                        image: AssetImage(
                                                                            "assets/images/bookico.png"),
                                                                        height:
                                                                            140.0,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 16),
                                                    Text(
                                                      title,
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      author,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 140,
                      width: 140,
                      padding: EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: (connectioncheck == true)
                            ? Image.network(
                                FirebaseAuth.instance.currentUser.photoURL,
                                fit: BoxFit.cover,
                                height: 140.0,
                              )
                            : Image(
                                image: AssetImage(
                                  "assets/images/blankprofile.png",
                                ),
                                height: 140.0,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final kTitleStyle = TextStyle(
  fontSize: 14,
  color: Colors.grey,
  fontWeight: FontWeight.w700,
);

final kSubtitleStyle = TextStyle(
  fontSize: 18,
  color: Colors.black,
  fontWeight: FontWeight.w700,
);

class CardAction {
  static const String Edit = 'Edit';
  static const String Delete = 'Delete';

  static const List<String> choice = <String>[Edit, Delete];
}
