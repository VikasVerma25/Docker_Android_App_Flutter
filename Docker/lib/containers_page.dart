import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'start_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ContainersPage extends StatefulWidget {
  const ContainersPage({Key? key}) : super(key: key);

  @override
  _ContainersState createState() => _ContainersState();
}

class _ContainersState extends State<ContainersPage> {
  String total = '0', running = '0';
  String listContainers = '';

  String containerName = '', imageName = '';

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
    if (cmd == "docker container ls -a -q | wc -l") {
      setState(() {
        total = result.body;
      });
    } else if (cmd == "docker container ls -q | wc -l") {
      setState(() {
        running = result.body;
      });
    } else if (cmd == "docker ps -a") {
      setState(() {
        listContainers = result.body;
      });
    } else {
      toastmsg = result.body;
      toast();
    }
  }

  setCount() {
    getOutput("docker container ls -a -q | wc -l");
    getOutput("docker container ls -q | wc -l");
  }

  setListContainers() {
    getOutput("docker ps -a");
  }

  runContainer(){
    getOutput("docker run -dit --name $containerName $imageName");
    
  }

  stopContainer(){
    getOutput("docker stop $containerName");
  }

  startContainer(){
    getOutput("docker start $containerName");
  }

  deleteContainer(){
    getOutput("docker rm $containerName");
  }

  @override
  void initState() {
    super.initState();
    setCount();
    setListContainers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Containers'),
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
                      "List Containers",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
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
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(),
                                child: Text(
                                  listContainers,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black54),
                                ),
                              ),
                            ));
                      });
                },
              ),
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Center(
                        child: Text(
                          "Total: $total",
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Center(
                        child: Text(
                          "Running: $running",
                          style: const TextStyle(
                              color: Colors.green, fontSize: 17),
                        ),
                      ),
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
                  children: <Widget>[
                    const Center(
                      child: Text(
                        "Run a new Container",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: TextField(
                            cursorWidth: 2,
                            autocorrect: false,
                            enableSuggestions: false,
                            style: const TextStyle(fontSize: 15, color: Colors.blue),
                            decoration: const InputDecoration(
                              hintText: "Container name",
                              hintStyle: TextStyle(fontSize: 15),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(
                                () {
                                  containerName = value;
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: TextField(
                            cursorWidth: 2,
                            autocorrect: false,
                            enableSuggestions: false,
                            style: const TextStyle(fontSize: 15, color: Colors.blue),
                            decoration: const InputDecoration(
                              hintText: "Image name",
                              hintStyle: TextStyle(fontSize: 15),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(() {
                                imageName = value;
                              });
                            },
                          ),
                        ),
                        FloatingActionButton.extended(
                          heroTag: "run",
                          elevation: 1,
                          backgroundColor: Colors.white,
                          onPressed: () async {
                            runContainer();
                            await Future.delayed(const Duration(seconds: 1), (){
                                setListContainers();
                                setCount();
                            });                            
                          },
                          label: const Text('RUN', style: TextStyle(color: Colors.blue),),
                        )
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
                        "Stop Container",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: TextField(
                            cursorWidth: 2,
                            autocorrect: false,
                            enableSuggestions: false,
                            style: const TextStyle(fontSize: 15, color: Colors.blue),
                            decoration: const InputDecoration(
                              hintText: "Enter Container name or Id",
                              hintStyle: TextStyle(fontSize: 15),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(
                                () {
                                  containerName = value;
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        
                        FloatingActionButton.extended(
                          heroTag: "stop",
                          elevation: 1,
                          backgroundColor: Colors.white,
                          onPressed: () async {
                            stopContainer();
                            await Future.delayed(const Duration(seconds: 1), (){
                                setListContainers();
                                setCount();
                            }); 
                          },
                          label: const Text('STOP', style: TextStyle(color: Colors.blue),),
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
                        "Start Container",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: TextField(
                            cursorWidth: 2,
                            autocorrect: false,
                            enableSuggestions: false,
                            style: const TextStyle(fontSize: 15, color: Colors.blue),
                            decoration: const InputDecoration(
                              hintText: "Enter Container name or Id",
                              hintStyle: TextStyle(fontSize: 15),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(
                                () {
                                  containerName = value;
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        
                        FloatingActionButton.extended(
                          heroTag: "start",
                          elevation: 1,
                          backgroundColor: Colors.white,
                          onPressed: () async {
                            startContainer();
                            await Future.delayed(const Duration(seconds: 1), (){
                                setListContainers();
                                setCount();
                            }); 
                          },
                          label: const Text('START', style: TextStyle(color: Colors.blue),),
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
                        "Delete Container",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: TextField(
                            cursorWidth: 2,
                            autocorrect: false,
                            enableSuggestions: false,
                            style: const TextStyle(fontSize: 15, color: Colors.blue),
                            decoration: const InputDecoration(
                              hintText: "Enter Container name or Id",
                              hintStyle: TextStyle(fontSize: 15),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(
                                () {
                                  containerName = value;
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.08,
                        ),
                        
                        FloatingActionButton.extended(
                          heroTag: "delete",
                          elevation: 1,
                          backgroundColor: Colors.white,
                          onPressed: () async {
                            deleteContainer();
                            await Future.delayed(const Duration(seconds: 1), (){
                                setListContainers();
                                setCount();
                            }); 
                          },
                          label: const Text('DELETE', style: TextStyle(color: Colors.red),),
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
