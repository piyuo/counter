# scripts/build_flutter_runner.sh
# Generating code for packages like json_serializable, freezed, injectable, and others that rely on code generation.
dart run build_runner build --delete-conflicting-outputs