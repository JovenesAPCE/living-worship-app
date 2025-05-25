
part of 'home_bloc.dart';

class HomeState extends Equatable {


  final List<String> shuffledList;
  final Map<String, String> imageByTitle;

  const HomeState({
    this.shuffledList = const [],
    this.imageByTitle = const {},
  });

  @override
  List<Object?> get props => [shuffledList, imageByTitle];

  HomeState copyWith({
    List<String>? shuffledList,
    Map<String, String>? imageByTitle,
  }) {
    return HomeState(
      shuffledList: shuffledList ?? this.shuffledList,
      imageByTitle: imageByTitle ?? this.imageByTitle,
    );
  }

}
