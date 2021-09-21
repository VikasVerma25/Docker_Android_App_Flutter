import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'terminal.dart';

class TerminalPage extends StatefulWidget {
  const TerminalPage({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<TerminalPage> {
  FirebaseFirestore fs = FirebaseFirestore.instance;

  void delete() {
    fs.collection('cmdrecords').get().then(
      (snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(actions: <Widget>[
        Material(
          type: MaterialType.card,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.blue)),
          color: Colors.blue,
          shadowColor: Colors.blue,
          child: MaterialButton(
            onPressed: delete,
            focusColor: null,
            splashColor: null,
            child: const Text(
              'CLEAR ALL',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ]),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.87,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              // side: BorderSide(color: Colors.red.shade900, width: 2),
            ),
            color: Colors.black,
            child: const SingleChildScrollView(
              child: TerminalRoute(),
            ),
          ),
        ),
      ),
    );
  }
}
