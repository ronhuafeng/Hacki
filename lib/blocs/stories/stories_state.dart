part of 'stories_bloc.dart';

enum StoriesStatus { loading, loaded }

class StoriesState extends Equatable {
  const StoriesState({
    required this.storiesByType,
    required this.storyIdsByType,
    required this.statusByType,
    required this.currentPageByType,
  });

  const StoriesState.init({
    this.storiesByType = const <StoryType, List<Story>>{
      StoryType.top: [],
      StoryType.latest: [],
      StoryType.ask: [],
      StoryType.show: [],
      StoryType.jobs: [],
    },
    this.storyIdsByType = const <StoryType, List<int>>{
      StoryType.top: [],
      StoryType.latest: [],
      StoryType.ask: [],
      StoryType.show: [],
      StoryType.jobs: [],
    },
    this.statusByType = const <StoryType, StoriesStatus>{
      StoryType.top: StoriesStatus.loaded,
      StoryType.latest: StoriesStatus.loaded,
      StoryType.ask: StoriesStatus.loaded,
      StoryType.show: StoriesStatus.loaded,
      StoryType.jobs: StoriesStatus.loaded,
    },
    this.currentPageByType = const <StoryType, int>{
      StoryType.top: 0,
      StoryType.latest: 0,
      StoryType.ask: 0,
      StoryType.show: 0,
      StoryType.jobs: 0,
    },
  });

  final Map<StoryType, List<Story>> storiesByType;
  final Map<StoryType, List<int>> storyIdsByType;
  final Map<StoryType, StoriesStatus> statusByType;
  final Map<StoryType, int> currentPageByType;

  StoriesState copyWith({
    Map<StoryType, List<Story>>? storiesByType,
    Map<StoryType, List<int>>? storyIdsByType,
    Map<StoryType, StoriesStatus>? statusByType,
    Map<StoryType, int>? currentPageByType,
  }) {
    return StoriesState(
      storiesByType: storiesByType ?? this.storiesByType,
      storyIdsByType: storyIdsByType ?? this.storyIdsByType,
      statusByType: statusByType ?? this.statusByType,
      currentPageByType: currentPageByType ?? this.currentPageByType,
    );
  }

  StoriesState copyWithStoryAdded({
    required StoryType of,
    required Story story,
  }) {
    final newMap = Map<StoryType, List<Story>>.from(storiesByType);
    newMap[of] = List<Story>.from(newMap[of]!)..add(story);
    return StoriesState(
      storiesByType: newMap,
      storyIdsByType: storyIdsByType,
      statusByType: statusByType,
      currentPageByType: currentPageByType,
    );
  }

  StoriesState copyWithStoryIdsUpdated({
    required StoryType of,
    required List<int> to,
  }) {
    final newMap = Map<StoryType, List<int>>.from(storyIdsByType);
    newMap[of] = to;
    return StoriesState(
      storiesByType: storiesByType,
      storyIdsByType: newMap,
      statusByType: statusByType,
      currentPageByType: currentPageByType,
    );
  }

  StoriesState copyWithStatusUpdated({
    required StoryType of,
    required StoriesStatus to,
  }) {
    final newMap = Map<StoryType, StoriesStatus>.from(statusByType);
    newMap[of] = to;
    return StoriesState(
      storiesByType: storiesByType,
      storyIdsByType: storyIdsByType,
      statusByType: newMap,
      currentPageByType: currentPageByType,
    );
  }

  StoriesState copyWithCurrentPageUpdated({
    required StoryType of,
    required int to,
  }) {
    final newMap = Map<StoryType, int>.from(currentPageByType);
    newMap[of] = to;
    return StoriesState(
      storiesByType: storiesByType,
      storyIdsByType: storyIdsByType,
      statusByType: statusByType,
      currentPageByType: newMap,
    );
  }

  StoriesState copyWithRefreshed({required StoryType of}) {
    final newStoriesMap = Map<StoryType, List<Story>>.from(storiesByType);
    newStoriesMap[of] = [];
    final newStoryIdsMap = Map<StoryType, List<int>>.from(storyIdsByType);
    newStoryIdsMap[of] = [];
    final newStatusMap = Map<StoryType, StoriesStatus>.from(statusByType);
    newStatusMap[of] = StoriesStatus.loading;
    final newCurrentPageMap = Map<StoryType, int>.from(currentPageByType);
    newCurrentPageMap[of] = 0;
    return StoriesState(
      storiesByType: newStoriesMap,
      storyIdsByType: newStoryIdsMap,
      statusByType: newStatusMap,
      currentPageByType: newCurrentPageMap,
    );
  }

  @override
  List<Object?> get props => [
        storiesByType,
        storyIdsByType,
        statusByType,
        currentPageByType,
      ];
}
