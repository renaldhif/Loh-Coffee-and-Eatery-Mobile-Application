import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewInitial());
}
