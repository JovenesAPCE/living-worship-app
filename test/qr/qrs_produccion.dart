import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GenerateQRProduction Entrada y Salida', () {


    final semiplenarias = {
      "semiplenaria_1": {
        "title": "ALVA Y ALVA",
        "time": "Sábado 8:40 HS"
      },
      "semiplenaria_2": {
        "title": "E. FORGA",
        "time": "Sábado 8:40 HS"
      },
      "semiplenaria_3": {
        "title": "SALÓN AZUL",
        "time": "Sábado 8:40 HS"
      },
      "semiplenaria_4": {
        "title": "TEATRÍN",
        "time": "Sábado 8:40 HS"
      },
      "semiplenaria_5": {
        "title": "CARPA MOVÍL",
        "time": "Sábado 8:40 HS"
      },
      "semiplenaria_6": {
        "title": "PABELLON D",
        "time": "Sábado 8:40 HS"
      },
      "semiplenaria_7": {
        "title": "ALVA Y ALVA",
        "time": "Sábado 15:30 HS"
      },
      "semiplenaria_8": {
        "title": "E. FORGA",
        "time": "Sábado 15:30 HS"
      },
      "semiplenaria_9": {
        "title": "SALÓN AZUL",
        "time": "Sábado 15:30 HS"
      },
      "semiplenaria_10": {
        "title": "TEATRÍN",
        "time": "Sábado 15:30 HS"
      },
      "semiplenaria_11": {
        "title": "CARPA MOVÍL",
        "time": "Sábado 15:30 HS"
      },
      "semiplenaria_12": {
        "title": "PABELLON D",
        "time": "Sábado 15:30 HS"
      },
    };

    test("🔐 Generar QR ENTRADA y SALIDA por semiplenaria", () {
      print("🔐 QRs generados (entrada y salida):\n");

      semiplenarias.forEach((id, info) {
        for (final type in ['ENTRADA', 'SALIDA']) {
          final code =  info['title']??"";
          final description = "${info['time']} - ${info['title']} ($type)";
          final payload = QrPayload(
            uid: id,
            type: type,
            code: code,
            description: description,
          );

          final qrText = QRUtils.generateEncryptedQR(payload);
          print('# QR [$id][$type] ${info["time"]} ${info["title"]}:');
          print(qrText);
          print('---');
        }
      });
    });

    test("✅ Verificar que todos los QRs ENTRADA y SALIDA se pueden desencriptar", () {
      semiplenarias.forEach((id, info) {
        for (final type in ['ENTRADA', 'SALIDA']) {
          final code =  info['title']??"";
          final description = "${info['time']} - ${info['title']} ($type)";

          final payload = QrPayload(
            uid: id,
            type: type,
            code: code,
            description: description,
          );

          final qrText = QRUtils.generateEncryptedQR(payload);
          final result = QRUtils.decryptQR(qrText);

          expect(result, isNotNull, reason: "QR inválido para $id ($type)");
          expect(result!.uid, equals(id));
          expect(result.type, equals(type));
          expect(result.code, equals(code));
          expect(result.description, equals(description));
        }
      });
    });
  });
}