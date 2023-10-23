// Create a ExpenseProvider class that extends

import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spese_condivise/models/expense.dart';

final _db = FirebaseFirestore.instance;

final expensesProvider = StreamProvider.autoDispose<List<Expense>>(
  (ref) {
    final stream = FirebaseFirestore.instance.collection('expenses').snapshots();
    ref.keepAlive();
    return stream.map((snapshot) => snapshot.docs.map((doc) {
          return Expense.fromJson({...doc.data(), 'id' : doc.id});
    }).toList());
  },
);

void addExpense(Expense e){
  _db.collection('expenses').add(e.toMap());
}

void removeExpense(Expense e){
  _db.collection('expenses').doc(e.id).delete();
}

void updateExpense(Expense e){
  _db.collection('expenses').doc(e.id).update(e.toMap());
}