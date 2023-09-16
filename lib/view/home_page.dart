import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallet/core/data.dart';
import 'package:wallet/core/styles.dart';
import 'package:wallet/core/widgets/wallet.dart';


import 'package:wallet/core/data_local/sql_lite.dart';
import 'package:wallet/view/payment/payment_bottom_sheet.dart';

import '../core/constants/constants.dart';
import '../core/form_Submission_Status.dart';
import '../view_model/credit_card_bloc/credit_card_bloc.dart';
import 'credit-cards/credit_cards_page.dart';
import 'credit-cards/detail_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

   List<TabItem> tabItems = [
     TabItem(
      title: 'Cards',
      view: BlocProvider(
        create: (context) => CreditCardBloc(),
          child: CreditCardsPage()),
    ),
    TabItem(view: Container()),
    const TabItem(
      title: 'Images',
      view: _NotificationsPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        // Ngăn người dùng quay lại màn hình trước đó bằng nút "Back"
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -10,
              left: Constants.appHPadding / 2,
              right: Constants.appHPadding / 2,
              height: 500,
              child: Wallet(
                width: screenSize.width,
                height: 500,
              ),
            ),
            NavigationBar(
              onDestinationSelected: (int index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              selectedIndex: currentPageIndex,
              indicatorColor: Colors.transparent,
              labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
              destinations: <Widget>[
                NavigationDestination(
                  selectedIcon: Image.asset(
                    'assets/icons/cards-active.png',
                    width: 35,
                    height: 35,
                  ),
                  icon: Image.asset(
                    'assets/icons/cards.png',
                    width: 35,
                    height: 35,
                  ),
                  label: 'Cards',
                ),
                Center(
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      fixedSize: const Size(
                        Constants.walletStrapWidth * 0.6,
                        Constants.walletStrapWidth * 0.6,
                      ),
                    ),
                    onPressed: () async {
                      await showModalBottomSheet<String>(
                        context: context,
                        backgroundColor: AppColors.onBlack,
                        elevation: 0,
                        useRootNavigator: true,
                        isScrollControlled: true,
                        showDragHandle: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25),
                          ),
                        ),
                        builder: (context1) =>   PaymentBottomSheet(myFunction: () {
                        },));
                    },
                  ),
                ),
                const NavigationDestination(
                  selectedIcon: Icon(Icons.image_rounded,color: AppColors.primary,size: 40,),
                  icon: Icon(Icons.image_rounded,size: 40,),
                  label: 'Images',
                ),
              ],
            ),
          ],
        ),
        body: tabItems[currentPageIndex].view,
      ),
    );
  }
}

class _NotificationsPage extends StatefulWidget {
  const _NotificationsPage();

  @override
  State<_NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<_NotificationsPage> {
  final imageDb = ImageDatabase();
  List<CreditCardData> cards =[];
  bool delete = false;
  List<bool> selectedImages = [];
  List<int> listID = [];
  @override
  void initState() {
    getData();
    super.initState();
  }
  Future<void> getData() async {
    cards = await imageDb.getAllImages();
    selectedImages = List.generate(cards.length, (index) => false);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Images"),
        actions: [if(listID.isNotEmpty)IconButton(icon: Icon(Icons.delete), onPressed: () async {
          await imageDb.deleteMultipleImages(listID);
          cards = await imageDb.getAllImages();
          for (int i = 0; i < cards.length; i++) {
            if (cards[i].id==listID[i]) {
              setState(() {
                cards.removeAt(i);
                selectedImages.removeAt(i);
              });
              i--; // Điều này cần thiết để không bỏ lỡ các phần tử sau khi xóa
            }
          }
          setState(() {
            if(cards.isNotEmpty) listID.clear();
            }
          );
        },)],
      ),
    body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: (){
          setState(() {
            if(delete){
              delete =false;
              listID.clear();
            }
          });
        },
        child: MasonryGridView.builder(
            itemCount: cards.length,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context,index)=>Padding(
                padding: EdgeInsets.all(2.0),
              child: GestureDetector(
                onLongPress: (){
                  setState(() {
                    delete = !delete;
                    if(delete){
                      listID.clear();
                    }
                  });
                },
                onTap:delete?(){
                  setState(() {
                    selectedImages[index] = !selectedImages[index];
                    if(cards[index].id!=null && selectedImages[index]){
                      listID.add(cards[index].id!);
                      print("object:${listID}");
                    }else if(!selectedImages[index]){
                      listID.remove(cards[index].id!);
                      print("object:${listID}");
                    }
                  });
                }: (){
                  pushFadeInRoute(
                    context,
                    pageBuilder: (context, animation, __) => detailImagePage(
                      initialIndex: index,
                      pageTransitionAnimation: animation,
                      cards: cards,
                    ),
                  );
                },
                child: Stack(
                  children: [
                    ClipRRect(
                      child: Image.file(File(cards[index].imagePath)),
                    ),
                    if (delete)
                      Positioned(
                        top: 0,
                        right: 0,
                        child:selectedImages[index]? Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 30,
                        ):
                        Icon(
                          Icons.circle,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
                  ],
                ),
              ),
            )),
      ),
    ),
    );
  }
}
