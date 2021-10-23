import 'package:get/get.dart';

class StoryController extends GetxController {
  final RxBool _isStorySelected = false.obs;
  final RxInt _selectedIndex = 0.obs;
  final RxString _storyUrl = ''.obs;
  final RxBool _isAppOpen = true.obs;

  late DateTime startTime;
  late DateTime endTime;

  bool get isAppOpen => _isAppOpen.value;

  set isAppOpen(bool value) => _isAppOpen.value = value;

  int get selectedIndex => _selectedIndex.value;

  set selectedIndex(int selectedIndex) => _selectedIndex.value = selectedIndex;

  String get storyUrl => _storyUrl.value;

  set storyUrl(String storyUrl) => _storyUrl.value = storyUrl;

  bool get isStorySelected => _isStorySelected.value;

  set isStorySelected(bool isEnabled) => _isStorySelected.value = isEnabled;
}
