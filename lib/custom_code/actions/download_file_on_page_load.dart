// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future downloadFileOnPageLoad() async {
  // Add your function code here!
  try {
    // The URL to download the file from
    String url =
        "https://firebasestorage.googleapis.com/v0/b/farmers-help-rb0ek4.appspot.com/o/object_labeler.tflite?alt=media&token=b5e6a479-0a49-4354-bf78-191e5f8f719d";

    // Get the directory to save the file
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.path}/object_labeler.tflite';

    // Make the HTTP GET request
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Write the file to the device
      File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      ;
    } else {
      throw Exception('Failed to download file');
    }
  } catch (e) {
    print('Error: $e');
  } finally {}
}
