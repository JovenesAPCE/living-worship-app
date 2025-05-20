class RegisterUserDecision{
  final String email;
  final String cellPhone;
  final String number;
  final String name;
  final CalebDecision decision;

  const RegisterUserDecision({
    this.email = '',
    this.cellPhone = '',
    this.number = '',
    this.name = '',
    this.decision = CalebDecision.notReady,
  });




  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'cell_phone': cellPhone,
      'number': number,
      'name': name,
      'decision': decision.name,
    };
  }

  RegisterUserDecision copyWith({
    String? email,
    String? cellPhone,
    String? number,
    String? name,
    CalebDecision? decision,
  }) {
    return RegisterUserDecision(
      email: email ?? this.email,
      cellPhone: cellPhone ?? this.cellPhone,
      number: number ?? this.number,
      name: name ?? this.name,
      decision: decision ?? this.decision,
    );
  }

}


enum CalebDecision {
  yesIPreacher,         // Sí, deseo ser un predicador CALEB
  maybeLater,           // Tal vez más adelante
  notReady              // No, no me siento preparado
}