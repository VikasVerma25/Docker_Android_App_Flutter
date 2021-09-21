import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'start_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ImagesPage extends StatefulWidget {
  const ImagesPage({Key? key}) : super(key: key);

  @override
  _ImagesState createState() => _ImagesState();
}

class _ImagesState extends State<ImagesPage> {
  String total = '0';
  String listImages = '';
  String imageName = '';
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
    
    if (cmd == "docker image ls -q | wc -l") {
      setState(() {
        total = result.body;
      });
    } else if (cmd == "docker image ls") {
      setState(() {
        listImages = result.body;
      });
    } else {
      toastmsg = result.body;
      toast();
    }
  }

  setCount() {
    getOutput("docker image ls -q | wc -l");
  }

  setListImages() {
    getOutput("docker image ls");
  }

  pullImage(){
    toastmsg = "Downloading...";
    toast();
    getOutput("docker pull $imageName");    
  }

  deleteImage(){
    getOutput("docker rmi $imageName");
  }

  @override
  void initState() {
    super.initState();
    setCount();
    setListImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images'),
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
                      "List Images",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                onTap: () {
                  setListImages();
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
                                  listImages,
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
                        "Pull Image",
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
                              hintText: "Enter Image name",
                              hintStyle: TextStyle(fontSize: 15),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(
                                () {
                                  imageName = value;
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        
                        FloatingActionButton.extended(
                          heroTag: "pull",
                          elevation: 1,
                          backgroundColor: Colors.white,
                          onPressed: () async {
                            pullImage();                            
                            await Future.delayed(const Duration(seconds: 15), (){
                                setListImages();
                                setCount();
                            }); 
                          },
                          label: const Text('PULL', style: TextStyle(color: Colors.blue),),
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
                        "Delete Image",
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
                              hintText: "Enter Image name",
                              hintStyle: TextStyle(fontSize: 15),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(
                                () {
                                  imageName = value;
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
                            deleteImage();
                            await Future.delayed(const Duration(seconds: 1), (){
                                setListImages();
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
