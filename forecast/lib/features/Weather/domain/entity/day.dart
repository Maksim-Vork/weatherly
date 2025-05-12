import 'package:forecast/features/Weather/domain/entity/condition.dart';

class Day {
  final double maxtempC;
  final double mintempC;
  final Condition condition;

  Day({
    required this.maxtempC,
    required this.mintempC,
    required this.condition,
  });
}
