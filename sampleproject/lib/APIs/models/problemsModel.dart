class ProblemsModel {
  late String name;
  late String desc;
  late String type;
  late String photo;
  late String status;
  late String owner;
  late String ownerName;
  late String date;
  late String id;
  late double lat;
  late double long;

  ProblemsModel(this.name, this.desc, this.type, this.photo, this.status,
      this.owner, this.lat, this.long, this.date, this.id);

  ProblemsModel.fromJson(Map<String, dynamic> map) {
    this.name = map['name'];
    this.ownerName = map['ownerName'];
    this.desc = map['description'];
    this.type = map['problem_type'];
    this.photo = map['photo'];
    this.status = map['problem_status'];
    // this.owner = map['owner'];
    this.date = map['problem_date'];
    this.id = map['_id'];
    this.lat = map['lat'];
    this.long = map['long'];
  }
}
