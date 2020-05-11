import 'dart:convert' show utf8;
import 'dart:io' show HttpClient;

void main(List<String> arguments) {
    () async {
        var client = HttpClient();
        var url = Uri.parse('http://www.example.com/');
        var req = await client.getUrl(url);
        var resp = await req.close();
        resp.transform(utf8.decoder).listen((content) {
            print(content);
        });
    }();
}
