import 'dart:io';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:wallet/core/data.dart';
import 'package:wallet/core/styles.dart';
import 'package:wallet/credit-cards/credit_card.dart';

import '../core/constants.dart';

class detailImagePage extends StatefulWidget {
   detailImagePage({super.key, required this.initialIndex, required this.pageTransitionAnimation,required this.cards});
  List<CreditCardData> cards;
  final int initialIndex;
  final Animation<double> pageTransitionAnimation;
  @override
  State<detailImagePage> createState() => _detailImagePageState();
}

class _detailImagePageState extends State<detailImagePage> {
  late final PageController pageController;
  late int activeIndex;
  List<CreditCardData> cards =[];
  @override
  void initState() {
    cards = widget.cards;
    activeIndex = widget.initialIndex;
    pageController = PageController(
      initialPage: widget.initialIndex,
      viewportFraction: 0.85,
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Detail Images"),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(activeIndex),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCardsPageView(context),
        ],
      ),
    );
  }
  Widget _buildCardsPageView(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final cardWidth = screenSize.width - Constants.appHPadding * 2;
    return SizedBox(
      height: cardWidth / creditCardAspectRatio,
      width: screenSize.width,
      child: PageView.builder(
        controller: pageController,
        itemCount: cards.length,
        onPageChanged: (index) => setState(() => activeIndex = index),
        itemBuilder: (context, index) {
          return AnimatedScale(
            scale: index == activeIndex ? 1 : 0.84,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: HeroMode(
              enabled: index == activeIndex,
              child: Hero(
                tag: 'card_${cards[index].id}',
                child: FlipCard(
                  direction: FlipDirection.HORIZONTAL,
                  front: Card(
                    elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        // color: data.style.color,
                        borderRadius: BorderRadius.circular(AppBorderRadius.xxl),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(0.5),
                            blurRadius: 15,
                          ),
                        ],
                        image:DecorationImage(
                          image: FileImage(File(cards[activeIndex].imagePath)),
                          fit: BoxFit.cover,
                        ),
                      ),
                      clipBehavior: Clip.hardEdge,
                      // child: isFront ? _CreditCardFront(data) : _CreditCardBack(data),
                    ),
                  ),
                  back: Card(
                    elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        // color: data.style.color,
                        borderRadius: BorderRadius.circular(AppBorderRadius.xxl),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(0.5),
                            blurRadius: 15,
                          ),
                        ],
                        image:DecorationImage(
                          image: FileImage(File(cards[activeIndex].imagePath2)),
                          fit: BoxFit.cover,
                        ),
                      ),
                      clipBehavior: Clip.hardEdge,
                      // child: isFront ? _CreditCardFront(data) : _CreditCardBack(data),
                    )
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
