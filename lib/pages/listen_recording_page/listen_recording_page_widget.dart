import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/gemini/gemini.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_audio_player.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'listen_recording_page_model.dart';
export 'listen_recording_page_model.dart';

class ListenRecordingPageWidget extends StatefulWidget {
  const ListenRecordingPageWidget({
    super.key,
    this.recordingInText,
  });

  final String? recordingInText;

  @override
  State<ListenRecordingPageWidget> createState() =>
      _ListenRecordingPageWidgetState();
}

class _ListenRecordingPageWidgetState extends State<ListenRecordingPageWidget>
    with TickerProviderStateMixin {
  late ListenRecordingPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListenRecordingPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.userData = await UsersTable().queryRows(
        queryFn: (q) => q.eq(
          'user_id',
          currentUserUid,
        ),
      );
      FFAppState().textForAudio = functions.getProperString(getJsonField(
        functions.getStringToJson(widget.recordingInText!),
        r'''$["voice_result"]''',
      ).toString().toString());
      safeSetState(() {});
      await geminiGenerateText(
        context,
        '${FFAppState().textForAudio}, convert it to language code ${_model.userData?.first.langCode}',
      ).then((generatedText) {
        safeSetState(() => _model.ggOutput = generatedText);
      });

      FFAppState().textForAudio = _model.ggOutput!;
      safeSetState(() {});
      _model.apiResultuk5 = await BuildShipApisGroup.testToSpeechCall.call(
        text: FFAppState().textForAudio,
      );

      if ((_model.apiResultuk5?.succeeded ?? true)) {
        _model.textToSpeechRsp = (_model.apiResultuk5?.jsonBody ?? '');
        safeSetState(() {});
        _model.soundPlayer1 ??= AudioPlayer();
        if (_model.soundPlayer1!.playing) {
          await _model.soundPlayer1!.stop();
        }
        _model.soundPlayer1!.setVolume(1.0);
        await _model.soundPlayer1!
            .setUrl(getJsonField(
              _model.textToSpeechRsp,
              r'''$.data''',
            ).toString())
            .then((_) => _model.soundPlayer1!.play());

        context.pushNamed('HomePage');
      } else {
        if (FFLocalizations.of(context).languageCode == 'en') {
          _model.soundPlayer2 ??= AudioPlayer();
          if (_model.soundPlayer2!.playing) {
            await _model.soundPlayer2!.stop();
          }
          _model.soundPlayer2!.setVolume(1.0);
          await _model.soundPlayer2!
              .setAsset('assets/audios/something_went_wrong.mp3')
              .then((_) => _model.soundPlayer2!.play());
        } else {
          _model.soundPlayer3 ??= AudioPlayer();
          if (_model.soundPlayer3!.playing) {
            await _model.soundPlayer3!.stop();
          }
          _model.soundPlayer3!.setVolume(1.0);
          await _model.soundPlayer3!
              .setAsset('assets/audios/something_went_wrong_hindi.mp3')
              .then((_) => _model.soundPlayer3!.play());
        }

        context.pushNamed('HomePage');
      }
    });

    animationsMap.addAll({
      'imageOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 3000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 5000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 5000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'imageOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 3000.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'progressBarOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
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
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primary,
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () async {
                _model.soundPlayer1?.stop();

                context.pushNamed('HomePage');
              },
            ),
            title: Text(
              FFLocalizations.of(context).getText(
                'eebnqjqd' /* Processing */,
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
                        if (false)
                          Container(
                            decoration: const BoxDecoration(),
                            child: Visibility(
                              visible: getJsonField(
                                    FFAppState().textToSpeechApiResp,
                                    r'''$.data''',
                                  ) !=
                                  null,
                              child: FlutterFlowAudioPlayer(
                                audio: Audio.network(
                                  getJsonField(
                                    FFAppState().textToSpeechApiResp,
                                    r'''$.data''',
                                  ).toString(),
                                  metas: Metas(),
                                ),
                                titleTextStyle: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      fontFamily: 'Outfit',
                                      letterSpacing: 0.0,
                                    ),
                                playbackDurationTextStyle:
                                    FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0.0,
                                        ),
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                playbackButtonColor:
                                    FlutterFlowTheme.of(context).primary,
                                activeTrackColor:
                                    FlutterFlowTheme.of(context).alternate,
                                elevation: 4.0,
                                playInBackground: PlayInBackground
                                    .disabledRestoreOnForeground,
                              ),
                            ),
                          ),
                        if (getJsonField(
                              _model.textToSpeechRsp,
                              r'''$.data''',
                            ) !=
                            null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/greenCircle.gif',
                              width: double.infinity,
                              height: 500.0,
                              fit: BoxFit.contain,
                            ),
                          ).animateOnPageLoad(
                              animationsMap['imageOnPageLoadAnimation1']!),
                        if (false)
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 10.0, 0.0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'wothnnea' /* Please hold on while we transf... */,
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        if (false)
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 20.0, 0.0),
                                    child: Container(
                                      width: 200.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(1000.0),
                                          bottomRight: Radius.circular(0.0),
                                          topLeft: Radius.circular(0.0),
                                          topRight: Radius.circular(1000.0),
                                        ),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Lottie.asset(
                                        'assets/lottie_animations/Animation_-_1724520181737_(1).json',
                                        width: 150.0,
                                        height: 130.0,
                                        fit: BoxFit.contain,
                                        animate: true,
                                      ),
                                    ).animateOnPageLoad(animationsMap[
                                        'containerOnPageLoadAnimation1']!),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        20.0, 0.0, 0.0, 0.0),
                                    child: Container(
                                      width: 200.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(0.0),
                                          bottomRight: Radius.circular(1000.0),
                                          topLeft: Radius.circular(1000.0),
                                          topRight: Radius.circular(0.0),
                                        ),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Lottie.asset(
                                        'assets/lottie_animations/Animation_-_1724520181737_(1).json',
                                        width: 150.0,
                                        height: 130.0,
                                        fit: BoxFit.contain,
                                        animate: true,
                                      ),
                                    ).animateOnPageLoad(animationsMap[
                                        'containerOnPageLoadAnimation2']!),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (false)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/takinglips.gif',
                              width: 250.0,
                              height: 250.0,
                              fit: BoxFit.contain,
                            ),
                          ).animateOnPageLoad(
                              animationsMap['imageOnPageLoadAnimation2']!),
                        if (getJsonField(
                              _model.textToSpeechRsp,
                              r'''$.data''',
                            ) ==
                            null)
                          CircularPercentIndicator(
                            percent: 0.5,
                            radius: 25.0,
                            lineWidth: 8.0,
                            animation: true,
                            animateFromLastPercent: true,
                            progressColor: FlutterFlowTheme.of(context).primary,
                            backgroundColor:
                                FlutterFlowTheme.of(context).accent4,
                          ).animateOnPageLoad(
                              animationsMap['progressBarOnPageLoadAnimation']!),
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
