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

