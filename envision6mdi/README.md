# envision6mdi

Flutter 3.24.3 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 2663184aa7 (6 months ago) • 2024-09-11 16:27:48 -0500
Engine • revision a18df97ca5
Tools • Dart 3.5.4 • DevTools 2.37.3

CORS policy fix
1- Go to flutter\bin\cache and remove a file named: flutter_tools.stamp
2- Go to flutter\packages\flutter_tools\lib\src\web and open the file chrome.dart.
3- Find '--disable-extensions' remove and add 4.step
4- Add '--disable-web-security'

flutter build web --release --base-href="/EnvisionMDITest/" --web-renderer html --no-tree-shake-icons  


http://127.0.0.1:8080/EnvisionMDITest/#/EnvisionMDITest/mdiinsert?orguid=pts&odalityuid=PTS_CARDIO1

http://localhost:6055/EnvisionMDI/#/EnvisionMDI/mdiinsert?orguid=pts&modalityuid=PTS_CARDIO1

ยังไม่ได้ใช้งาน
http://localhost:52422/EnvisionMDI/#/EnvisionMDI/config