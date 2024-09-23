import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'info_page_model.dart';
export 'info_page_model.dart';

class InfoPageWidget extends StatefulWidget {
  const InfoPageWidget({super.key});

  @override
  State<InfoPageWidget> createState() => _InfoPageWidgetState();
}

class _InfoPageWidgetState extends State<InfoPageWidget> {
  late InfoPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InfoPageModel());

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
                '5r44vlcg' /* How to use this app ? */,
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
            child: Container(
              decoration: const BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      MarkdownBody(
                        data:
                            '''### We’ve developed this app specifically for blind and low vision individuals, featuring three key functions accessible via voice commands. While we\'ve optimized the voice prompts, there may be occasional issues. The features are as follows:\n\n### **1. Around Me:** This feature records a 5-second video, analyzes it, and audibly announces what’s happening in the surroundings.\n###    - How to use: Activate this feature by saying phrases like “What is around me” or “What is behind me.”\n\n ### **2. Emergency Contact:** This feature sends an emergency message to your saved contacts when needed.\n  ###  - How to use: Trigger this feature by saying “Help me” to quickly send an alert.\n    \n### we have also created few more examples to trigger above feature you can find them below.\n\n\n### Around me\n### 1. Show me around | mujhe chaaron or dikhao \n### 2. what is happening around me | mere aasapaas kya ho raha hai\n### 3. Show me the street | mujhe sadak dikhao\n### 4. Explore my surroundings | mere aas-paas kya hai\n\n\n### Object Identificatin\n### 1. Please identify the object | krpaya vastu kee pahachaan karen \n### 2. What is the name of this item | is vastu ka naam kya hai \n### 3. Can you identify this object | kya aap is vastu ko pahachaan sakate hain\n\n\n### Emergency Contact\n### 1. help me please | krpaya meree madad karo \n### 2. Someone is following me | koee mera peechha kar raha hai\n### 3. Not felling safe here | yahaan girana surakshit nahin hai\n### 4. Please send message to my emergency contacts | krpaya mere aapaatakaaleen samparkon ko sandesh bhejen''',
                        selectable: true,
                        onTapLink: (_, url, __) => launchURL(url!),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
