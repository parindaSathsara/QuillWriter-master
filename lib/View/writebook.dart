import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:quilwriterfinal/Models/database.dart';
import 'package:quilwriterfinal/Styles/colors.dart';
import 'package:quilwriterfinal/View/books_profile.dart';
import 'package:quilwriterfinal/View/message.dart';
import 'package:zefyr/zefyr.dart';

class BookWrite extends StatefulWidget {
  final String bookid;
  final String bookcontent;
  final String title;
  BookWrite({this.bookid, this.bookcontent,this.title});

  @override
  State<BookWrite> createState() => _BookWriteState();
}

class _BookWriteState extends State<BookWrite> {


  double _scaleFactor = 1.0;
  double _baseScaleFactor = 1.0;

  ZefyrController _controller;

  FocusNode _focusNode;
  final content=TextEditingController();
  final title=TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final document=_loadDocument();

    _controller=ZefyrController(document);
    _focusNode=FocusNode();

    content.text=widget.bookcontent;
  }


  NotusDocument _loadDocument(){

    if(widget.bookcontent=="") {
      final Delta delta = Delta()..insert("\n");
      return NotusDocument.fromDelta(delta);
    }
    else{
      print(widget.bookcontent);
      final Delta delta = Delta()..insert(widget.bookcontent.toString()+"\n"); //import quill_delta
      //return NotusDocument.fromDelta(delta);

      //return NotusDocument.fromJson(jsonDecode(_notes.content));
      return NotusDocument.fromJson(jsonDecode(widget.bookcontent));
    }
  }

  final String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

  Database db = Database();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffff8ee),
      body: Container(
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
                            onPressed: () => Navigator.pop(context),
                          ),

                          Flexible(
                            child: Text(
                              widget.title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                height: 1.5,
                                fontSize: 18.0
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
                                _scaleFactor = _baseScaleFactor * details.scale;
                              });
                            },
                              child: Column(
                                children: [
                                  ZefyrToolbar.basic(controller: _controller),
                                  ZefyrEditor(
                                    padding: EdgeInsets.all(16),
                                    controller: _controller,
                                    focusNode: _focusNode,
                            ),
                                ],
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
                            width: 130.0,
                            height: 50.0,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_box_rounded,
                                    size: 30,
                                    color: brown,
                                  ),
                                  SizedBox(
                                    width: 2.0,
                                  ),
                                  Text(
                                    "Update Book",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: brown,
                                    ),
                                  )
                                ],
                              ),
                              onTap: () {
                                db.updateBookContent(jsonEncode(_controller.document),widget.bookid);
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
                                  builder: (BuildContext context) => CustomDialog(
                                    title: widget.title + " book content updated successfully",
                                    description: "Book Content Updated Successfully",
                                    buttonText: "Okay",
                                  ),
                                );
                              },
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
    );
  }
}
