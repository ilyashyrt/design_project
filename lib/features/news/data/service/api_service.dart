import 'package:chopper/chopper.dart';

part 'api_service.chopper.dart';

@ChopperApi(
    baseUrl:
        'https://newsapi.org/v2/top-headlines?country=tr&apiKey=4856d4f2237c492aacdc743fc80005d2')
abstract class ApiService extends ChopperService {
  @Get(path: '')
  Future<Response<dynamic>> getNews();

  static ApiService create() {
    final client = ChopperClient(
      baseUrl:
          'https://newsapi.org/v2/top-headlines?country=tr&apiKey=4856d4f2237c492aacdc743fc80005d2',
      services: [
        _$ApiService(),
      ],
      converter: const JsonConverter(),
    );
    return _$ApiService(client);
  }
}
