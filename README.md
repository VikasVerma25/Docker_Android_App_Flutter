# Docker Android App
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

<img src="https://user-images.githubusercontent.com/64186894/152976219-222bad96-38fa-4af1-8485-822dd7c5ec2b.png" width="600">

Otherwise, it will connect to the docker host through CGI program and navigate to the dashboard.

<img src="https://user-images.githubusercontent.com/64186894/152969042-12041ed8-67a3-456b-8600-41d21ff684e3.jpg" width="200px">

#### CONTAINERS
See status of containers, run, start, stop and delete containers.

<img src="https://user-images.githubusercontent.com/64186894/152977379-0b1582b6-c2f8-4c87-a53a-dc278190e735.png" width="600">

#### IMAGES
View all images, pull and delete images.

<img src="https://user-images.githubusercontent.com/64186894/152977515-5d185f54-3722-4125-af6f-6062de6d2579.png" width="600">
<img src="https://user-images.githubusercontent.com/64186894/152977575-df717649-087e-44c0-80d7-f860d04fd2f3.png" width="600">

#### VOLUMES
See list and count of available volumes, create new volumes, inspect them and delete them.

<img src="https://user-images.githubusercontent.com/64186894/152977665-6e2ac3c2-1de3-4fd6-b783-7f107d868c2a.png" width="600">
<img src="https://user-images.githubusercontent.com/64186894/152977719-ff17d96f-1d4b-4933-9183-6103add2c548.png" width="600">

#### RUN COMMANDS
Get a terminal like interface to run all the operating system specific non-interactive commands that will be executed on the host and it will display their outputs.

<img src="https://user-images.githubusercontent.com/64186894/152977843-fa6cd1b0-2f5f-4c1a-9145-c5be90d0e3f9.png" width="600">
