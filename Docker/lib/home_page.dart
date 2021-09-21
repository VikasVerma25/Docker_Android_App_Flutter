// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'terminal_page.dart';
import 'start_page.dart';
import 'package:http/http.dart' as http;
import 'containers_page.dart';
import 'images_page.dart';
import 'volumes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}



class _HomeState extends State<HomePage> {
  String dockerversion = "";
  String dockerinfo=""; 
  getOutput(String cmd) async {
    Uri geturl = Uri.http(hostIP, '/cgi-bin/cmd.py', {'x': cmd });
    http.Response result = await http.get(geturl);
    if(cmd == "docker version"){
    setState(() {
      dockerversion = result.body;
    });
    }
    else {
      setState(() {
      dockerinfo = result.body;
    });
    }
    // return result.body;
  }

  @override
  void initState() {
    super.initState();
    getOutput("docker version");
    getOutput("docker info");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashBoard'),
      ),
      bottomSheet: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 22),
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.blue,
              boxShadow: [BoxShadow(color: Colors.black, blurRadius: 1)],
              // borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
          ),
          FloatingActionButton.extended(
              heroTag: "terminal",
              backgroundColor: Colors.black,
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TerminalPage())).then((value) => getOutput('docker info')),
              label: const Text('Run Commands'),)
        ],
      ),
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.40,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(color: Colors.black, blurRadius: 1)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          "DockerInfo",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Image.asset("docker_image/info.png")
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: SingleChildScrollView(
                                child: Center(
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(),
                                    child: Text(
                                      dockerinfo,
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.black54),
                                    ),
                                  ),
                                ),
                              ));
                        });
                  },
                ),
                InkWell(
                  child: Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.40,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(color: Colors.black, blurRadius: 1)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Containers",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Image.asset("docker_image/container.png")
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ContainersPage()));
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.40,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(color: Colors.black, blurRadius: 1)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Images",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Image.asset("docker_image/image.png")
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ImagesPage()),
                      );
                  },
                ),
                InkWell(
                  child: Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.40,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(color: Colors.black, blurRadius: 1)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Volumes",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Image.asset("docker_image/volume.png")
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VolumesPage()),
                      );
                  },
                ),
              ],
            ),
            
            Container(
              height: MediaQuery.of(context).size.height * 0.42,
              width: MediaQuery.of(context).size.width * 0.85,
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white70,
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: SingleChildScrollView(
                child: Text(
                  dockerversion,
                  style: const TextStyle(fontSize: 15, color: Colors.black54),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
