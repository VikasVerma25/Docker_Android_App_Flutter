# Docker_Android_App_Flutter
An Android application using Flutter framework to manage and monitor docker.

https://user-images.githubusercontent.com/64186894/134172741-abe8bb90-7eb0-4405-be31-b6e0bfc5b419.mp4

It provides a great user interface to work with docker directly from your mobile phone. The application also provides a terminal interface where you can execute operating system specific non-interactive commands and the commands and outputs will get stored at Google Firestore. With this application without knowing the underlying commands you can easily,\
• See the status of docker host machine, docker client and docker server.\
• See all containers and their state where you can run, stop, start and delete containers.\
• List, count, pull and delete container images.\
• List, count, create, inspect and delete volumes.


#### REQUIREMENTS
• Dart and Flutter SDK \
• Android Studio / Visual Studio Code\
• Google Firebase – Firestore service\
• A Docker Host,\
&nbsp; o A cloud instance\
&nbsp; o Docker service configured\
&nbsp; o Apache web server as CGI\
&nbsp; o Python for CGI program

#### Working of Application
The application on the first page requires to connect to the docker host, for that we need to give the docker host IP. The application sends http request to the host using the given IP address and if it does not receive active status from the CGI program at the host, then application will toast a massage stating that it cannot connect to host.

<img src="https://user-images.githubusercontent.com/64186894/152969029-6a5893e9-5abf-4e8e-80b8-c1333caa4865.jpg" width="200px">
<img src="https://user-images.githubusercontent.com/64186894/152969038-9b5a9d52-b2fb-495e-a163-f72bdd8f84ec.jpg" width="200px">
<img src="https://user-images.githubusercontent.com/64186894/152969040-2ee8d19f-6f45-461e-824a-e0cf9f1c75c2.jpg" width="200px">
<img src="https://user-images.githubusercontent.com/64186894/152969042-12041ed8-67a3-456b-8600-41d21ff684e3.jpg" width="200px">
<img src="https://user-images.githubusercontent.com/64186894/152969048-6858ccc3-de5d-4543-b4a0-59a5ad6edba8.jpg" width="200px">

<img src="https://user-images.githubusercontent.com/64186894/152969063-51c42521-042b-4f5d-8fd9-7223d2078660.jpg" width="200px">
<img src="https://user-images.githubusercontent.com/64186894/152969070-1c8937fa-ff2b-4e59-830b-4ac409458105.jpg" width="200px">
<img src="https://user-images.githubusercontent.com/64186894/152969073-7ac51b75-b379-4fcf-97e1-de3ab3b04b31.jpg" width="200px">
<img src="https://user-images.githubusercontent.com/64186894/152969077-37176d24-eb78-4970-8fca-a32858bc9061.jpg" width="200px">
<img src="https://user-images.githubusercontent.com/64186894/152969084-29712e8c-257d-4129-82f1-0428f7c85b3e.jpg" width="200px">
<img src="https://user-images.githubusercontent.com/64186894/152969087-2fc8c733-fd7d-496a-8a70-853f6ab3e1ae.jpg" width="200px">
<img src="https://user-images.githubusercontent.com/64186894/152969088-264f752a-ce97-4ad2-a21b-8f9f76229c9e.jpg" width="200px">
<img src="https://user-images.githubusercontent.com/64186894/152969090-ed59bb38-6ae6-48d3-b122-555b92405d37.jpg" width="200px">
<img src="https://user-images.githubusercontent.com/64186894/152969093-a858532a-1ead-40e8-bd78-857ccf9f6c5f.jpg" width="200px">
<img src="https://user-images.githubusercontent.com/64186894/152969097-965a2e63-e98d-4fd0-a998-47255ef7c44d.jpg" width="200px">
<img src="https://user-images.githubusercontent.com/64186894/152969100-33e80796-7a41-4c22-b847-f6149dc05694.jpg" width="200px">
<img src="https://user-images.githubusercontent.com/64186894/152969106-fe13ebdd-4cc4-44d3-afc3-7f8af9416fb3.jpg" width="200px">
<img src="https://user-images.githubusercontent.com/64186894/152969055-7600d36c-7461-4cd9-ba33-51c0deb63603.jpg" width="200px">
