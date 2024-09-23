// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom actions

import 'dart:async'; // Required for the Completer
import 'dart:convert';
// import 'dart:html' as html; // Import for web audio playback
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<int> textToSpeech(
  String promptText,
  String? apiKey,
) async {
  // Ensure the API key is provided
  if (apiKey == null || apiKey.isEmpty) {
    throw Exception('API key is required.');
  }

  // Set up the POST request headers.
  Map<String, String> headers = {
    'Authorization': 'Bearer $apiKey',
    'Content-Type': 'application/json',
  };

  // Set up the POST request body.
  String body = json.encode(
      {'model': 'tts-1', 'input': promptText, 'voice': 'nova', 'speed': '1'});

  // Make the POST request to fetch the speech audio.
  final response = await http.post(
    Uri.parse('https://api.openai.com/v1/audio/speech'),
    headers: headers,
    body: body,
  );
  print("*****Here is respose******");
  print(promptText);
  print(response.bodyBytes.runtimeType);

  // Handle the response
  if (response.statusCode == 200) {
    // Create an audio element
    // html.AudioElement audioElement = html.AudioElement()
    //   ..src = 'data:audio/mp3;base64,${base64.encode(response.bodyBytes)}'
    //   ..autoplay = true
    //   ..controls = false;

    final AudioPlayer _audioPlayer = AudioPlayer();
    FFAppState().audioFile =
        'data:audio/mp3;base64,${base64.encode(response.bodyBytes)}';
    print("1");
    final base64Audio = FFAppState().audioFile.split(',').last;
    print("2");
    final Uint8List audioBytes = base64Decode(base64Audio);
    print("3");

    final tempDir = await getTemporaryDirectory();
    print("4");
    final tempFile = File('${tempDir.path}/temp_audio.mp3');
    print("5");

    await tempFile.writeAsBytes(audioBytes);

    print("see here***");
    print(tempFile.path);
    await _audioPlayer.play(DeviceFileSource(tempFile.path));

    // html.document.body?.children.add(audioElement);

    // Completer<int> durationCompleter = Completer<int>();
    // audioElement.onCanPlay.first.then((_) {

    //   int durationMs = (audioElement.duration * 1000).round();
    //   durationCompleter.complete(durationMs);
    // });

    // audioElement.play();

    // Return the duration in milliseconds once it's available
    // return durationCompleter.future;
    return 25;
  } else {
    // If the server did not return a "200 OK response",
    // throw an exception
    throw Exception(
        'Failed to generate speech. Status code: ${response.statusCode}');
  }
}
