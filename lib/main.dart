import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:emoji_maker/emoji.dart';
import 'package:emoji_maker/emojiDB.dart';
import 'dart:math';
import 'dart:ui';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Emoji Maker V1.0'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Emoji> listEmoji = [];
  List<Emoji> listBase = [];
  List<Emoji> listEyes = [];
  List<Emoji> listMouth = [];
  List<Emoji> listDetails = [];
  int menu =
      4; // 4 Main, 0 Base, 1 Eyes, 2 Mouth, 3 Details, 5 Move choose, 6 Move
  int move = 0; // 0 Move Base, 1 Move Eyes, 2 Move Mouth, 3 Move Details

  void initState() {
    super.initState();

    listEmoji = getData();

    for (Emoji e in listEmoji) {
      if (e.getType() == 0) {
        listBase.add(e);
      } else if (e.getType() == 1) {
        listEyes.add(e);
      } else if (e.getType() == 2) {
        listMouth.add(e);
      } else if (e.getType() == 3) {
        listDetails.add(e);
      }
    }
  }

  final String svgHeader =
      '''<svg width="36" height="36" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">''';
  String svgBase = ''' ''';
  String svgEyes = ''' ''';
  String svgMouth = ''' ''';
  String svgDetails = ''' ''';
  final String svgFooter = '''</svg>''';

  Widget getSVG() {
    String svgBuild =
        svgHeader + svgBase + svgEyes + svgMouth + svgDetails + svgFooter;
    return SvgPicture.string(
      svgBuild,
      height: 150,
      width: 150,
    );
  }

  Future<bool> _onWillPop() async {
    if (menu != 4) {
      setState(() {
        menu = 4;
      });
      return false;
    } else {
      return showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Emoji not saved'),
              content: new Text('Do you want to exit the app ?'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('No'),
                ),
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Stack(children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: new GestureDetector(
                child: Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                    color: Colors.green,
                    border: new Border.all(color: Colors.grey),
                    borderRadius: new BorderRadius.all(Radius.circular(30.0)),
                  ),
                  child: Center(
                      child: Column(
                    children: getSave(),
                  )),
                ),
                onTap: () {
                  _saveEmoji();
                },
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: new GestureDetector(
                child: Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    border: new Border.all(color: Colors.grey),
                    borderRadius: new BorderRadius.all(Radius.circular(30.0)),
                  ),
                  child: Center(
                      child: Column(
                    children: getClear(),
                  )),
                ),
                onTap: () {
                  _clearEmoji();
                },
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: new GestureDetector(
                child: Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                    color: Colors.black12,
                    border: new Border.all(color: Colors.grey),
                    borderRadius: new BorderRadius.all(Radius.circular(30.0)),
                  ),
                  child: Center(
                      child: Column(
                    children: getRandom(),
                  )),
                ),
                onTap: () {
                  _randomEmoji();
                },
              ),
            ),
            Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[getSVG()])),
            Align(
                alignment: Alignment(1, 0.95),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 10,
                  height: 100,
                  child: getMenu(),
                )),
          ]),
        ));
  }

  void _saveEmoji() async {
    print(svgEyes);
    //TODO
    /*String svgBuild =
        svgHeader + svgBase + svgEyes + svgMouth + svgDetails + svgFooter;
    final DrawableRoot svgRoot = await svg.fromSvgString(svgBuild, svgBuild);
    final Picture picture = svgRoot.toPicture();
    Future<Image> saved =  picture.toImage(50, 50);*/
  }

  void _moveEmoji(int index) {
    print(index);
    if (index == 0) { // Left
      _moveLeft();
    } else if (index == 1) { // Right
      _moveRight();
    } else if (index == 2) { // Up
      _moveUp();
    } else if (index == 3) { // Down
      _moveDown();
    }
  }

  void _moveLeft() {

    if (move == 0) { // Base
      //TODO
    } else if (move == 1) { // Eyes

      List<String> tempEyes = svgEyes.split(">");
      print(tempEyes.length);
      if (tempEyes.length-1 == 1) { // 1 seul objet a bouger
        if (tempEyes[0].contains("path")) {
          List<String> tempCoord = tempEyes[0].split("m");
          // tempCoord[0] + m = partie gauche

          List<String> tempCoord2 = tempCoord[1].split("c");
          // c + tempCoord2[1] + > = partie droite
          List<String> tempCoord3 = tempCoord2[0].split(",");
          double newCoord = double.parse(tempCoord3[0])-1.5;
          // tempCoord3[0] + , + tempCoord3[1] = partie du milieu
          int i = 1;
          String coord2 ='''''';
          while (i < tempCoord2.length) {
            if (i != tempCoord2.length-1) {
              coord2 = coord2 + tempCoord2[i] +'''c''';
            } else {
              coord2 = coord2 + tempCoord2[i];
            }
            i++;
          }
          if (tempCoord.length>2) {
            int x = 2;
            while (x < tempCoord.length) {
              coord2 = coord2 +'''m''' +tempCoord[x];
            x++;
            }
          }
          setState(() {
            svgEyes = tempCoord[0] + '''m''' + newCoord.toString() +''','''+ tempCoord3[1]+'''c'''+coord2+'''>''';
            print(svgEyes);
          });
        } else if (tempEyes[0].contains("circle") || tempEyes[0].contains("ellipse")){
          List<String> tempCoord = tempEyes[0].split('''cx="''');
          double newCoord = double.parse((tempCoord[1][0]+tempCoord[1][1]+tempCoord[1][2]).replaceAll('''"''', ''''''))-1;
          List<String> tempo = tempCoord[1].split('''"''');
          String tempi='''''';
          int w = 1;
          while (w<tempo.length) {
            tempi = tempi +'''"''' + tempo[w];
            w++;
          }
          setState(() {
            svgEyes = tempCoord[0]+'''cx="'''+newCoord.toString()+tempi+'''>''';
            print(svgEyes);
          });
        }
      } else {
        int y =0;
        String svgBuild='''''';
        while (y<tempEyes.length-1) {
          if (tempEyes[y].contains("path")) {
            List<String> tempCoord = tempEyes[y].split("m");
            // tempCoord[0] + m = partie gauche

            List<String> tempCoord2 = tempCoord[1].split("c");
            // c + tempCoord2[1] + > = partie droite
            List<String> tempCoord3 = tempCoord2[0].split(",");
            double newCoord = double.parse(tempCoord3[0])-1.5;
            // tempCoord3[0] + , + tempCoord3[1] = partie du milieu
            int i = 1;
            String coord2 ='''''';
            while (i < tempCoord2.length) {
              if (i != tempCoord2.length-1) {
                coord2 = coord2 + tempCoord2[i] +'''c''';
              } else {
                coord2 = coord2 + tempCoord2[i];
              }
              i++;
            }
            if (tempCoord.length>2) {
              int x = 2;
              while (x < tempCoord.length) {
                coord2 = coord2 +'''m''' +tempCoord[x];
                x++;
              }
            }
            setState(() {
              svgEyes = tempCoord[0] + '''m''' + newCoord.toString() +''','''+ tempCoord3[1]+'''c'''+coord2+'''>''';
              print(svgEyes);
            });
          } else if (tempEyes[y].contains("circle")||tempEyes[y].contains("ellipse")){
            List<String> tempCoord = tempEyes[y].split('''cx="''');
            double newCoord = double.parse((tempCoord[1][0]+tempCoord[1][1]+tempCoord[1][2]).replaceAll('''"''', ''''''))-1;
              List<String> tempo = tempCoord[1].split('''"''');
              String tempi='''''';
              int w = 1;
              while (w<tempo.length) {
                tempi = tempi +'''"''' + tempo[w];
                w++;
              }
            svgBuild = svgBuild+tempCoord[0]+'''cx="'''+newCoord.toString()+tempi+'''>''';
          }
          y++;
        }
        setState(() {
          svgEyes = svgBuild;
          print(svgEyes);
        });
      }


    } else if (move == 2) { // Mouth
      List<String> tempMouth = svgMouth.split(">");
      print(tempMouth.length);
      if (tempMouth.length-1 == 1) { // 1 seul objet a bouger
        if (tempMouth[0].contains("path")) {
          List<String> tempCoord = tempMouth[0].split("m");
          // tempCoord[0] + m = partie gauche

          List<String> tempCoord2 = tempCoord[1].split("c");
          // c + tempCoord2[1] + > = partie droite
          List<String> tempCoord3 = tempCoord2[0].split(",");
          double newCoord = double.parse(tempCoord3[0])-1.5;
          // tempCoord3[0] + , + tempCoord3[1] = partie du milieu
          int i = 1;
          String coord2 ='''''';
          while (i < tempCoord2.length) {
            if (i != tempCoord2.length-1) {
              coord2 = coord2 + tempCoord2[i] +'''c''';
            } else {
              coord2 = coord2 + tempCoord2[i];
            }
            i++;
          }
          if (tempCoord.length>2) {
            int x = 2;
            while (x < tempCoord.length) {
              coord2 = coord2 +'''m''' +tempCoord[x];
              x++;
            }
          }
          setState(() {
            svgMouth = tempCoord[0] + '''m''' + newCoord.toString() +''','''+ tempCoord3[1]+'''c'''+coord2+'''>''';
            print(svgMouth);
          });
        } else if (tempMouth[0].contains("circle") || tempMouth[0].contains("ellipse")){
          List<String> tempCoord = tempMouth[0].split('''cx="''');
          double newCoord = double.parse((tempCoord[1][0]+tempCoord[1][1]+tempCoord[1][2]).replaceAll('''"''', ''''''))-1;
          List<String> tempo = tempCoord[1].split('''"''');
          String tempi='''''';
          int w = 1;
          while (w<tempo.length) {
            tempi = tempi +'''"''' + tempo[w];
            w++;
          }
          setState(() {
            svgEyes = tempCoord[0]+'''cx="'''+newCoord.toString()+tempi+'''>''';
            print(svgEyes);
          });
        }
      } else {
        int y =0;
        String svgBuild='''''';
        while (y<tempMouth.length-1) {
          if (tempMouth[y].contains("path")) {
            List<String> tempCoord = tempMouth[y].split("m");
            // tempCoord[0] + m = partie gauche

            List<String> tempCoord2 = tempCoord[1].split("c");
            // c + tempCoord2[1] + > = partie droite
            List<String> tempCoord3 = tempCoord2[0].split(",");
            double newCoord = double.parse(tempCoord3[0])-1.5;
            // tempCoord3[0] + , + tempCoord3[1] = partie du milieu
            int i = 1;
            String coord2 ='''''';
            while (i < tempCoord2.length) {
              if (i != tempCoord2.length-1) {
                coord2 = coord2 + tempCoord2[i] +'''c''';
              } else {
                coord2 = coord2 + tempCoord2[i];
              }
              i++;
            }
            if (tempCoord.length>2) {
              int x = 2;
              while (x < tempCoord.length) {
                coord2 = coord2 +'''m''' +tempCoord[x];
                x++;
              }
            }
            setState(() {
              svgEyes = tempCoord[0] + '''m''' + newCoord.toString() +''','''+ tempCoord3[1]+'''c'''+coord2+'''>''';
              print(svgEyes);
            });
          } else if (tempMouth[y].contains("circle")||tempMouth[y].contains("ellipse")){
            List<String> tempCoord = tempMouth[y].split('''cx="''');
            double newCoord = double.parse((tempCoord[1][0]+tempCoord[1][1]+tempCoord[1][2]).replaceAll('''"''', ''''''))-1;
            List<String> tempo = tempCoord[1].split('''"''');
            String tempi='''''';
            int w = 1;
            while (w<tempo.length) {
              tempi = tempi +'''"''' + tempo[w];
              w++;
            }
            svgBuild = svgBuild+tempCoord[0]+'''cx="'''+newCoord.toString()+tempi+'''>''';
          }
          y++;
        }
        setState(() {
          svgEyes = svgBuild;
          print(svgEyes);
        });
      }
    } else if (move == 3) { // Details

    }

  }
  void _moveRight() {

    if (move == 0) { // Base

    } else if (move == 1) { // Eyes
      List<String> tempEyes = svgEyes.split(">");
      print(tempEyes.length);
      if (tempEyes.length-1 == 1) { // 1 seul objet a bouger
        if (tempEyes[0].contains("path")) {
          List<String> tempCoord = tempEyes[0].split("m");
          // tempCoord[0] + m = partie gauche

          List<String> tempCoord2 = tempCoord[1].split("c");
          // c + tempCoord2[1] + > = partie droite
          List<String> tempCoord3 = tempCoord2[0].split(",");
          double newCoord = double.parse(tempCoord3[0])+1.5;
          // tempCoord3[0] + , + tempCoord3[1] = partie du milieu
          int i = 1;
          String coord2 ='''''';
          while (i < tempCoord2.length) {
            if (i != tempCoord2.length-1) {
              coord2 = coord2 + tempCoord2[i] +'''c''';
            } else {
              coord2 = coord2 + tempCoord2[i];
            }
            i++;
          }
          if (tempCoord.length>2) {
            int x = 2;
            while (x < tempCoord.length) {
              coord2 = coord2 +'''m''' +tempCoord[x];
              x++;
            }
          }
          setState(() {
            svgEyes = tempCoord[0] + '''m''' + newCoord.toString() +''','''+ tempCoord3[1]+'''c'''+coord2+'''>''';
            print(svgEyes);
          });
        } else if (tempEyes[0].contains("circle") || tempEyes[0].contains("ellipse")){
          List<String> tempCoord = tempEyes[0].split('''cx="''');
          double newCoord = double.parse((tempCoord[1][0]+tempCoord[1][1]+tempCoord[1][2]).replaceAll('''"''', ''''''))+1;
          List<String> tempo = tempCoord[1].split('''"''');
          String tempi='''''';
          int w = 1;
          while (w<tempo.length) {
            tempi = tempi +'''"''' + tempo[w];
            w++;
          }
          setState(() {
            svgEyes = tempCoord[0]+'''cx="'''+newCoord.toString()+tempi+'''>''';
            print(svgEyes);
          });
        }
      } else {
        int y =0;
        String svgBuild='''''';
        while (y<tempEyes.length-1) {
          if (tempEyes[y].contains("path")) {
            List<String> tempCoord = tempEyes[y].split("m");
            // tempCoord[0] + m = partie gauche

            List<String> tempCoord2 = tempCoord[1].split("c");
            // c + tempCoord2[1] + > = partie droite
            List<String> tempCoord3 = tempCoord2[0].split(",");
            double newCoord = double.parse(tempCoord3[0])-1.5;
            // tempCoord3[0] + , + tempCoord3[1] = partie du milieu
            int i = 1;
            String coord2 ='''''';
            while (i < tempCoord2.length) {
              if (i != tempCoord2.length-1) {
                coord2 = coord2 + tempCoord2[i] +'''c''';
              } else {
                coord2 = coord2 + tempCoord2[i];
              }
              i++;
            }
            if (tempCoord.length>2) {
              int x = 2;
              while (x < tempCoord.length) {
                coord2 = coord2 +'''m''' +tempCoord[x];
                x++;
              }
            }
            setState(() {
              svgEyes = tempCoord[0] + '''m''' + newCoord.toString() +''','''+ tempCoord3[1]+'''c'''+coord2+'''>''';
              print(svgEyes);
            });
          } else if (tempEyes[y].contains("circle")||tempEyes[y].contains("ellipse")){
            List<String> tempCoord = tempEyes[y].split('''cx="''');
            double newCoord = double.parse((tempCoord[1][0]+tempCoord[1][1]+tempCoord[1][2]).replaceAll('''"''', ''''''))+1;
            List<String> tempo = tempCoord[1].split('''"''');
            String tempi='''''';
            int w = 1;
            while (w<tempo.length) {
              tempi = tempi +'''"''' + tempo[w];
              w++;
            }
            svgBuild = svgBuild+tempCoord[0]+'''cx="'''+newCoord.toString()+tempi+'''>''';
          }
          y++;
        }
        setState(() {
          svgEyes = svgBuild;
          print(svgEyes);
        });
      }
    } else if (move == 2) { // Mouth
      List<String> tempMouth = svgMouth.split(">");
      print(tempMouth.length);
      if (tempMouth.length-1 == 1) { // 1 seul objet a bouger
        if (tempMouth[0].contains("path")) {
          List<String> tempCoord = tempMouth[0].split("m");
          // tempCoord[0] + m = partie gauche

          List<String> tempCoord2 = tempCoord[1].split("c");
          // c + tempCoord2[1] + > = partie droite
          List<String> tempCoord3 = tempCoord2[0].split(",");
          double newCoord = double.parse(tempCoord3[0])+1.5;
          // tempCoord3[0] + , + tempCoord3[1] = partie du milieu
          int i = 1;
          String coord2 ='''''';
          while (i < tempCoord2.length) {
            if (i != tempCoord2.length-1) {
              coord2 = coord2 + tempCoord2[i] +'''c''';
            } else {
              coord2 = coord2 + tempCoord2[i];
            }
            i++;
          }
          if (tempCoord.length>2) {
            int x = 2;
            while (x < tempCoord.length) {
              coord2 = coord2 +'''m''' +tempCoord[x];
              x++;
            }
          }
          setState(() {
            svgMouth = tempCoord[0] + '''m''' + newCoord.toString() +''','''+ tempCoord3[1]+'''c'''+coord2+'''>''';
            print(svgMouth);
          });
        } else if (tempMouth[0].contains("circle") || tempMouth[0].contains("ellipse")){
          List<String> tempCoord = tempMouth[0].split('''cx="''');
          double newCoord = double.parse((tempCoord[1][0]+tempCoord[1][1]+tempCoord[1][2]).replaceAll('''"''', ''''''))-1;
          List<String> tempo = tempCoord[1].split('''"''');
          String tempi='''''';
          int w = 1;
          while (w<tempo.length) {
            tempi = tempi +'''"''' + tempo[w];
            w++;
          }
          setState(() {
            svgEyes = tempCoord[0]+'''cx="'''+newCoord.toString()+tempi+'''>''';
            print(svgEyes);
          });
        }
      } else {
        int y =0;
        String svgBuild='''''';
        while (y<tempMouth.length-1) {
          if (tempMouth[y].contains("path")) {
            List<String> tempCoord = tempMouth[y].split("m");
            // tempCoord[0] + m = partie gauche

            List<String> tempCoord2 = tempCoord[1].split("c");
            // c + tempCoord2[1] + > = partie droite
            List<String> tempCoord3 = tempCoord2[0].split(",");
            double newCoord = double.parse(tempCoord3[0])-1.5;
            // tempCoord3[0] + , + tempCoord3[1] = partie du milieu
            int i = 1;
            String coord2 ='''''';
            while (i < tempCoord2.length) {
              if (i != tempCoord2.length-1) {
                coord2 = coord2 + tempCoord2[i] +'''c''';
              } else {
                coord2 = coord2 + tempCoord2[i];
              }
              i++;
            }
            if (tempCoord.length>2) {
              int x = 2;
              while (x < tempCoord.length) {
                coord2 = coord2 +'''m''' +tempCoord[x];
                x++;
              }
            }
            setState(() {
              svgEyes = tempCoord[0] + '''m''' + newCoord.toString() +''','''+ tempCoord3[1]+'''c'''+coord2+'''>''';
              print(svgEyes);
            });
          } else if (tempMouth[y].contains("circle")||tempMouth[y].contains("ellipse")){
            List<String> tempCoord = tempMouth[y].split('''cx="''');
            double newCoord = double.parse((tempCoord[1][0]+tempCoord[1][1]+tempCoord[1][2]).replaceAll('''"''', ''''''))-1;
            List<String> tempo = tempCoord[1].split('''"''');
            String tempi='''''';
            int w = 1;
            while (w<tempo.length) {
              tempi = tempi +'''"''' + tempo[w];
              w++;
            }
            svgBuild = svgBuild+tempCoord[0]+'''cx="'''+newCoord.toString()+tempi+'''>''';
          }
          y++;
        }
        setState(() {
          svgEyes = svgBuild;
          print(svgEyes);
        });
      }
    } else if (move == 3) { // Details

    }
  }
  void _moveUp() {

    if (move == 0) { // Base

    } else if (move == 1) { // Eyes
      List<String> tempEyes = svgEyes.split(">");
      print(tempEyes.length);
      if (tempEyes.length-1 == 1) { // 1 seul objet a bouger
        if (tempEyes[0].contains("path")) {
          List<String> tempCoord = tempEyes[0].split("m");
          // tempCoord[0] + m = partie gauche

          List<String> tempCoord2 = tempCoord[1].split("c");
          // c + tempCoord2[1] + > = partie droite
          List<String> tempCoord3 = tempCoord2[0].split(",");
          double newCoord = double.parse(tempCoord3[1])-1.5;
          // tempCoord3[0] + , + tempCoord3[1] = partie du milieu
          int i = 1;
          String coord2 ='''''';
          while (i < tempCoord2.length) {
            if (i != tempCoord2.length-1) {
              coord2 = coord2 + tempCoord2[i] +'''c''';
            } else {
              coord2 = coord2 + tempCoord2[i];
            }
            i++;
          }
          if (tempCoord.length>2) {
            int x = 2;
            while (x < tempCoord.length) {
              coord2 = coord2 +'''m''' +tempCoord[x];
              x++;
            }
          }
          setState(() {
            svgEyes = tempCoord[0] + '''m''' + tempCoord3[0] +''','''+ newCoord.toString()+'''c'''+coord2+'''>''';
          });
        } else if (tempEyes[0].contains("circle") || tempEyes[0].contains("ellipse")){
          List<String> tempCoord = tempEyes[0].split('''cy="''');
          double newCoord = double.parse((tempCoord[1][0]+tempCoord[1][1]+tempCoord[1][2]).replaceAll('''"''', ''''''))-1;
          List<String> tempo = tempCoord[1].split('''"''');
          String tempi='''''';
          int w = 1;
          while (w<tempo.length) {
            tempi = tempi +'''"''' + tempo[w];
            w++;
          }
          setState(() {
            svgEyes = tempCoord[0]+'''cy="'''+newCoord.toString()+tempi+'''>''';
            print(svgEyes);
          });
        }
      } else {
        int y =0;
        String svgBuild='''''';
        while (y<tempEyes.length-1) {
          if (tempEyes[y].contains("path")) {
            List<String> tempCoord = tempEyes[y].split("m");
            // tempCoord[0] + m = partie gauche

            List<String> tempCoord2 = tempCoord[1].split("c");
            // c + tempCoord2[1] + > = partie droite
            List<String> tempCoord3 = tempCoord2[0].split(",");
            double newCoord = double.parse(tempCoord3[0])-1.5;
            // tempCoord3[0] + , + tempCoord3[1] = partie du milieu
            int i = 1;
            String coord2 ='''''';
            while (i < tempCoord2.length) {
              if (i != tempCoord2.length-1) {
                coord2 = coord2 + tempCoord2[i] +'''c''';
              } else {
                coord2 = coord2 + tempCoord2[i];
              }
              i++;
            }
            if (tempCoord.length>2) {
              int x = 2;
              while (x < tempCoord.length) {
                coord2 = coord2 +'''m''' +tempCoord[x];
                x++;
              }
            }
            setState(() {
              svgEyes = tempCoord[0] + '''m''' + newCoord.toString() +''','''+ tempCoord3[1]+'''c'''+coord2+'''>''';
              print(svgEyes);
            });
          } else if (tempEyes[y].contains("circle")||tempEyes[y].contains("ellipse")){
            List<String> tempCoord = tempEyes[y].split('''cy="''');
            double newCoord = double.parse((tempCoord[1][0]+tempCoord[1][1]+tempCoord[1][2]).replaceAll('''"''', ''''''))-1;
            List<String> tempo = tempCoord[1].split('''"''');
            String tempi='''''';
            int w = 1;
            while (w<tempo.length) {
              tempi = tempi +'''"''' + tempo[w];
              w++;
            }
            svgBuild = svgBuild+tempCoord[0]+'''cy="'''+newCoord.toString()+tempi+'''>''';
          }
          y++;
        }
        setState(() {
          svgEyes = svgBuild;
          print(svgEyes);
        });
      }
    } else if (move == 2) { // Mouth
      List<String> tempMouth = svgMouth.split(">");
      print(tempMouth.length);
      if (tempMouth.length-1 == 1) { // 1 seul objet a bouger
        if (tempMouth[0].contains("path")) {
          List<String> tempCoord = tempMouth[0].split("m");
          // tempCoord[0] + m = partie gauche

          List<String> tempCoord2 = tempCoord[1].split("c");
          // c + tempCoord2[1] + > = partie droite
          List<String> tempCoord3 = tempCoord2[0].split(",");
          double newCoord = double.parse(tempCoord3[1])-1.5;
          // tempCoord3[0] + , + tempCoord3[1] = partie du milieu
          int i = 1;
          String coord2 ='''''';
          while (i < tempCoord2.length) {
            if (i != tempCoord2.length-1) {
              coord2 = coord2 + tempCoord2[i] +'''c''';
            } else {
              coord2 = coord2 + tempCoord2[i];
            }
            i++;
          }
          if (tempCoord.length>2) {
            int x = 2;
            while (x < tempCoord.length) {
              coord2 = coord2 +'''m''' +tempCoord[x];
              x++;
            }
          }
          setState(() {
            svgMouth = tempCoord[0] + '''m''' + tempCoord3[0] +''','''+ newCoord.toString()+'''c'''+coord2+'''>''';
            print(svgMouth);
          });
        }
      }
    } else if (move == 3) { // Details

    }
  }
  void _moveDown() {

    if (move == 0) { // Base

    } else if (move == 1) { // Eyes
      List<String> tempEyes = svgEyes.split(">");
      print(tempEyes.length);
      if (tempEyes.length-1 == 1) { // 1 seul objet a bouger
        if (tempEyes[0].contains("path")) {
          List<String> tempCoord = tempEyes[0].split("m");
          // tempCoord[0] + m = partie gauche

          List<String> tempCoord2 = tempCoord[1].split("c");
          // c + tempCoord2[1] + > = partie droite
          List<String> tempCoord3 = tempCoord2[0].split(",");
          double newCoord = double.parse(tempCoord3[1])+1.5;
          // tempCoord3[0] + , + tempCoord3[1] = partie du milieu
          int i = 1;
          String coord2 ='''''';
          while (i < tempCoord2.length) {
            if (i != tempCoord2.length-1) {
              coord2 = coord2 + tempCoord2[i] +'''c''';
            } else {
              coord2 = coord2 + tempCoord2[i];
            }
            i++;
          }
          if (tempCoord.length>2) {
            int x = 2;
            while (x < tempCoord.length) {
              coord2 = coord2 +'''m''' +tempCoord[x];
              x++;
            }
          }
          setState(() {
            svgEyes = tempCoord[0] + '''m''' + tempCoord3[0] +''','''+ newCoord.toString()+'''c'''+coord2+'''>''';
          });
        } else if (tempEyes[0].contains("circle") || tempEyes[0].contains("ellipse")){
          List<String> tempCoord = tempEyes[0].split('''cy="''');
          double newCoord = double.parse((tempCoord[1][0]+tempCoord[1][1]+tempCoord[1][2]).replaceAll('''"''', ''''''))+1;
          List<String> tempo = tempCoord[1].split('''"''');
          String tempi='''''';
          int w = 1;
          while (w<tempo.length) {
            tempi = tempi +'''"''' + tempo[w];
            w++;
          }
          setState(() {
            svgEyes = tempCoord[0]+'''cy="'''+newCoord.toString()+tempi+'''>''';
            print(svgEyes);
          });
        }
      } else {
        int y =0;
        String svgBuild='''''';
        while (y<tempEyes.length-1) {
          if (tempEyes[y].contains("path")) {
            List<String> tempCoord = tempEyes[y].split("m");
            // tempCoord[0] + m = partie gauche

            List<String> tempCoord2 = tempCoord[1].split("c");
            // c + tempCoord2[1] + > = partie droite
            List<String> tempCoord3 = tempCoord2[0].split(",");
            double newCoord = double.parse(tempCoord3[0])-1.5;
            // tempCoord3[0] + , + tempCoord3[1] = partie du milieu
            int i = 1;
            String coord2 ='''''';
            while (i < tempCoord2.length) {
              if (i != tempCoord2.length-1) {
                coord2 = coord2 + tempCoord2[i] +'''c''';
              } else {
                coord2 = coord2 + tempCoord2[i];
              }
              i++;
            }
            if (tempCoord.length>2) {
              int x = 2;
              while (x < tempCoord.length) {
                coord2 = coord2 +'''m''' +tempCoord[x];
                x++;
              }
            }
            setState(() {
              svgEyes = tempCoord[0] + '''m''' + newCoord.toString() +''','''+ tempCoord3[1]+'''c'''+coord2+'''>''';
              print(svgEyes);
            });
          } else if (tempEyes[y].contains("circle")||tempEyes[y].contains("ellipse")){
            List<String> tempCoord = tempEyes[y].split('''cy="''');
            double newCoord = double.parse((tempCoord[1][0]+tempCoord[1][1]+tempCoord[1][2]).replaceAll('''"''', ''''''))+1;
            List<String> tempo = tempCoord[1].split('''"''');
            String tempi='''''';
            int w = 1;
            while (w<tempo.length) {
              tempi = tempi +'''"''' + tempo[w];
              w++;
            }
            svgBuild = svgBuild+tempCoord[0]+'''cy="'''+newCoord.toString()+tempi+'''>''';
          }
          y++;
        }
        setState(() {
          svgEyes = svgBuild;
          print(svgEyes);
        });
      }
    } else if (move == 2) { // Mouth
      List<String> tempMouth = svgMouth.split(">");
      print(tempMouth.length);
      if (tempMouth.length-1 == 1) { // 1 seul objet a bouger
        if (tempMouth[0].contains("path")) {
          List<String> tempCoord = tempMouth[0].split("m");
          // tempCoord[0] + m = partie gauche

          List<String> tempCoord2 = tempCoord[1].split("c");
          // c + tempCoord2[1] + > = partie droite
          List<String> tempCoord3 = tempCoord2[0].split(",");
          double newCoord = double.parse(tempCoord3[1])+1.5;
          // tempCoord3[0] + , + tempCoord3[1] = partie du milieu
          int i = 1;
          String coord2 ='''''';
          while (i < tempCoord2.length) {
            if (i != tempCoord2.length-1) {
              coord2 = coord2 + tempCoord2[i] +'''c''';
            } else {
              coord2 = coord2 + tempCoord2[i];
            }
            i++;
          }
          if (tempCoord.length>2) {
            int x = 2;
            while (x < tempCoord.length) {
              coord2 = coord2 +'''m''' +tempCoord[x];
              x++;
            }
          }
          setState(() {
            svgMouth = tempCoord[0] + '''m''' + tempCoord3[0] +''','''+ newCoord.toString()+'''c'''+coord2+'''>''';
            print(svgMouth);
          });
        }
      }
    } else if (move == 3) { // Details

    }
  }

  void _clearEmoji() {
    setState(() {
      svgBase = ''' ''';
      svgEyes = ''' ''';
      svgMouth = ''' ''';
      svgDetails = ''' ''';
    });
  }

  void _randomEmoji() {
    var rng = new Random();
    setState(() {
      svgBase = listBase[rng.nextInt(listBase.length)].rawSVG;
      svgEyes = listEyes[rng.nextInt(listEyes.length)].rawSVG;
      svgMouth = listMouth[rng.nextInt(listMouth.length)].rawSVG;
      svgDetails = listDetails[rng.nextInt(listDetails.length)].rawSVG;
    });
  }

  Widget getMenu() {
    if (menu == 4) {
      return GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: List.generate(5, (index) {
          return new GestureDetector(
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.black12,
                border: new Border.all(color: Colors.grey),
                borderRadius: new BorderRadius.all(Radius.circular(30.0)),
              ),
              child: Center(
                  child: Column(
                children: getButton(index),
              )),
            ),
            onTap: () {
              setState(() {
                if(index!=4) {
                  menu = index;
                } else {
                  menu = 5;
                }
              });
            },
          );
        }),
      );
    } else if (menu == 0) {
      // Base
      return GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: List.generate(listBase.length + 1, (index) {
          // +1 pour bouton back
          return new GestureDetector(
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.black12,
                border: new Border.all(color: Colors.grey),
                borderRadius: new BorderRadius.all(Radius.circular(30.0)),
              ),
              child: Center(
                  child: Column(
                children: index == 0
                    ? getReturn()
                    : getEmoji(index - 1) // -1 car bouton back
                ,
              )),
            ),
            onTap: () {
              if (index == 0) {
                setState(() {
                  menu = 4;
                });
              } else {
                setState(() {
                  svgBase = listBase[index - 1].rawSVG;
                });
              }
            },
          );
        }),
      );
    } else if (menu == 1) {
      // Eyes
      return GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: List.generate(listEyes.length + 1, (index) {
          return new GestureDetector(
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.black12,
                border: new Border.all(color: Colors.grey),
                borderRadius: new BorderRadius.all(Radius.circular(30.0)),
              ),
              child: Center(
                  child: Column(
                children: index == 0
                    ? getReturn()
                    : getEmoji(index - 1) // -1 car bouton back
                ,
              )),
            ),
            onTap: () {
              if (index == 0) {
                setState(() {
                  menu = 4;
                });
              } else {
                setState(() {
                  svgEyes = listEyes[index - 1].rawSVG;
                });
              }
            },
          );
        }),
      );
    } else if (menu == 2) {
      // Mouth
      return GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: List.generate(listMouth.length + 1, (index) {
          return new GestureDetector(
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.black12,
                border: new Border.all(color: Colors.grey),
                borderRadius: new BorderRadius.all(Radius.circular(30.0)),
              ),
              child: Center(
                  child: Column(
                children: index == 0
                    ? getReturn()
                    : getEmoji(index - 1) // -1 car bouton back
                ,
              )),
            ),
            onTap: () {
              if (index == 0) {
                setState(() {
                  menu = 4;
                });
              } else {
                setState(() {
                  svgMouth = listMouth[index - 1].rawSVG;
                });
              }
            },
          );
        }),
      );
    } else if (menu == 3) {
      // Details
      return GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: List.generate(listDetails.length + 1, (index) {
          return new GestureDetector(
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.black12,
                border: new Border.all(color: Colors.grey),
                borderRadius: new BorderRadius.all(Radius.circular(30.0)),
              ),
              child: Center(
                  child: Column(
                children: index == 0
                    ? getReturn()
                    : getEmoji(index - 1) // -1 car bouton back
                ,
              )),
            ),
            onTap: () {
              if (index == 0) {
                setState(() {
                  menu = 4;
                });
              } else {
                setState(() {
                  svgDetails = listDetails[index - 1].rawSVG;
                });
              }
            },
          );
        }),
      );
    } else if (menu == 5) {
      // Move choose
      return GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: List.generate(5, (index) {
          return new GestureDetector(
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.black12,
                border: new Border.all(color: Colors.grey),
                borderRadius: new BorderRadius.all(Radius.circular(30.0)),
              ),
              child: Center(
                  child: Column(
                      children: index == 0
                          ? getReturn()
                          : getMoveChoose(index - 1) // -1 car bouton back
                      )),
            ),
            onTap: () {
              if (index == 0) {
                setState(() {
                  menu = 4;
                });
              } else {
                setState(() {
                  menu = 6;
                  move = index-1;
                });
              }
            },
          );
        }),
      );
    } else if (menu == 6) {
      // Move details
      return GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: List.generate(5, (index) {
          return new GestureDetector(
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.black12,
                border: new Border.all(color: Colors.grey),
                borderRadius: new BorderRadius.all(Radius.circular(30.0)),
              ),
              child: Center(
                  child: Column(
                      children: index == 0
                          ? getReturn()
                          : getMove(index - 1) // -1 car bouton back
                      )),
            ),
            onTap: () {
              if (index == 0) {
                setState(() {
                  menu = 5;
                });
              } else {
                _moveEmoji(index-1);
                print(
                    "_____________________________________________________Pressed : " +
                        (index-1).toString() +" AND ITEM : " + move.toString());
              }
            },
          );
        }),
      );
    }
  }

  List<Widget> getSave() {
    List listings = new List<Widget>();
    listings.add(Spacer());
    listings.add(Icon(Icons.save_alt, size: 50));
    listings.add(Text('Save', style: TextStyle(fontSize: 15)));
    listings.add(Spacer());
    return listings;
  }

  List<Widget> getClear() {
    List listings = new List<Widget>();
    listings.add(Spacer());
    listings.add(Icon(Icons.clear, size: 50));
    listings.add(Text('Clear', style: TextStyle(fontSize: 15)));
    listings.add(Spacer());
    return listings;
  }

  List<Widget> getRandom() {
    List listings = new List<Widget>();
    listings.add(Spacer());
    listings.add(Icon(Icons.cached, size: 50));
    listings.add(Text('Random', style: TextStyle(fontSize: 15)));
    listings.add(Spacer());
    return listings;
  }

  List<Widget> getReturn() {
    List listings = new List<Widget>();
    listings.add(Spacer());
    listings.add(Icon(Icons.arrow_back, size: 50));
    listings.add(Text('Back', style: TextStyle(fontSize: 15)));
    listings.add(Spacer());
    return listings;
  }

  List<Widget> getEmoji(int index) {
    List listings = new List<Widget>();

    if (menu == 0) {
      String svgBuild = svgHeader + listBase[index].rawSVG + svgFooter;
      SvgPicture svg = SvgPicture.string(
        svgBuild,
        height: 50,
        width: 50,
      );
      listings.add(Spacer());
      listings.add(svg);
      listings.add(Text(listBase[index].name, style: TextStyle(fontSize: 15)));
      listings.add(Spacer());
    } else if (menu == 1) {
      String svgBuild = svgHeader + listEyes[index].rawSVG + svgFooter;
      SvgPicture svg = SvgPicture.string(
        svgBuild,
        height: 50,
        width: 50,
      );
      listings.add(Spacer());
      listings.add(svg);
      listings.add(Text(listEyes[index].name, style: TextStyle(fontSize: 15)));
      listings.add(Spacer());
    } else if (menu == 2) {
      String svgBuild = svgHeader + listMouth[index].rawSVG + svgFooter;
      SvgPicture svg = SvgPicture.string(
        svgBuild,
        height: 50,
        width: 50,
      );
      listings.add(Spacer());
      listings.add(svg);
      listings.add(Text(listMouth[index].name, style: TextStyle(fontSize: 15)));
      listings.add(Spacer());
    } else if (menu == 3) {
      String svgBuild = svgHeader + listDetails[index].rawSVG + svgFooter;
      SvgPicture svg = SvgPicture.string(
        svgBuild,
        height: 50,
        width: 50,
      );
      listings.add(Spacer());
      listings.add(svg);
      listings
          .add(Text(listDetails[index].name, style: TextStyle(fontSize: 15)));
      listings.add(Spacer());
    }
    return listings;
  }

  List<Widget> getButton(int index) {
    List listings = new List<Widget>();

    if (index == 0) {
      String svgBuild =
          '''<svg width="36" height="36" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">
 <g class="layer">
  <title>Layer 1</title>
  <path id="svg_1" d="m36,18c0,9.941 -8.059,18 -18,18s-18,-8.059 -18,-18s8.059,-18 18,-18s18,8.059 18,18" fill="#FFCC4D"/>
 </g>
</svg>''';
      SvgPicture svg = SvgPicture.string(
        svgBuild,
        height: 50,
        width: 50,
      );
      listings.add(Spacer());
      listings.add(svg);
      listings.add(Text('Base', style: TextStyle(fontSize: 15)));
      listings.add(Spacer());
    } else if (index == 1) {
      String svgBuild =
          '''<svg width="36" height="36" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">
 <g class="layer">
  <title>Layer 1</title>
  <path fill="#DD2E44" d="m16.65,3.281c-0.859,-2.431 -3.524,-3.707 -5.956,-2.85c-1.476,0.52 -2.521,1.711 -2.928,3.104c-1.191,-0.829 -2.751,-1.1 -4.225,-0.58c-2.43,0.858 -3.708,3.525 -2.849,5.956c0.122,0.344 0.284,0.663 0.472,0.958c1.951,3.582 7.588,6.1 11.001,6.131c2.637,-2.167 5.446,-7.665 4.718,-11.677c-0.038,-0.348 -0.113,-0.698 -0.233,-1.042zm2.7,0c0.859,-2.431 3.525,-3.707 5.956,-2.85c1.476,0.52 2.521,1.711 2.929,3.104c1.191,-0.829 2.751,-1.1 4.225,-0.58c2.43,0.858 3.707,3.525 2.85,5.956c-0.123,0.344 -0.284,0.663 -0.473,0.958c-1.951,3.582 -7.588,6.1 -11.002,6.131c-2.637,-2.167 -5.445,-7.665 -4.717,-11.677c0.037,-0.348 0.112,-0.698 0.232,-1.042z"/>
 </g>
</svg>''';
      SvgPicture svg = SvgPicture.string(
        svgBuild,
        height: 50,
        width: 50,
      );
      listings.add(Spacer());
      listings.add(svg);
      listings.add(Text('Eyes', style: TextStyle(fontSize: 15)));
      listings.add(Spacer());
    } else if (index == 2) {
      String svgBuild =
          '''<svg width="36" height="36" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">
 <g class="layer">
  <title>Layer 1</title>
  <path fill="#664500" d="m18,21.849c-2.966,0 -4.935,-0.346 -7.369,-0.819c-0.557,-0.106 -1.638,0 -1.638,1.638c0,3.275 3.763,7.369 9.007,7.369s9.007,-4.094 9.007,-7.369c0,-1.638 -1.082,-1.745 -1.638,-1.638c-2.434,0.473 -4.402,0.819 -7.369,0.819"/>
 </g>
</svg>''';
      SvgPicture svg = SvgPicture.string(
        svgBuild,
        height: 50,
        width: 50,
      );
      listings.add(Spacer());
      listings.add(svg);
      listings.add(Text('Mouth', style: TextStyle(fontSize: 15)));
      listings.add(Spacer());
    } else if (index == 3) {
      String svgBuild =
          '''<svg width="36" height="36" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">
 <g class="layer">
  <title>Layer 1</title>
  <path fill="#5DADEC" d="m23,23c6.211,0 13,4 13,9c0,4 -3,4 -3,4c-8,0 -1,-9 -10,-13z"/>
 </g>
</svg>''';
      SvgPicture svg = SvgPicture.string(
        svgBuild,
        height: 50,
        width: 50,
      );
      listings.add(Spacer());
      listings.add(svg);
      listings.add(Text('Details', style: TextStyle(fontSize: 15)));
      listings.add(Spacer());
    } else if (index == 4) {
      listings.add(Spacer());
      listings.add(Transform.rotate(
          angle: -pi / 4, child: Icon(Icons.zoom_out_map, size: 50)));
      listings.add(Text('Move', style: TextStyle(fontSize: 15)));
      listings.add(Spacer());
    }

    return listings;
  }

  List<Widget> getMove(int index) {
    List listings = new List<Widget>();

    if (index == 0) {
      listings.add(Spacer());
      listings.add(Icon(Icons.keyboard_arrow_left, size: 50));
      listings.add(Text("Left", style: TextStyle(fontSize: 15)));
      listings.add(Spacer());
    } else if (index == 1) {
      listings.add(Spacer());
      listings.add(Icon(Icons.keyboard_arrow_right, size: 50));
      listings.add(Text("Right", style: TextStyle(fontSize: 15)));
      listings.add(Spacer());
    } else if (index == 2) {
      listings.add(Spacer());
      listings.add(Icon(Icons.keyboard_arrow_up, size: 50));
      listings.add(Text("Up", style: TextStyle(fontSize: 15)));
      listings.add(Spacer());
    } else if (index == 3) {
      listings.add(Spacer());
      listings.add(Icon(Icons.keyboard_arrow_down, size: 50));
      listings.add(Text("Down", style: TextStyle(fontSize: 15)));
      listings.add(Spacer());
    }
    return listings;
  }

  List<Widget> getMoveChoose(int index) {
    List listings = new List<Widget>();

    if (index == 0) {
      String svgBuild =
          '''<svg width="36" height="36" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">
 <g class="layer">
  <title>Layer 1</title>
  <path id="svg_1" d="m36,18c0,9.941 -8.059,18 -18,18s-18,-8.059 -18,-18s8.059,-18 18,-18s18,8.059 18,18" fill="#FFCC4D"/>
 </g>
</svg>''';
      SvgPicture svg = SvgPicture.string(
        svgBuild,
        height: 50,
        width: 50,
      );
      listings.add(Spacer());
      listings.add(svg);
      listings.add(Text('Move Base', style: TextStyle(fontSize: 15)));
      listings.add(Spacer());
    } else if (index == 1) {
      String svgBuild =
          '''<svg width="36" height="36" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">
 <g class="layer">
  <title>Layer 1</title>
  <path fill="#DD2E44" d="m16.65,3.281c-0.859,-2.431 -3.524,-3.707 -5.956,-2.85c-1.476,0.52 -2.521,1.711 -2.928,3.104c-1.191,-0.829 -2.751,-1.1 -4.225,-0.58c-2.43,0.858 -3.708,3.525 -2.849,5.956c0.122,0.344 0.284,0.663 0.472,0.958c1.951,3.582 7.588,6.1 11.001,6.131c2.637,-2.167 5.446,-7.665 4.718,-11.677c-0.038,-0.348 -0.113,-0.698 -0.233,-1.042zm2.7,0c0.859,-2.431 3.525,-3.707 5.956,-2.85c1.476,0.52 2.521,1.711 2.929,3.104c1.191,-0.829 2.751,-1.1 4.225,-0.58c2.43,0.858 3.707,3.525 2.85,5.956c-0.123,0.344 -0.284,0.663 -0.473,0.958c-1.951,3.582 -7.588,6.1 -11.002,6.131c-2.637,-2.167 -5.445,-7.665 -4.717,-11.677c0.037,-0.348 0.112,-0.698 0.232,-1.042z"/>
 </g>
</svg>''';
      SvgPicture svg = SvgPicture.string(
        svgBuild,
        height: 50,
        width: 50,
      );
      listings.add(Spacer());
      listings.add(svg);
      listings.add(Text('Move Eyes', style: TextStyle(fontSize: 15)));
      listings.add(Spacer());
    } else if (index == 2) {
      String svgBuild =
          '''<svg width="36" height="36" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">
 <g class="layer">
  <title>Layer 1</title>
  <path fill="#664500" d="m18,21.849c-2.966,0 -4.935,-0.346 -7.369,-0.819c-0.557,-0.106 -1.638,0 -1.638,1.638c0,3.275 3.763,7.369 9.007,7.369s9.007,-4.094 9.007,-7.369c0,-1.638 -1.082,-1.745 -1.638,-1.638c-2.434,0.473 -4.402,0.819 -7.369,0.819"/>
 </g>
</svg>''';
      SvgPicture svg = SvgPicture.string(
        svgBuild,
        height: 50,
        width: 50,
      );
      listings.add(Spacer());
      listings.add(svg);
      listings.add(Text('Move Mouth', style: TextStyle(fontSize: 15)));
      listings.add(Spacer());
    } else if (index == 3) {
      String svgBuild =
          '''<svg width="36" height="36" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">
 <g class="layer">
  <title>Layer 1</title>
  <path fill="#5DADEC" d="m23,23c6.211,0 13,4 13,9c0,4 -3,4 -3,4c-8,0 -1,-9 -10,-13z"/>
 </g>
</svg>''';
      SvgPicture svg = SvgPicture.string(
        svgBuild,
        height: 50,
        width: 50,
      );
      listings.add(Spacer());
      listings.add(svg);
      listings.add(Text('Move Detail', style: TextStyle(fontSize: 15)));
      listings.add(Spacer());
    }

    return listings;
  }
}
