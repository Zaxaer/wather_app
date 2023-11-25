class MainTabScreenState {
  final int currentTabIndex;
  MainTabScreenState({
    required this.currentTabIndex,
  });

  const MainTabScreenState.initialState() : currentTabIndex = 0;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MainTabScreenState &&
        other.currentTabIndex == currentTabIndex;
  }

  @override
  int get hashCode => currentTabIndex.hashCode;

  MainTabScreenState copyWith({
    int? currentTabIndex,
  }) {
    return MainTabScreenState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    );
  }
}
