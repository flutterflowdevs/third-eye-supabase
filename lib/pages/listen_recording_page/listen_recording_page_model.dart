import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'listen_recording_page_widget.dart' show ListenRecordingPageWidget;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ListenRecordingPageModel
    extends FlutterFlowModel<ListenRecordingPageWidget> {
  ///  Local state fields for this page.

  dynamic textToSpeechRsp;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in ListenRecordingPage widget.
  List<UsersRow>? userData;
  // Stores action output result for [Gemini - Generate Text] action in ListenRecordingPage widget.
  String? ggOutput;
  // Stores action output result for [Backend Call - API (Test to speech)] action in ListenRecordingPage widget.
  ApiCallResponse? apiResultuk5;
  AudioPlayer? soundPlayer1;
  AudioPlayer? soundPlayer2;
  AudioPlayer? soundPlayer3;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
