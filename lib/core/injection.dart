import 'package:get_it/get_it.dart';
import 'package:omar_apis/data/repo_impl/repo_impl.dart';
import 'package:omar_apis/data/data_source/api_service.dart';
import 'package:omar_apis/presentation/manager/user_cubit.dart';

final getIt = GetIt.instance;

void initGetIt() {
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(createAndSetupDio()),
  );
  getIt.registerLazySingleton<RepoImpl>(() => RepoImpl(getIt()));
  getIt.registerLazySingleton<UserCubit>(() => UserCubit(getIt()));
}
