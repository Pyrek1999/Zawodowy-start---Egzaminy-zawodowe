import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'quiz_forty_answears_widget.dart' show QuizFortyAnswearsWidget;
import 'package:flutter/material.dart';

class QuizFortyAnswearsModel extends FlutterFlowModel<QuizFortyAnswearsWidget> {
  ///  Local state fields for this page.

  int correctAnswers = 0;

  int wrongAnswers = 0;

  int loopCounter = 0;

  int indexIDGrow = 0;

  int percentageResult = 0;

  bool adWatched = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in quizFortyAnswears widget.
  UsersRecord? usersRef;
  // Stores action output result for [Firestore Query - Query a collection] action in quizFortyAnswears widget.
  QuizQuestionsRecord? pytLoop;
  // Stores action output result for [AdMob - Show Interstitial Ad] action in Button widget.
  bool? interstitialAdSuccess;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
