import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sampleproject/APIs/models/RatingModel.dart';
import 'package:sampleproject/APIs/models/chargingPoint.dart';
import 'package:sampleproject/APIs/models/employeeModel.dart';
import 'package:sampleproject/APIs/models/problemsModel.dart';
import 'package:sampleproject/APIs/models/servicesModel.dart';
import 'package:sampleproject/main.dart';
import "package:sampleproject/APIs/models/userModel.dart";

class FetchData {
  static const String baseURL = "http://192.168.1.9:3080";
  static const String myAccount = "/users/me";
  static const String usersLogin = "/users/login";
  static const String employeeLogin = "/employees/login";
  static const String adminLogin = "/admin/login";
  static const String users = "/users";
  static const String employees = "/employees";
  static const String chargingPoints = "/chargingPoint";

  var header = {"Authorization": "Bearer " + prefs.get("token").toString()};

  Future<userModel> fetchMyAccount() async {
    var res = await http.get(Uri.parse(baseURL + "/users/me"), headers: header);
    var body = jsonDecode(res.body);
    userModel myAccount = userModel.fromJson(body);
    return myAccount;
  }

  Future<emoployeeModel> fetchEmployeeAccount() async {
    var res = await http.get(Uri.parse(baseURL + "/employees/me"), headers: {
      "Authorization": "Bearer " + prefs.get("token").toString(),
      'Content-Type': 'application/json; charset=UTF-8'
    });
    var body = jsonDecode(res.body);
    emoployeeModel myAccount = emoployeeModel.fromJson(body);

    return myAccount;
  }

  Future<List<ProblemsModel>> fetchMyProblems() async {
    var res = await http.get(Uri.parse(baseURL + "/problems"), headers: header);
    var body = jsonDecode(res.body) as List<dynamic>;

    return body.map((user) => ProblemsModel.fromJson(user)).toList();
  }

  Future<ProblemsModel> findProblemById(id) async {
    var url = baseURL + "/problems/" + id.toString();
    var res = await http.get(Uri.parse(url), headers: {
      "Authorization": "Bearer " + prefs.get("token").toString(),
      'Content-Type': 'application/json; charset=UTF-8'
    });
    var body = jsonDecode(res.body);
    print(body);
    return ProblemsModel.fromJson(body);
  }

