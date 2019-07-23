import 'package:flutter/material.dart';

class Emoji {
  int type; //Type de l'emoji : 0 pour Base , 1 pour eyes, 2 pour mouth et 3 pour details
  String rawSVG; //SVG de l'Emoji
  int isFront; //SVG de l'Emoji


  getType() {
    return type;
  }

  getSvg() {
    return rawSVG;
  }

  getisFront() {
    return isFront;
  }

  Emoji(this.type, this.rawSVG, this.isFront);
}
