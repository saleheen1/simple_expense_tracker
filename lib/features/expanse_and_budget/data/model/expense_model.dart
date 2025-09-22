class ExpenseModel {
  final String date;
  final String description;
  final double cost;

  ExpenseModel({
    required this.date,
    required this.description,
    required this.cost,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      description: json['description'],
      date: json['date'] ?? '',
      cost: (json['cost'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description, // keep description in sync with name for now
      'date': date,
      'cost': cost,
    };
  }
}
