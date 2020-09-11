import 'package:alquran/bloc/bloc_verses.dart';
import 'package:alquran/model/chapters/chapters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageVerses extends StatefulWidget {
  final Chapters chapter_id;
  final VersesBloc versesBloc;

  PageVerses({
    Key key,
    this.chapter_id,
    @required this.versesBloc,
  }) : super(key: key);

  @override
  _PageVersesState createState() => _PageVersesState();
}

class _PageVersesState extends State<PageVerses> {
  @override
  void initState() {
    super.initState();

    widget.versesBloc.add(VerseProvider(
      id: widget.chapter_id.id,
    ));
  }

  Widget header() {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.chevron_left,
              size: 30,
              color: Color(0xff565656),
            ),
          ),
          Text("Verses",
              style: TextStyle(
                fontSize: 18,
                letterSpacing: .7,
                fontFamily: "roboto",
                fontWeight: FontWeight.bold,
                color: Color(0xff565656),
              )),
          Container(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => widget.versesBloc,
          )
        ],
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: BlocBuilder<VersesBloc, VerseState>(
            builder: (context, state) {
              if (state is SuccessVerse) {
                return Column(
                  children: [
                    header(),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemCount: state.versesModel.verses.length,
                          padding: EdgeInsets.only(top: 10),
                          itemBuilder: (context, index) {
                            String arti = "";

                            for (var a
                                in state.versesModel.verses[index].words) {
                              if (a.translation != null) {
                                arti += a.translation.text;
                              }
                            }

                            return Container(
                              decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.transparent
                                      : Colors.black54),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        (index + 1).toString(),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 8,
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Text(
                                              state.versesModel.verses[index]
                                                  .textIndopak,
                                              softWrap: true,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .copyWith(
                                                    letterSpacing: 2,
                                                  ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            child: Text(
                                              arti,
                                              softWrap: true,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .copyWith(
                                                    letterSpacing: 2,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                );
              }

              return Container(
                child: Text("failed"),
              );
            },
          ),
        ));
  }
}
