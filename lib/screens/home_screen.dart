import 'package:flutter/material.dart';
import 'package:flutter_video_netflix/cubits/cubits.dart';
import 'package:flutter_video_netflix/data/data.dart';
import 'package:flutter_video_netflix/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        // ignore: deprecated_member_use
        context.bloc<AppBarCubit>().setOffset(_scrollController.offset);
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context)
        .size; //通常情况下，不会直接将MediaQuery当作一个控件，而是使用MediaQuery.of获取当前设备的信息
    return Scaffold(
      extendBodyBehindAppBar: true, //遮盖appbar
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        child: Icon(Icons.cast),
        onPressed: () => {print('object')},
      ),
      appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 50.0),
          child: BlocBuilder<AppBarCubit, double>(
              builder: (context, scrollOffset) {
            return CustomAppBar(scrollOffset: scrollOffset);
          })),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ContentHeader(featuredContent: sintelContent),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: Previews(
                key: PageStorageKey('prviews'),
                title: 'Previews',
                contentList: previews,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              key: PageStorageKey('MyList'),
              title: 'My List',
              contentList: myList,
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
                key: PageStorageKey('originals'),
                title: 'Netflix Originals',
                contentList: originals,
                isOriginals: true),
          ),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 20.0),
            sliver: SliverToBoxAdapter(
              child: ContentList(
                key: PageStorageKey('trending'),
                title: 'Trending',
                contentList: trending,
              ),
            ),
          )
        ],
      ),
    );
  }
}
