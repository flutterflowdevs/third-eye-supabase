import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'language_page_widget.dart' show LanguagePageWidget;
import 'package:flutter/material.dart';

class LanguagePageModel extends FlutterFlowModel<LanguagePageWidget> {
  ///  Local state fields for this page.

  String langCode = 'en';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in LanguagePage widget.
  List<UsersRow>? userData;
  // Stores action output result for [Backend Call - Update Row(s)] action in Container widget.
  List<UsersRow>? updateUserData;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
