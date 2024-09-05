class Books {
  final String bookname;
  final String author;
  final String authorid;
  final String coverImage;
  final String bookdescription;
  final String bookcontent;
  final String bookcategory;

  Books(
      {this.bookname,
      this.bookdescription,
      this.author,
      this.coverImage,
      this.bookcontent,
      this.authorid,
      this.bookcategory});

  Map<String, dynamic> toBookMap() {
    return {
      'bookname': bookname,
      'author': author,
      'authorid': authorid,
      'coverImage': coverImage,
      'bookdescription': bookdescription,
      'bookcontent': bookcontent,
      'bookcategory': bookcategory
    };
  }
}
