import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:quilwriterfinal/Presenter/main_presenter.dart';
import 'package:quilwriterfinal/View/mainscreen.dart';
import 'package:zefyr/zefyr.dart';

class BookRead extends StatefulWidget {
  final String title;
  final String author;
  final String content;
  final String imgUrl;
  final String bookid;
  BookRead({this.title, this.author, this.imgUrl, this.content,this.bookid});

  @override
  State<BookRead> createState() => _BookReadState();
}

class _BookReadState extends State<BookRead> {
  double _scaleFactor = 1.0;
  double _baseScaleFactor = 1.0;


  ZefyrController _controller;

  Presenter mainPresenter=Presenter();

  FocusNode _focusNode;
  final content=TextEditingController();
  final title=TextEditingController();

  bool isFavourite=false;

  bool connectioncheck;
  void checkConnection() async{
    connectioncheck=await mainPresenter.hasNetwork();
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnection();
    final document=_loadDocument();

    _controller=ZefyrController(document);
    _focusNode=FocusNode();
    content.text=widget.content;
  }


  NotusDocument _loadDocument(){

    if(widget.content=="") {
      final Delta delta = Delta()..insert("\n");
      return NotusDocument.fromDelta(delta);
    }
    else{
      print(widget.content);
      final Delta delta = Delta()..insert(widget.content.toString()+"\n"); //import quill_delta
      //return NotusDocument.fromDelta(delta);

      //return NotusDocument.fromJson(jsonDecode(_notes.content));
      return NotusDocument.fromJson(jsonDecode(widget.content));
    }
  }


  @override
  Widget build(BuildContext context) {
    var getScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xfffff8ee),
      body: CarouselSlider(
        options: CarouselOptions(
            height: getScreenHeight,
            enableInfiniteScroll: false,
            viewportFraction: 1.0),
        items: [
          Container(
            child: FittedBox(
              fit: BoxFit.fill,
              child: (connectioncheck == true)
                  ? Image.network(
                widget.imgUrl,
              )
                  : Image(
                image: AssetImage(
                    "assets/images/offlinecover.png"
                ),
              )
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Image(
                  image: AssetImage("assets/images/quill.png"),
                  height: 200.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Writer - "+widget.author,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ],
            ),
          ),


          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                SafeArea(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                  size: 25,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return MainBookScreen();
                                      },
                                    ),
                                  );
                                },
                              ),
                              Flexible(
                                child: Center(
                                  child: Text(
                                    widget.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        height: 1.5,
                                        fontSize: 18.0
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                left: 35,
                                right: 30,
                              ),
                              child: GestureDetector(
                                onScaleStart: (details) {
                                  _baseScaleFactor = _scaleFactor;
                                },
                                onScaleUpdate: (details) {
                                  setState(() {
                                    _scaleFactor =
                                        _baseScaleFactor * details.scale;
                                  });
                                },
                                child: ZefyrEditor(
                                  readOnly: true,
                                  padding: EdgeInsets.all(16),
                                  controller: _controller,
                                  focusNode: _focusNode,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10.0),

                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.menu_book,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      widget.author,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
Icon favBook(IconData iconData) {
  return Icon(
    iconData,
    size: 26.0,
    color: Colors.black,
  );
}

