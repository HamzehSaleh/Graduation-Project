import 'package:flutter/material.dart';
import 'package:sampleproject/APIs/fetchData.dart';
import 'package:sampleproject/Custom_widgets/CustomTextField.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';
import '../../../APIs/models/employeeModel.dart';
import 'package:http/http.dart' as http;

class employeesClass_body_admin extends StatefulWidget {
  const employeesClass_body_admin({Key? key}) : super(key: key);

  @override
  State<employeesClass_body_admin> createState() =>
      _employeesClass_body_adminState();
}

class _employeesClass_body_adminState extends State<employeesClass_body_admin> {
  FetchData _fetchData = FetchData();
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _fetchData.allEmployees();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      //  mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              // SizedBox(
              //   height: 15,
              // ),
              // myCustomTextField(
              //   hint: "البحث عن موظف",
              //   icon: Icons.search,
              //   controller: _searchController,
              // ),
              // ElevatedButton(onPressed: SearchEmployee, child: Text("بحث")),
              SizedBox(
                height: 5,
              ),
              fetchAllEmployees(),
              Spacer(
                flex: 3,
              ),
            ],
          ),
        ))
      ],
    );
  }

  Widget fetchAllEmployees() {
    return FutureBuilder(
        future: _fetchData.allEmployees(),
        builder: (contxt, snapchot) {
          var employees = snapchot.data as List<emoployeeModel>;
          return snapchot.data == null
              ? CircularProgressIndicator(
                  value: 0.8,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: employees == null ? 0 : employees.length,
                  itemBuilder: (context, index) {
                    return myEmployeessCard(
                      employees[index].Name,
                      employees[index].Identity,
                      employees[index].phoneNumber,
                      employees[index].jobTitle,
                      employees[index].id,
                    );
                  });
        });
  }

  Padding myEmployeessCard(
      String text, String identity, String phone, String job, String _id) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.10,
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(myMenAvatar),
                radius: myMenAvatarRadius * 0.5,
              ),
              const SizedBox(
                width: 20,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 3,
                    ),
                    Text(text,
                        style: TextStyle(
                            fontFamily: myOtherFont,
                            fontSize: 13,
                            color: myGray,
                            fontWeight: FontWeight.bold)),
                    const Spacer(
                      flex: 3,
                    ),
                    Text(" رقم الهوية:  $identity",
                        style: TextStyle(
                          fontFamily: myOtherFont,
                          fontSize: 13,
                          color: TFmyGray,
                        )),
                    const Spacer(
                      flex: 1,
                    ),
                    Text("رقم الهاتف:  $phone",
                        style: TextStyle(
                          fontFamily: myOtherFont,
                          fontSize: 13,
                          color: TFmyGray,
                        )),
                    const Spacer(
                      flex: 3,
                    ),
                    Text("الوظيفة:  $job",
                        style: TextStyle(
                          fontFamily: myOtherFont,
                          fontSize: 13,
                          color: TFmyGray,
                        )),
                    const Spacer(
                      flex: 3,
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 9,
              ),
              PopupMenuButton(
                  itemBuilder: (context) => [
                        popupMenu(context, "حذف", _id),
                        popupMenu(context, "ارسال رسالة", _id),
                        popupMenu(context, "عرض البيانات", _id),
                      ])
            ],
          )),
    );
  }

  PopupMenuItem<int> popupMenu(BuildContext context, String text, String id) {
    return PopupMenuItem(
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(fontFamily: myOtherFont, fontSize: 13),
          ),
        ],
      ),
      value: 4,
      onTap: () {
        switch (text) {
          case "حذف":
            {
              DeleteEmployee(id);
              setState(() {});
            }
            break;
          case "ارسال رسالة":
            {
              Future<void>.delayed(
                const Duration(),
                () => sendMessageDialog(context),
              );
            }
            break;
          case "عرض البيانات":
            {
              print("show data");
            }
            break;
        }
      },
    );
  }

  Future<void> DeleteEmployee(id) async {
    var employeeID = FetchData.baseURL + "/employees/" + id.toString();
    var res = await http.delete(
      Uri.parse(employeeID),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  SearchEmployee() async {
    var employee = _searchController.text;

    var searchUrl = FetchData.baseURL + "/employees/" + employee;
    var res = await http.get(
      Uri.parse(searchUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print(res.body);
  }

  sendMessageDialog(BuildContext context) {
    TextEditingController customController = new TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "ارسال رسالة خاصة",
              style: const TextStyle(fontFamily: myOtherFont, fontSize: 14),
            ),
            content: Container(
              height: 280,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                              width: 200,
                              child: Image.network(
                                sendMessage,
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: customController,
                            decoration: InputDecoration(
                              hintText: "أدخل نص الرسالة",
                              hintStyle: TextStyle(
                                  fontFamily: 'ALMARAI',
                                  fontSize: 15,
                                  color: TFmyGray),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text(
                  "ارسال",
                  style: const TextStyle(
                    fontFamily: myOtherFont,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(customController.text.toString());
                },
              ),
            ],
          );
        });
  }
}
