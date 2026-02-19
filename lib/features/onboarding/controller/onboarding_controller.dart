import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

class OnboardingController extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  final List<String> videos = const [
    'assets/videos/onboarding.mp4',
    'assets/videos/onboarding2.mp4',
    'assets/videos/onboarding3.mp4',
  ];

  VideoPlayerController? _videoController;
  VideoPlayerController? get videoController => _videoController;

  bool get isLastPage => _currentIndex == videos.length - 1;

  Future<void> initialize() async {
    await _loadVideo(0);
  }

  Future<void> changePage(int index) async {
    _currentIndex = index;
    await _loadVideo(index);
  }

  Future<void> _loadVideo(int index) async {
    await _videoController?.dispose();

    final video = VideoPlayerController.asset(videos[index]);
    await video.initialize();
    video.setLooping(true);
    video.setVolume(0);
    await video.play();

    _videoController = video;

    notifyListeners(); // ✅ now available
  }

  Future<void> disposeMedia() async {
    await _videoController?.dispose();
  }

  @override
  void dispose() {
    disposeMedia();
    super.dispose(); // ✅ now valid
  }
}
