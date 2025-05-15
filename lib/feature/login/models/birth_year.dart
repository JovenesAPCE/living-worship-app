import 'package:formz/formz.dart';

class BirthYear extends FormzInput<String, BirthYearValidationError> {
  const BirthYear.pure([String birthYear = '']) : super.pure(birthYear);
  const BirthYear.dirty([super.value = '']) : super.dirty();

  @override
  BirthYearValidationError? validator(String value) {
    if (value.isEmpty) return BirthYearValidationError.empty;

    final intYear = int.tryParse(value);
    final currentYear = DateTime.now().year;

    if (intYear == null || intYear < 1900 || intYear > currentYear) {
      return BirthYearValidationError.invalid;
    }

    return null;
  }
}

enum BirthYearValidationError { empty, invalid }