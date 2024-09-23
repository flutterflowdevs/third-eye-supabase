import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

List<dynamic> getLanguages() {
  List<dynamic> lang = [
    {"language": "English", "lang_code": "en"},
    {"language": "Hindi", "lang_code": "hi"}
  ];
  return lang;
}

String getLangCode(String langCode) {
  print("***********");

  print(langCode);

  print("***********");

  return langCode;
}

List<String> testing() {
  List<String> tst = [];
  Map<Object, String> test = {"abc": "122", "b": "ppp"};
  tst.add(test["abc"] ?? "");
  tst.add(test["b"] ?? "");
  return tst;
}

dynamic getStringToJson(String strResp) {
  dynamic convetedData = {};
  print("check here***");
  print(strResp);
  convetedData = jsonDecode(strResp);
  print("end here***");
  return convetedData;
}

String getProperString(String oldString) {
  String newString = oldString.replaceAll(RegExp(r'[^\w\s]'), '');

  print(newString);

  return newString;
}

String getFirstCharOfName(String userName) {
  return userName.trim()[0].toUpperCase();
}
