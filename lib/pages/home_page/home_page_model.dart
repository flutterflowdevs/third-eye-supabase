import '/backend/api_requests/api_calls.dart';
import '/components/drawer_hamburger/drawer_hamburger_widget.dart';
import '/components/menu_left_drawer/menu_left_drawer_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  String speechToText = 'NA';

  String category = 'NA';

  bool isLoading = true;

  ///  State fields for stateful widgets in this page.

  AudioPlayer? soundPlayer1;
  AudioPlayer? soundPlayer2;
  AudioPlayer? soundPlayer3;
  AudioPlayer? soundPlayer4;
  // Stores action output result for [Custom Action - getTextFromSpeech] action in Container widget.
  String? sttOutput;
  // Stores action output result for [Backend Call - API (Get Category)] action in Container widget.
  ApiCallResponse? apiResultksh;
  AudioPlayer? soundPlayer5;
  AudioPlayer? soundPlayer6;
  AudioPlayer? soundPlayer7;
  AudioPlayer? soundPlayer8;
  // Model for menu_left_drawer component.
  late MenuLeftDrawerModel menuLeftDrawerModel;
  // Model for drawerHamburger component.
  late DrawerHamburgerModel drawerHamburgerModel;

  @override
  void initState(BuildContext context) {
    menuLeftDrawerModel = createModel(context, () => MenuLeftDrawerModel());
    drawerHamburgerModel = createModel(context, () => DrawerHamburgerModel());
  }

  @override
  void dispose() {
    menuLeftDrawerModel.dispose();
    drawerHamburgerModel.dispose();
  }
}
