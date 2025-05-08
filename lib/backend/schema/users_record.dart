import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "IsConfifurated" field.
  String? _isConfifurated;
  String get isConfifurated => _isConfifurated ?? '';
  bool hasIsConfifurated() => _isConfifurated != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "surname" field.
  String? _surname;
  String get surname => _surname ?? '';
  bool hasSurname() => _surname != null;

  // "school" field.
  String? _school;
  String get school => _school ?? '';
  bool hasSchool() => _school != null;

  // "technicTittleUsers" field.
  String? _technicTittleUsers;
  String get technicTittleUsers => _technicTittleUsers ?? '';
  bool hasTechnicTittleUsers() => _technicTittleUsers != null;

  // "isUserPremium" field.
  bool? _isUserPremium;
  bool get isUserPremium => _isUserPremium ?? false;
  bool hasIsUserPremium() => _isUserPremium != null;

  // "correctAnswers" field.
  int? _correctAnswers;
  int get correctAnswers => _correctAnswers ?? 0;
  bool hasCorrectAnswers() => _correctAnswers != null;

  // "wrongAnswers" field.
  int? _wrongAnswers;
  int get wrongAnswers => _wrongAnswers ?? 0;
  bool hasWrongAnswers() => _wrongAnswers != null;

  // "schoodCode" field.
  String? _schoodCode;
  String get schoodCode => _schoodCode ?? '';
  bool hasSchoodCode() => _schoodCode != null;

  // "streakCount" field.
  int? _streakCount;
  int get streakCount => _streakCount ?? 0;
  bool hasStreakCount() => _streakCount != null;

  // "lastActiveDate" field.
  DateTime? _lastActiveDate;
  DateTime? get lastActiveDate => _lastActiveDate;
  bool hasLastActiveDate() => _lastActiveDate != null;

  // "streakAvailable" field.
  bool? _streakAvailable;
  bool get streakAvailable => _streakAvailable ?? false;
  bool hasStreakAvailable() => _streakAvailable != null;

  // "likedQuestionsIDList" field.
  List<int>? _likedQuestionsIDList;
  List<int> get likedQuestionsIDList => _likedQuestionsIDList ?? const [];
  bool hasLikedQuestionsIDList() => _likedQuestionsIDList != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _uid = snapshotData['uid'] as String?;
    _isConfifurated = snapshotData['IsConfifurated'] as String?;
    _name = snapshotData['name'] as String?;
    _surname = snapshotData['surname'] as String?;
    _school = snapshotData['school'] as String?;
    _technicTittleUsers = snapshotData['technicTittleUsers'] as String?;
    _isUserPremium = snapshotData['isUserPremium'] as bool?;
    _correctAnswers = castToType<int>(snapshotData['correctAnswers']);
    _wrongAnswers = castToType<int>(snapshotData['wrongAnswers']);
    _schoodCode = snapshotData['schoodCode'] as String?;
    _streakCount = castToType<int>(snapshotData['streakCount']);
    _lastActiveDate = snapshotData['lastActiveDate'] as DateTime?;
    _streakAvailable = snapshotData['streakAvailable'] as bool?;
    _likedQuestionsIDList = getDataList(snapshotData['likedQuestionsIDList']);
    _photoUrl = snapshotData['photo_url'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  DateTime? createdTime,
  String? phoneNumber,
  String? uid,
  String? isConfifurated,
  String? name,
  String? surname,
  String? school,
  String? technicTittleUsers,
  bool? isUserPremium,
  int? correctAnswers,
  int? wrongAnswers,
  String? schoodCode,
  int? streakCount,
  DateTime? lastActiveDate,
  bool? streakAvailable,
  String? photoUrl,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'uid': uid,
      'IsConfifurated': isConfifurated,
      'name': name,
      'surname': surname,
      'school': school,
      'technicTittleUsers': technicTittleUsers,
      'isUserPremium': isUserPremium,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
      'schoodCode': schoodCode,
      'streakCount': streakCount,
      'lastActiveDate': lastActiveDate,
      'streakAvailable': streakAvailable,
      'photo_url': photoUrl,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.uid == e2?.uid &&
        e1?.isConfifurated == e2?.isConfifurated &&
        e1?.name == e2?.name &&
        e1?.surname == e2?.surname &&
        e1?.school == e2?.school &&
        e1?.technicTittleUsers == e2?.technicTittleUsers &&
        e1?.isUserPremium == e2?.isUserPremium &&
        e1?.correctAnswers == e2?.correctAnswers &&
        e1?.wrongAnswers == e2?.wrongAnswers &&
        e1?.schoodCode == e2?.schoodCode &&
        e1?.streakCount == e2?.streakCount &&
        e1?.lastActiveDate == e2?.lastActiveDate &&
        e1?.streakAvailable == e2?.streakAvailable &&
        listEquality.equals(
            e1?.likedQuestionsIDList, e2?.likedQuestionsIDList) &&
        e1?.photoUrl == e2?.photoUrl;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.createdTime,
        e?.phoneNumber,
        e?.uid,
        e?.isConfifurated,
        e?.name,
        e?.surname,
        e?.school,
        e?.technicTittleUsers,
        e?.isUserPremium,
        e?.correctAnswers,
        e?.wrongAnswers,
        e?.schoodCode,
        e?.streakCount,
        e?.lastActiveDate,
        e?.streakAvailable,
        e?.likedQuestionsIDList,
        e?.photoUrl
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
