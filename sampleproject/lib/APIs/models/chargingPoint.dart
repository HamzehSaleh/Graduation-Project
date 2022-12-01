class chargingPointModel {
  late String name;
  late String lat;
  late String long;
  late String open;
  late String close;
  late String days;
  late String id;

  chargingPointModel(this.name, this.lat, this.long, this.open, this.close,
      this.days, this.id);

  chargingPointModel.fromJson(Map<String, dynamic> map) {
    this.name = map['name'];
    this.lat = map['lat'];
    this.long = map['long'];
    this.open = map['openingTime'];
    this.close = map['closingTime'];
    this.days = map['days'];
    this.id = map['_id'];
  }
}
