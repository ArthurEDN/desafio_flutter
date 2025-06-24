  import 'package:firebase_auth/firebase_auth.dart';

  import '../../models/user.dart';
  import '../../../utils/result.dart';

  abstract class IAuthRepository {
    Future<Result<UserEntity>> signIn({
      required String cpf,
      required String password,
    });
    Future<Result<UserEntity>> signUp({
      required String name,
      required String email,
      required String cpf,
      required String password,
    });
    Future<Result<void>> signOut();
    Future<Result<void>> requestPasswordReset({required String email});
    Future<Result<UserEntity?>> getCurrentUser();
    Stream<User?> get authStateChanges;
  }
