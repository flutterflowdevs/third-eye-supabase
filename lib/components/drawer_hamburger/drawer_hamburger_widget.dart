import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'drawer_hamburger_model.dart';
export 'drawer_hamburger_model.dart';

class DrawerHamburgerWidget extends StatefulWidget {
  const DrawerHamburgerWidget({super.key});

  @override
  State<DrawerHamburgerWidget> createState() => _DrawerHamburgerWidgetState();
}

class _DrawerHamburgerWidgetState extends State<DrawerHamburgerWidget> {
  late DrawerHamburgerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DrawerHamburgerModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterFlowIconButton(
      borderColor: Colors.transparent,
      borderRadius: 30.0,
      borderWidth: 1.0,
      buttonSize: 60.0,
      icon: const FaIcon(
        FontAwesomeIcons.alignJustify,
        color: Colors.white,
        size: 25.0,
      ),
      onPressed: () async {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}
