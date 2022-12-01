import 'package:flutter/material.dart';
import 'package:sampleproject/Custom_widgets/CustomButton.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FlatButton(
              onPressed: _showMessageDialog(context), child: Text("اضغط"))
        ],
      ),
    );
  }

  _showMessageDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Are you sure?"),
            content: Text("Do you want to delete?"),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("yes"))
            ],
          ));
}
