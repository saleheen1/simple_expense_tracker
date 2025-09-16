class ExpenseModel {
  final String date;
  final String name;
  final double cost;

  ExpenseModel({required this.date, required this.name, required this.cost});

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      name: json['name'] ?? '',
      date: json['date'] ?? '',
      cost: json['cost'] ?? 0,
    );
  }
}
