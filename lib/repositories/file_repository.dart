import 'package:cinema_fe/utils/http_request.dart';
import 'package:file_picker/file_picker.dart';

class FileRepository {
  final String url = "/erasmus/upload/";

  Future<String> postFile(PlatformFile file, String path) async {
    final String response = await HttpRequest?.postFile(url, file, path);

    return response;
  }
}
