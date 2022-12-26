part of 'news_cubit.dart';

enum NewsStatus { initial, loading, loaded, error }

class NewsState extends Equatable {
  const NewsState({
    required this.newsList,
    required this.status,
  });

  final List<Articles> newsList;
  final NewsStatus status;

  NewsState copyWith({
    List<Articles>? newsList,
    NewsStatus? status,
  }) {
    return NewsState(
      newsList: newsList ?? this.newsList,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [newsList, status];
}
