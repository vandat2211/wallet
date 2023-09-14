import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:wallet/core/constants.dart';
import 'package:wallet/core/data.dart';
import 'package:wallet/core/styles.dart';
import 'package:wallet/credit-cards/credit_card.dart';
import 'package:wallet/on-boarding/on_boarding_page.dart';

import '../sql_lite.dart';

class CreditCardPage extends StatefulWidget {
   CreditCardPage({
    required this.initialIndex,
    required this.pageTransitionAnimation,
    required this.cards,
    super.key,
  });
  List<CreditCardData> cards;
  final int initialIndex;
  final Animation<double> pageTransitionAnimation;

  @override
  State<CreditCardPage> createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  late final Animation<Offset> slideAnimation;
  late final PageController pageController;
  TextRecognizer textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  late int activeIndex;
  final imageDb = ImageDatabase();
  List<CreditCardData> cards =[];
  Future<void> _getInformationFromIDCard() async {
    try {
      final InputImage inputImage = InputImage.fromFilePath(cards[widget.initialIndex].imagePath);

      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
      String name = "";
      recognizedText.blocks.forEach((element) {
      if(element.text.contains('name')){
        print("ok:${element.text.split(': ')[1]}");
      }
      });
      for (TextBlock block in recognizedText.blocks) {
        if(block.text.contains('name')){
          name = recognizedText.text.split(': ')[1];
          break;
        }
        final Rect rect = block.boundingBox;
        final List<Point<int>> cornerPoints = block.cornerPoints;
        final String text = block.text;
        final List<String> languages = block.recognizedLanguages;

        for (TextLine line in block.lines) {
          // Same getters as TextBlock
          for (TextElement element in line.elements) {
            // Same getters as TextBlock
          }
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  @override
  void initState() {
    super.initState();
    cards = widget.cards;
    activeIndex = widget.initialIndex;
    pageController = PageController(
      initialPage: widget.initialIndex,
      viewportFraction: 0.85,
    );
    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: widget.pageTransitionAnimation,
        curve: Curves.easeOut,
      ),
    );
  }
@override
  void dispose() {
  textRecognizer.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: Text(cards[activeIndex].name),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(activeIndex),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                _buildCardsPageView(context),
                SlideTransition(
                  position: slideAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        PageIndicator(
                          length: cards.length,
                          activeIndex: activeIndex,
                          activeColor: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SlideTransition(
                position: slideAnimation,
                child: _buildLatestTransactionsSection(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardsPageView(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final cardWidth = screenSize.width - Constants.appHPadding * 2;
    return SizedBox(
      height: cardWidth / creditCardAspectRatio,
      child: PageView.builder(
        controller: pageController,
        itemCount: cards.length,
        onPageChanged: (index) => setState(() => activeIndex = index),
        itemBuilder: (context, index) {
          return AnimatedScale(
            scale: index == activeIndex ? 1 : 0.85,
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
                    child: CreditCard(
                      width: cardWidth,
                      data: cards[index],
                      isFront: true,
                    ),
                  ),
                  back: Card(
                    elevation: 5,
                    child: CreditCard(
                      width: cardWidth,
                      data: cards[index],
                      isFront: false,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: _Button(
            label: 'Edit',
            icon: Icons.edit,
            onTap: () {},
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _Button(
            label: 'Delete',
            icon: Icons.delete,
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildLatestTransactionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        const Text(
          'Thông tin',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 15),

        SizedBox(height: MediaQuery.of(context).padding.bottom),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.label,
    required this.icon,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.onBlack,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 50,
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 20,
                color: AppColors.white,
              ),
            ),
            const SizedBox(width: 20),
            const Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Edit',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  const _TransactionItem(this.transaction);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.onWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              transaction.icon,
              width: 60,
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Text(
                  transaction.date,
                  style: const TextStyle(color: AppColors.onBlack),
                ),
              ],
            ),
          ),
          Text(
            (transaction.amount < 0 ? '' : '+') + transaction.amount.toString(),
            style: TextStyle(
              color:
                  transaction.amount < 0 ? AppColors.danger : AppColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
