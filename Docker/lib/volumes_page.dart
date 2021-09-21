import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'start_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VolumesPage extends StatefulWidget {
  const VolumesPage({Key? key}) : super(key: key);

  @override
  _VolumesState createState() => _VolumesState();
}

class _VolumesState extends State<VolumesPage> {
  String total = '0';
  String listVolumes = '';
  String volumeName = '', driverName = '', size = '', device = '', type = '';
  String toastmsg = '';

  toast() => Fluttertoast.showToast(
        msg: toastmsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[400],
        textColor: Colors.white,
        fontSize: 15.0,
      );

  getOutput(String cmd) async {
    Uri geturl = Uri.http(hostIP, '/cgi-bin/cmd.py', {'x': cmd});
    http.Response result = await http.get(geturl);

    if (cmd == "docker volume ls -q | wc -l") {
      setState(() {
        total = result.body;
      });
    } else if (cmd == "docker volume ls") {
      setState(() {
        listVolumes = result.body;
      });
    } else {
      toastmsg = result.body;
      toast();
    }
  }

  setCount() {
    getOutput("docker volume ls -q | wc -l");
  }

  setListVolumes() {
    getOutput("docker volume ls");
  }

  createVolume() {
    getOutput(
        "docker volume create --name $volumeName --driver $driverName --opt type=$type --opt device=$device --opt o=size=${size}m");
  }

  inspectVolume() {
    getOutput("docker volume inspect $volumeName");
  }

  deleteVolume() {
    getOutput("docker volume rm $volumeName");
  }

  @override
  void initState() {
    super.initState();
    setCount();
    setListVolumes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volumes'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              InkWell(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    boxShadow: [BoxShadow(color: Colors.black, blurRadius: 1)],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Center(
                    child: Text(
                      "List Volumes",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                onTap: () {
                  setListVolumes();
                  setCount();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(),
                                child: Text(
                                  listVolumes,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black54),
                                ),
                              ),
                            ));
                      });
                },
              ),
              Card(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Center(
                    child: Text(
                      "Total: $total",
                      style: const TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 0.1)],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "Create Volume",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: TextField(
                            cursorWidth: 2,
                            autocorrect: false,
                            enableSuggestions: false,
                            style: const TextStyle(fontSize: 15, color: Colors.blue),
                            decoration: const InputDecoration(
                              hintText: "Name",
                              hintStyle: TextStyle(fontSize: 15),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(
                                () {
                                  volumeName = value;
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: TextField(
                            cursorWidth: 2,
                            autocorrect: false,
                            enableSuggestions: false,
                            style: const TextStyle(fontSize: 15, color: Colors.blue),
                            decoration: const InputDecoration(
                              hintText: "Driver name",
                              hintStyle: TextStyle(fontSize: 15),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(
                                () {
                                  driverName = value;
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: TextField(
                            cursorWidth: 2,
                            autocorrect: false,
                            enableSuggestions: false,
                            style: const TextStyle(fontSize: 15, color: Colors.blue),
                            decoration: const InputDecoration(
                              hintText: "Device name",
                              hintStyle: TextStyle(fontSize: 15),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(
                                () {
                                  device = value;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: TextField(
                            cursorWidth: 2,
                            autocorrect: false,
                            enableSuggestions: false,
                            style: const TextStyle(fontSize: 15, color: Colors.blue),
                            decoration: const InputDecoration(
                              hintText: "Size in MB",
                              hintStyle: TextStyle(fontSize: 15),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(
                                () {
                                  size = value;
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: TextField(
                            cursorWidth: 2,
                            autocorrect: false,
                            enableSuggestions: false,
                            style: const TextStyle(fontSize: 15, color: Colors.blue),
                            decoration: const InputDecoration(
                              hintText: "fs type",
                              hintStyle: TextStyle(fontSize: 15),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(
                                () {
                                  type = value;
                                },
                              );
                            },
                          ),
                        ),
                        FloatingActionButton.extended(
                          heroTag: "create",
                          elevation: 1,
                          backgroundColor: Colors.white,
                          onPressed: () async {
                            createVolume();
                            await Future.delayed(const Duration(seconds: 1),
                                () {
                              setListVolumes();
                              setCount();
                            });
                          },
                          label: const Text(
                            'CREATE',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 0.1)],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "Inspect Volume",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextField(
                            cursorWidth: 2,
                            autocorrect: false,
                            enableSuggestions: false,
                            style: const TextStyle(fontSize: 15, color: Colors.blue),
                            decoration: const InputDecoration(
                              hintText: "Volume name",
                              hintStyle: TextStyle(fontSize: 15),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(
                                () {
                                  volumeName = value;
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        FloatingActionButton.extended(
                          heroTag: "inspect",
                          elevation: 1,
                          backgroundColor: Colors.white,
                          onPressed: () async {
                            inspectVolume();
                            await Future.delayed(const Duration(seconds: 1),
                                () {
                              setListVolumes();
                              setCount();
                            });
                          },
                          label: const Text(
                            'INSPECT',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 0.1)],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "Delete Volume",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextField(
                            cursorWidth: 2,
                            autocorrect: false,
                            enableSuggestions: false,
                            style: const TextStyle(fontSize: 15, color: Colors.blue),
                            decoration: const InputDecoration(
                              hintText: "Enter Volume name",
                              hintStyle: TextStyle(fontSize: 15),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(
                                () {
                                  volumeName = value;
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        FloatingActionButton.extended(
                          heroTag: "delete",
                          elevation: 1,
                          backgroundColor: Colors.white,
                          onPressed: () async {
                            deleteVolume();
                            await Future.delayed(const Duration(seconds: 1),
                                () {
                              setListVolumes();
                              setCount();
                            });
                          },
                          label: const Text(
                            'DELETE',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
