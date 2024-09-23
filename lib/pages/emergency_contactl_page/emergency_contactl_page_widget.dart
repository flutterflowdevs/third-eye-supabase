import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/add_contact/add_contact_widget.dart';
import '/components/contact_tile/contact_tile_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:just_audio/just_audio.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'emergency_contactl_page_model.dart';
export 'emergency_contactl_page_model.dart';

class EmergencyContactlPageWidget extends StatefulWidget {
  const EmergencyContactlPageWidget({
    super.key,
    this.actionFlow,
  });

  final int? actionFlow;

  @override
  State<EmergencyContactlPageWidget> createState() =>
      _EmergencyContactlPageWidgetState();
}

class _EmergencyContactlPageWidgetState
    extends State<EmergencyContactlPageWidget> with TickerProviderStateMixin {
  late EmergencyContactlPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmergencyContactlPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget.actionFlow == 1) {
        return;
      }

      _model.isLoaderShown = true;
      safeSetState(() {});
      await Future.delayed(const Duration(milliseconds: 2000));
      _model.isLoaderShown = false;
      safeSetState(() {});
      _model.numberOfEmergencyDocs = await EmergencyContactTable().queryRows(
        queryFn: (q) => q.eq(
          'user_id',
          currentUserUid,
        ),
      );
      if (_model.numberOfEmergencyDocs?.length != 0) {
        if (FFLocalizations.of(context).languageCode == 'en') {
          _model.soundPlayer1 ??= AudioPlayer();
          if (_model.soundPlayer1!.playing) {
            await _model.soundPlayer1!.stop();
          }
          _model.soundPlayer1!.setVolume(1.0);
          await _model.soundPlayer1!
              .setAsset('assets/audios/emergency_contact.mp3')
              .then((_) => _model.soundPlayer1!.play());
        } else {
          _model.soundPlayer2 ??= AudioPlayer();
          if (_model.soundPlayer2!.playing) {
            await _model.soundPlayer2!.stop();
          }
          _model.soundPlayer2!.setVolume(1.0);
          await _model.soundPlayer2!
              .setAsset('assets/audios/Emergency_message_hindi.mp3')
              .then((_) => _model.soundPlayer2!.play());
        }
      } else {
        if (FFLocalizations.of(context).languageCode == 'en') {
          _model.soundPlayer3 ??= AudioPlayer();
          if (_model.soundPlayer3!.playing) {
            await _model.soundPlayer3!.stop();
          }
          _model.soundPlayer3!.setVolume(1.0);
          await _model.soundPlayer3!
              .setAsset('assets/audios/emergency_list_empty.mp3')
              .then((_) => _model.soundPlayer3!.play());
        } else {
          _model.soundPlayer4 ??= AudioPlayer();
          if (_model.soundPlayer4!.playing) {
            await _model.soundPlayer4!.stop();
          }
          _model.soundPlayer4!.setVolume(1.0);
          await _model.soundPlayer4!
              .setAsset('assets/audios/Empty_Emergency_Contact_Hindi.mp3')
              .then((_) => _model.soundPlayer4!.play());
        }
      }

      await Future.delayed(const Duration(milliseconds: 1000));

      context.pushNamed('HomePage');

      return;
    });

    animationsMap.addAll({
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              var shouldSetState = false;
              _model.numberOfEmergencyDocsAddButton =
                  await EmergencyContactTable().queryRows(
                queryFn: (q) => q.eq(
                  'user_id',
                  currentUserUid,
                ),
              );
              shouldSetState = true;
              if (_model.numberOfEmergencyDocsAddButton!.length < 2) {
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  enableDrag: false,
                  context: context,
                  builder: (context) {
                    return GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: Padding(
                        padding: MediaQuery.viewInsetsOf(context),
                        child: AddContactWidget(
                          isEdit: false,
                          refreshData: () async {
                            safeSetState(() => _model.requestCompleter = null);
                            await _model.waitForRequestCompleted();
                          },
                        ),
                      ),
                    );
                  },
                ).then((value) => safeSetState(() {}));

                if (shouldSetState) safeSetState(() {});
                return;
              } else {
                await showDialog(
                  context: context,
                  builder: (alertDialogContext) {
                    return AlertDialog(
                      title: const Text('Note'),
                      content: const Text('Maximum 2 contacts allowed.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(alertDialogContext),
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
            backgroundColor: FlutterFlowTheme.of(context).primary,
            elevation: 8.0,
            child: Icon(
              Icons.add,
              color: FlutterFlowTheme.of(context).info,
              size: 24.0,
            ),
          ),
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
                context.pushNamed('HomePage');
              },
            ),
            title: Text(
              FFLocalizations.of(context).getText(
                'zezcasee' /* Emergency Contacts */,
              ),
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Readex Pro',
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
                if (!_model.isLoaderShown)
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(),
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: FutureBuilder<List<EmergencyContactRow>>(
                          future: (_model.requestCompleter ??= Completer<
                                  List<EmergencyContactRow>>()
                                ..complete(EmergencyContactTable().queryRows(
                                  queryFn: (q) => q.eq(
                                    'user_id',
                                    currentUserUid,
                                  ),
                                )))
                              .future,
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              );
                            }
                            List<EmergencyContactRow>
                                columnEmergencyContactRowList = snapshot.data!;

                            if (columnEmergencyContactRowList.isEmpty) {
                              return Image.asset(
                                'assets/images/Screenshot_2024-08-25_131445.png',
                                width: 300.0,
                                height: 300.0,
                                fit: BoxFit.contain,
                              );
                            }

                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: List.generate(
                                  columnEmergencyContactRowList.length,
                                  (columnIndex) {
                                final columnEmergencyContactRow =
                                    columnEmergencyContactRowList[columnIndex];
                                return Builder(
                                  builder: (context) => ContactTileWidget(
                                    key: Key(
                                        'Keykwr_${columnIndex}_of_${columnEmergencyContactRowList.length}'),
                                    contactDoc: columnEmergencyContactRow,
                                    contactShowAction: () async {
                                      context.pushNamed(
                                        'ContactPersonPage',
                                        queryParameters: {
                                          'contact': serializeParam(
                                            columnEmergencyContactRow,
                                            ParamType.SupabaseRow,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                    delete: () async {
                                      safeSetState(
                                          () => _model.requestCompleter = null);
                                      await _model.waitForRequestCompleted();
                                    },
                                    edit: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return Dialog(
                                            elevation: 0,
                                            insetPadding: EdgeInsets.zero,
                                            backgroundColor: Colors.transparent,
                                            alignment: const AlignmentDirectional(
                                                    0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                            child: GestureDetector(
                                              onTap: () =>
                                                  FocusScope.of(dialogContext)
                                                      .unfocus(),
                                              child: AddContactWidget(
                                                isEdit: true,
                                                contactData:
                                                    columnEmergencyContactRow,
                                                refreshData: () async {
                                                  safeSetState(() => _model
                                                      .requestCompleter = null);
                                                  await _model
                                                      .waitForRequestCompleted();
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                if (_model.isLoaderShown)
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
