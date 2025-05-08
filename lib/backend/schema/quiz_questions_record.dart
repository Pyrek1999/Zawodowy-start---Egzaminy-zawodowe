import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class QuizQuestionsRecord extends FirestoreRecord {
  QuizQuestionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "correct_answer" field.
  String? _correctAnswer;
  String get correctAnswer => _correctAnswer ?? '';
  bool hasCorrectAnswer() => _correctAnswer != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "question_id" field.
  int? _questionId;
  int get questionId => _questionId ?? 0;
  bool hasQuestionId() => _questionId != null;

  // "options" field.
  List<String>? _options;
  List<String> get options => _options ?? const [];
  bool hasOptions() => _options != null;

  // "explenation" field.
  String? _explenation;
  String get explenation => _explenation ?? '';
  bool hasExplenation() => _explenation != null;

  // "qualification" field.
  String? _qualification;
  String get qualification => _qualification ?? '';
  bool hasQualification() => _qualification != null;

  // "question_photo" field.
  String? _questionPhoto;
  String get questionPhoto => _questionPhoto ?? '';
  bool hasQuestionPhoto() => _questionPhoto != null;

  // "correct_answer_letter" field.
  String? _correctAnswerLetter;
  String get correctAnswerLetter => _correctAnswerLetter ?? '';
  bool hasCorrectAnswerLetter() => _correctAnswerLetter != null;

  void _initializeFields() {
    _correctAnswer = snapshotData['correct_answer'] as String?;
    _description = snapshotData['description'] as String?;
    _questionId = castToType<int>(snapshotData['question_id']);
    _options = getDataList(snapshotData['options']);
    _explenation = snapshotData['explenation'] as String?;
    _qualification = snapshotData['qualification'] as String?;
    _questionPhoto = snapshotData['question_photo'] as String?;
    _correctAnswerLetter = snapshotData['correct_answer_letter'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('quiz_questions');

  static Stream<QuizQuestionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => QuizQuestionsRecord.fromSnapshot(s));

  static Future<QuizQuestionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => QuizQuestionsRecord.fromSnapshot(s));

  static QuizQuestionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      QuizQuestionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static QuizQuestionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      QuizQuestionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'QuizQuestionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is QuizQuestionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createQuizQuestionsRecordData({
  String? correctAnswer,
  String? description,
  int? questionId,
  String? explenation,
  String? qualification,
  String? questionPhoto,
  String? correctAnswerLetter,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'correct_answer': correctAnswer,
      'description': description,
      'question_id': questionId,
      'explenation': explenation,
      'qualification': qualification,
      'question_photo': questionPhoto,
      'correct_answer_letter': correctAnswerLetter,
    }.withoutNulls,
  );

  return firestoreData;
}

class QuizQuestionsRecordDocumentEquality
    implements Equality<QuizQuestionsRecord> {
  const QuizQuestionsRecordDocumentEquality();

  @override
  bool equals(QuizQuestionsRecord? e1, QuizQuestionsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.correctAnswer == e2?.correctAnswer &&
        e1?.description == e2?.description &&
        e1?.questionId == e2?.questionId &&
        listEquality.equals(e1?.options, e2?.options) &&
        e1?.explenation == e2?.explenation &&
        e1?.qualification == e2?.qualification &&
        e1?.questionPhoto == e2?.questionPhoto &&
        e1?.correctAnswerLetter == e2?.correctAnswerLetter;
  }

  @override
  int hash(QuizQuestionsRecord? e) => const ListEquality().hash([
        e?.correctAnswer,
        e?.description,
        e?.questionId,
        e?.options,
        e?.explenation,
        e?.qualification,
        e?.questionPhoto,
        e?.correctAnswerLetter
      ]);

  @override
  bool isValidKey(Object? o) => o is QuizQuestionsRecord;
}
