import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'emergency_contactl_page_widget.dart' show EmergencyContactlPageWidget;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class EmergencyContactlPageModel
    extends FlutterFlowModel<EmergencyContactlPageWidget> {
  ///  Local state fields for this page.

  bool isLoaderShown = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in EmergencyContactlPage widget.
  List<EmergencyContactRow>? numberOfEmergencyDocs;
  AudioPlayer? soundPlayer1;
  AudioPlayer? soundPlayer2;
  AudioPlayer? soundPlayer3;
  AudioPlayer? soundPlayer4;
  Completer<List<EmergencyContactRow>>? requestCompleter;
  // Stores action output result for [Backend Call - Query Rows] action in FloatingActionButton widget.
  List<EmergencyContactRow>? numberOfEmergencyDocsAddButton;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Additional helper methods.
  Future waitForRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(const Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
