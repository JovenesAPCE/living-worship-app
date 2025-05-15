import 'package:data/data.dart';
import 'package:test/test.dart';

void main() {
  group('QRUtils', () {
    test('should generate and decrypt a valid QR text', () {
      // Generar QR encriptado
      final encryptedQR = QRUtils.generateEncryptedQR(
          QrPayload(uid: "123", type: 'entry', code: 'SESSION-4A', description: 'Semi Plenaria 1'));
      expect(encryptedQR, isNotNull);
      expect(encryptedQR, isNotEmpty);
      print("encryptedQR: $encryptedQR");

      // Desencriptar → devuelve QrPayload?
      final payload = QRUtils.decryptQR(encryptedQR);
      expect(payload, isNotNull);
      expect(payload!.uid, equals("123"));
      expect(payload.type, equals('entry'));
      expect(payload.code, equals('SESSION-4A'));
    });

    test('should return null for invalid encrypted text', () {
      final fakeQR = "INVALIDTEXT";
      final result = QRUtils.decryptQR(fakeQR);
      expect(result, isNull);
    });
  });
}