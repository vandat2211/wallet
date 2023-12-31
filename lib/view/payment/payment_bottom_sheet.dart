import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wallet/core/data.dart';
import 'package:wallet/core/styles.dart';


import 'package:wallet/core/data_local/sql_lite.dart';
import 'package:wallet/view/payment/payment_button.dart';

import '../../core/constants/constants.dart';
import '../../core/form_Submission_Status.dart';
import '../../view_model/credit_card_bloc/credit_card_bloc.dart';


class PaymentBottomSheet extends StatefulWidget {
   PaymentBottomSheet({super.key,required this.myFunction});
   VoidCallback myFunction = () {};
  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  final TextEditingController sendingCardsController = TextEditingController();
  final TextEditingController receivingCardsController =
      TextEditingController();
  final TextEditingController accountsController = TextEditingController();
  int? selectedSendingCard = 0;
  int? selectedReceivingCard = 0;
  List<CreditCardData> cards =[];
  CreditCardData? imageItem ;
  PaymentStatus status =PaymentStatus.idle;
  String path= "";
  String path2= "";
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final cardWidth = screenSize.width - Constants.appHPadding * 2;
    final cardsEntries = <DropdownMenuEntry<int>>[
      DropdownMenuEntry<int>(
        value: 0,
        label: 'Thẻ căn cước',
      ),
      DropdownMenuEntry<int>(
        value: 1,
        label: 'Thẻ ngân hàng',
      ),
      DropdownMenuEntry<int>(
        value: 2,
        label: 'Bằng lái xe',
      ),
      DropdownMenuEntry<int>(
        value: 3,
        label: 'Ảnh',
      ),
    ];
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return BlocProvider(
      create: (context) => CreditCardBloc(),
      child: BlocConsumer<CreditCardBloc,CreditCardState>(
        listener: (context,state){
          final formStatus = state.formStatus;
          if(formStatus is SubmissionSuccess){
            widget.myFunction();
            Navigator.of(context).pop();
          }
        },
        builder: (context,state){
          return Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).padding.bottom + bottomInset + 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownMenu<int>(
                  controller: sendingCardsController,
                  width: MediaQuery.of(context).size.width - 20 * 2,
                  leadingIcon: const Icon(Icons.credit_card),
                  label: const Text('Sending Card'),
                  initialSelection: selectedSendingCard,
                  dropdownMenuEntries: cardsEntries,
                  onSelected: (int? index) {
                    setState(() {
                      selectedSendingCard = index;
                      sendingCardsController.text = cardsEntries[index!].label;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Text("Ảnh mặt trước"),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () async {
                    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      setState(() {
                        path = pickedFile.path;
                      });


                    }

                  },
                  child: Container(
                    width: cardWidth,
                    height: 200,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.5),
                          blurRadius: 15,
                        ),
                      ],
                      image:path.isNotEmpty?
                      DecorationImage(
                        image: FileImage(File(path)),
                        fit: BoxFit.cover,
                      ) :
                      const DecorationImage(
                        image: AssetImage(
                          'assets/images/secondary-pattern-back.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child:path.isNotEmpty?null: const Icon(Icons.add,size: 50),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      setState(() {
                        path2 = pickedFile.path;
                        imageItem = CreditCardData(
                          name: sendingCardsController.text, // Thay thế bằng tên ảnh thích hợp
                          imagePath: path,
                          imagePath2: path2, // Đường dẫn tới ảnh đã chọn từ thư viện
                        );
                      });
                    }
                  },
                  child: Visibility(
                    visible: path.isNotEmpty,
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Text("Ảnh mặt sau"),
                        const SizedBox(height: 10),
                        Container(
                          width: cardWidth,
                          height: 200,
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(0.5),
                                blurRadius: 15,
                              ),
                            ],
                            image:path2.isNotEmpty?
                            DecorationImage(
                              image: FileImage(File(path2)),
                              fit: BoxFit.cover,
                            ) : const DecorationImage(
                              image: AssetImage(
                                'assets/images/secondary-pattern-back.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child:path2.isNotEmpty?null: const Icon(Icons.add,size: 50),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                PaymentButton(
                  enabled: false,
                  width: screenSize.width - 20 * 2, onSuccess: () {
                  BlocProvider.of<CreditCardBloc>(context).add(AddCardEvent(imageItem!));
                }, data: imageItem,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
