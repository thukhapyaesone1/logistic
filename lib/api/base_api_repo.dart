import 'package:dio/dio.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../src/mmt_application.dart';
import 'dio_interceptor.dart';

class BaseApiRepo {
  late OdooClient _client;
  late Dio _dio;
  late Stream<OdooSession> _listenSessionChange;
  final String jsonRpc = '/jsonrpc';
  final String createMethod = 'create';
  final String searchRead = 'search_read';
  final String executeMethod = 'execute';

  BaseApiRepo() {
    _client = OdooClient(MMTApplication.serverUrl, MMTApplication.odooSession);
    _dio = Dio(
      BaseOptions(
        responseType: ResponseType.json,
        contentType: Headers.jsonContentType,
        baseUrl: MMTApplication.serverUrl,
        connectTimeout: const Duration(minutes: 2),
        sendTimeout: const Duration(minutes: 2),
        receiveTimeout: const Duration(minutes: 2),
      ),
    );
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));
    dio.interceptors.add(DioInterceptor());
    _listenSessionChange = client.sessionStream;
  }

  Dio get dio => _dio;

  OdooClient get client => _client;

  Stream<OdooSession> get listenSessionChange => _listenSessionChange;

  Map<String, dynamic> createApiRequest(
      {required String model,
      required String method,
      List? args,
      dynamic? kwargs}) {
    return {
      'service': 'object',
      'model': model,
      'method': method,
      'args': args ?? [],
      'kwargs': kwargs ?? {},
    };
  }

  Future<Response> postMethodCall({String? additionalPath, Map<String,dynamic>? data }) async {
    return await dio.post(MMTApplication.serverUrl+(additionalPath ?? ''),data:  data);
}

  Map<String, dynamic> createOneToManyApiRequest({List? args, dynamic kwargs}) {
    return {
      "service": "object",
      "method": "execute",
      'args': args ?? [],
      'kwargs': kwargs ?? {},
    };
  }

  Future<Response<dynamic>> retryApiRequest(RequestOptions requestOptions) {
    // Create a new `RequestOptions` object with the same method, path, data, and query parameters as the original request.
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    // Retry the request with the new `RequestOptions` object.
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}
