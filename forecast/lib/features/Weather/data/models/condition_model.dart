class ConditionModel {
  final String icon;

  ConditionModel({required this.icon});

  factory ConditionModel.fromJson(Map<String, dynamic> json) {
    return ConditionModel(icon: json['icon']);
  }
}
