import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

int getRandomNumber(
  int minValue,
  int maxValue,
) {
  // Write a function that will give me a random int from rang of arguments
  final _random = math.Random();
  return minValue + _random.nextInt(maxValue - minValue + 1);
}

int calculateDayDifference(
  DateTime date1,
  DateTime date2,
) {
  return date2.difference(date1).inDays;
}
