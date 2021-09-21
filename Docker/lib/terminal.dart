import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docker/start_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class TerminalRoute extends StatefulWidget {
  const TerminalRoute({Key? key}) : super(key: key);

  @override
  _TerminalState createState() => _TerminalState();
}

class _TerminalState extends State<TerminalRoute> {
  FirebaseFirestore fs = FirebaseFirestore.instance;

  var textController = TextEditingController();
  String cmd='', output='';
  
  getOutput() async {
    // var sendCmd = cmd.replaceAll(' ', '+');
    Uri geturl = Uri.http(hostIP, '/cgi-bin/cmd.py', {'x': cmd});
    http.Response result = await http.get(geturl);
    output = result.body;
    fs.collection('cmdrecords').add(
      {'cmd': cmd, 'output': output, 'timestamp': Timestamp.now()},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text("No record");
                }
                else{
                  var msg = snapshot.data!.docs;
                  List<Widget> datalist = [];

                  for (var data in msg) {
                    var cmd = (data.data() as dynamic)['cmd'];
                    var output = (data.data() as dynamic)['output'];
                    datalist.add(
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              //color: Colors.black,
                              ),
                          children: <TextSpan>[
                            TextSpan(
                                text: '[$hostIP~]# ',
                                style: const TextStyle(
                                    color: Colors.orange, fontSize: 12)),
                            TextSpan(
                                text: '$cmd\n$output\n',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12)),
                          ],
                        ),
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: datalist,
                  );
                }
              },
              stream:
                  fs.collection('cmdrecords').orderBy('timestamp').snapshots()),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('[$hostIP~]# ',
                  style: const TextStyle(color: Colors.orange, fontSize: 12)),
              Expanded(
                child: TextField(
                  cursorColor: Colors.orange,
                  cursorWidth: 2,
                  autocorrect: false,
                  enableSuggestions: false,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                  controller: textController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: -24),
                  ),
                  onSubmitted: (value) {
                    cmd = value;
                    getOutput();
                    textController.clear();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
