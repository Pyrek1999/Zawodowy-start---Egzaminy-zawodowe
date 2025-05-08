import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'quiz_forty_questions_widget.dart' show QuizFortyQuestionsWidget;
import 'package:flutter/material.dart';

class QuizFortyQuestionsModel
    extends FlutterFlowModel<QuizFortyQuestionsWidget> {
  ///  Local state fields for this page.

  String? currentQualificationForty;

  int? randomNumForty;

  List<int> listOfQuestionsID = [];
  void addToListOfQuestionsID(int item) => listOfQuestionsID.add(item);
  void removeFromListOfQuestionsID(int item) => listOfQuestionsID.remove(item);
  void removeAtIndexFromListOfQuestionsID(int index) =>
      listOfQuestionsID.removeAt(index);
  void insertAtIndexInListOfQuestionsID(int index, int item) =>
      listOfQuestionsID.insert(index, item);
  void updateListOfQuestionsIDAtIndex(int index, Function(int) updateFn) =>
      listOfQuestionsID[index] = updateFn(listOfQuestionsID[index]);

  int? loopCounter;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in quizFortyQuestions widget.
  QuizQuestionsRecord? queryForty;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController1;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController2;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController3;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController4;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController5;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController6;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController7;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController8;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController9;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController10;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController11;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController12;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController13;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController14;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController15;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController16;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController17;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController18;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController19;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController20;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController21;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController22;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController23;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController24;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController25;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController26;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController27;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController28;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController29;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController30;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController31;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController32;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController33;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController34;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController35;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController36;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController37;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController38;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController39;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController40;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Additional helper methods.
  String? get radioButtonValue1 => radioButtonValueController1?.value;
  String? get radioButtonValue2 => radioButtonValueController2?.value;
  String? get radioButtonValue3 => radioButtonValueController3?.value;
  String? get radioButtonValue4 => radioButtonValueController4?.value;
  String? get radioButtonValue5 => radioButtonValueController5?.value;
  String? get radioButtonValue6 => radioButtonValueController6?.value;
  String? get radioButtonValue7 => radioButtonValueController7?.value;
  String? get radioButtonValue8 => radioButtonValueController8?.value;
  String? get radioButtonValue9 => radioButtonValueController9?.value;
  String? get radioButtonValue10 => radioButtonValueController10?.value;
  String? get radioButtonValue11 => radioButtonValueController11?.value;
  String? get radioButtonValue12 => radioButtonValueController12?.value;
  String? get radioButtonValue13 => radioButtonValueController13?.value;
  String? get radioButtonValue14 => radioButtonValueController14?.value;
  String? get radioButtonValue15 => radioButtonValueController15?.value;
  String? get radioButtonValue16 => radioButtonValueController16?.value;
  String? get radioButtonValue17 => radioButtonValueController17?.value;
  String? get radioButtonValue18 => radioButtonValueController18?.value;
  String? get radioButtonValue19 => radioButtonValueController19?.value;
  String? get radioButtonValue20 => radioButtonValueController20?.value;
  String? get radioButtonValue21 => radioButtonValueController21?.value;
  String? get radioButtonValue22 => radioButtonValueController22?.value;
  String? get radioButtonValue23 => radioButtonValueController23?.value;
  String? get radioButtonValue24 => radioButtonValueController24?.value;
  String? get radioButtonValue25 => radioButtonValueController25?.value;
  String? get radioButtonValue26 => radioButtonValueController26?.value;
  String? get radioButtonValue27 => radioButtonValueController27?.value;
  String? get radioButtonValue28 => radioButtonValueController28?.value;
  String? get radioButtonValue29 => radioButtonValueController29?.value;
  String? get radioButtonValue30 => radioButtonValueController30?.value;
  String? get radioButtonValue31 => radioButtonValueController31?.value;
  String? get radioButtonValue32 => radioButtonValueController32?.value;
  String? get radioButtonValue33 => radioButtonValueController33?.value;
  String? get radioButtonValue34 => radioButtonValueController34?.value;
  String? get radioButtonValue35 => radioButtonValueController35?.value;
  String? get radioButtonValue36 => radioButtonValueController36?.value;
  String? get radioButtonValue37 => radioButtonValueController37?.value;
  String? get radioButtonValue38 => radioButtonValueController38?.value;
  String? get radioButtonValue39 => radioButtonValueController39?.value;
  String? get radioButtonValue40 => radioButtonValueController40?.value;
}
