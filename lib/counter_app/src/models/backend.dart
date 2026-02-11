import 'package:freezed_annotation/freezed_annotation.dart';

part 'backend.freezed.dart';
part 'backend.g.dart';

@freezed
sealed class Backend with _$Backend {
  const factory Backend.empty() = EmptyBackend;

  const factory Backend.piyuo({required String token}) = PiyuoBackend;

  const factory Backend.customServer({required String serverUrl, String? token}) = CustomServerBackend;

  const factory Backend.none() = NoBackend;

  factory Backend.fromJson(Map<String, dynamic> json) => _$BackendFromJson(json);
}
