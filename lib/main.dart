import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:emoji_maker/emoji.dart';

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
  int menu = 4; // 4 Main, 0 Base, 1 Eyes, 2 Mouth, 3 Details

  void initState() {
    super.initState();
    // listEmoji.add(new Emoji(0, 0, '''COPYME''',0));
    listEmoji.add(new Emoji(0, 0,
        '''<path id="svg_1" d="m36,18c0,9.941 -8.059,18 -18,18s-18,-8.059 -18,-18s8.059,-18 18,-18s18,8.059 18,18" fill="#FFCC4D"/>''',
        0));
    listEmoji.add(new Emoji(1, 1,
        '''<path fill="#DD2E44" d="m16.65,3.281c-0.859,-2.431 -3.524,-3.707 -5.956,-2.85c-1.476,0.52 -2.521,1.711 -2.928,3.104c-1.191,-0.829 -2.751,-1.1 -4.225,-0.58c-2.43,0.858 -3.708,3.525 -2.849,5.956c0.122,0.344 0.284,0.663 0.472,0.958c1.951,3.582 7.588,6.1 11.001,6.131c2.637,-2.167 5.446,-7.665 4.718,-11.677c-0.038,-0.348 -0.113,-0.698 -0.233,-1.042zm2.7,0c0.859,-2.431 3.525,-3.707 5.956,-2.85c1.476,0.52 2.521,1.711 2.929,3.104c1.191,-0.829 2.751,-1.1 4.225,-0.58c2.43,0.858 3.707,3.525 2.85,5.956c-0.123,0.344 -0.284,0.663 -0.473,0.958c-1.951,3.582 -7.588,6.1 -11.002,6.131c-2.637,-2.167 -5.445,-7.665 -4.717,-11.677c0.037,-0.348 0.112,-0.698 0.232,-1.042z"/>''',
        0));
    listEmoji.add(new Emoji(2, 2,
        '''<path fill="#664500" d="m18,21.849c-2.966,0 -4.935,-0.346 -7.369,-0.819c-0.557,-0.106 -1.638,0 -1.638,1.638c0,3.275 3.763,7.369 9.007,7.369s9.007,-4.094 9.007,-7.369c0,-1.638 -1.082,-1.745 -1.638,-1.638c-2.434,0.473 -4.402,0.819 -7.369,0.819"/>''',
        0));
    listEmoji.add(new Emoji(3, 3,
        '''<path fill="#5DADEC" d="m23,23c6.211,0 13,4 13,9c0,4 -3,4 -3,4c-8,0 -1,-9 -10,-13z"/>''',
        0));

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




  final String svgHeader = '''<svg width="36" height="36" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">''';
  String svgBase = ''' ''';
  String svgEyes = ''' ''';
  String svgMouth = ''' ''';
  String svgDetail = ''' ''';
  final String svgFooter = '''</svg>''';

  Widget getSVG() {
    String svgBuild =
        svgHeader + svgBase + svgEyes + svgMouth + svgDetail + svgFooter;
    return SvgPicture.string(
      svgBuild,
      height: 150,
      width: 150,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(children: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getSVG()
          ])),
        Align(
            alignment: Alignment(1, 0.95),
            child: SizedBox(
              width: MediaQuery.of(context).size.width-10,
              height: 100,
              child: getMenu(),
            )),]),
    );
  }

  Widget getMenu() {
    if (menu == 4) {
      return GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: List.generate(4, (index) {
          return new GestureDetector(
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.transparent,
                border: new Border.all(color: Colors.grey),
                borderRadius: new BorderRadius.all(Radius.circular(30.0)),
              ),
              child: Center(
                  child: Column(
                    children:
                    getButton(index)
                    ,
                  )),
            ),
            onTap: () {
              setState(() {
                menu = index;
              });
            },
          );
        }),

      );
    } else if (menu == 0) { // Base
      return GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: List.generate(listBase.length+1, (index) { // +1 pour bouton back
          return new GestureDetector(
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.transparent,
                border: new Border.all(color: Colors.grey),
                borderRadius: new BorderRadius.all(Radius.circular(30.0)),
              ),
              child: Center(
                  child: Column(
                    children:
                        index == 0 ? getReturn() :
                    getEmoji(index-1) // -1 car bouton back
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
                  svgBase = listBase[index-1].rawSVG;
                });
              }
            },
          );
        }),
      );
    } else if (menu == 1) { // Eyes
      return GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: List.generate(listEyes.length+1, (index) {
          return new GestureDetector(
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.transparent,
                border: new Border.all(color: Colors.grey),
                borderRadius: new BorderRadius.all(Radius.circular(30.0)),
              ),
              child: Center(
                  child: Column(
                    children:
                    index == 0 ? getReturn() :
                    getEmoji(index-1) // -1 car bouton back
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
                svgEyes = listEyes[index-1].rawSVG;
              });
              }
            },
          );
        }),
      );
    } else if (menu == 2) { // Mouth
      return GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: List.generate(listMouth.length+1, (index) {
          return new GestureDetector(
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.transparent,
                border: new Border.all(color: Colors.grey),
                borderRadius: new BorderRadius.all(Radius.circular(30.0)),
              ),
              child: Center(
                  child: Column(
                    children:
                    index == 0 ? getReturn() :
                    getEmoji(index-1) // -1 car bouton back
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
                svgMouth = listMouth[index-1].rawSVG;
              });
              }
            },
          );
        }),
      );
    } else if (menu == 3) { // Details
      return GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: List.generate(listDetails.length+1, (index) {
          return new GestureDetector(
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.transparent,
                border: new Border.all(color: Colors.grey),
                borderRadius: new BorderRadius.all(Radius.circular(30.0)),
              ),
              child: Center(
                  child: Column(
                    children:
                    index == 0 ? getReturn() :
                    getEmoji(index-1) // -1 car bouton back
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
                  svgDetail = listDetails[index - 1].rawSVG;
                });
              }
            },
          );
        }),
      );
    }



  }

  List<Widget> getReturn() {
    List listings = new List<Widget>();
      listings.add(Spacer());
      listings.add(Icon(Icons.arrow_back,size: 50));
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
        height: 40,
        width: 40,
      );
      listings.add(Spacer());
      listings.add(svg);
      listings.add(Spacer());
    } else if (menu == 1) {
      String svgBuild = svgHeader + listEyes[index].rawSVG + svgFooter;
      SvgPicture svg = SvgPicture.string(
        svgBuild,
        height: 40,
        width: 40,
      );
      listings.add(Spacer());
      listings.add(svg);
      listings.add(Spacer());
    } else if (menu == 2) {
      String svgBuild = svgHeader + listMouth[index].rawSVG + svgFooter;
      SvgPicture svg = SvgPicture.string(
        svgBuild,
        height: 40,
        width: 40,
      );
      listings.add(Spacer());
      listings.add(svg);
      listings.add(Spacer());
    } else if (menu == 3) {
      String svgBuild = svgHeader + listDetails[index].rawSVG + svgFooter;
      SvgPicture svg = SvgPicture.string(
        svgBuild,
        height: 40,
        width: 40,
      );
      listings.add(Spacer());
      listings.add(svg);
      listings.add(Spacer());
    }
    return listings;
  }



  List<Widget> getButton(int index) {
    List listings = new List<Widget>();

    if (index == 0) {
      String svgBuild ='''<svg width="36" height="36" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">
 <g class="layer">
  <title>Layer 1</title>
  <path id="svg_1" d="m36,18c0,9.941 -8.059,18 -18,18s-18,-8.059 -18,-18s8.059,-18 18,-18s18,8.059 18,18" fill="#FFCC4D"/>
 </g>
</svg>''';
      SvgPicture svg = SvgPicture.string(
        svgBuild,
        height: 40,
        width: 40,
      );
      listings.add(Spacer());
      listings.add(svg);
      listings.add(Text('Base', style: TextStyle(fontSize: 15)));
      listings.add(Spacer());

    } else if (index == 1) {

      String svgBuild ='''<svg width="36" height="36" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">
 <g class="layer">
  <title>Layer 1</title>
  <path fill="#DD2E44" d="m16.65,3.281c-0.859,-2.431 -3.524,-3.707 -5.956,-2.85c-1.476,0.52 -2.521,1.711 -2.928,3.104c-1.191,-0.829 -2.751,-1.1 -4.225,-0.58c-2.43,0.858 -3.708,3.525 -2.849,5.956c0.122,0.344 0.284,0.663 0.472,0.958c1.951,3.582 7.588,6.1 11.001,6.131c2.637,-2.167 5.446,-7.665 4.718,-11.677c-0.038,-0.348 -0.113,-0.698 -0.233,-1.042zm2.7,0c0.859,-2.431 3.525,-3.707 5.956,-2.85c1.476,0.52 2.521,1.711 2.929,3.104c1.191,-0.829 2.751,-1.1 4.225,-0.58c2.43,0.858 3.707,3.525 2.85,5.956c-0.123,0.344 -0.284,0.663 -0.473,0.958c-1.951,3.582 -7.588,6.1 -11.002,6.131c-2.637,-2.167 -5.445,-7.665 -4.717,-11.677c0.037,-0.348 0.112,-0.698 0.232,-1.042z"/>
 </g>
</svg>''';
      SvgPicture svg = SvgPicture.string(
        svgBuild,
        height: 40,
        width: 40,
      );
      listings.add(Spacer());
      listings.add(svg);
      listings.add(Text('Eyes', style: TextStyle(fontSize: 15)));
      listings.add(Spacer());

    } else if (index == 2) {

      String svgBuild ='''<svg width="36" height="36" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">
 <g class="layer">
  <title>Layer 1</title>
  <path fill="#664500" d="m18,21.849c-2.966,0 -4.935,-0.346 -7.369,-0.819c-0.557,-0.106 -1.638,0 -1.638,1.638c0,3.275 3.763,7.369 9.007,7.369s9.007,-4.094 9.007,-7.369c0,-1.638 -1.082,-1.745 -1.638,-1.638c-2.434,0.473 -4.402,0.819 -7.369,0.819"/>
 </g>
</svg>''';
      SvgPicture svg = SvgPicture.string(
        svgBuild,
        height: 40,
        width: 40,
      );
      listings.add(Spacer());
      listings.add(svg);
      listings.add(Text('Mouth', style: TextStyle(fontSize: 15)));
      listings.add(Spacer());

    } else if (index == 3) {

      String svgBuild ='''<svg width="36" height="36" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">
 <g class="layer">
  <title>Layer 1</title>
  <path fill="#5DADEC" d="m23,23c6.211,0 13,4 13,9c0,4 -3,4 -3,4c-8,0 -1,-9 -10,-13z"/>
 </g>
</svg>''';
      SvgPicture svg = SvgPicture.string(
        svgBuild,
        height: 40,
        width: 40,
      );
      listings.add(Spacer());
      listings.add(svg);
      listings.add(Text('Details', style: TextStyle(fontSize: 15)));
      listings.add(Spacer());

    }

    return listings;
  }
}
