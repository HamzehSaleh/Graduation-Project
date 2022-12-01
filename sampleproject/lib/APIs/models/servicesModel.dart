class ServicesModel {
  late String name;
  late List photos;
  late String service_status;
  late String ownerName;
  late String owner;
  late String service_date;
  late String id;
  late double lat;
  late double long;

  ServicesModel(this.name, this.photos, this.service_status, this.owner,
      this.lat, this.long, this.service_date, this.id);

  ServicesModel.fromJson(Map<String, dynamic> map) {
    this.name = map['name'];
    this.ownerName = map['ownerName'];
    this.photos = map['photos'];
    this.service_status = map['service_status'];
    // this.owner = map['owner'];
    this.service_date = map['service_date'];
    this.id = map['_id'];
    this.lat = map['lat'];
    this.long = map['long'];
  }
}
