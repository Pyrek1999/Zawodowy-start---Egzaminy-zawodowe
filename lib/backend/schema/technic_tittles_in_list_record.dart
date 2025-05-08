import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TechnicTittlesInListRecord extends FirestoreRecord {
  TechnicTittlesInListRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "tittleInList" field.
  List<String>? _tittleInList;
  List<String> get tittleInList => _tittleInList ?? const [];
  bool hasTittleInList() => _tittleInList != null;

  void _initializeFields() {
    _tittleInList = getDataList(snapshotData['tittleInList']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('technicTittlesInList');

  static Stream<TechnicTittlesInListRecord> getDocument(
          DocumentReference ref) =>
      ref.snapshots().map((s) => TechnicTittlesInListRecord.fromSnapshot(s));

  static Future<TechnicTittlesInListRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => TechnicTittlesInListRecord.fromSnapshot(s));

  static TechnicTittlesInListRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TechnicTittlesInListRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TechnicTittlesInListRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TechnicTittlesInListRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TechnicTittlesInListRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TechnicTittlesInListRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTechnicTittlesInListRecordData() {
  final firestoreData = mapToFirestore(
    <String, dynamic>{}.withoutNulls,
  );

  return firestoreData;
}

class TechnicTittlesInListRecordDocumentEquality
    implements Equality<TechnicTittlesInListRecord> {
  const TechnicTittlesInListRecordDocumentEquality();

  @override
  bool equals(TechnicTittlesInListRecord? e1, TechnicTittlesInListRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.tittleInList, e2?.tittleInList);
  }

  @override
  int hash(TechnicTittlesInListRecord? e) =>
      const ListEquality().hash([e?.tittleInList]);

  @override
  bool isValidKey(Object? o) => o is TechnicTittlesInListRecord;
}
