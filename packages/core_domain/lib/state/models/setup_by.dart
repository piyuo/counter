import 'package:freezed_annotation/freezed_annotation.dart';

part 'setup_by.freezed.dart';
part 'setup_by.g.dart';

@freezed
sealed class SetupBy with _$SetupBy {
  const factory SetupBy.empty() = SetupByEmpty;
  const factory SetupBy.invitation() = SetupByInvitation;
  const factory SetupBy.signUp() = SetupBySignUp;
  const factory SetupBy.demo() = SetupByDemo;

  factory SetupBy.fromJson(Map<String, dynamic> json) => _$SetupByFromJson(json);
}
