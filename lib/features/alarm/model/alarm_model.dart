class AlarmModel {
  final int id;
  final DateTime dateTime;
  bool isEnabled;

  AlarmModel({
    required this.id,
    required this.dateTime,
    this.isEnabled = true,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'dateTime': dateTime.toIso8601String(),
    'isEnabled': isEnabled,
  };

  factory AlarmModel.fromJson(Map<String, dynamic> json) {
    return AlarmModel(
      id: json['id'],
      dateTime: DateTime.parse(json['dateTime']),
      isEnabled: json['isEnabled'],
    );
  }
}
