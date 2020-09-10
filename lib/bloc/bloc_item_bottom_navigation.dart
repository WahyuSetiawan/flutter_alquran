import 'package:flutter_bloc/flutter_bloc.dart';

enum PageNavigationBar { Home, LastReader, Setting }

class NavigationBloc extends Bloc<PageNavigationBar, PageNavigationBar> {
  PageNavigationBar bar;

  NavigationBloc() : super(PageNavigationBar.Home);

  @override
  Stream<PageNavigationBar> mapEventToState(PageNavigationBar event) async* {
    bar = event;
    yield bar;
  }
}
