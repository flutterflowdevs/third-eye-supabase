import '/backend/api_requests/api_calls.dart';
import '/components/drawer_hamburger/drawer_hamburger_widget.dart';
import '/components/menu_left_drawer/menu_left_drawer_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.soundPlayer3?.stop();
      _model.soundPlayer4?.stop();
      if (FFLocalizations.of(context).languageCode == 'en') {
        _model.soundPlayer1 ??= AudioPlayer();
        if (_model.soundPlayer1!.playing) {
          await _model.soundPlayer1!.stop();
        }
        _model.soundPlayer1!.setVolume(1.0);
        _model.soundPlayer1!
            .setAsset('assets/audios/tap_middle.mp3')
            .then((_) => _model.soundPlayer1!.play());
      } else {
        _model.soundPlayer2 ??= AudioPlayer();
        if (_model.soundPlayer2!.playing) {
          await _model.soundPlayer2!.stop();
        }
        _model.soundPlayer2!.setVolume(1.0);
        _model.soundPlayer2!
            .setAsset('assets/audios/tab_in_hindi.mp3')
            .then((_) => _model.soundPlayer2!.play());
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          drawer: Drawer(
            elevation: 16.0,
            child: wrapWithModel(
              model: _model.menuLeftDrawerModel,
              updateCallback: () => safeSetState(() {}),
              child: const MenuLeftDrawerWidget(),
            ),
          ),
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primary,
            automaticallyImplyLeading: false,
            leading: wrapWithModel(
              model: _model.drawerHamburgerModel,
              updateCallback: () => safeSetState(() {}),
              child: const DrawerHamburgerWidget(),
            ),
            title: Text(
              FFLocalizations.of(context).getText(
                'm06svl5n' /* Home */,
              ),
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Outfit',
                    color: Colors.white,
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                  ),
            ),
            actions: const [],
            centerTitle: true,
            elevation: 2.0,
          ),
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  var shouldSetState = false;
                                  _model.soundPlayer1?.stop();
                                  _model.soundPlayer2?.stop();
                                  if (FFLocalizations.of(context)
                                          .languageCode ==
                                      'en') {
                                    _model.soundPlayer7?.stop();
                                    _model.soundPlayer3 ??= AudioPlayer();
                                    if (_model.soundPlayer3!.playing) {
                                      await _model.soundPlayer3!.stop();
                                    }
                                    _model.soundPlayer3!.setVolume(1.0);
                                    await _model.soundPlayer3!
                                        .setAsset(
                                            'assets/audios/assist_audio.mp3')
                                        .then(
                                            (_) => _model.soundPlayer3!.play());
                                  } else {
                                    _model.soundPlayer8?.stop();
                                    _model.soundPlayer4 ??= AudioPlayer();
                                    if (_model.soundPlayer4!.playing) {
                                      await _model.soundPlayer4!.stop();
                                    }
                                    _model.soundPlayer4!.setVolume(1.0);
                                    await _model.soundPlayer4!
                                        .setAsset(
                                            'assets/audios/namste_mic_is_on.mp3')
                                        .then(
                                            (_) => _model.soundPlayer4!.play());
                                  }

                                  _model.sttOutput =
                                      await actions.getTextFromSpeech();
                                  shouldSetState = true;
                                  _model.speechToText = _model.sttOutput!;
                                  safeSetState(() {});
                                  _model.apiResultksh =
                                      await OpenAIGroup.getCategoryCall.call(
                                    token: FFAppState().token,
                                    content: _model.speechToText,
                                    instructions:
                                        'You are an assistant for a blind person. Your job is to classify their requests into one of three categories. Emergency contact: If the request involves emergencies or help, return \'Emergency contact\'. Show me: If the request involves understanding the general surroundings or an explanation of what is in the vicinity, return \'Show me\'. Object Identification: If the request involves identifying or naming a specific object in front of them, such as What is this object called?, return \'Object Identification\'. Try again: If the request doesn’t fit any of the above categories, return \'Try again\'',
                                    languageCode: 'en',
                                  );

                                  shouldSetState = true;
                                  if ((_model.apiResultksh?.succeeded ??
                                      true)) {
                                    _model.category = getJsonField(
                                      (_model.apiResultksh?.jsonBody ?? ''),
                                      r'''$.choices[0].message.content''',
                                    ).toString();
                                    safeSetState(() {});
                                    if (_model.category == 'Show me') {
                                      context.pushNamed('RecordingPage');

                                      if (shouldSetState) safeSetState(() {});
                                      return;
                                    } else if (_model.category ==
                                        'Emergency contact') {
                                      context.pushNamed(
                                        'EmergencyContactlPage',
                                        queryParameters: {
                                          'actionFlow': serializeParam(
                                            2,
                                            ParamType.int,
                                          ),
                                        }.withoutNulls,
                                      );

                                      if (shouldSetState) safeSetState(() {});
                                      return;
                                    } else if (_model.category ==
                                        'Object Identification') {
                                      if (FFLocalizations.of(context)
                                              .languageCode ==
                                          'en') {
                                        _model.soundPlayer5 ??= AudioPlayer();
                                        if (_model.soundPlayer5!.playing) {
                                          await _model.soundPlayer5!.stop();
                                        }
                                        _model.soundPlayer5!.setVolume(1.0);
                                        await _model.soundPlayer5!
                                            .setAsset(
                                                'assets/audios/try_again.mp3')
                                            .then((_) =>
                                                _model.soundPlayer5!.play());
                                      } else {
                                        _model.soundPlayer6 ??= AudioPlayer();
                                        if (_model.soundPlayer6!.playing) {
                                          await _model.soundPlayer6!.stop();
                                        }
                                        _model.soundPlayer6!.setVolume(1.0);
                                        await _model.soundPlayer6!
                                            .setAsset(
                                                'assets/audios/try_again_hindi_.mp3')
                                            .then((_) =>
                                                _model.soundPlayer6!.play());
                                      }

                                      if (shouldSetState) safeSetState(() {});
                                      return;
                                    } else {
                                      if (FFLocalizations.of(context)
                                              .languageCode ==
                                          'en') {
                                        _model.soundPlayer7 ??= AudioPlayer();
                                        if (_model.soundPlayer7!.playing) {
                                          await _model.soundPlayer7!.stop();
                                        }
                                        _model.soundPlayer7!.setVolume(1.0);
                                        await _model.soundPlayer7!
                                            .setAsset(
                                                'assets/audios/try_again.mp3')
                                            .then((_) =>
                                                _model.soundPlayer7!.play());
                                      } else {
                                        _model.soundPlayer8 ??= AudioPlayer();
                                        if (_model.soundPlayer8!.playing) {
                                          await _model.soundPlayer8!.stop();
                                        }
                                        _model.soundPlayer8!.setVolume(1.0);
                                        await _model.soundPlayer8!
                                            .setAsset(
                                                'assets/audios/try_again_hindi_.mp3')
                                            .then((_) =>
                                                _model.soundPlayer8!.play());
                                      }

                                      if (shouldSetState) safeSetState(() {});
                                      return;
                                    }
                                  } else {
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: const Text('Note'),
                                          content: const Text('Category Api Failed'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: const Text('Ok'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    if (shouldSetState) safeSetState(() {});
                                    return;
                                  }

                                  if (shouldSetState) safeSetState(() {});
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 4.0,
                                        color: Color(0x33000000),
                                        offset: Offset(
                                          0.0,
                                          2.0,
                                        ),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'n3o09m26' /* Tap Here */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 48.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (false)
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 10.0),
                            child: Text(
                              _model.speechToText,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                        if (false)
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 10.0),
                            child: Text(
                              _model.category,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                        if (false)
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed('ObjectDetectorPage');
                                },
                                child: Container(
                                  width: 200.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 4.0,
                                        color: Color(0x33000000),
                                        offset: Offset(
                                          0.0,
                                          2.0,
                                        ),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'nkrpzgi3' /* Object Detector */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
