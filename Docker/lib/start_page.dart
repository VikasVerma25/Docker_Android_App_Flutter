import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

String hostIP = "";

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartState createState() => _StartState();
}

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              key: key,
              backgroundColor: Colors.black54,
              children: <Widget>[
                Center(
                  child: Column(children: const [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Please Wait....",
                      style: TextStyle(color: Colors.blueAccent),
                    )
                  ]),
                )
              ],
            ),
          );
        });
  }
}

final GlobalKey<State> _keyLoader = GlobalKey<State>();

class _StartState extends State<StartPage> {
  toast() => Fluttertoast.showToast(
        msg: "Can not connect to host",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[400],
        textColor: Colors.white,
        fontSize: 15.0,
      );

  checkhost() async {
    try {
      Dialogs.showLoadingDialog(context, _keyLoader);
      Uri geturl = Uri.http(hostIP, '/cgi-bin/cmd.py', {'x': "CHECK"});
      http.Response result = await http.get(geturl);
      Navigator.of(context, rootNavigator: true).pop();
      if (result.body.compareTo("ACTIVE") == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        toast();
      }
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      toast();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              child: Image.asset('docker_image/docker.jpg'),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 80),
              color: Colors.blue[300],
              child: TextField(
                cursorColor: Colors.white,
                cursorWidth: 2,
                autocorrect: false,
                enableSuggestions: false,
                style: const TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: "Docker Host IP",
                  hintStyle: TextStyle(fontSize: 15, color: Colors.white),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    hostIP = value;
                  });
                },
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  primary: Colors.blue,
                ),
                child: const Text(
                  'Enter',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                onPressed: () {
                  checkhost();
                })
          ],
        ),
      ),
    );
  }
}
