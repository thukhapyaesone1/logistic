import 'dart:convert';
import 'package:odoo_rpc/odoo_rpc.dart';
import '../../exception/admin_login_require_exception.dart';
import '../../exception/login_fail_exception.dart';
import '../../share_preference/sh_keys.dart';
import '../../share_preference/sh_utils.dart';
import '../../src/mmt_application.dart';
import '../base_api_repo.dart';

class LoginApiRepo extends BaseApiRepo {
  final SharePrefUtils sharePrefUtils = SharePrefUtils();

  Future<bool?> loginProcess(
      {required String name,
      required String password,
      required String db}) async {
    await postMethodCall(additionalPath: '/web/session/authenticate', data: {
      'jsonrpc': '2.0',
      'method': 'call',
      'params': {'db': db, 'login': name, 'password': password}
    }) ;
    sharePrefUtils.saveString(ShKeys.sessionKey, 'session_key');
    return true;
  }
}
