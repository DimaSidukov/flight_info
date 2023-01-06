import 'package:flight_info/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../data/flight.dart';

class FlightScreen extends StatefulWidget {
  const FlightScreen({super.key, required this.flight});

  final Flight flight;

  @override
  _FlightScreen createState() => _FlightScreen();
}

class _FlightScreen extends State<FlightScreen> {
  @override
  Widget build(BuildContext context) {
    Flight flight = widget.flight;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: null,
        body: Container(
            height: MediaQuery.of(context).size.height,
            color: AppColors.grey4,
            child: Stack(children: [
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      child: SizedBox(
                          height: 340,
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            flight.imgUrl,
                            fit: BoxFit.cover,
                          ))),
                  SafeArea(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 30, top: 45),
                          child: GestureDetector(
                            onTap: () {
                              context.pop();
                            },
                            child: Container(
                              width: 79,
                              height: 49,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: AppColors.white),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 18,
                                      width: 18,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.grey2),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: SvgPicture.asset(
                                          'assets/arrow_left.svg'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: SvgPicture.asset('assets/card.svg'),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 70),
                                child:
                                    SvgPicture.asset('assets/fading_line.svg')),
                            Padding(
                              padding: const EdgeInsets.only(top: 97, right: 2),
                              child: Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 177,
                                  width: 307,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 31, left: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "From",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 14,
                                                      fontFamily: 'FiraSans'),
                                                ),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(),
                                                    child: Text(
                                                        flight.destinationCountry ==
                                                                null
                                                            ? "Yoshkar-Ola"
                                                            : "Russia"))
                                              ],
                                            )),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 31, right: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                const Text(
                                                  "To",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 14,
                                                      fontFamily: 'FiraSans'),
                                                ),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(),
                                                    child: Text(
                                                        flight.destinationCity))
                                              ],
                                            )),
                                      ),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 50),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                  'assets/airplane.svg'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 45),
                                                child: Text(
                                                  flight.flightLength,
                                                  style: const TextStyle(
                                                      fontFamily: 'FiraSans',
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 12),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 18, bottom: 18),
                                          child: Container(
                                            width: 82,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: AppColors.purple3),
                                            child: Row(
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: SvgPicture.asset(
                                                        'assets/paper_plane.svg')),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4),
                                                    child: Text(
                                                        DateFormat('hh:mma')
                                                            .format(DateFormat(
                                                                    "hh:mm")
                                                                .parse(flight
                                                                    .departureTime)),
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'FiraSans',
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 12,
                                                            color: AppColors
                                                                .purple)))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 18, bottom: 18),
                                          child: Container(
                                            width: 90,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: AppColors.purple3),
                                            child: Row(
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: SvgPicture.asset(
                                                        'assets/calendar.svg')),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4),
                                                    child: Text(
                                                        DateFormat("dd.MM.yyyy")
                                                            .format(DateFormat(
                                                                    "yyyy-mm-dd")
                                                                .parse(flight
                                                                    .date)),
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'FiraSans',
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 12,
                                                            color: AppColors
                                                                .purple)))
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                    padding:
                        const EdgeInsets.only(top: 200, left: 34, right: 34),
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
                          onPressed: () {},
                          child: const Text(
                            "Buy ticket",
                            style: TextStyle(
                                fontFamily: 'FiraSans',
                                fontSize: 20,
                                color: AppColors.white),
                          )),
                    )),
              )
            ])));
  }
}
