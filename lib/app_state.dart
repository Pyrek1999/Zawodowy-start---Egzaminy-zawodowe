import 'package:flutter/material.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  int _previousQuestion = 0;
  int get previousQuestion => _previousQuestion;
  set previousQuestion(int value) {
    _previousQuestion = value;
  }

  String _previousAnswer = '';
  String get previousAnswer => _previousAnswer;
  set previousAnswer(String value) {
    _previousAnswer = value;
  }

  String _userEmail = '';
  String get userEmail => _userEmail;
  set userEmail(String value) {
    _userEmail = value;
  }

  List<String> _technicUsersTable = [];
  List<String> get technicUsersTable => _technicUsersTable;
  set technicUsersTable(List<String> value) {
    _technicUsersTable = value;
  }

  void addToTechnicUsersTable(String value) {
    technicUsersTable.add(value);
  }

  void removeFromTechnicUsersTable(String value) {
    technicUsersTable.remove(value);
  }

  void removeAtIndexFromTechnicUsersTable(int index) {
    technicUsersTable.removeAt(index);
  }

  void updateTechnicUsersTableAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    technicUsersTable[index] = updateFn(_technicUsersTable[index]);
  }

  void insertAtIndexInTechnicUsersTable(int index, String value) {
    technicUsersTable.insert(index, value);
  }

  String _passTechnicTittle = '';
  String get passTechnicTittle => _passTechnicTittle;
  set passTechnicTittle(String value) {
    _passTechnicTittle = value;
  }

  String _passQualification = '';
  String get passQualification => _passQualification;
  set passQualification(String value) {
    _passQualification = value;
  }

  List<int> _listOfQuestionsID = [];
  List<int> get listOfQuestionsID => _listOfQuestionsID;
  set listOfQuestionsID(List<int> value) {
    _listOfQuestionsID = value;
  }

  void addToListOfQuestionsID(int value) {
    listOfQuestionsID.add(value);
  }

  void removeFromListOfQuestionsID(int value) {
    listOfQuestionsID.remove(value);
  }

  void removeAtIndexFromListOfQuestionsID(int index) {
    listOfQuestionsID.removeAt(index);
  }

  void updateListOfQuestionsIDAtIndex(
    int index,
    int Function(int) updateFn,
  ) {
    listOfQuestionsID[index] = updateFn(_listOfQuestionsID[index]);
  }

  void insertAtIndexInListOfQuestionsID(int index, int value) {
    listOfQuestionsID.insert(index, value);
  }

  List<String> _selectedOptionsForty = [];
  List<String> get selectedOptionsForty => _selectedOptionsForty;
  set selectedOptionsForty(List<String> value) {
    _selectedOptionsForty = value;
  }

  void addToSelectedOptionsForty(String value) {
    selectedOptionsForty.add(value);
  }

  void removeFromSelectedOptionsForty(String value) {
    selectedOptionsForty.remove(value);
  }

  void removeAtIndexFromSelectedOptionsForty(int index) {
    selectedOptionsForty.removeAt(index);
  }

  void updateSelectedOptionsFortyAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    selectedOptionsForty[index] = updateFn(_selectedOptionsForty[index]);
  }

  void insertAtIndexInSelectedOptionsForty(int index, String value) {
    selectedOptionsForty.insert(index, value);
  }

  int _adCounter = 0;
  int get adCounter => _adCounter;
  set adCounter(int value) {
    _adCounter = value;
  }
}
