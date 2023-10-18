import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Expense {
  Expense(
      {required this.title,
      required this.date,
      required this.category,
      required this.payer,
      required this.cost,
      this.description})
      : id = uuid.v4();

  final String id;
  final DateTime date;
  final String? description;
  final String title;
  final Category category;
  final Payer payer;
  final double cost;

  String get formattedDate {
    return DateFormat('dd / MMM / yy').format(date);
  }

  String get month {
    return DateFormat('MMM').format(date);
  }

  double get costPerPerson {
    return cost / 2;
  }
}

enum Category {
  Affitto,
  Spesa,
  Svago,
  Bollette,
  Istruzione,
  Trasporti,
  Altro,
}

enum Payer {
  Mancio,
  Sespo,
}
