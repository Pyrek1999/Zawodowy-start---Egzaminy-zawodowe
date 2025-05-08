import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'wrong_answer_quiz_widget.dart' show WrongAnswerQuizWidget;
import 'package:flutter/material.dart';

class WrongAnswerQuizModel extends FlutterFlowModel<WrongAnswerQuizWidget> {
  ///  Local state fields for this page.

  bool adWatched = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in wrong_answer_quiz widget.
  QuizQuestionsRecord? wrongPageOneQueQuiz;
  // Stores action output result for [AdMob - Show Interstitial Ad] action in Button widget.
  bool? interstitialAdSuccess;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
