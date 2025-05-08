import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/admob_util.dart' as admob;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'quiz_one_question_widget.dart' show QuizOneQuestionWidget;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class QuizOneQuestionModel extends FlutterFlowModel<QuizOneQuestionWidget> {
  ///  Local state fields for this page.

  int? randomNUM;

  String? selectedOption;

  int? randomNumPass;

  String? currentQualification;

  int? minValue;

  int? maxValue;

  ///  State fields for stateful widgets in this page.

  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  UsersRecord? usersRefOneQuestion;
  // Stores action output result for [AdMob - Show Interstitial Ad] action in Button widget.
  bool? interstitialAdSuccess;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks.
  Future byIDgetQuestion(BuildContext context) async {
    if (FFAppState().passQualification == 'INF.02') {
      minValue = 1;
      maxValue = 2120;
    } else if (FFAppState().passQualification == 'INF.03') {
      minValue = 2121;
      maxValue = 3200;
    } else if (FFAppState().passQualification == 'INF.04') {
      minValue = 5058;
      maxValue = 5685;
    } else if (FFAppState().passQualification == 'ELE.02') {
      minValue = 3201;
      maxValue = 4759;
    } else if (FFAppState().passQualification == 'ELE.05') {
      minValue = 4760;
      maxValue = 5057;
    } else {
      return;
    }

    randomNUM = functions.getRandomNumber(minValue!, maxValue!);
    randomNumPass = functions.getRandomNumber(minValue!, maxValue!);
    await queryQuizQuestionsRecordOnce(
      queryBuilder: (quizQuestionsRecord) => quizQuestionsRecord.where(
        'question_id',
        isEqualTo: randomNUM,
      ),
      singleRecord: true,
    ).then((s) => s.firstOrNull);

    admob.loadInterstitialAd(
      "ca-app-pub-6394141425643906/5601492649",
      "ca-app-pub-6394141425643906/3081709894",
      false,
    );
  }

  Future oldLogicPage(BuildContext context) async {
    QuizQuestionsRecord? zapytanieCopy;

    while (FFAppState().passQualification != currentQualification) {
      randomNUM = functions.getRandomNumber(1, 5685);
      zapytanieCopy = await queryQuizQuestionsRecordOnce(
        queryBuilder: (quizQuestionsRecord) => quizQuestionsRecord.where(
          'question_id',
          isEqualTo: randomNUM,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      currentQualification = zapytanieCopy?.qualification;
    }
    randomNumPass = randomNUM;

    admob.loadInterstitialAd(
      "ca-app-pub-6394141425643906/5601492649",
      "ca-app-pub-6394141425643906/3081709894",
      false,
    );
  }

  /// Additional helper methods.
  String? get radioButtonValue => radioButtonValueController?.value;
}
