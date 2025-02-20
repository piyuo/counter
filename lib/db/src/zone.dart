import 'package:freezed_annotation/freezed_annotation.dart';

part 'zone.freezed.dart';
part 'zone.g.dart'; // JSON support

@freezed
class Zone with _$Zone {
  const factory Zone({
    required String firstName,
    required String lastName,
    required int age,
  }) = _Zone;

  factory Zone.fromJson(Map<String, Object?> json) => _$ZoneFromJson(json);
}
