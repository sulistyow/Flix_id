import 'package:flix_id/data/repositories/authentication.dart';
import 'package:flix_id/data/repositories/user_repository.dart';
import 'package:flix_id/domain/entities/user.dart';
import 'package:flix_id/domain/result.dart';
import 'package:flix_id/domain/usecases/usecase.dart';

class GetLoggedInUser implements Usecase<Result<User>, void> {
  final Authentication _authentication;
  final UserRepository _userRepository;

  GetLoggedInUser(
      {required Authentication authentication,
      required UserRepository userRepository})
      : _authentication = authentication,
        _userRepository = userRepository;

  @override
  Future<Result<User>> call(void params) async {
    String? loggedId = _authentication.getLoggedInUserId();
    if (loggedId != null) {
      var userResult = await _userRepository.getUser(uid: loggedId);
      if (userResult.isSuccess) {
        return Result.success(userResult.resultValue!);
      } else {
        return Result.failed(userResult.errorMessage!);
      }
    } else {
      return const Result.failed('No user logged id');
    }
  }
}