  Future<String> findUserById(Id) async {
    var url = baseURL + "/users/" + Id.toString();
    var res = await http.get(Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=UTF-8'});

    var body = jsonDecode(res.body);
    userModel data = userModel.fromJson(body);
    return data.Name;
  }

  Future<ProblemsModel> adminProblemId(id) async {
    var url = baseURL + "/adminProblemId/" + id.toString();
    var res = await http.get(Uri.parse(url));
    var body = jsonDecode(res.body);
    // print(body);
    return ProblemsModel.fromJson(body);
  }

  Future<List<ProblemsModel>> AllProblems() async {
    var res = await http.get(Uri.parse(baseURL + "/allproblems"));
    var body = jsonDecode(res.body) as List<dynamic>;
    return body.map((problem) => ProblemsModel.fromJson(problem)).toList();
  }

  Future<List<ServicesModel>> AllServices() async {
    var res = await http.get(Uri.parse(baseURL + "/allServices"));
    var body = jsonDecode(res.body) as List<dynamic>;
    print(body);
    return body.map((problem) => ServicesModel.fromJson(problem)).toList();
  }

  Future<ServicesModel> adminServiceId(id) async {
    var url = baseURL + "/adminServiceId/" + id.toString();
    var res = await http.get(Uri.parse(url));
    var body = jsonDecode(res.body);
    // print(body);
    return ServicesModel.fromJson(body);
  }

  Future<List<userModel>> allUsers() async {
    var res = await http.get(Uri.parse(baseURL + users));
    var body = jsonDecode(res.body) as List<dynamic>;

    return body.map((user) => userModel.fromJson(user)).toList();
  }

  Future<List<emoployeeModel>> allEmployees() async {
    var res = await http.get(Uri.parse(baseURL + employees));
    var body = jsonDecode(res.body) as List<dynamic>;

    return body.map((employee) => emoployeeModel.fromJson(employee)).toList();
  }

  Future<List<RatingModel>> allRatings() async {
    var res = await http.get(Uri.parse(baseURL + "/rating"));
    var body = jsonDecode(res.body) as List<dynamic>;

    return body.map((rate) => RatingModel.fromJson(rate)).toList();
  }

  Future<List<chargingPointModel>> allChargingPoints() async {
    var res = await http.get(Uri.parse(baseURL + chargingPoints));
    var body = jsonDecode(res.body) as List<dynamic>;

    return body.map((point) => chargingPointModel.fromJson(point)).toList();
  }

  Future<chargingPointModel> pointLat(lat) async {
    print("22222222222222222222  ->>>> " + lat.toString());
    var res =
        await http.get(Uri.parse(baseURL + "/chargingPoint/" + lat.toString()));
    var body = jsonDecode(res.body);
    print("7777777777777777777777");
    print(body);
    return chargingPointModel.fromJson(body);
  }

  // Future<List> PointsName(List p) async {
  //   var res = await http.get(Uri.parse(baseURL + chargingPoints));
  //   var body = jsonDecode(res.body) as List<dynamic>;

  //   var temp = body.map((point) => chargingPointModel.fromJson(point)).toList();
  //   p.add(temp.map((item) => (item.name)));
  //   print( "]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]" + p[0].toString());
  //   return p;
  // }

  Future<List> PointsName(List p) async {
    var res = await http.get(Uri.parse(baseURL + chargingPoints));
    var body = jsonDecode(res.body) as List<dynamic>;

    var temp = body.map((point) => chargingPointModel.fromJson(point)).toList();

    p.add(temp.map((item) => (item.name)));
    // p.add("hamzeh");
    print("]]]]]]]]]]]]]]]]]]]]]]]]]]]]]] Points Names" + p.toString());

    return p;
  }

  Future<List> PointsLat() async {
    List p = [];
    var res = await http.get(Uri.parse(baseURL + chargingPoints));
    var body = jsonDecode(res.body) as List<dynamic>;

    var temp = body.map((point) => chargingPointModel.fromJson(point)).toList();

    p.add(temp.map((item) => (item.lat)));

    print("]]]]]]]]]]]]]]]]]]]]]]]]]]]]]] Points Lat Values" + p.toString());

    return p;
  }

  Future<List> PointsLong(List p) async {
    var res = await http.get(Uri.parse(baseURL + chargingPoints));
    var body = jsonDecode(res.body) as List<dynamic>;

    var temp = body.map((point) => chargingPointModel.fromJson(point)).toList();

    p.add(temp.map((item) => (item.long)));
    print("]]]]]]]]]]]]]]]]]]]]]]]]]]]]]] Points long Values" + p.toString());

    return p;
  }

  Future<void> changeAdminPass(newpass) async {
    var body1 = jsonEncode({"password": newpass});
    var res = await http.patch(Uri.parse(baseURL + "/admin/update/1151"),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: body1);
    print(res.statusCode);
  }

  Future<void> changeUserPass(newpass) async {
    var body1 = jsonEncode({"password": newpass});
    var res = await http.patch(
      Uri.parse(baseURL + myAccount),
      headers: {
        "Authorization": "Bearer " + prefs.get("token").toString(),
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: body1,
    );
    print(res.body);
  }

  Future<void> changeUserData(update, data) async {
    var resUrl = baseURL + "/users/me";
    if (update == "email") {
      var body = jsonEncode({"email": data});
      var res = await http.patch(Uri.parse(resUrl),
          headers: {
            "Authorization": "Bearer " + prefs.get("token").toString(),
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: body);
    } else if (update == "phoneNumber") {
      var body = jsonEncode({"phoneNumber": data});
      var res = await http.patch(Uri.parse(resUrl),
          headers: {
            "Authorization": "Bearer " + prefs.get("token").toString(),
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: body);
    } else if (update == "sub_Number") {
      var body = jsonEncode({"sub_Number": data});
      var res = await http.patch(Uri.parse(resUrl),
          headers: {
            "Authorization": "Bearer " + prefs.get("token").toString(),
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: body);
    } else if (update == "cunsump") {
      var newConsump = [
        800.0,
        800.0,
        800.0,
        800.0,
        800.0,
        data,
        800.0,
        800.0,
        800.0,
        800.0,
        800.0,
        800.0
      ];

      var body = jsonEncode({"cunsump": newConsump});
      var res = await http.patch(Uri.parse(resUrl),
          headers: {
            "Authorization": "Bearer " + prefs.get("token").toString(),
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: body);

      print(res.body);
    }
  }

  Future<void> changeStatus(update, data, id) async {
    var resUrl = baseURL + "/problem/update/" + id.toString();
    if (update == "status") {
      var body = jsonEncode({"problem_status": data});
      var res = await http.patch(Uri.parse(resUrl),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
      print(res.statusCode);
    }
  }
}
