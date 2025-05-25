import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GenerateQRProduction Entrada y Salida', () {


    final semiplenarias = {
      "edu_forga_am": {
        "available": 150,
        "capacity": 150,
        "color": "#F44336",
        "endTime": "2025-05-31T09:40:00",
        "gender": "Male",
        "group": "Semiplenaria 1",
        "registered": 0,
        "speaker": "Pedro Valenca",
        "startTime": "2025-05-31T08:25:00",
        "time": "Sábado 8:40 HS",
        "title": "E. FORGA - Solo Varones",
        "topic": ""
      },
      "edu_forga_pm": {
        "available": 150,
        "capacity": 150,
        "color": "#FFEB3B",
        "endTime": "2025-05-31T16:30:00",
        "group": "Semiplenaria 2",
        "registered": 0,
        "speaker": "Pr. Rolando Quinteros",
        "startTime": "2025-05-25T15:15:00",
        "time": "Sábado 15:30 HS",
        "title": "E. FORGA",
        "topic": "Líderes que dejan huellas y no heridas"
      },
      "grados_titulos_am": {
        "available": 500,
        "capacity": 500,
        "color": "#2196F3",
        "endTime": "2025-05-31T23:21:00",
        "gender": "Female",
        "group": "Semiplenaria 1",
        "registered": 0,
        "speaker": "Joyce Carnasale",
        "startTime": "2025-05-25T15:00:00",
        "time": "Sábado 8:40 HS",
        "title": "GRADO Y TITULOS - Solo Mujeres",
        "topic": ""
      },
      "grados_titulos_pm": {
        "available": 450,
        "capacity": 450,
        "color": "#FF9800",
        "endTime": "2025-05-31T16:30:00",
        "group": "Semiplenaria 2",
        "registered": 0,
        "speaker": "Pr. Edison Choque",
        "startTime": "2025-05-25T15:15:00",
        "time": "Sábado 15:30 HS",
        "title": "GRADO Y TITULOS",
        "topic": ""
      },
      "salon_azul_am": {
        "available": 150,
        "capacity": 150,
        "color": "#FFEB3B",
        "endTime": "2025-05-31T09:40:00",
        "group": "Semiplenaria 1",
        "issue": "",
        "registered": 0,
        "speaker": "Pr. Raul Sotelo",
        "startTime": "2025-05-25T08:25:00",
        "time": "Sábado 8:40 HS",
        "title": "SALÓN AZUL",
        "topic": "Creacionismo Puro"
      },
      "salon_azul_pm": {
        "available": 150,
        "capacity": 150,
        "color": "#F44336",
        "endTime": "2025-05-31T16:30:00",
        "group": "Semiplenaria 2",
        "registered": 0,
        "speaker": "Pr. Raul Sotelo",
        "startTime": "2025-05-31T15:15:00",
        "time": "Sábado 15:30 HS",
        "title": "SALÓN AZUL",
        "topic": ""
      },
      "salon_d_501_am": {
        "available": 100,
        "capacity": 100,
        "color": "#FF9800",
        "endTime": "2025-05-31T09:40:00",
        "group": "Semiplenaria 1",
        "registered": 0,
        "speaker": "Pr. Alan Cosavalente",
        "startTime": "2025-05-25T08:25:00",
        "time": "Sábado 8:40 HS",
        "title": "PABELLON D - 501",
        "topic": ""
      },
      "salon_d_501_pm": {
        "available": 50,
        "capacity": 50,
        "color": "#2196F3",
        "endTime": "2025-05-31T16:30:00",
        "group": "Semiplenaria 2",
        "registered": 0,
        "speaker": "Victoria Sanchez(MAP)",
        "startTime": "2025-05-31T15:15:00",
        "time": "Sábado 15:30 HS",
        "title": "PABELLON D - 501",
        "topic": ""
      },
      "salon_d_504_am": {
        "available": 50,
        "capacity": 50,
        "color": "#795548",
        "endTime": "2025-05-31T09:40:00",
        "group": "Semiplenaria 1",
        "registered": 0,
        "speaker": "Psic. Mayumi Arellano",
        "startTime": "2025-05-31T08:25:00",
        "time": "Sábado 8:40 HS",
        "title": "PABELLON D - 504",
        "topic": "Un Amor de Otro Nivel: Cuando el Cerebro Ama con Libertad"
      },
      "salon_d_504_pm": {
        "available": 50,
        "capacity": 50,
        "color": "#795548",
        "endTime": "2025-05-31T16:30:00",
        "group": "Semiplenaria 2",
        "registered": 0,
        "speaker": "Psic. Mayumi Arellano",
        "startTime": "2025-05-21T15:15:00",
        "time": "Sábado 15:30 HS",
        "title": "PABELLON D - 504",
        "topic": "Un Amor de Otro Nivel: Cuando el Cerebro Ama con Libertad"
      },
      "teatrin_am": {
        "available": 100,
        "capacity": 100,
        "color": "#4CAF50",
        "endTime": "2025-05-31T09:40:00",
        "group": "Semiplenaria 1",
        "registered": 0,
        "speaker": "Psic. Damaris Quintero",
        "startTime": "2025-05-25T08:25:00",
        "time": "Sábado 8:40 HS",
        "title": "TEATRÍN",
        "topic": "Amores Extraños"
      },
      "teatrin_pm": {
        "available": 100,
        "capacity": 100,
        "color": "#4CAF50",
        "endTime": "2025-05-31T16:30:00",
        "group": "Semiplenaria 2",
        "registered": 0,
        "speaker": "Psic. Carolyn Azo",
        "startTime": "2025-05-25T15:00:00",
        "time": "Sábado 15:30 HS",
        "title": "TEATRÍN",
        "topic": "La inteligencia emocional: el corazón del voluntariado efectivo"
      }
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
            code: code.toString(),
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
            code: code.toString(),
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