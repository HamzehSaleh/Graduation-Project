
class emoployeeModel {
  late String Identity;
  late String Name;
  late String Email;
  late String phoneNumber;
  late String jobTitle;
  late String id;

  emoployeeModel(this.Identity, this.Name, this.Email, this.phoneNumber,
      this.jobTitle, this.id);

  emoployeeModel.fromJson(Map<String, dynamic> map) {
    this.Identity = map['Identity'];
    this.Name = map['name'];
    this.Email = map['email'];
    this.phoneNumber = map['phoneNumber'];
    this.jobTitle = map['jobTitle'];
    this.id = map['_id'];
  }
}
