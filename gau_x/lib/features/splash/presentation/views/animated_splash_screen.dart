import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../wallet/presentation/views/wallet_dashboard_view.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    
    _controller = VideoPlayerController.asset('assets/splash_video.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });

    _controller.addListener(() {
      if (_controller.value.isInitialized && 
          _controller.value.position >= _controller.value.duration) {
        
        // Routing to main dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WalletDashboardView()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBg,
      body: Center(
        child: _controller.value.isInitialized
            ? SizedBox.expand(
                child: FittedBox(
                  
                  fit: BoxFit.contain, 
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    
                    child: Transform.scale(
                      scale: 2.0, 
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}