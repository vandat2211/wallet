import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wallet/core/data.dart';
import 'package:wallet/core/styles.dart';


const double creditCardAspectRatio = 1.56;

class CreditCard extends StatelessWidget {
  const CreditCard({
    required this.data,
    super.key,
    this.width,
    this.isFront = false,
  }) : height = width != null ? width / creditCardAspectRatio : null;

  final CreditCardData data;
  final bool isFront;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        // color: data.style.color,
        borderRadius: BorderRadius.circular(AppBorderRadius.xxl),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.5),
            blurRadius: 15,
          ),
        ],
        image:isFront ?DecorationImage(
          image: FileImage(File(data.imagePath2)),
          fit: BoxFit.cover,
        )
        :DecorationImage(
          image: FileImage(File(data.imagePath)),
          fit: BoxFit.cover,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      // child: isFront ? _CreditCardFront(data) : _CreditCardBack(data),
    );
  }
}

class _CreditCardFront extends StatelessWidget {
  const _CreditCardFront(this.data);

  final CreditCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Image(
              image: FileImage(File(data.imagePath)),
              width: 45,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class _CreditCardBack extends StatelessWidget {
  const _CreditCardBack(this.data);

  final CreditCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(""),
          ),
        ],
      ),
    );
  }
}
