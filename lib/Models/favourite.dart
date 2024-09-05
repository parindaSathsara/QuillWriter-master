class Favourite {
  final String userid;
  final String bookid;

  Favourite({this.userid, this.bookid});


  Map<String, dynamic> toFavouriteMap() {
    return {
      'userid': userid,
      'bookid': bookid,
    };
  }
}
