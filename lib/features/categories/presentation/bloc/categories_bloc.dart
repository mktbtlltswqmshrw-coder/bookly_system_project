import 'package:bookly_system/core/usecases/usecase.dart';
import 'package:bookly_system/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:bookly_system/features/categories/presentation/bloc/categories_event.dart';
import 'package:bookly_system/features/categories/presentation/bloc/categories_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Bloc للفئات
class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetCategoryByIdUseCase getCategoryByIdUseCase;
  final AddCategoryUseCase addCategoryUseCase;
  final UpdateCategoryUseCase updateCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;
  final GetMainCategoriesUseCase getMainCategoriesUseCase;
  final GetSubCategoriesUseCase getSubCategoriesUseCase;
  final SearchCategoriesUseCase searchCategoriesUseCase;

  CategoriesBloc({
    required this.getCategoriesUseCase,
    required this.getCategoryByIdUseCase,
    required this.addCategoryUseCase,
    required this.updateCategoryUseCase,
    required this.deleteCategoryUseCase,
    required this.getMainCategoriesUseCase,
    required this.getSubCategoriesUseCase,
    required this.searchCategoriesUseCase,
  }) : super(CategoriesInitial()) {
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<RefreshCategoriesEvent>(_onRefreshCategories);
    on<SearchCategoriesEvent>(_onSearchCategories);
    on<AddCategoryEvent>(_onAddCategory);
    on<UpdateCategoryEvent>(_onUpdateCategory);
    on<DeleteCategoryEvent>(_onDeleteCategory);
    on<LoadMainCategoriesEvent>(_onLoadMainCategories);
    on<LoadSubCategoriesEvent>(_onLoadSubCategories);
  }

  /// معالج تحميل الفئات
  Future<void> _onLoadCategories(LoadCategoriesEvent event, Emitter<CategoriesState> emit) async {
    emit(const CategoriesLoading());

    final result = await getCategoriesUseCase(GetCategoriesParams(
      parentId: event.parentId,
      isActive: event.isActive,
    ));

    result.fold(
      (failure) => emit(CategoriesError(failure.message)),
      (categories) => emit(CategoriesLoaded(categories)),
    );
  }

  /// معالج تحديث الفئات
  Future<void> _onRefreshCategories(RefreshCategoriesEvent event, Emitter<CategoriesState> emit) async {
    emit(const CategoriesLoading());

    final result = await getCategoriesUseCase(const GetCategoriesParams());

    result.fold(
      (failure) => emit(CategoriesError(failure.message)),
      (categories) => emit(CategoriesLoaded(categories)),
    );
  }

  /// معالج البحث في الفئات
  Future<void> _onSearchCategories(SearchCategoriesEvent event, Emitter<CategoriesState> emit) async {
    emit(const CategoriesLoading());

    final result = await searchCategoriesUseCase(event.query);

    result.fold(
      (failure) => emit(CategoriesError(failure.message)),
      (categories) => emit(CategoriesLoaded(categories)),
    );
  }

  /// معالج إضافة فئة
  Future<void> _onAddCategory(AddCategoryEvent event, Emitter<CategoriesState> emit) async {
    final result = await addCategoryUseCase(event.category);

    result.fold(
      (failure) => emit(CategoriesError(failure.message)),
      (category) => emit(CategoryAdded(category)),
    );
  }

  /// معالج تحديث فئة
  Future<void> _onUpdateCategory(UpdateCategoryEvent event, Emitter<CategoriesState> emit) async {
    final result = await updateCategoryUseCase(event.category);

    result.fold(
      (failure) => emit(CategoriesError(failure.message)),
      (category) => emit(CategoryUpdated(category)),
    );
  }

  /// معالج حذف فئة
  Future<void> _onDeleteCategory(DeleteCategoryEvent event, Emitter<CategoriesState> emit) async {
    final result = await deleteCategoryUseCase(event.categoryId);

    result.fold(
      (failure) => emit(CategoriesError(failure.message)),
      (_) => emit(CategoryDeleted(event.categoryId)),
    );
  }

  /// معالج تحميل الفئات الرئيسية
  Future<void> _onLoadMainCategories(LoadMainCategoriesEvent event, Emitter<CategoriesState> emit) async {
    emit(const CategoriesLoading());

    final result = await getMainCategoriesUseCase(NoParams());

    result.fold(
      (failure) => emit(CategoriesError(failure.message)),
      (categories) => emit(CategoriesLoaded(categories)),
    );
  }

  /// معالج تحميل الفئات الفرعية
  Future<void> _onLoadSubCategories(LoadSubCategoriesEvent event, Emitter<CategoriesState> emit) async {
    emit(const CategoriesLoading());

    final result = await getSubCategoriesUseCase(event.parentId);

    result.fold(
      (failure) => emit(CategoriesError(failure.message)),
      (categories) => emit(CategoriesLoaded(categories)),
    );
  }
}
