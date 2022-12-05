import 'package:flutter/material.dart';
import 'package:s_crypto/data/local/pref.dart';
import 'package:s_crypto/routes/routes.dart';
import 'package:s_crypto/share/constants/app_type.dart';
import 'package:s_crypto/share/constants/assets.dart';
import 'package:s_crypto/share/utils/size_config.dart';
import 'package:s_crypto/share/widgets/widgets.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardView extends StatefulWidget {
  const OnboardView({Key? key}) : super(key: key);

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  final controller = PageController();

  bool isEndPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      _buildPage(asset: Assets.onboard1, title: "Trade like a pro!"),
      _buildPage(asset: Assets.onboard2, title: "Secured & Reliable"),
      _buildPage(asset: Assets.onboard3, title: "Start Growing"),
    ];

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: ((value) =>
                setState(() => isEndPage = value == (pages.length - 1))),
            children: pages,
          ),
          Positioned(
            bottom: 12,
            right: 16,
            left: 16,
            child: SafeArea(
              child: isEndPage
                  ? ButtonWidget(onPressed: _onGetStated, label: "Get started")
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonWidget(
                          onPressed: () => controller.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn),
                          label: "Prev",
                          type: ButtonType.ghost,
                        ),
                        SmoothPageIndicator(
                          count: pages.length,
                          controller: controller,
                          onDotClicked: (index) => controller.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          ),
                          effect: WormEffect(
                              spacing: 16,
                              dotColor: Colors.black26,
                              activeDotColor:
                                  Theme.of(context).colorScheme.primary),
                        ),
                        ButtonWidget(
                          onPressed: () => controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn),
                          label: "Next",
                          type: ButtonType.ghost,
                        )
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }

  _buildPage({
    required String title,
    required String asset,
  }) {
    final s = SizeConfig();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ImageWidget(
          asset,
          width: s.screenWidth,
          height: s.screenHeight * 0.3,
        ),
        const Space(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 27,
          ),
        ),
        const Space(),
        const Text(
          "Grow your investments with Treyd trading tools built for you.",
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }

  _onGetStated() {
    AppPref.firstInstall = false;
    AppRouter.routes.goNamed(APP_PAGE.home.toName);
  }
}
