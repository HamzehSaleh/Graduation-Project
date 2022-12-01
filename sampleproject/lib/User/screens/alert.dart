import "package:flutter/material.dart";
import 'package:sampleproject/User/screens/myProblems/widgets/myProblem_body.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';

class alert extends StatelessWidget {
  const alert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          RaisedButton(
              child: Text("simple Dialog"),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Hello everyone'),
                        content: Text("this is a body from alert dialog"),
                        actions: [
                          FlatButton(onPressed: () {}, child: Text("OK")),
                          FlatButton(onPressed: () {}, child: Text("cancle"))
                        ],
                      );
                    });
              }),
          RaisedButton(
            child: Text('Custom Dialog'),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        height: 200,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "what do you want",
                                ),
                              ),
                              SizedBox(
                                width: 320,
                                child: RaisedButton(
                                  color: Colors.blue,
                                  onPressed: () {},
                                  child: Text(
                                    "confirm",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
          ),
          RaisedButton(
              child: Text("click here"),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => CustomDialog(
                    title: "Success",
                    description: "thank you for your regestraion",
                    buttonText: "confirm",
                    image: Image.network(chargingPoints),
                  ),
                );
              }),
        ],
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;
  const CustomDialog(
      {required this.title,
      required this.description,
      required this.buttonText,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogCntent(context),
    );
  }

  dialogCntent(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 100, bottom: 16, left: 16, right: 16),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(17),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                )
              ]),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 24,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("confirm"),
              ),
            )
          ]),
        ),
        Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: 50,
            backgroundImage: AssetImage(
              "assets/images/myLogo.png",
            ),
          ),
        )
      ],
    );
  }
}
