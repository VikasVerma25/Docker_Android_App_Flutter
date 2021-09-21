/usr/bin/python3
import subprocess
import cgi
print("content-type: text/html")
print()
mydata = cgi.FieldStorage()
cmd = mydata.getvalue("x")
if cmd == "CHECK":
    print("ACTIVE",end='')
else:
    print(subprocess.getoutput("sudo "+cmd), end='')
