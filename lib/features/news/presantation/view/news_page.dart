import 'dart:ui';

import 'package:design_project/features/news/presantation/view/cubit/news_cubit.dart';
import 'package:design_project/features/news/presantation/view/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  NewsCubit get _cubit => NewsCubit()..getNews();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: const NewsListWidget(),
    );
  }
}

class NewsListWidget extends StatelessWidget {
  const NewsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, boolState) {
        return Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: Row(
                children: const [
                  Text("New App"),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.chrome_reader_mode),
                ],
              ),
              backgroundColor:
                  boolState ? Colors.blue : Colors.orange.shade800),
          body: BlocBuilder<NewsCubit, NewsState>(builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Text(
                  "Most Popular",
                  style: TextStyle(
                      color: boolState ? Colors.blue : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                BlocBuilder<ThemeCubit, bool>(
                  builder: (context, state) {
                    return SwitchListTile(
                      activeColor: state ? Colors.blue : Colors.orange.shade800,
                      value: state,
                      onChanged: (value) {
                        BlocProvider.of<ThemeCubit>(context)
                            .toggleTheme(value: value);
                      },
                      title: const Text("Açık/Koyu Mod"),
                    );
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 400,
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.newsList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => launchUrl(
                            Uri.parse(state.newsList[index].url.toString())),
                        child: Container(
                          width: 250,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: boolState
                                  ? Colors.blue
                                  : Colors.orange.shade800,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  state.newsList[index].title.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color:
                                        boolState ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Image.network(
                                state.newsList[index].urlToImage.toString(),
                                height: 160,
                                width: 250,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: SizedBox(
                    height: 500,
                    child: ListView.builder(
                      itemCount: state.newsList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => launchUrl(
                              Uri.parse(state.newsList[index].url.toString())),
                          child: Card(
                            color: boolState ? Colors.black : Colors.white,
                            child: ListTile(
                              trailing: SizedBox(
                                width: 70,
                                child: ShaderMask(
                                  shaderCallback: (rectangle) {
                                    return const LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.transparent,
                                        Color.fromARGB(255, 230, 230, 230),
                                      ],
                                    ).createShader(
                                      Rect.fromLTRB(0, 0, rectangle.height,
                                          rectangle.width),
                                    );
                                  },
                                  child: Image.network(
                                    state.newsList[index].urlToImage.toString(),
                                    errorBuilder: (ontext, error, stackTrace) {
                                      return const CircularProgressIndicator();
                                    },
                                    width: 70,
                                    height: 100,
                                  ),
                                ),
                              ),
                              title: Text(
                                state.newsList[index].title.toString(),
                                style: TextStyle(
                                  color:
                                      boolState ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                              leading: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Icon(
                                    Icons.chrome_reader_mode_outlined,
                                    color: boolState
                                        ? Colors.blue
                                        : Colors.orange.shade800,
                                    size: 14,
                                  ),
                                  const SizedBox(height: 10),
                                  InkWell(
                                    onTap: () {
                                      Share.share(
                                          "Bu haberi seninle paylaşmak istedim $launchUrl(Uri.parse(state.newsList[index].url.toString()))");
                                    },
                                    child: Icon(
                                      Icons.share,
                                      size: 14,
                                      color: boolState
                                          ? Colors.blue
                                          : Colors.orange.shade800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
