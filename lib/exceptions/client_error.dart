class ClientError extends Error {
  ClientError({this.statusCode = 400, this.message = ""}) : super();
  final int statusCode;
  final String message;
}
