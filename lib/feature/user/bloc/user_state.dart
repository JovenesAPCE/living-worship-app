part of 'user_bloc.dart';

class UserState extends Equatable {

  final UserPageState pageState;
  final List<UserDecision> decisions;
  final String email;
  final bool emailError;
  final String emailErrorText;
  final String phone;
  final bool phoneError;
  final String phoneErrorText;
  final UserMessage userMessage;
  final bool progress;
  final bool close;
  final String openLaunchUrlNative;
  final String whatsAppGroup;

  @override
  List<Object?> get props => [whatsAppGroup, close, openLaunchUrlNative,progress, pageState, decisions, email, emailError, emailErrorText, phone, phoneError, phoneErrorText, userMessage];

  const UserState({
    this.whatsAppGroup = "",
    this.close = false,
    this.openLaunchUrlNative = "",
    this.progress = false,
    this.userMessage = const UserMessage.empty(),
    this.email = "",
    this.emailError = false,
    this.emailErrorText = "",
    this.phone = "",
    this.phoneError = false,
    this.phoneErrorText  = "",
    this.pageState = UserPageState.pageDecision,
    this.decisions = const [
      UserDecision(
        id: 1,
        selected: true,
        name: 'Sí, deseo ser un misionero CALEB'
      ),
      UserDecision(
          id: 3,
          selected: false,
          name: 'No, no me siento preparado'
      ),
    ],
  });

  UserState copyWith({
    UserPageState? pageState,
    List<UserDecision>? decisions,
    String? email,
    bool? emailError,
    String? emailErrorText,
    String? phone,
    bool? phoneError,
    String? phoneErrorText,
    UserMessage? userMessage,
    bool? progress,
    bool? close,
    String? openLaunchUrlNative,
    String? whatsAppGroup,
  }) {
    return UserState(
      pageState: pageState ?? this.pageState,
      decisions: decisions ?? this.decisions,
      email: email ?? this.email,
      emailError: emailError ?? this.emailError,
      emailErrorText: emailErrorText ?? this.emailErrorText,
      phone: phone ?? this.phone,
      phoneError: phoneError ?? this.phoneError,
      phoneErrorText: phoneErrorText ?? this.phoneErrorText,
      userMessage: userMessage ?? this.userMessage,
      progress: progress ?? this.progress,
      close: close ?? this.close,
      openLaunchUrlNative: openLaunchUrlNative ?? this.openLaunchUrlNative,
      whatsAppGroup: whatsAppGroup ?? this.whatsAppGroup,
    );
  }

}
