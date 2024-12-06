import 'package:flix_id/data/repositories/authentication.dart';
import 'package:flix_id/domain/result.dart';

class DummyAuth implements Authentication {
  @override
  String? getLoggedInUserId() {
    // TODO: implement getLoggedInUserId
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> login(
      {required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 1));
    // return const Result.success("ID-123456");
    return const Result.failed('Gagal Login');
  }

  @override
  Future<Result<void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> register(
      {required String email, String password = ""}) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
