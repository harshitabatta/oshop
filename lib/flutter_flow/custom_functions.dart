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

double quantityPrice(
  double price,
  int quantity,
) {
  // multiply price with quantity
  return price * quantity;
}

double listsum(List<double> price) {
  // add list of price
  double sum = 0;
  for (double p in price) {
    sum += p;
  }
  return sum;
}

double negativePrice(
  double price,
  int quantity,
) {
  // multiply price with quantity
  return -(price * quantity);
}
