import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:data/data.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class QRUtils {
  static final _key = encrypt.Key.fromUtf8(QrConst.aesKey);
  static final _iv = encrypt.IV.fromUtf8(QrConst.aesIv);
  static final _encrypter = encrypt.Encrypter(encrypt.AES(_key));

  /// Calcula la firma HMAC del texto usando una clave secreta
  static String _generateHmac(String data) {
    final hmac = Hmac(sha256, utf8.encode(QrConst.hmacKey));
    final digest = hmac.convert(utf8.encode(data));
    return base64Url.encode(digest.bytes);
  }

  /// Genera QR con prefijo visible, contenido cifrado y firma
  static String generateEncryptedQR(QrPayload qr) {
    final json = jsonEncode(qr.toJson());
    final encrypted = _encrypter.encrypt(json, iv: _iv);
    final encryptedText = encrypted.base64;
    final signature = _generateHmac(encryptedText);
    return '${QrConst.appPrefix}${qr.description}|$encryptedText|$signature';
  }

  /// Desencripta y valida firma del QR
  static QrPayload? decryptQR(String fullQRText) {
    try {
      if (!fullQRText.startsWith(QrConst.appPrefix)) {
        final err = InvalidQrException("El QR no empieza con el prefijo esperado", context: fullQRText);
        FBUtils.tryLog(err.toString());
        FBUtils.tryRecordError(err);
        return null;
      }

      final parts = fullQRText.split('|');
      if (parts.length < 4) {
        final err = InvalidQrException("QR incompleto o malformado", context: fullQRText);
        FBUtils.tryLog(err.toString());
        FBUtils.tryRecordError(err);
        return null;
      }

      final encryptedBase64 = parts[2];
      final receivedHmac = parts[3];
      final expectedHmac = _generateHmac(encryptedBase64);

      if (receivedHmac != expectedHmac) {
        final err = InvalidQrException("Firma digital inválida o QR manipulado", context: fullQRText);
        FBUtils.tryLog(err.toString());
        FBUtils.tryRecordError(err);
        return null;
      }

      final decryptedJson = _encrypter.decrypt64(encryptedBase64, iv: _iv);
      final data = jsonDecode(decryptedJson);
      return QrPayload.fromJson(data);
    } catch (e, stack) {
      final err = InvalidQrException("Error desconocido al procesar QR: ${e.toString()}", context: fullQRText);
      FBUtils.tryLog(err.toString());
      FBUtils.tryRecordError(err, stack: stack);
      return null;
    }
  }
}