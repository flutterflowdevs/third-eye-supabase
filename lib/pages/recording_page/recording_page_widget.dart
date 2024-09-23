import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'recording_page_model.dart';
export 'recording_page_model.dart';

class RecordingPageWidget extends StatefulWidget {
  const RecordingPageWidget({super.key});

  @override
  State<RecordingPageWidget> createState() => _RecordingPageWidgetState();
}

class _RecordingPageWidgetState extends State<RecordingPageWidget> {
  late RecordingPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RecordingPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: const SafeArea(
            top: true,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: custom_widgets.RecordingScreen(
                width: double.infinity,
                height: double.infinity,
                time: 5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
