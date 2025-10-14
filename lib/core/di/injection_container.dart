import 'package:bookly_system/core/network/network_info.dart';
import 'package:bookly_system/core/network/supabase_client.dart';
import 'package:bookly_system/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:bookly_system/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:bookly_system/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bookly_system/features/auth/domain/repositories/auth_repository.dart';
import 'package:bookly_system/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:bookly_system/features/auth/domain/usecases/login_usecase.dart';
import 'package:bookly_system/features/auth/domain/usecases/logout_usecase.dart';
import 'package:bookly_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookly_system/features/categories/data/datasources/categories_remote_datasource.dart';
import 'package:bookly_system/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:bookly_system/features/categories/domain/repositories/categories_repository.dart';
import 'package:bookly_system/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:bookly_system/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:bookly_system/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:bookly_system/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:bookly_system/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:bookly_system/features/dashboard/domain/usecases/get_dashboard_stats_usecase.dart';
import 'package:bookly_system/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:bookly_system/features/products/data/datasources/products_remote_datasource.dart';
import 'package:bookly_system/features/products/data/repositories/products_repository_impl.dart';
import 'package:bookly_system/features/products/domain/repositories/products_repository.dart';
import 'package:bookly_system/features/products/domain/usecases/get_products_usecase.dart';
import 'package:bookly_system/features/products/presentation/bloc/products_bloc.dart';
import 'package:bookly_system/features/users/data/datasources/users_remote_datasource.dart';
import 'package:bookly_system/features/users/data/repositories/users_repository_impl.dart';
import 'package:bookly_system/features/users/domain/repositories/users_repository.dart';
import 'package:bookly_system/features/users/domain/usecases/activate_user_usecase.dart';
import 'package:bookly_system/features/users/domain/usecases/add_user_usecase.dart';
import 'package:bookly_system/features/users/domain/usecases/deactivate_user_usecase.dart';
import 'package:bookly_system/features/users/domain/usecases/delete_user_usecase.dart';
import 'package:bookly_system/features/users/domain/usecases/get_user_by_id_usecase.dart';
import 'package:bookly_system/features/users/domain/usecases/get_users_usecase.dart';
import 'package:bookly_system/features/users/domain/usecases/update_permissions_usecase.dart';
import 'package:bookly_system/features/users/domain/usecases/update_user_usecase.dart';
import 'package:bookly_system/features/users/presentation/bloc/users_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// GetIt Service Locator
final getIt = GetIt.instance;

/// تهيئة جميع الـ dependencies
Future<void> initDependencies(SharedPreferences sharedPreferences) async {
  // ========== Core ==========

  // Supabase
  await SupabaseClientService.initialize();

  // Network Info
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  // ========== Features ==========

  // Auth
  await _initAuth(sharedPreferences);

  // Users Management
  await _initUsers();

  // Dashboard
  await _initDashboard();

  // Categories
  await _initCategories();

  // Products
  await _initProducts();
}

// ========== Auth Feature ==========
Future<void> _initAuth(SharedPreferences sharedPreferences) async {
  // Data sources
  // Auth Local Data Source
  getIt.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(sharedPreferences: sharedPreferences));

  // Auth Remote Data Source
  getIt.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(localDataSource: getIt()));

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: getIt(), networkInfo: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCurrentUserUseCase(getIt()));

  // Bloc
  getIt.registerFactory(() => AuthBloc(loginUseCase: getIt(), logoutUseCase: getIt(), getCurrentUserUseCase: getIt()));
}

// ========== Users Management Feature ==========
Future<void> _initUsers() async {
  // Data sources
  getIt.registerLazySingleton<UsersRemoteDataSource>(() => UsersRemoteDataSourceImpl());

  // Repository
  getIt.registerLazySingleton<UsersRepository>(
    () => UsersRepositoryImpl(remoteDataSource: getIt(), networkInfo: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetUsersUseCase(getIt()));
  getIt.registerLazySingleton(() => GetUserByIdUseCase(getIt()));
  getIt.registerLazySingleton(() => AddUserUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateUserUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteUserUseCase(getIt()));
  getIt.registerLazySingleton(() => ActivateUserUseCase(getIt()));
  getIt.registerLazySingleton(() => DeactivateUserUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdatePermissionsUseCase(getIt()));

  // Bloc
  getIt.registerFactory(
    () => UsersBloc(
      getUsersUseCase: getIt(),
      getUserByIdUseCase: getIt(),
      addUserUseCase: getIt(),
      updateUserUseCase: getIt(),
      deleteUserUseCase: getIt(),
      activateUserUseCase: getIt(),
      deactivateUserUseCase: getIt(),
      updatePermissionsUseCase: getIt(),
    ),
  );
}

// ========== Dashboard Feature ==========
Future<void> _initDashboard() async {
  // Data sources
  getIt.registerLazySingleton<DashboardRemoteDataSource>(() => DashboardRemoteDataSourceImpl());

  // Repository
  getIt.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(remoteDataSource: getIt(), networkInfo: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetDashboardStatsUseCase(getIt()));

  // Bloc
  getIt.registerFactory(() => DashboardBloc(getDashboardStatsUseCase: getIt()));
}

// ========== Categories Feature ==========
Future<void> _initCategories() async {
  // Data sources
  getIt.registerLazySingleton<CategoriesRemoteDataSource>(() => CategoriesRemoteDataSourceImpl());

  // Repository
  getIt.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(remoteDataSource: getIt(), networkInfo: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetCategoriesUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCategoryByIdUseCase(getIt()));
  getIt.registerLazySingleton(() => AddCategoryUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateCategoryUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteCategoryUseCase(getIt()));
  getIt.registerLazySingleton(() => GetMainCategoriesUseCase(getIt()));
  getIt.registerLazySingleton(() => GetSubCategoriesUseCase(getIt()));
  getIt.registerLazySingleton(() => SearchCategoriesUseCase(getIt()));

  // Bloc
  getIt.registerFactory(
    () => CategoriesBloc(
      getCategoriesUseCase: getIt(),
      getCategoryByIdUseCase: getIt(),
      addCategoryUseCase: getIt(),
      updateCategoryUseCase: getIt(),
      deleteCategoryUseCase: getIt(),
      getMainCategoriesUseCase: getIt(),
      getSubCategoriesUseCase: getIt(),
      searchCategoriesUseCase: getIt(),
    ),
  );
}

// ========== Products Feature ==========
Future<void> _initProducts() async {
  // Data sources
  getIt.registerLazySingleton<ProductsRemoteDataSource>(() => ProductsRemoteDataSourceImpl());

  // Repository
  getIt.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(remoteDataSource: getIt(), networkInfo: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetProductsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetProductByIdUseCase(getIt()));
  getIt.registerLazySingleton(() => AddProductUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateProductUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteProductUseCase(getIt()));
  getIt.registerLazySingleton(() => SearchProductsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetLowStockProductsUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateProductStockUseCase(getIt()));

  // Bloc
  getIt.registerFactory(
    () => ProductsBloc(
      getProductsUseCase: getIt(),
      getProductByIdUseCase: getIt(),
      addProductUseCase: getIt(),
      updateProductUseCase: getIt(),
      deleteProductUseCase: getIt(),
      searchProductsUseCase: getIt(),
      getLowStockProductsUseCase: getIt(),
      updateProductStockUseCase: getIt(),
    ),
  );
}
