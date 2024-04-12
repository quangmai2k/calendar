import 'package:flutter/material.dart';

const sfProFont = "SFPro";

//Style on start screen
const textStartScreen28 =
    TextStyle(fontFamily: sfProFont, fontSize: 28, fontWeight: FontWeight.w700);
const textStartScreen32 =
    TextStyle(fontFamily: sfProFont, fontSize: 32, fontWeight: FontWeight.w700);
const textBtnStartScreen1 = TextStyle(
    fontFamily: sfProFont,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Colors.white);
const textBtnStartScreen2 = TextStyle(
    fontFamily: sfProFont,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.white);
const textCalendar = TextStyle(
    fontFamily: sfProFont,
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: Colors.black);
const textBtnNoActive =
    TextStyle(fontFamily: sfProFont, fontSize: 12, color: Colors.black26);

const textCalendarInMonth = TextStyle(
    fontFamily: sfProFont,
    color: Colors.black,
    fontSize: 12,
    fontWeight: FontWeight.w400);
ButtonStyle bgBtnActive = TextButton.styleFrom(
    minimumSize: Size.zero,
    padding: const EdgeInsets.all(7),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    backgroundColor: Colors.black12);

ButtonStyle bgBtnNoActive = TextButton.styleFrom(
  minimumSize: Size.zero,
  padding: const EdgeInsets.all(7),
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
);
const textBtnActive = TextStyle(
  fontFamily: sfProFont,
  fontSize: 12,
  color: Colors.black,
);

const paddingBox = EdgeInsets.all(20);
