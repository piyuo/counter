// TOC:
//  - RandomTokenGeneratorService: generates URL-safe tokens using timestamp + secure random bytes

import 'dart:math';
import 'dart:typed_data';

import 'package:core_domain/core_domain.dart' as core_domain;

class RandomTokenGeneratorService implements core_domain.TokenGeneratorService {
  static const _alphabet = '23456789abcdefghjkmnpqrstuvwxyz';
  static final _random = Random.secure();

  @override
  String generate({int length = 12}) {
    final timestamp = DateTime.now().microsecondsSinceEpoch;

    final randomBytes = Uint8List(8);
    for (int i = 0; i < randomBytes.length; i++) {
      randomBytes[i] = _random.nextInt(256);
    }

    BigInt value = BigInt.from(timestamp);
    for (final b in randomBytes) {
      value = (value << 8) | BigInt.from(b);
    }

    return _encodeBase(value).substring(0, length);
  }

  static String _encodeBase(BigInt value) {
    final base = BigInt.from(_alphabet.length);
    final buffer = StringBuffer();

    while (value > BigInt.zero) {
      final mod = (value % base).toInt();
      buffer.write(_alphabet[mod]);
      value = value ~/ base;
    }

    return buffer.toString().split('').reversed.join();
  }
}
