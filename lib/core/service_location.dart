import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/CategoryCubit/categorycubit.dart';
import 'package:waslet_khier/features/charity_feature/data/repo/categoryrepo.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // Core
  getIt.registerLazySingleton<ApiService>(() => ApiService(Dio()));

  // Repos
  getIt.registerLazySingleton<Categoryrepo>(
    () => Categoryrepo(getIt<ApiService>()),
  );

  // Cubits — registerFactory عشان كل مرة instance جديد
  getIt.registerFactory<Categorycubit>(
    () => Categorycubit(getIt<Categoryrepo>()),
  );
}
