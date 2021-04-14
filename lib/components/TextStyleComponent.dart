import 'dart:ui';

import './Colors.dart';
import 'package:flutter/material.dart';

class TextStyleComponent {
  // Black
  static const TextStyle boldBlack36 = TextStyle(
    color: Colors.black,
    fontFamily: 'SoleilW01',
    fontSize: 36,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle boldBlack24 = TextStyle(
    color: Colors.black,
    fontFamily: 'SoleilW01',
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle boldOrange22 = TextStyle(
    color: Color(0XFFEB7F00),
    fontFamily: 'SoleilW01',
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle boldBlack20 = TextStyle(
    color: Colors.black,
    fontFamily: 'SoleilW01',
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle boldBlack18 = TextStyle(
    color: Colors.black,
    fontFamily: 'SoleilW01',
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle boldBlack16 = TextStyle(
      color: Colors.black,
      fontFamily: 'SoleilW01',
      fontSize: 16,
      fontWeight: FontWeight.bold);

  static const TextStyle boldBlack14 = TextStyle(
      color: Colors.black,
      fontFamily: 'SoleilW01',
      fontSize: 14,
      fontWeight: FontWeight.bold);

  static const TextStyle boldBlack12 = TextStyle(
      color: Colors.black,
      fontFamily: 'SoleilW01',
      fontSize: 12,
      fontWeight: FontWeight.bold);

  static const TextStyle normalBlack20 =
      TextStyle(color: Colors.black, fontFamily: 'SoleilW01', fontSize: 20);

  static const TextStyle normalBlack18 =
      TextStyle(color: Colors.black, fontFamily: 'SoleilW01', fontSize: 18);

  static const TextStyle bookBlack16 = TextStyle(
      color: Colors.black, fontFamily: 'SoleilW01-Book', fontSize: 16);

  static const TextStyle bookBlack14 = TextStyle(
      color: Colors.black, fontFamily: 'SoleilW01-Book', fontSize: 14);

  static const TextStyle normalBlack12 =
      TextStyle(color: Colors.black, fontFamily: 'SoleilW01', fontSize: 12);

  static const TextStyle normalBlack14 =
      TextStyle(color: Colors.black, fontFamily: 'SoleilW01', fontSize: 14);

  static const TextStyle normalBlack16 =
      TextStyle(color: Colors.black, fontFamily: 'SoleilW01', fontSize: 16);

  static const TextStyle w200Black12 = TextStyle(
    fontFamily: 'SoleilW01',
    fontSize: 12,
    fontWeight: FontWeight.w200,
  );

  // Grey
  static const TextStyle boldGrey14 = TextStyle(
      fontFamily: 'SoleilW01',
      fontSize: 14,
      color: ColorCodes.cGrey,
      fontWeight: FontWeight.bold);

  static const TextStyle normalGrey16 = TextStyle(
      fontFamily: 'SoleilW01-Book', fontSize: 16, color: ColorCodes.cGrey);

  static const TextStyle normalGrey14 =
      TextStyle(fontFamily: 'SoleilW01', fontSize: 14, color: ColorCodes.cGrey);

  static const TextStyle normalLightGrey10 = TextStyle(
      fontFamily: 'SoleilW01', fontSize: 10, color: ColorCodes.cLightGrey);

  static const TextStyle normalLightGrey12 = TextStyle(
      fontFamily: 'SoleilW01', fontSize: 12, color: ColorCodes.cLightGrey);

  static const TextStyle normalDarkGrey14 = TextStyle(
      fontFamily: 'SoleilW01', fontSize: 14, color: ColorCodes.cDarkGrey);

  static const TextStyle boldDisabledGrey12 = TextStyle(
      fontFamily: 'SoleilW01',
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: ColorCodes.cDisabledGrey);

  static const TextStyle normalDisabledGrey10 = TextStyle(
      fontFamily: 'SoleilW01', fontSize: 10, color: ColorCodes.cDisabledGrey);

  static const TextStyle normalDisabledGrey16 = TextStyle(
      fontFamily: 'SoleilW01',
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: ColorCodes.cDisabledGrey);

  // White
  static const TextStyle boldWhite20 = TextStyle(
      fontFamily: 'SoleilW01',
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold);

  static const TextStyle normalWhite14 =
      TextStyle(fontFamily: 'SoleilW01', fontSize: 14, color: Colors.white);

  // Purple
  static const TextStyle boldPurple14 = TextStyle(
    color: ColorCodes.cPurple,
    fontSize: 14,
    fontFamily: "SoleilW01",
    fontWeight: FontWeight.bold,
  );

  static const TextStyle boldPurple16 = TextStyle(
    color: ColorCodes.cPurple,
    fontSize: 16,
    fontFamily: "SoleilW01",
    fontWeight: FontWeight.bold,
  );

  static const TextStyle normalMediumPurple10 = TextStyle(
      fontFamily: 'SoleilW01', fontSize: 10, color: ColorCodes.cMediumPurple);

  static const TextStyle normalPurple14 = TextStyle(
      fontFamily: 'SoleilW01-Book',
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: ColorCodes.cPurple);

  static const TextStyle normalPurple16 = TextStyle(
      fontFamily: 'SoleilW01',
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: ColorCodes.cPurple);

  // Red
  static const TextStyle normalRed12 =
      TextStyle(fontFamily: 'SoleilW01', fontSize: 12, color: Colors.red);

  // Orange
  static const TextStyle bookOrange12 = TextStyle(
      color: ColorCodes.cOrange, fontFamily: "SoleilW01-Book", fontSize: 12);

  // Green
  static const TextStyle bookGreen12 = TextStyle(
      color: ColorCodes.cGreen, fontFamily: "SoleilW01-Book", fontSize: 12);

  // Styles for V2 --Rudra

  static const TextStyle v2boldBlack30 = TextStyle(
    color: Color(0xFF282828),
    fontFamily: 'SoleilW01',
    fontSize: 30,
    height: 1.2,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle v2lightBlack20 = TextStyle(
    color: Color(0xFF282828),
    fontFamily: 'SoleilW01',
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle v2normalWhite18 = TextStyle(
    color: Colors.white,
    fontFamily: 'SoleilW01',
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle v2BluePurple16 = TextStyle(
      fontFamily: 'SoleilW01',
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: ColorCodes.cBluePurple);
  static const TextStyle v2normalWhite16 = TextStyle(
    fontFamily: 'SoleilW01',
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  static const TextStyle v2normalGrey16 = TextStyle(
      fontFamily: 'SoleilW01',
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: ColorCodes.cLightGrey);

  static const TextStyle v2normalGrey18 = TextStyle(
      fontFamily: 'SoleilW01-Book',
      fontSize: 18,
      color: ColorCodes.cButtonGrey);

  static const TextStyle v2Error14 = TextStyle(
    fontFamily: 'SoleilW01-Book',
    fontSize: 14,
    color: ColorCodes.cErrorRed,
  );

  static TextStyle v2LinkBlue16 = TextStyle(
      fontFamily: 'SoleilW01',
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.lightBlue[900]);

  static TextStyle v2SettingList = TextStyle(
      fontFamily: 'SoleilW01',
      fontSize: 18,
      letterSpacing: 1,
      fontWeight: FontWeight.w500,
      color: Colors.white70);
}
