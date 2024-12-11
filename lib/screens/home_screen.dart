import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/responsive.dart';
import '../providers/movie.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  double scrollOffSet = 0.0;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          scrollOffSet = _scrollController.offset;
        });
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
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: Responsive.isDesktop(context)
          ? null
          : FloatingActionButton(
              onPressed: () => print("cast"),
              child: const Icon(Icons.cast),
            ),
      appBar: PreferredSize(
        preferredSize: Size(
          screenSize.width,
          50,
        ),
        child: CustomAppBar(
          scrollOffSet: scrollOffSet,
        ),
      ),
      body: FutureBuilder(
        future: context.read<MovieProvider>().list(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: ContentHeader(
                    feature: context.watch<MovieProvider>().featured!),
              ),
              const SliverPadding(
                padding: EdgeInsets.only(top: 20),
                sliver: SliverToBoxAdapter(
                  child: Previews(
                    key: PageStorageKey('previews'),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ContentList(
                  title: "New releases",
                  contentList: context.watch<MovieProvider>().newReleases,
                ),
              ),
              SliverToBoxAdapter(
                child: ContentList(
                    title: "Netflix Originals",
                    contentList: context.watch<MovieProvider>().originals,
                    isOriginal: true),
              ),
              SliverToBoxAdapter(
                child: ContentList(
                  title: "Trending",
                  contentList: context.watch<MovieProvider>().trending,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 20),
                sliver: SliverToBoxAdapter(
                  child: ContentList(
                    title: "Animation",
                    contentList: context.watch<MovieProvider>().animations,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
