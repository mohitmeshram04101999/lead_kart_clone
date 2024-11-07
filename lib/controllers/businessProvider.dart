import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:leadkart/ApiServices/BussnessApi.dart';
import 'package:leadkart/ApiServices/getPagesApi.dart';
import 'package:leadkart/Methods/methods.dart';
import 'package:leadkart/Models/BussnessdetailModel.dart';
import 'package:leadkart/Models/MycustomResponce.dart';
import 'package:leadkart/Models/VerifyOtpModel.dart';
import 'package:leadkart/Models/business_model.dart';
import 'package:leadkart/Models/getPagesModel.dart';
import 'package:leadkart/controllers/shredprefrence.dart';
import 'package:leadkart/helper/controllerInstances.dart';
import 'package:leadkart/helper/helper.dart';
import 'package:logger/logger.dart';

class BusinessProvider with ChangeNotifier {
  final _log = Logger();

  //Variables
  bool _loding = false;
  bool _warning = true;
  bool _isWarningOpen = false;
  List<BusinessModel> _allBusiness = [];
  BusinessModel? _currentBusiness;
  //

  //Getters
  bool get loding => _loding;
  bool get warnIng => _warning;
  List<BusinessModel> get allBusiness => _allBusiness;
  BusinessModel? get currentBusiness => _currentBusiness;
  //

//lode Method
  Future<void> lode(BuildContext context) async {
    _loding = true;
    CurrentUser? user = await Controllers.userPreferencesController.getUser();
    CustomResponce responce =
        await BussnissApi().getBusinessByUserId(userId: user!.id!);

    if (responce.statusCode == 200) {
      _allBusiness = responce.data;
      // log(_allBusiness.toString());
    }

    _loding = false;
    BusinessModel? CB = await Controllers.useraPrefrenc.getBusiness();


    _allBusiness.forEach((e){
      if(CB?.id==e.id)
        {
          _currentBusiness = e;
        }
    });

    // _currentBusiness = await Controllers.useraPrefrenc.getBusiness();
    notifyListeners();
    Logger().f(_currentBusiness);
    if (_currentBusiness?.pageAccessToken == null &&
        !_isWarningOpen &&
        _warning) {
      showWarning(context);
    }
  }
  //

  //set Current Business
  setCurrentBusiness(BuildContext context, BusinessModel business) async {
    _warning = true;
    _currentBusiness = business;
    notifyListeners();
    UserPreference().saveBusiness(business);
    Controllers.addListByBusinessProvider(context).clear();
    await lode(context);
    Controllers.addListByBusinessProvider(context).load(context, page: 1);
  }
  //

  Future<bool> showWarning(BuildContext context) async {
    _log.i("Hi Threr");
    if (_currentBusiness != null) {
      _isWarningOpen = true;
      BusinessDetailModel? businessDetail = await MyHelper.bussnissApi
          .getFullDetailOfBusiness(_currentBusiness?.id ?? "");
      if (businessDetail != null) {
        // _log.i("in");
        if (businessDetail.isFacebookPageLinked == false ||
            businessDetail.isFacebookPageLinked == null) {
          await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                    title: const Text(
                      "Meta account is not linked,please link",
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () async {
                            Methods().loginWithFacebook(context).then(
                              (value) {
                                if (value != null) {
                                  log(value.accessToken!.tokenString);
                                  _warning = false;
                                  Navigator.pop(context);

                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return Dialog(
                                        child: FutureBuilder<FacebookPageData>(
                                          future: MetaApis.getPages(
                                              value.accessToken!.tokenString),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                            // if (snapshot.data == null) {
                                            //   return const Center(
                                            //     child: Text("No Data Found"),
                                            //   );
                                            // }

                                            if (snapshot.hasData) {
                                              log('facebook alpha ${snapshot.data.toString()}');
                                            }
                                            // log('facebook ${snapshot.data.toString()}');
                                            final data = snapshot.data;

                                            if (data?.data.length == 0) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 20),
                                                child: Text(
                                                    "No FaceBook Page Found"),
                                              );
                                            }
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final finalData =
                                                        data!.data[index];
                                                    return ListTile(
                                                      title: Text(
                                                          finalData['name']),
                                                      subtitle:
                                                          Text(finalData['id']),
                                                      onTap: () async {
                                                        await Controllers
                                                                .linkedPageProvider(
                                                                    context)
                                                            .setLinkedPage(
                                                          name:
                                                              finalData['name'],
                                                          accessToken: finalData[
                                                              'access_token'],
                                                          id: finalData['id'],
                                                        )
                                                            .then((e) async {
                                                          CustomResponce res = await MyHelper.bussnissApi.upDateBusiness(
                                                              businessId:
                                                                  _currentBusiness!
                                                                      .id!,
                                                              serviceId: _currentBusiness!
                                                                  .servicesId,
                                                              address:
                                                                  _currentBusiness!
                                                                      .address,
                                                              businessName:
                                                                  _currentBusiness!
                                                                      .businessName,
                                                              businessCategoryId:
                                                                  _currentBusiness!
                                                                      .businessCategoryId,
                                                              businessContactNum:
                                                                  _currentBusiness!
                                                                      .businessContact
                                                                      .toString(),
                                                              cityId:
                                                                  _currentBusiness!
                                                                      .cityId,
                                                              countryId:
                                                                  _currentBusiness!
                                                                      .countryId,
                                                              faceBookLink:
                                                                  _currentBusiness!
                                                                      .facebookLink,
                                                              instaLink:
                                                                  _currentBusiness!
                                                                      .instagramLink,
                                                              stateId:
                                                                  _currentBusiness!
                                                                      .stateId,
                                                              tagLine: _currentBusiness!.tagline,
                                                              twitterLink: _currentBusiness!.twitterLink,
                                                              webLink: _currentBusiness!.websiteLink,
                                                              whatAppNum: _currentBusiness!.whatsappNumber.toString(),
                                                              youTubeLink: _currentBusiness!.youtubeLink,
                                                              isPageSubscribe: false,
                                                              pageAccessToken: finalData['access_token'],
                                                              pageId: finalData['id'],
                                                              metaAccessToken: value.accessToken!.tokenString);

                                                          if(res.statusCode==200)
                                                            {
                                                              BusinessModel business = res.data;
                                                              setCurrentBusiness(context, business);
                                                            }

                                                          // setCurrentBusiness(context, _currentBusiness!);

                                                          lode(context);

                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      },
                                                    );
                                                  },
                                                  itemCount: snapshot
                                                          .data?.data.length ??
                                                      0,
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Facebook Page Linked"),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                          child: const Text("Link")),
                      ElevatedButton(
                          onPressed: () {
                            _warning = false;
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                    ],
                  ));

          return false;
        } else if (businessDetail.isMetaAccessTokenActive != true) {
          await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text(
                      "Meta To",
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            _warning = false;
                            Navigator.pop(context);
                          },
                          child: const Text("Close")),
                      // ElevatedButton(onPressed: (){
                      //   _warning = false;
                      //   Navigator.pop(context);
                      // }, child:const Text("Cancel")),
                    ],
                  ));
          return false;
        } else {
          return true;
        }
      } else {
        return false;
      }
      _isWarningOpen = false;
    } else {
      return false;
    }
  }
}
