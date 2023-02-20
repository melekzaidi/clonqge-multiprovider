import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiprovider/bloc/app_state.dart';
import 'package:multiprovider/bloc/bloc_events.dart';
import 'dart:math' as math;

typedef AppBlocRandomUrlPicker = String Function(Iterable<String> allUrls);

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

class AppBloc extends Bloc<AppEvent, AppState> {
  String _pickRandomUrl(Iterable<String> allUrls) => allUrls.getRandomElement();
  AppBloc(
      {required Iterable<String> urls,
      Duration? waitBeforeLoading,
      AppBlocRandomUrlPicker? urlPicker})
      : super(
          const AppState.empty(),
        ) {
    on<LoadNextUrlEvent>(
      (event, emit) async {
        emit(AppState(isLoading: true, data: null, error: null));
        final url = (urlPicker ?? _pickRandomUrl(urls));
        try {
          if (waitBeforeLoading != null) {
            await Future.delayed(waitBeforeLoading);
          }
          final bundle = NetworkAssetBundle(Uri.parse(url.toString()));
          final data = (await bundle.load(url.toString())).buffer.asUint8List();
          emit(AppState(isLoading: false, data: data, error: null));
        } catch (e) {
          emit(AppState(isLoading: false, data: null, error: e));
        }
      },
    );
  }
}
