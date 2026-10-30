import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_period.freezed.dart';
part 'business_period.g.dart';

enum BusinessPeriodStatus { notStarted, inProgress, completed }

@freezed
sealed class BusinessPeriod with _$BusinessPeriod {
  const BusinessPeriod._();

  const factory BusinessPeriod({
    required String id,
    required String name,
    @Assert('startMinute >= 0 && startMinute < 1440') required int startMinute,
    @Assert('endMinute > startMinute && endMinute <= 1440') required int endMinute,
  }) = _BusinessPeriod;

  factory BusinessPeriod.fromJson(Map<String, dynamic> json) => _$BusinessPeriodFromJson(json);

  static const List<BusinessPeriod> defaultSchedule = [
    BusinessPeriod(id: 'breakfast', name: 'Breakfast', startMinute: 7 * 60, endMinute: 9 * 60),
    BusinessPeriod(id: 'lunch', name: 'Lunch', startMinute: 11 * 60 + 30, endMinute: 13 * 60 + 30),
    BusinessPeriod(id: 'dinner', name: 'Dinner', startMinute: 17 * 60, endMinute: 19 * 60),
  ];

  BusinessPeriodStatus statusAt(DateTime businessLocalTime) {
    final minuteOfDay = businessLocalTime.hour * 60 + businessLocalTime.minute;
    if (minuteOfDay < startMinute) return BusinessPeriodStatus.notStarted;
    if (minuteOfDay >= endMinute) return BusinessPeriodStatus.completed;
    return BusinessPeriodStatus.inProgress;
  }
}
