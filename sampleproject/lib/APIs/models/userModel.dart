class userModel {
  late String Identity;
  late String Name;
  late String Email;
  late String phoneNumber;
  late String sub_Number;
  late String password;
  late String id;
  late List arr;

  userModel(this.Identity, this.Name, this.Email, this.phoneNumber,
      this.sub_Number, this.id);

  userModel.fromJson(Map<String, dynamic> map) {
    this.Identity = map['Identity'];
    this.Name = map['name'];
    this.Email = map['email'];
    this.phoneNumber = map['phoneNumber'];
    this.sub_Number = map['sub_Number'];
    this.id = map['_id'];
    this.password = map['password'];
    this.arr = map['cunsump'];
  }

  void setName(String name) {
    this.Name = name;
  }

  String getName() {
    return this.Name;
  }
}
