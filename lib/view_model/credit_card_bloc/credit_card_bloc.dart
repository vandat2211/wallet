import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/view_model/bloc_state.dart';

import '../../core/data.dart';
import '../../core/data_local/sql_lite.dart';
import '../../core/form_Submission_Status.dart';
import '../bloc_event.dart';
class CreditCardBloc extends Bloc<CreditCardEvent, CreditCardState> {
  final imageDb = ImageDatabase();
  List<CreditCardData> cards =[];
  CreditCardBloc():super(CreditCardState()){
    on<GetDataEvent>(_getDataEvent);
    on<DeleteCardEvent>(_deleteCardEvent);
    on<AddCardEvent>(_addCardEvent);
  }
  void _getDataEvent(
      GetDataEvent event, Emitter<CreditCardState> emitter) async {
    cards = await imageDb.getAllImages();
    emitter(state.copyWith(cardss: cards));
  }
  void _deleteCardEvent(
      DeleteCardEvent event, Emitter<CreditCardState> emitter) async {
    await imageDb.deleteImage(event.id);
    cards = await imageDb.getAllImages();
    emitter(state.copyWith(cardss: cards,formStatus: SubmissionSuccessDelete()));
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
  DeleteCardEvent(this.id);
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