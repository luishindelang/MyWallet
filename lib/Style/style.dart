import 'package:flutter/material.dart';

//Color

const background = Color.fromARGB(255, 255, 188, 188);
const forground = Color.fromARGB(255, 255, 60, 60);
const forgroundSecondery = Color.fromARGB(255, 255, 90, 90);
const forgroundSelected = Color.fromARGB(255, 255, 30, 30);

const text = Color.fromARGB(255, 255, 10, 10);
const textSelected = Color.fromARGB(255, 255, 245, 245);

const icon = Color.fromARGB(255, 255, 10, 10);
const iconSelected = Color.fromARGB(255, 255, 245, 245);

const boxBackround = Color.fromARGB(255, 255, 123, 123);
const boxBorder = Color.fromARGB(255, 255, 30, 30);
const boxShadow = Color.fromARGB(150, 255, 180, 180);

const buttonBackground = Color.fromARGB(255, 255, 225, 225);
const buttonForground = Color.fromARGB(255, 255, 30, 30);
const buttonSplash = Color.fromARGB(110, 171, 171, 171);

const switchActive = Color.fromARGB(255, 255, 30, 30);
const switchActiveTrack = Color.fromARGB(60, 255, 30, 30);
const switchInactive = Color.fromARGB(255, 255, 150, 150);
const switchInactiveTrack = Color.fromARGB(60, 255, 150, 150);
const switchBorder = Color.fromARGB(255, 255, 30, 30);

const fieldBorder = Color.fromARGB(255, 255, 51, 51);
const fieldCurser = Color.fromARGB(255, 255, 51, 51);

//Border

const double borderRadius = 5;
const double borderWith = 1;

//Shadow

const double shadowRadius = 1;
const double shadowBlur = 2;

//Padding-Margin

const double boxPL = 15;
const double boxPT = 5;
const double boxPR = 15;
const double boxPB = 5;

const boxMargin = EdgeInsets.fromLTRB(10, 10, 10, 0);
const boxTitlePadding = EdgeInsets.fromLTRB(boxPL, 0, 0, 0);
const boxChildPadding = EdgeInsets.fromLTRB(boxPL, boxPT, boxPR, boxPB);

const numberBoxPadding = EdgeInsets.fromLTRB(20, 20, 30, 0);

const popupContextPadding = EdgeInsets.fromLTRB(0, 5, 0, 0);

const addAccountBodyPadding = EdgeInsets.fromLTRB(20, 20, 20, 20);

//Text-Style

const b9 = FontWeight.w900;
const b8 = FontWeight.w800;
const b7 = FontWeight.w700;
const b6 = FontWeight.w600;
const b5 = FontWeight.w500;
const b4 = FontWeight.w400;

TextStyle textCalcNum(Color color) =>
    TextStyle(fontSize: 60, fontWeight: b5, color: color);
TextStyle textCalcField(Color color) =>
    TextStyle(fontSize: 50, fontWeight: b5, color: color);

TextStyle textXXL(Color color) =>
    TextStyle(fontSize: 38, fontWeight: b6, color: color);
TextStyle textXL(Color color) =>
    TextStyle(fontSize: 30, fontWeight: b6, color: color);
TextStyle textL(Color color) =>
    TextStyle(fontSize: 24, fontWeight: b6, color: color);
TextStyle textM(Color color) =>
    TextStyle(fontSize: 20, fontWeight: b5, color: color);
TextStyle textS(Color color) =>
    TextStyle(fontSize: 16, fontWeight: b5, color: color);
TextStyle textXS(Color color) =>
    TextStyle(fontSize: 14, fontWeight: b4, color: color);

TextStyle textXXLB(Color color) =>
    TextStyle(fontSize: 38, fontWeight: b9, color: color);
TextStyle textXLB(Color color) =>
    TextStyle(fontSize: 30, fontWeight: b9, color: color);
TextStyle textLB(Color color) =>
    TextStyle(fontSize: 24, fontWeight: b8, color: color);
TextStyle textMB(Color color) =>
    TextStyle(fontSize: 20, fontWeight: b8, color: color);
TextStyle textSB(Color color) =>
    TextStyle(fontSize: 16, fontWeight: b8, color: color);
TextStyle textXSB(Color color) =>
    TextStyle(fontSize: 14, fontWeight: b7, color: color);

const textInput = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: text,
);
