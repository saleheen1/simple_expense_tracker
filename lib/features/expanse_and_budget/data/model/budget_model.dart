class BudgetModel {
  final int year;
  final int month;
  final double budget;

  BudgetModel({required this.year, required this.month, required this.budget});

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    return BudgetModel(
      year: json['year'] ?? 0000,
      month: json['month'] ?? 00,
      budget: json['budget'] ?? 0,
    );
  }
}
