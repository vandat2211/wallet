import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/view_model/bloc_state.dart';

import '../../core/data.dart';
import '../../core/data_local/sql_lite.dart';
import '../../core/form_Submission_Status.dart';
import '../bloc_event.dart';
class CreditCardBloc extends Bloc<CreditCardEvent, CreditCardState> {
  final imageDb = ImageDatabase();
  List<CreditCardData> cards =[];
  List<CreditCardData> randomList = [];
  CreditCardBloc():super(CreditCardState()){
    on<GetDataEvent>(_getDataEvent);
    on<DeleteCardEvent>(_deleteCardEvent);
    on<AddCardEvent>(_addCardEvent);
  }
  void _getDataEvent(
      GetDataEvent event, Emitter<CreditCardState> emitter) async {
    cards = await imageDb.getAllImages();
    var random = Random();
    cards.shuffle(random);
    randomList=cards.take(10).toList();
    emitter(state.copyWith(cardss: randomList));
  }
  void _deleteCardEvent(
      DeleteCardEvent event, Emitter<CreditCardState> emitter) async {
    await imageDb.deleteImage(event.id);
    // cards = await imageDb.getAllImages();
    randomList.remove(event.creditCardData);
    emitter(state.copyWith(cardss: randomList,formStatus: SubmissionSuccessDelete()));
  }
  void _addCardEvent(
      AddCardEvent event, Emitter<CreditCardState> emitter) async {
    await imageDb.insertImage(event.creditCardData);
    cards = await imageDb.getAllImages();
    emitter(state.copyWith(cardss: cards,formStatus: SubmissionSuccess()));
  }
}
class CreditCardEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}
class GetDataEvent extends  CreditCardEvent{}
class DeleteCardEvent extends  CreditCardEvent{
  final int id;
  final CreditCardData creditCardData;
  DeleteCardEvent(this.id,this.creditCardData);
}
class AddCardEvent extends  CreditCardEvent{
  final CreditCardData creditCardData;
  AddCardEvent(this.creditCardData);
}
class CreditCardState extends BlocState {
   List<CreditCardData> cards;
   final FormSubmissionStatus formStatus;
  @override
  List<Object?> get props => [cards,formStatus];
  CreditCardState({this.cards = const [],this.formStatus = const InitialFormStatus()});
   CreditCardState copyWith({
     List<CreditCardData>? cardss,
     FormSubmissionStatus? formStatus,
}){
     return CreditCardState(cards: cardss??cards,formStatus: formStatus ?? this.formStatus);
   }
}