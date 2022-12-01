class RatingModel {
  late int index;
  late String note;
  late String id;

  RatingModel(this.index, this.note, this.id);
  RatingModel.fromJson(Map<String, dynamic> map) {
    this.index = map['index'];
    this.note = map['note'];
    this.id = map['_id'];
  }
}
