class QrConst {
  static const appPrefix = 'JAMT_2025|';

  /// La clave y el IV deben tener 16 caracteres exactamente para AES-128
  static const aesKey = '8E6F2293DC6CF6C9';
  static const aesIv = 'CE8FBEB4F868B4B3';
  /// Clave secreta solo para firma HMAC (debe ser muy segura y no compartida)
  static const hmacKey = '495BD43A7EEE3E4FEE9EE2342D4A36227D68E23BBD8FC874F4';

  static const typeSemiPlenaryCheckIn = 'ENTRADA';
  static const typeSemiPlenaryCheckOut = 'SALIDA';
}