import 'package:equatable/equatable.dart';

enum HomeTab {
  upload,
  files,
  exams,
  profile,
}

class HomeState extends Equatable {
  const HomeState({this.currentTab = HomeTab.upload});

  final HomeTab currentTab;

  int get tabIndex => currentTab.index;

  HomeState copyWith({HomeTab? currentTab}) {
    return HomeState(
      currentTab: currentTab ?? this.currentTab,
    );
  }

  @override
  List<Object?> get props => [currentTab];
}
