// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:speech_to_text/speech_to_text.dart';
import 'dart:async';

Future<String> getTextFromSpeech() async {
  // Add your function code here!
  Duration duration = const Duration(seconds: 20);
  Completer<String> listenComplete = Completer();
  final SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;

  speechEnabled = await speechToText.initialize();

  if (speechEnabled) {
    speechToText
        .listen(
      onResult: (result) {
        if (speechToText.isNotListening) {
          listenComplete.complete(result.recognizedWords);
          speechToText.stop();
        }
      },
      pauseFor: duration,
    )
        .onError((error, stackTrace) {
      listenComplete.complete(error.toString());
    });
  } else {
    listenComplete.complete("Speech to text service not enable");
  }
  return listenComplete.future;
}
