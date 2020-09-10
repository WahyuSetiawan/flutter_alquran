import 'package:flutter_bloc/flutter_bloc.dart';

enum PageNavigationBar { Dashboard, ListChapter, LastReader, Setting }

class NavigationBloc extends Bloc<PageNavigationBar, PageNavigationBar> {
  PageNavigationBar bar;

  NavigationBloc() : super(PageNavigationBar.Dashboard);

  @override
  Stream<PageNavigationBar> mapEventToState(PageNavigationBar event) async* {
    bar = event;
    yield bar;
  }
}
