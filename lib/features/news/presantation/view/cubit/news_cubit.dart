import 'package:design_project/features/news/data/repository/api_repository.dart';
import 'package:design_project/features/news/domain/models/articles_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit()
      : super(const NewsState(
          newsList: [],
          status: NewsStatus.initial,
        ));

  Future<void> getNews() async {
    try {
      emit(state.copyWith(status: NewsStatus.loading));

      final newsList = await apiRepository.getNews();
      emit(
        state.copyWith(
          status: NewsStatus.loaded,
          newsList: newsList,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: NewsStatus.error));
    }
  }

  final ApiRepository apiRepository = ApiRepository();
}
