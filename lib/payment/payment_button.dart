import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wallet/core/data.dart';
import 'package:wallet/core/styles.dart';
import 'package:wallet/core/widgets/core_toast.dart';
import 'package:wallet/sql_lite.dart';


const dragSnapDuration = Duration(milliseconds: 300);
const draggableMinWidth = 60.0;

class PaymentButton extends StatefulWidget {
   PaymentButton({
    super.key,
    this.enabled = false,
    this.width = 100, required this.onSuccess, required this.status, required this.data,

  });

  final bool enabled;
  final double width;
  final VoidCallback onSuccess;
  final PaymentStatus status;
   CreditCardData? data;

  @override
  State<PaymentButton> createState() => _PaymentButtonState();
}

class _PaymentButtonState extends State<PaymentButton>
    with TickerProviderStateMixin {
  late final AnimationController loadingAnimationController;
  double dragOffset = 0;
  Duration dragDuration = Duration.zero;
  static const draggableMinWidth = 60.0;

  bool get canDrag => (status.isIdle || status.isPending) && !status.isSuccess;

  PaymentStatus status = PaymentStatus.idle;

  double get draggableMaxWidth => widget.width - 4 * 2;

  double get maxDraggableDistance => draggableMaxWidth - draggableMinWidth;

  double get dragThreshold => maxDraggableDistance * 0.8;

  void _handleHorizontalDragStart(DragStartDetails details) {
    if(widget.data!=null){
      if (dragDuration > Duration.zero) {
        dragDuration = Duration.zero;
      }
    }else{
      Toast.showLongTop("Bạn chưa chọn hình ảnh cho thẻ");
    }

  }

  void _handleHorizontalDragUpdate(DragUpdateDetails details) {
    if(widget.data!=null){
      if (canDrag) {
        setState(() {
          dragOffset =
              (dragOffset + details.delta.dx).clamp(0, maxDraggableDistance);
          if (!status.isPending) {
            status = PaymentStatus.pending;
          }
        });
      }
    }

  }

  void _handleHorizontalDragEnd(DragEndDetails details) {
    if(widget.data!=null){
    if (!status.isSuccess) {
      dragDuration = dragSnapDuration;
      if (dragOffset <= dragThreshold) {
        setState(() {
          dragOffset = 0;
          status = PaymentStatus.idle;
        });
      } else {
        setState(() {
          dragOffset = maxDraggableDistance;
          status = PaymentStatus.loading;
        });
        loadingAnimationController.repeat();
        Future<void>.delayed(const Duration(milliseconds: 1500)).then((value) {
          setState(() {
            status = PaymentStatus.success;
            widget.onSuccess.call();
          });
        });
      }
    }}
  }

  @override
  void initState() {
    super.initState();
    status = widget.status;
    loadingAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    loadingAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.black,
      ),
      height: 60,
      padding: const EdgeInsets.all(4),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(left: draggableMinWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Slide to pay',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 10),
                  _AnimatedArrows(enabled: widget.enabled),
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: dragDuration,
            curve: Curves.easeOut,
            top: 0,
            left: 0,
            bottom: 0,
            width: draggableMinWidth + dragOffset,
            child: GestureDetector(
              onHorizontalDragUpdate: _handleHorizontalDragUpdate,
              onHorizontalDragStart: _handleHorizontalDragStart,
              onHorizontalDragEnd: _handleHorizontalDragEnd,
              child: AnimatedBuilder(
                animation: loadingAnimationController,
                builder: (context, child) {
                  return _buildDollarIcon(
                    context,
                    dragOffset: dragOffset,
                    loadingAnimationValue: loadingAnimationController.value,
                  );
                },
              ),
            ),
          ),
          Positioned.fill(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: dragOffset >= dragThreshold && status.isPending ? 1 : 0,
              curve: Curves.easeOut,
              child: const Center(
                child: Text(
                  'Release to pay',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 300),
              offset: Offset(0, status.isSuccess ? 0 : 1),
              curve: Curves.easeOut,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check),
                  SizedBox(width: 10),
                  Center(
                    child: Text(
                      'Payment Successful',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  bool isSuccessPrinted = false;
  Widget _buildDollarIcon(
    BuildContext context, {
    double dragOffset = 0,
    double loadingAnimationValue = 0,
  })  {
    final yRotation = status.isPending
        ? 4 * pi * (dragOffset / maxDraggableDistance)
        : status.isLoading
            ? 2 * pi * loadingAnimationValue
            : 0.0;

    Widget child = SizedBox(
      width: 60,
      child: Center(
        child: Icon(Icons.image,size: 40,),
      ),
    );

    // y rotation - happens while loading OR dragging
    child = Transform(
      transform: Matrix4.identity()..rotateY(yRotation),
      alignment: Alignment.center,
      child: child,
    );

    // Slide animation - sliding the Dollar up on success
    child = AnimatedSlide(
      duration: const Duration(milliseconds: 300),
      offset: Offset(0, status.isSuccess ? -1 : 0),
      curve: Curves.easeOut,
      child: child,
    );

    // Animate alignment & color
    // Alignment is center as long as the status is not pending, which means
    // the user is dragging and the dollar should follow the right edge of
    // the dragged area
    child = AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      alignment: !status.isPending ? Alignment.center : Alignment.centerRight,
      decoration: BoxDecoration(
        color: status.isSuccess ? AppColors.success : AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
    return child;
  }
}

class _AnimatedArrows extends StatefulWidget {
  const _AnimatedArrows({
    this.enabled = false,
  });

  final bool enabled;

  @override
  State<_AnimatedArrows> createState() => __AnimatedArrowsState();
}

class __AnimatedArrowsState extends State<_AnimatedArrows>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const offset = 10.0;
    const count = 5;

    return SizedBox(
      width: (count + 1) * offset,
      child: Stack(
        children: List.generate(
          count,
          (index) => Positioned(
            left: offset * index,
            bottom: 0,
            top: 0,
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: _animationController,
                curve: Interval(
                  (index / count) * 0.5,
                  1,
                  curve: Curves.easeInOut,
                ),
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 17,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum PaymentStatus {
  /// User has not interacted with the button
  idle,

  /// User has started dragging
  pending,

  /// User has released the button after reaching the end of the draggable area
  loading,

  /// Payment was successful
  success;

  bool get isSuccess => this == success;

  bool get isLoading => this == loading;

  bool get isPending => this == pending;

  bool get isIdle => this == idle;
}
