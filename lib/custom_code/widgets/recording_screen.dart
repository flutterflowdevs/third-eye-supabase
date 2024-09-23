// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom widgets

import 'package:third_eye_supabase/index.dart';

import 'index.dart'; // Imports other custom widgets

import 'index.dart'; // Imports other custom widgets

import 'index.dart'; // Imports other custom widgets

import 'dart:io';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

class RecordingScreen extends StatefulWidget {
  const RecordingScreen({
    super.key,
    this.width,
    this.height,
    required this.time,
  });

  final double? width;
  final double? height;
  final int time;

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  late CameraController _controller;
  late List<CameraDescription> _cameras;
  bool _isRecording = false;
  String? _videoPath;
  Timer? _stopTimer;
  late AudioPlayer _preRecordingAudioPlayer;
  late AudioPlayer _recordingAudioPlayer;

  @override
  void initState() {
    super.initState();
    _preRecordingAudioPlayer = AudioPlayer();
    _recordingAudioPlayer = AudioPlayer();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(
      _cameras.first,
      ResolutionPreset.high,
    );

    try {
      await _controller.initialize();
      setState(() {});

      _playPreRecordingSound();
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _playPreRecordingSound() async {
    String startAudio = FFLocalizations.of(context).languageCode == 'en'
        ? 'assets/audios/start_audio.mp3'
        : 'assets/audios/start_recording_in_hindi.mp3';

    try {
      await _preRecordingAudioPlayer.setAsset(startAudio); // First sound
      await _preRecordingAudioPlayer.play();

      _preRecordingAudioPlayer.playbackEventStream.listen((event) {
        if (event.processingState == ProcessingState.completed) {
          _preRecordingAudioPlayer.dispose();
          _startRecording();
        }
      });
    } catch (e) {
      print('Error playing pre-recording sound: $e');
    }
  }

  Future<void> _playRecordingSound() async {
    try {
      await _recordingAudioPlayer
          .setAsset('assets/audios/recording_sound.mp3'); // Second sound
      await _recordingAudioPlayer.setLoopMode(LoopMode.off); // Play in a loop
      await _recordingAudioPlayer.play();
    } catch (e) {
      print('Error playing recording sound: $e');
    }
  }

  Future<void> _startRecording() async {
    if (!_controller.value.isInitialized) return;

    if (_controller.value.isRecordingVideo) return;

    final Directory tempDir = await getTemporaryDirectory();
    final String tempFilePath =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.temp';

    try {
      await _controller.startVideoRecording();
      setState(() {
        _isRecording = true;
        _videoPath = tempFilePath;
      });

      //_playRecordingSound();
      _stopTimer = Timer(Duration(seconds: widget.time), _stopRecording);
    } catch (e) {
      print('Error starting video recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    if (!_controller.value.isRecordingVideo) return;
    try {
      final XFile videoFile = await _controller.stopVideoRecording();
      final Directory tempDir = await getTemporaryDirectory();
      final String newFilePath =
          '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';

      // Rename the file from .temp to .mp4
      final File tempFile = File(videoFile.path);
      final File renamedFile = await tempFile.rename(newFilePath);

      setState(() {
        _isRecording = false;
        _videoPath = renamedFile.path;
      });

      _stopTimer?.cancel();

      // Stop the recording sound
      await _recordingAudioPlayer.stop();
      await _recordingAudioPlayer.dispose();
      _controller.dispose();
      print('Video path: $_videoPath');
      await uploadVideoFile(_videoPath!);

      // Navigate to the HomePage with the video path
    } catch (e) {
      print('Error stopping video recording: $e');
    }
  }

  Future uploadVideoFile(String filePath) async {
    try {
      print("Preparing to upload file...");

      final file = File(filePath);
      final bytes = await file.readAsBytes();

      final dio = Dio()
        ..interceptors.add(LogInterceptor(
          responseBody: true,
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
        ));

      final multipartFile = MultipartFile.fromBytes(
        bytes,
        filename: path.basename(filePath),
        contentType: MediaType('video', 'mp4'), // Specify the content type
      );

      final formData = FormData.fromMap({
        'video': multipartFile,
      });

      final response = await dio.post(
        'https://vision-ai-soiuxz4bbq-uc.a.run.app/convert_video',
        data: formData,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('File uploaded successfully');
        dynamic apiResp = response.data;
        String encodeJson = jsonEncode(apiResp);
        print(encodeJson);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                ListenRecordingPageWidget(recordingInText: encodeJson),
          ),
        );
        // return response.data;
      } else {
        print('Failed to upload file. Status code: ${response.statusCode}');
        // return response.data['message'] ?? 'Unknown error occurred';
      }
    } catch (e) {
      print('Error: $e');
      // return [
      //   {'message': 'Failed to upload file. Error: ${e.toString()}'}
      // ];
    }
  }

  @override
  void dispose() {
    _stopTimer?.cancel();
    _preRecordingAudioPlayer.dispose();
    _recordingAudioPlayer.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isRecording) {
      return const Center(
          child: CircularProgressIndicator(
        color: Color(0xFF86C144),
      ));
    }

    return Scaffold(
      body: CameraPreview(_controller),
    );
  }
}
