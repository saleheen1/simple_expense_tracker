class BudgetModel {
  final int year;
  final int month;
  final double budget;

  BudgetModel({required this.year, required this.month, required this.budget});

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    return BudgetModel(
      year: json['year'] as int? ?? 0,
      month: json['month'] as int? ?? 0,
      budget: (json['budget'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'year': year, 'month': month, 'budget': budget};
  }
}
