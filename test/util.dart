import 'package:http/http.dart';

Response resp(String body, {int code = 200}) {
  return Response(body, code);
}