class Users {
  final String fullname;
  final String email;
  final String password;


  Users({this.fullname, this.email, this.password});


  Map<String,dynamic>toMap(){
    return {
      'fullname':fullname,
      'email':email,
      'password':password};
  }
}
