import 'package:flix_id/data/repositories/user_repository.dart';
import 'package:flix_id/domain/result.dart';
import 'package:flix_id/domain/usecases/get_user_balance/get_user_balance_param.dart';
import 'package:flix_id/domain/usecases/usecase.dart';

class GetUserBalance implements Usecase<Result<int>, GetUserBalanceParam> {
  final UserRepository _userRepository;

  GetUserBalance({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Result<int>> call(GetUserBalanceParam params) =>
      _userRepository.getUserBalance(uid: params.userId);
}
