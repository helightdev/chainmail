import 'package:chainmail/chainmail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BlocExtension on ChainmailBase {

  B bloc<B extends BlocBase>() => BlocProvider.of<B>(context);

}