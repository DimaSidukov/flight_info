import 'package:dio/dio.dart';
import 'package:flight_info/colors/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/Flight.dart';
import '../data/api_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final client = ApiClient(Dio());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: null,
        body: SingleChildScrollView(
            child: SafeArea(
          child: Container(
            color: AppColors.grey4,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
                  child: TextField(
                    obscureText: true,
                    style: const TextStyle(
                        fontSize: 20,
                        color: AppColors.grey2,
                        fontFamily: 'FiraSans'),
                    decoration: InputDecoration(
                        labelText: "Search",
                        prefixIcon: Container(
                            margin: const EdgeInsets.only(left: 20, right: 16),
                            child: SvgPicture.asset('assets/search.svg',
                                height: 20,
                                width: 20,
                                allowDrawingOutsideViewBox: true)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle: const TextStyle(
                            fontSize: 18, color: AppColors.grey2),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        filled: true,
                        fillColor: AppColors.grey3),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "International flights",
                        style: TextStyle(
                            color: AppColors.black,
                            fontFamily: 'FiraSans',
                            fontSize: 20),
                      ),
                      Text(
                        "See all",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: AppColors.purple,
                            fontSize: 12),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 30, top: 15),
                    child: FutureBuilder(
                      future: client.getInternationalFlights(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.none) {
                          return const Center(
                              child: Text("No internet connection!"));
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          List<Flight>? data = snapshot.data;
                          if (data == null) {
                            return const Text(
                                "Information was not loaded! Try again later!");
                          } else {
                            return SizedBox(
                                height: 174,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: data?.length ?? 0,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 10),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        context.push('/flight',
                                            extra: data![index].toJson());
                                      },
                                      child: Container(
                                        width: 120,
                                        height: 174,
                                        decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                // Image border
                                                child: SizedBox.fromSize(
                                                  size:
                                                      const Size.fromRadius(60),
                                                  // Image radius
                                                  child: Image.network(
                                                      data![index].imgUrl,
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              Expanded(
                                                  child: Stack(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 12, top: 5),
                                                      child: Text(
                                                        data![index]
                                                            .destinationCity,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            color:
                                                                AppColors.black,
                                                            fontFamily:
                                                                'FiraSans',
                                                            fontSize: 20),
                                                      )),
                                                  const Align(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 12,
                                                                bottom: 10),
                                                        child: Text(
                                                          "Starting from",
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .purple,
                                                              fontFamily:
                                                                  'FiraSans',
                                                              fontSize: 10),
                                                        ),
                                                      )),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 11,
                                                              bottom: 10),
                                                      child: Text(
                                                        "${data[index].minPrice}\$",
                                                        style: const TextStyle(
                                                            color:
                                                                AppColors.black,
                                                            fontFamily:
                                                                'FiraSans',
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ))
                                            ]),
                                      ),
                                    );
                                  },
                                ));
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Local flights",
                        style: TextStyle(
                            color: AppColors.black,
                            fontFamily: 'FiraSans',
                            fontSize: 20),
                      ),
                      Text(
                        "See all",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: AppColors.purple,
                            fontSize: 12),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 30, top: 15),
                    child: FutureBuilder(
                        future: client.getLocalFlights(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.none) {
                            return const Center(
                                child: Text("No internet connection!"));
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            List<Flight>? data = snapshot.data;
                            if (data == null) {
                              return const Text(
                                  "Information was not loaded! Try again later!");
                            } else {
                              return SizedBox(
                                  height: 174,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: data?.length ?? 0,
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(width: 10),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                          onTap: () {
                                            context.push('/flight',
                                                extra: data![index].toJson());
                                          },
                                          child: Container(
                                            width: 120,
                                            height: 174,
                                            decoration: BoxDecoration(
                                                color: AppColors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    // Image border
                                                    child: SizedBox.fromSize(
                                                      size:
                                                          const Size.fromRadius(
                                                              60),
                                                      // Image radius
                                                      child: Image.network(
                                                          data![index].imgUrl,
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Stack(
                                                    children: [
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 12,
                                                                  top: 5),
                                                          child: Text(
                                                            data[index]
                                                                .destinationCity,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                color: AppColors
                                                                    .black,
                                                                fontFamily:
                                                                    'FiraSans',
                                                                fontSize: 20),
                                                          )),
                                                      const Align(
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 12,
                                                                    bottom: 10),
                                                            child: Text(
                                                              "Starting from",
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .purple,
                                                                  fontFamily:
                                                                      'FiraSans',
                                                                  fontSize: 10),
                                                            ),
                                                          )),
                                                      Align(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 11,
                                                                  bottom: 10),
                                                          child: Text(
                                                            "${data[index].minPrice}\$",
                                                            style: const TextStyle(
                                                                color: AppColors
                                                                    .black,
                                                                fontFamily:
                                                                    'FiraSans',
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ))
                                                ]),
                                          ));
                                    },
                                  ));
                            }
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        })),
                Padding(
                    padding: EdgeInsets.only(top: 20, left: 34, right: 34),
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [AppColors.purple2, AppColors.purple],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(62),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              backgroundColor: Colors.transparent),
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('is_logged_in', false);
                            if (mounted) {
                              context.go('/login');
                            }
                          },
                          child: const Text(
                            "Log out",
                            style: TextStyle(
                                fontFamily: 'FiraSans',
                                fontSize: 20,
                                color: AppColors.white),
                          )),
                    )),
              ],
            ),
          ),
        )),
        bottomNavigationBar: SizedBox(
          height: 100,
          child: Container(
            color: AppColors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Material(
                  color: AppColors.white,
                  child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                          margin: const EdgeInsets.all(15),
                          child: SvgPicture.asset(
                            'assets/home.svg',
                          )),
                      onTap: () {}),
                ),
                Material(
                  color: AppColors.white,
                  child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                          margin: const EdgeInsets.all(15),
                          child: SvgPicture.asset(
                            'assets/search.svg',
                          )),
                      onTap: () {}),
                ),
                Material(
                  color: AppColors.white,
                  child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      child: SvgPicture.asset(
                        'assets/compass.svg',
                      ),
                      onTap: () {}),
                ),
                Material(
                  color: AppColors.white,
                  child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                          margin: const EdgeInsets.all(15),
                          child: SvgPicture.asset(
                            'assets/ticket.svg',
                          )),
                      onTap: () {}),
                ),
                Material(
                  color: AppColors.white,
                  child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                          margin: const EdgeInsets.all(15),
                          child: SvgPicture.asset(
                            'assets/bell.svg',
                          )),
                      onTap: () {}),
                )
              ],
            ),
          ),
        ));
  }
}
