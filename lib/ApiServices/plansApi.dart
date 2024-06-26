import 'package:dio/dio.dart';
import 'package:leadkart/Models/VerifyOtpModel.dart';
import 'package:leadkart/Models/ads_plan_model.dart';
import 'package:leadkart/Models/offering_model.dart';
import 'package:leadkart/helper/controllerInstances.dart';
import 'package:leadkart/helper/helper.dart';

class PlansApi{

 getAllAiImagePlans() async
 {
   try{
     final CurrentUser? _user = await Controllers.userPreferencesController
         .getUser();
   var resp = await MyHelper.dio.get('plan/getAllPlan', options: Options(
     headers: {
       "Authorization": "${_user!.token}",
     }
   ));
   MyHelper.logger.i(resp.data);
   return resp;
   }
   catch(e)
   {
     MyHelper.logger.e(e);
   }
 }

 createAiImagePlan( String userId) async
 {
   try {
     CurrentUser? _user = await Controllers.userPreferencesController.getUser();
     AdsPlan _plan = AdsPlan(
       advertisementTypeId: '615f4b3b7b3b3b001f3b3b3b',
       title: 'SK e solution',
       price: 100,
       duration: 30,
       dailySpendBudget: 10,
       aiImageCount: 10,
       instaBudget: 10,
       googleBudget: 10,
       facebookBudget: 10,
     );
     var resp = await MyHelper.dio.post('plan/createPlan?userId=$userId', data: _plan.toJson(), options: Options(
         headers: {
           "Authorization": "${_user!.token}",
         }
     ));
     MyHelper.logger.i(resp.data);
     return resp;
   } catch (e) {
     MyHelper.logger.e(e);
   }
 }
}