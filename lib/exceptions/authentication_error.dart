class AuthenticationError extends Error {
  AuthenticationError({this.statusCode = 401, this.message = ""}) : super();
  final int statusCode;
  final String message;
}
