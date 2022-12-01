import "package:flutter/material.dart";
import 'package:sampleproject/myadditional_folder/constants.dart';

class myCustomPasswordField extends StatefulWidget {
  final String hint;
  final IconData icon = Icons.vpn_key;

  final TextEditingController? controller;

  myCustomPasswordField({required this.hint, this.controller});

  @override
  _myCustomPasswordFieldState createState() => _myCustomPasswordFieldState();
}

class _myCustomPasswordFieldState extends State<myCustomPasswordField> {
  bool _showEye = false;
  bool _passwordIsEncrypted = true;
  String _password = '';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth,
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            suffixIcon: _showEye
                ? GestureDetector(
                    child: _passwordIsEncrypted
                        ? Container(
                            width: 25,
                            height: 25,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            child: Icon(Icons.visibility),
                          )
                        : Container(
                            width: 25,
                            height: 25,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.visibility_off,
                              size: 20,
                            ),
                          ),
                    onTap: () {
                      setState(() {
                        _passwordIsEncrypted = !_passwordIsEncrypted;
                      });
                    },
                  )
                : null,
            prefixIcon: Icon(widget.icon),
            hintText: widget.hint,
            hintStyle: TextStyle(
                fontFamily: 'ALMARAI', fontSize: 13, color: TFmyGray)),
        obscureText: _showEye ? _passwordIsEncrypted : true,
        onChanged: (enteredPassword) {
          _password = enteredPassword;
          if (enteredPassword.isEmpty) {
            setState(() {
              _showEye = false;
            });
          } else {
            if (!_showEye) {
              setState(() {
                _showEye = !_showEye;
              });
            }
          }
        },
      ),
    );
  }
}
