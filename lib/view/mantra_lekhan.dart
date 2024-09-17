import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/top_user_controller.dart';

class MantraJapPage extends StatefulWidget {
  const MantraJapPage({super.key});
  @override
  State<MantraJapPage> createState() => _MantraJapPageState();
}

class _MantraJapPageState extends State<MantraJapPage> {
  final Color themeColor = Color(0xFFedaa6f);
  final Color backgroundColor = Color(0xFFF5E8D0);
  final TopUserController topUserController = Get.put(TopUserController());


  @override
  void initState() {
    topUserController.getTotalJapData();
    topUserController.get50UserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(10),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.56,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(()=>Expanded(child: _buildStatCard("Today", topUserController.today.value),),),
                  const SizedBox(width: 10),
                  Obx(()=>Expanded(child: _buildStatCard("This week", topUserController.week.value),),)
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(()=>Expanded(child: _buildStatCard("This Month", topUserController.month.value),),),
                  const SizedBox(width: 10),
                  Obx(()=>Expanded(child: _buildStatCard("Total", topUserController.total.value),),)
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(()=>Expanded(child: _buildStatCard("Total MantraJap", topUserController.totalMantraJap.value),),)
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(()=>Expanded(child: _buildStatCard("Total User", topUserController.user.value),),),
                  const SizedBox(width: 10),
                  Obx(()=>Expanded(child: _buildStatCard("My Rank", topUserController.rank.value),),)
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Get.bottomSheet(
                    isDismissible: true,
                    ignoreSafeArea: false,
                    Container(
                      height: MediaQuery.of(context).size.height * 0.95,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                // Close the bottom sheet
                                Get.back();
                              },
                            ),
                          ),
                          if (topUserController.user != '')
                            Expanded(
                              child: ListView.builder(
                                itemCount: topUserController.topUserList.length,
                                itemBuilder: (context, index) {
                                  if (index < topUserController.topUserList.length) {
                                    final userData = topUserController.topUserList[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                      child: Card(
                                        elevation: 4,
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            child: Text('${index + 1}'),
                                          ),
                                          title: Text(userData.fullName ?? ''),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('${'Village'.tr} : ${userData.village ?? ''}'),
                                              Text('${'Total Credits'.tr} : ${userData.creditCount}'),
                                            ],
                                          ),
                                          onTap: () {},
                                        ),
                                      ),
                                    );
                                  }
                                  return SizedBox.shrink();
                                },
                              ),
                            )
                          else
                            Text('No users available'),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    isScrollControlled: true,
                  );
                },
                child: const Text("Top 50 Users"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Color(0xFFF5E8D0),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 4),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
