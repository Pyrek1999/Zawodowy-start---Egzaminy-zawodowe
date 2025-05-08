import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TechnicTittlesRecord extends FirestoreRecord {
  TechnicTittlesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "tittle" field.
  String? _tittle;
  String get tittle => _tittle ?? '';
  bool hasTittle() => _tittle != null;

  // "firstQualification" field.
  String? _firstQualification;
  String get firstQualification => _firstQualification ?? '';
  bool hasFirstQualification() => _firstQualification != null;

  // "secondQualification" field.
  String? _secondQualification;
  String get secondQualification => _secondQualification ?? '';
  bool hasSecondQualification() => _secondQualification != null;

  // "firstQuaDescription" field.
  String? _firstQuaDescription;
  String get firstQuaDescription => _firstQuaDescription ?? '';
  bool hasFirstQuaDescription() => _firstQuaDescription != null;

  // "secondQuaDescription" field.
  String? _secondQuaDescription;
  String get secondQuaDescription => _secondQuaDescription ?? '';
  bool hasSecondQuaDescription() => _secondQuaDescription != null;

  void _initializeFields() {
    _tittle = snapshotData['tittle'] as String?;
    _firstQualification = snapshotData['firstQualification'] as String?;
    _secondQualification = snapshotData['secondQualification'] as String?;
    _firstQuaDescription = snapshotData['firstQuaDescription'] as String?;
    _secondQuaDescription = snapshotData['secondQuaDescription'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('technic_tittles');

  static Stream<TechnicTittlesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TechnicTittlesRecord.fromSnapshot(s));

  static Future<TechnicTittlesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TechnicTittlesRecord.fromSnapshot(s));

  static TechnicTittlesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TechnicTittlesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TechnicTittlesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TechnicTittlesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TechnicTittlesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TechnicTittlesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTechnicTittlesRecordData({
  String? tittle,
  String? firstQualification,
  String? secondQualification,
  String? firstQuaDescription,
  String? secondQuaDescription,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'tittle': tittle,
      'firstQualification': firstQualification,
      'secondQualification': secondQualification,
      'firstQuaDescription': firstQuaDescription,
      'secondQuaDescription': secondQuaDescription,
    }.withoutNulls,
  );

  return firestoreData;
}

class TechnicTittlesRecordDocumentEquality
    implements Equality<TechnicTittlesRecord> {
  const TechnicTittlesRecordDocumentEquality();

  @override
  bool equals(TechnicTittlesRecord? e1, TechnicTittlesRecord? e2) {
    return e1?.tittle == e2?.tittle &&
        e1?.firstQualification == e2?.firstQualification &&
        e1?.secondQualification == e2?.secondQualification &&
        e1?.firstQuaDescription == e2?.firstQuaDescription &&
        e1?.secondQuaDescription == e2?.secondQuaDescription;
  }

  @override
  int hash(TechnicTittlesRecord? e) => const ListEquality().hash([
        e?.tittle,
        e?.firstQualification,
        e?.secondQualification,
        e?.firstQuaDescription,
        e?.secondQuaDescription
      ]);

  @override
  bool isValidKey(Object? o) => o is TechnicTittlesRecord;
}
