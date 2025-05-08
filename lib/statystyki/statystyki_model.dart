import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'statystyki_widget.dart' show StatystykiWidget;
import 'package:flutter/material.dart';

class StatystykiModel extends FlutterFlowModel<StatystykiWidget> {
  ///  Local state fields for this page.

  int percentageValue = 0;

  int sumOfQuestions = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in statystyki widget.
  UsersRecord? userTechnicTittle;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
