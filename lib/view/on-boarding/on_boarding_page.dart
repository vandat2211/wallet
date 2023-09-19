import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wallet/core/data.dart';
import 'package:wallet/core/styles.dart';
import 'package:wallet/core/utils.dart';
import 'package:wallet/core/widgets/wallet.dart';
import 'package:wallet/data/base_service/repository_impl.dart';
import 'package:wallet/login_model.dart';
import 'package:wallet/view/home_page.dart';

import '../../core/constants/constants.dart';
import '../../core/data_local/sql_lite.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with SingleTickerProviderStateMixin {
  final repositoryImpl = RepositoryImpl();
  late final AnimationController animationController;
  late final Animation<double> rotationAnimation;
  late final PageController pageController;
  static const viewportFraction = 0.7;
  int activeIndex = 0;
  final imageDb = ImageDatabase();
  List<CreditCardData> cards =[];
  @override
  void initState() {
    getData();
    pageController = PageController(viewportFraction: viewportFraction);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    final curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    );
    rotationAnimation =
        Tween<double>(begin: 0, end: 30 * pi / 180).animate(curvedAnimation);
    super.initState();
  }
Future<void> getData() async {
  cards = await imageDb.getAllImages();
}
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final itemWidth = screenSize.width * viewportFraction;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            const Center(
              child: Text(
                'My Wallet',
                style: TextStyle(fontSize: 35),
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Positioned(
                    left: -250 + 40,
                    width: 250,
                    top: -32,
                    bottom: -32,
                    child: WalletSide(),
                  ),
                  Positioned.fill(
                    child: GestureDetector(
                      onTapDown: (_) => animationController.forward(),
                      onTapUp: (_) => animationController.reverse(),
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: onBoardingItems.length,
                        onPageChanged: (int index) {
                          setState(() {
                            activeIndex = index;
                          });
                          animationController.forward().then(
                                (value) => animationController.reverse(),
                              );
                        },
                        itemBuilder: (context, index) {
                          return AnimatedScale(
                            duration: const Duration(milliseconds: 300),
                            scale: index == activeIndex ? 1 : 0.8,
                            curve: Curves.easeOut,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.onBlack,
                                borderRadius: BorderRadius.circular(25),
                                image: DecorationImage(
                                  image: AssetImage(
                                    onBoardingItems[index].image,
                                  ),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    left: -250 + 35,
                    width: 250,
                    top: -30,
                    bottom: -30,
                    child: AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) {
                        return Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(rotationAnimation.value),
                          alignment: Alignment.center,
                          child: const WalletSide(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: (screenSize.width - itemWidth) / 2,
                right: (screenSize.width - itemWidth) / 2,
                top: 40,
                bottom: 50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ..._buildItemInfo(activeIndex: activeIndex),
                  PageIndicator(
                    length: onBoardingItems.length,
                    activeIndex: activeIndex,
                  ),
                  FilledButton(
                    onPressed: () async {
                      // await repositoryImpl.login(
                      //     LoginRequest(
                      //       requestId: Utils.getCurrentTimeStringRequest(),
                      //       userName: "8399246453",
                      //       passWord: "111111",
                      //       version: '1.0',
                      //       lang: 'vi_VN',
                      //       otpNo: "",
                      //       operatingSystem: Constants.PLATFORM,
                      //       tokenPush: "",
                      //       deviceId: "sdk_gphone64_x86_64",
                      //     ),
                      // context, Constants.FINGERPRINT_N);

                      if(cards.isEmpty){
                        await repositoryImpl.getData(context).then((value) {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        });
                      }else{
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      }


                    },
                    child: const Text(
                      'Get Started!',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildItemInfo({int activeIndex = 0}) {
    return [
      Center(
        child: Text(
          onBoardingItems[activeIndex].title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      const SizedBox(height: 10),
      Center(
        child: Text(
          onBoardingItems[activeIndex].subtitle,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    ];
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    this.length = 1,
    this.activeIndex = 0,
    this.activeColor = AppColors.primary,
  });

  final int length;
  final int activeIndex;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox.fromSize(
        size: const Size.fromHeight(8),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = constraints.smallest;
            final activeWidth = size.width * 0.5;
            final inActiveWidth =
                (size.width - activeWidth - (2 * length * 2)) / (length - 1);

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    height: index == activeIndex ? 8 : 5,
                    width: index == activeIndex ? activeWidth : inActiveWidth,
                    decoration: BoxDecoration(
                      color: index == activeIndex
                          ? activeColor
                          : AppColors.onBlack,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
