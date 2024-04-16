// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:wear_ai/controller/discover_agent_controller.dart';
// import 'package:wear_ai/utils/app_text_styles.dart';
// import 'package:wear_ai/view/main_screens/drawer_tabs/enable_agent.dart';
// import 'package:wear_ai/widgets/widgets.dart';
//
// import '../../../utils/app_colors.dart';
// import '../drawer_screen.dart';
//
// class DiscoverScreen extends StatefulWidget {
//   const DiscoverScreen({super.key});
//
//   @override
//   State<DiscoverScreen> createState() => _DiscoverScreenState();
// }
//
// class _DiscoverScreenState extends State<DiscoverScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final DiscoverAgentController discoverAgentController = DiscoverAgentController();
//   final AppTextStyle appTextStyle = AppTextStyle();
//   final ScrollController scrollController = ScrollController();
//   int pageNumber = 1;
//
//   @override
//   void initState() {
//     super.initState();
//     scrollController.addListener(() => _scrollListener());
//     discoverAgentController.discoverAgent(pageNumber);
//   }
//
//   Future<void> _scrollListener() async {
//     if (discoverAgentController.isLoadingMore.value) return;
//     if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
//       discoverAgentController.isLoadingMore.value = true;
//       pageNumber += 1;
//       await discoverAgentController.discoverAgent(pageNumber);
//       discoverAgentController.isLoadingMore.value = false;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: AppColors.scaffoldColor,
//       drawer: DrawerScreen(),
//       appBar: AppBar(
//         title: const Text('Discover Agents'),
//         leading: IconButton(
//           icon: menuLeadingIcon,
//           onPressed: () => _scaffoldKey.currentState!.openDrawer(),
//         ),
//         actions: [
//           IconButton(
//             padding: EdgeInsets.zero,
//             visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
//             onPressed: () {},
//             icon: searchIcon,
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: filterIcon,
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: Obx(
//               () => discoverAgentController.isLoading.value
//               ? loader
//               : discoverAgentController.discoverAgentList.isNotEmpty
//               ? ListView.builder(
//             controller: scrollController,
//             shrinkWrap: true,
//             itemCount: discoverAgentController.isLoadingMore.value
//                 ? discoverAgentController.discoverAgentList.length + 1
//                 : discoverAgentController.discoverAgentList.length,
//             itemBuilder: (context, index) {
//               if (index < discoverAgentController.discoverAgentList.length) {
//                 return Container(
//                   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 11),
//                   margin: const EdgeInsets.symmetric(vertical: 8),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(6),
//                     color: AppColors.white,
//                     boxShadow: boxShadow,
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           /// image container
//                           Container(
//                             margin: const EdgeInsets.only(right: 10),
//                             padding: const EdgeInsets.all(4),
//                             decoration: BoxDecoration(
//                               border: Border.all(width: 1, color: AppColors.lightBorderColor),
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                             child: Image.network(
//                               discoverAgentController.discoverAgentList[index].discoverAgentImage,
//                               width: MediaQuery.of(context).size.width * 0.19,
//                               height: MediaQuery.of(context).size.height * 0.092,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 205,
//                             height: 90,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Text(
//                                   discoverAgentController.discoverAgentList[index].discoverAgentName,
//                                   softWrap: true,
//                                   style: appTextStyle.montserrat13W600,
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 2,
//                                 ),
//
//                                 /// price and switch
//                                 Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     index % 2 == 0
//                                         ? Container(
//                                       padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(4),
//                                         color: AppColors.primaryColor.withOpacity(0.15),
//                                       ),
//                                       child: Text(
//                                         'Free',
//                                         style: appTextStyle.montserrat14W600Green,
//                                       ),
//                                     )
//                                         : Text.rich(
//                                       TextSpan(
//                                         text: '\$194',
//                                         style: appTextStyle.montserrat18W600Green,
//                                         children: <InlineSpan>[
//                                           TextSpan(
//                                             text: ' per month',
//                                             style: appTextStyle.montserrat12W500Grey,
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 28,
//                                       width: 43,
//                                       child: FittedBox(
//                                         fit: BoxFit.contain,
//                                         child: CupertinoSwitch(
//                                           value: true,
//                                           onChanged: (value) {},
//                                           thumbColor: AppColors.white,
//                                           activeColor: AppColors.primaryColor,
//                                           applyTheme: true,
//                                           trackColor: AppColors.lightBorderColor,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Text.rich(
//                                   TextSpan(
//                                     text: 'Provider:',
//                                     style: appTextStyle.montserrat12W500Grey,
//                                     children: <InlineSpan>[
//                                       TextSpan(
//                                         text: ' ${discoverAgentController.discoverAgentList[index].discoverAgentProvider}',
//                                         style: appTextStyle.montserrat12W500,
//                                       )
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       Obx(
//                             () => discoverAgentController.discoverAgentList[index].isOpen.value == true
//                             ? SizedBox(
//                           width: double.infinity,
//                           height: 52,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Text.rich(
//                                 TextSpan(
//                                   text: 'Agent Type:',
//                                   style: appTextStyle.montserrat12W500Grey,
//                                   children: <InlineSpan>[
//                                     TextSpan(
//                                       text: ' ${discoverAgentController.discoverAgentList[index].discoverAgentType}',
//                                       style: appTextStyle.montserrat12W500,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               Text.rich(
//                                 softWrap: true,
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 2,
//                                 TextSpan(
//                                   text: 'Description:',
//                                   style: appTextStyle.montserrat12W500Grey,
//                                   children: <InlineSpan>[
//                                     TextSpan(
//                                       text: ' ${discoverAgentController.discoverAgentList[index].discoverAgentDescription}',
//                                       style: appTextStyle.montserrat12W500,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                             : const SizedBox(),
//                       ),
//                       const Divider(),
//                       InkWell(
//                         onTap: () {
//                           Get.to(() => EnableAgent(agentId: discoverAgentController.discoverAgentList[index].discoverAgentId));
//                           // discoverAgentController.discoverAgentList[index].isOpen.value =
//                           //     !discoverAgentController.discoverAgentList[index].isOpen.value;
//                         },
//                         child: Obx(
//                               () => Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 discoverAgentController.discoverAgentList[index].isOpen.value ? 'View Less ' : 'View More ',
//                                 style: appTextStyle.montserrat12W500Grey,
//                               ),
//                               Icon(
//                                 discoverAgentController.discoverAgentList[index].isOpen.value
//                                     ? Icons.keyboard_arrow_up_rounded
//                                     : Icons.keyboard_arrow_down,
//                                 color: AppColors.hintTextColor,
//                                 size: 18,
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//               } else {
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 20),
//                   child: loader,
//                 );
//               }
//             },
//           )
//               : Center(
//             child: Text('No Data Found', style: appTextStyle.montserrat14W500),
//           ),
//         ),
//       ),
//     );
//   }
// }
