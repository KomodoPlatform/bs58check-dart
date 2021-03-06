import '../lib/bs58check.dart' as bs58check;
import 'package:test/test.dart';
import 'dart:io';
import 'package:hex/hex.dart';
import 'dart:convert';
void main() {
  Map<String, dynamic> fixtures = json.decode(File('./test/fixtures.json').readAsStringSync(encoding: utf8));
  (fixtures['valid'] as List<dynamic>).forEach((f) {
    test("decodes ${f['string']}", () {
      expect(HEX.encode(bs58check.decode(f['string'])), f['payload']);
    });
  });
  (fixtures['invalid'] as List<dynamic>).forEach((f) {
    test("decode throws on ${f['string']}", () {
      var buffer;
      try {
        buffer = bs58check.decode(f['string']);
      } catch (err) {
        expect((err as ArgumentError).message, f['exception']);
      } finally {
        expect(buffer, null);
      }
    });
  });
  (fixtures['valid'] as List<dynamic>).forEach((f) {
    test("encodes ${f['payload']}", () {
      expect(bs58check.encode(HEX.decode(f['payload'])), f['string']);
    });
  });
}
