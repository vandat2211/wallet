import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppBorderRadius.xxl),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.5),
            blurRadius: 15,
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: isFront ? _CreditCardFront(data) : _CreditCardBack(data),
    );
  }
}

class _CreditCardFront extends StatelessWidget {
  const _CreditCardFront(this.data);

  final CreditCardData data;

  @override
  Widget build(BuildContext context) {
    return data.imagePath2.contains("https://")?
    SvgPicture.network(data.imagePath2, // Thay thế bằng URL của hình ảnh SVG của bạn
      fit: BoxFit.contain,
    ):
        Image.file(File(data.imagePath2),fit: BoxFit.cover,width: 45,);
  }
}

class _CreditCardBack extends StatelessWidget {
  const _CreditCardBack(this.data);

  final CreditCardData data;

  @override
  Widget build(BuildContext context) {
    return data.imagePath.contains("https://")?
    SvgPicture.network(data.imagePath, // Thay thế bằng URL của hình ảnh SVG của bạn
      fit: BoxFit.contain,
    ):
    Image.file(File(data.imagePath),fit: BoxFit.cover,width: 45,);
  }
}
