import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spese_condivise/firebase_options.dart';
import 'package:spese_condivise/models/expense.dart';
import 'package:spese_condivise/widgets/custom_bottom_navigation.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Create a new user with a first and last name
  final expense = Expense(
    title: "spesa prova",
    date: DateTime.now(),
    category: Category.Affitto,
    payer: Payer.Mancio,
    cost: 25,
  );

  runApp(
    const MaterialApp(
      home: ProviderScope(child: CustomBottomNavigation()),
    ),
  );
}
