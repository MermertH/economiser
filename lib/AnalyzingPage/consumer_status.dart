class Expenses {
  final String id;
  final String title;
  final String cost;
  final DateTime date;
  Expenses(
    this.id,
    this.title,
    this.cost,
    this.date,
  );
}

class Budget {
  final String budget;
  Budget(this.budget);
  String get getBudget {
    return budget;
  }
}
