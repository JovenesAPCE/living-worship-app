sealed class RegisterUserDecisionFailure {}

class UserNotExistRegisterUserDecision extends RegisterUserDecisionFailure {}
class SessionNotExistRegisterUserDecision extends RegisterUserDecisionFailure {}
class SessionNotFoundRegisterUserDecision extends RegisterUserDecisionFailure {}

class NoInternetRegisterUserDecision extends RegisterUserDecisionFailure {}

class UnknownRegisterUserDecision extends RegisterUserDecisionFailure {}
