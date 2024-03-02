class CustomAssertionError extends Error {
  CustomAssertionError({this.statusCode = 400, this.message = ""}) : super();
  final int statusCode;
  final String message;
}
