class ExpenseModel {
  final String date;
  final String name; // the name is the description field actually.
  final double cost;

  ExpenseModel({required this.date, required this.name, required this.cost});

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      name: json['name'] ?? '',
      date: json['date'] ?? '',
      cost: (json['cost'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'date': date, 'cost': cost,};
  }
}
