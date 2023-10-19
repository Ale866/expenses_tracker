import 'package:intl/intl.dart';

class Expense {
  Expense(
      {required this.title,
      required this.date,
      required this.category,
      required this.payer,
      required this.cost,})
      : id = '';

  Expense.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = DateTime.parse(json['date']),
        title = json['title'],
        category = Category.values.firstWhere((e) => e.name == json['category']),
        payer = Payer.values.firstWhere((e) => e.name == json['payer']),
        cost = json['cost'];

  final String id;
  final DateTime date;
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

  Map<String,dynamic> toMap(){
    return {
      "id": id,
      "date": date.toString(),
      "title": title,
      "category": category.name,
      "payer": payer.name,
      "cost": cost,
    };
  }
  @override
  String toString(){
    return toMap().toString();
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
