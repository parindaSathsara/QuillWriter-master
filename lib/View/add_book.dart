import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quilwriterfinal/Presenter/main_presenter.dart';
import 'package:quilwriterfinal/Styles/colors.dart';
import 'package:quilwriterfinal/View/book_read.dart';
import 'package:quilwriterfinal/View/books_profile.dart';
import 'package:quilwriterfinal/View/message.dart';
import 'package:quilwriterfinal/View/writebook.dart';

class AddBook extends StatefulWidget {
  final String title;
  final String id;
  final String description;
  final String imgUrl;
  final bool isUpdate;
  final String author;
  final String authorid;
  final String bookcontent;
  final String bookcategory;

  AddBook(
      {this.title,
      this.id,
      this.imgUrl,
      this.description,
      this.isUpdate,
      this.author,
      this.bookcontent,
      this.authorid,
      this.bookcategory});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PickedFile _image;
  bool imageLoding = false;
  String imgUrl;
  Presenter mainPresenter = Presenter();
  String selectedCategory = "Emotional";

  final bookTitle = TextEditingController();
  final bookDescription = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookTitle.text = widget.title;
    bookDescription.text = widget.description;
    if (widget.isUpdate == true) {
      setState(() {
        imgUrl = widget.imgUrl;
        loadup = true;
        newreg = false;
        selectedCategory = widget.bookcategory;
      });
    }
  }

  double _scaleFactor = 1.0;
  double _baseScaleFactor = 1.0;

  bool newreg = true;
  bool loadup = false;

  final String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 25,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                              left: 35,
                              right: 35,
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
                                  Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        //this is a container that contain image
                                        //when user select image from Gallery or Camera

                                        Visibility(
                                          visible: newreg,
                                          child: Container(
                                            margin: EdgeInsets.only(top: 20),
                                            width: 150,
                                            height: 150,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              child: (_image != null)
                                                  ? Image.file(
                                                      File(_image.path),
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Icon(
                                                      Icons.image,
                                                      size: 150,
                                                      color: Colors.black54,
                                                    ),
                                            ),
                                          ),
                                        ),

                                        Visibility(
                                          visible: loadup,
                                          child: Container(
                                            margin: EdgeInsets.only(top: 20),
                                            width: 150,
                                            height: 150,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              child: (_image != null)
                                                  ? Image.file(
                                                      File(_image.path),
                                                      fit: BoxFit.cover,
                                                    )
                                                  : (widget.imgUrl != null)
                                                      ? Image.network(
                                                          widget.imgUrl,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Icon(
                                                          Icons.image,
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
                                            //this widget is used to get image from
                                            //Camera
                                            IconButton(
                                              icon: Icon(
                                                Icons.camera_alt,
                                                size: 30,
                                                color: brown,
                                              ),
                                              onPressed: () {
                                                uploadFromCamera();
                                              },
                                            ),
                                            //this widget is used to get image from
                                            //Gallery
                                            IconButton(
                                              icon: Icon(
                                                Icons.image,
                                                size: 28,
                                                color: brown,
                                              ),
                                              onPressed: () {
                                                uploadImage();
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  TextFormField(
                                    controller: bookTitle,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'Please enter book title';
                                      }
                                      return null;
                                    },
                                    textCapitalization: TextCapitalization.words,
                                    decoration: InputDecoration(
                                      labelText: "Title",
                                      labelStyle: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 14,
                                          color: Colors.grey.shade400),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  TextFormField(
                                    controller: bookDescription,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'Please enter book description';
                                      }
                                      return null;
                                    },
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    decoration: InputDecoration(
                                      labelText: "Description",
                                      labelStyle: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 14,
                                          color: Colors.grey.shade400),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  DropdownButtonFormField<String>(
                                    value: selectedCategory,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'Please select book category';
                                      }
                                      return null;
                                    },
                                    items: [
                                      "Emotional",
                                      "Love",
                                      "Funny",
                                      "Wishes",
                                      "Sympathy",
                                      "Other"
                                    ]
                                        .map((label) => DropdownMenuItem(
                                              child: Text(label),
                                              value: label,
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedCategory = value;
                                      });
                                      print(selectedCategory);
                                    },
                                    decoration: InputDecoration(
                                      labelText: "Category",
                                      labelStyle: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 14,
                                          color: Colors.grey.shade400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: newreg,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            width: 160.0,
                            height: 60.0,
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
                                    "Save Book",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: brown,
                                    ),
                                  )
                                ],
                              ),
                              onTap: () {
                                if (_formKey.currentState.validate()) {
                                  if (imgUrl != null) {
                                    mainPresenter.insertBooks(
                                        bookTitle.text,
                                        FirebaseAuth
                                            .instance.currentUser.displayName
                                            .toString(),
                                        FirebaseAuth.instance.currentUser.uid
                                            .toString(),
                                        imgUrl,
                                        bookDescription.text,
                                        selectedCategory,
                                        context);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Please upload book cover"),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: loadup,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                                width: 160.0,
                                height: 60.0,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.update,
                                        size: 30,
                                        color: brown,
                                      ),
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      Text(
                                        "Update",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: brown,
                                        ),
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    mainPresenter.updateBooks(
                                        widget.author,
                                        widget.authorid,
                                        widget.bookcontent,
                                        bookTitle.text,
                                        imgUrl,
                                        bookDescription.text,
                                        selectedCategory,
                                        widget.id,
                                        context);
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          CustomDialog(
                                        title: widget.title +
                                            " book updated successfully",
                                        description: "Book Updated Successfully",
                                        buttonText: "Okay",
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                                width: 160.0,
                                height: 60.0,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        size: 30,
                                        color: brown,
                                      ),
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      Text(
                                        "Delete",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: brown,
                                        ),
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    mainPresenter.deleteBooks(widget.id);

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
                                        title: widget.title +
                                            " book deleted successfully",
                                        description: "Book Deleted Successfully",
                                        buttonText: "Okay",
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

  uploadFromCamera() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;
    //Check Permissions
    //Select Image
    image = await _picker.getImage(source: ImageSource.camera);
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
