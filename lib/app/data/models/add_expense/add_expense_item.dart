class AddExcpenseItem {
  int id;
  String category;
  String amountBefore;
  String amountAfter;
  String code;
  String dateformat;
  DateTime date;
  String? filePath;

  AddExcpenseItem({
    required this.id,
    required this.category,
    required this.amountBefore,
    required this.amountAfter,
    required this.code,
    required this.dateformat,
    required this.date,
    this.filePath,
  });

  factory AddExcpenseItem.fromJson(Map<String, dynamic> json) {
    return AddExcpenseItem(
      id: json['id'] as int,
      category: json['category'] as String,
      amountBefore: json['amountBefore'] as String,
      amountAfter: json['amountAfter'] as String,
      code: json['code'] as String,
      dateformat: json['dateformat'] as String,
      date: DateTime.parse(json['date'] as String),
      filePath: json['filePath'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'amountBefore': amountBefore,
      'amountAfter': amountAfter,
      'code': code,
      'dateformat': dateformat,
      'date': date.toIso8601String(),
      'filePath': filePath,
    };
  }
}
