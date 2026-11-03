import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routing/app_routes.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen> {
  late VideoPlayerController _controller;
  bool _finished = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(AppAssets.splashVideo);
    unawaited(
      _controller.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
        unawaited(_controller.play());
      }),
    );

    _controller.addListener(() {
      final video = _controller.value;
      if (!_finished &&
          video.isInitialized &&
          video.position >= video.duration) {
        _finished = true;
        // Signed-in users are redirected on to the wallet
        context.go(AppRoutes.login);
      }
    });
  }

  @override
  void dispose() {
    unawaited(_controller.dispose());
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
