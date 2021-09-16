import 'package:get/get.dart';

class StoryController extends GetxController {
  RxBool _isStorySelected = false.obs;
  RxInt _selectedIndex = 0.obs;
  RxString _storyUrl = ''.obs;
  RxString _error = ''.obs;

  int get selectedIndex => _selectedIndex.value;

  set selectedIndex(int selectedIndex) => _selectedIndex.value = selectedIndex;

  String get error => _error.value;

  set error(String error) => _error.value = error;

  String get storyUrl => _storyUrl.value;

  set storyUrl(String storyUrl) => _storyUrl.value = storyUrl;

  bool get isStorySelected => _isStorySelected.value;

  set isStorySelected(bool isEnabled) => _isStorySelected.value = isEnabled;
}
