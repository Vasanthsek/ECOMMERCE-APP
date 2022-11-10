import 'package:flutter/material.dart';

class GlobalMethods{
  Future<void> showDialogg(String title, String subtitle, Function fct, BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Row(
              children: [
                
                Text(title),
              ],
            ),
            content: Text(subtitle),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    fct();
                    Navigator.pop(context);
                  },
                  child: Text('ok'))
            ],
          );
        });
  }

  Future<void> authDialog(String subtitle, BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Row(
              children: const [
                
                Text("Error Occured"),
              ],
            ),
            content: Text(subtitle),
            actions: [
              
              TextButton(
                  onPressed: () {
                    
                    Navigator.pop(context);
                  },
                  child: Text('ok'))
            ],
          );
        });
  }

}