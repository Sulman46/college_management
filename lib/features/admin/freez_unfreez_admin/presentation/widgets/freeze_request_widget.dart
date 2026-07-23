import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/freez_unfreez_admin/models/freeze_request_model.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../core/enums/user_enums.dart';
import '../../../../../core/helper/downloader_helper.dart';
import '../../../../Authentication/presentation/controller/cubit.dart';
import '../controller/cubit.dart';
import 'freeze_request_status.dart';

class FreezeRequestWidget extends StatefulWidget {
  FreezeRequestWidget({super.key,required this.model});
  FreezeRequestModel model;

  @override
  State<FreezeRequestWidget> createState() => _FreezeRequestWidgetState();
}

class _FreezeRequestWidgetState extends State<FreezeRequestWidget> {

  List<String> statusList=[ "Approved","Rejected","Pending","Delete"];
  
  @override
  void initState() {
   
    // TODO: implement initState
    super.initState();
    
    statusList.remove(widget.model.requestStatus);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
      decoration: AppColor.containerNeon,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(text: widget.model.studentName??"",fontSize: 12,color: AppColor.white,),
          AppText(text: widget.model.srNo??"",fontSize: 10,color: AppColor.greyLight,),
          SizedBox(height: 5,),
          AppText(text: "Dept: ${widget.model.department??""}",fontSize: 11,color: AppColor.greyLight,),
          AppText(text: "${widget.model.program ?? ""} | ${widget.model.session} | ${widget.model.section}",fontSize: 11,color: AppColor.greyLight,),
          AppText(text: "Sem: ${widget.model.semesterAtRequest?? ""} ",fontSize: 11,color: AppColor.white,),




          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(text: "Req: ${widget.model.requestType?? ""} ",fontSize: 11,color:widget.model.requestType=="Unfreeze"? AppColor.fieldYellowBorder: AppColor.red,),
              FreezeRequestStatus(status: widget.model.requestStatus??"Active"),

              if(_authCubit.userModel!.role==UserRole.admin)
                CustomPopMenuButton(
                menus:statusList,
                onSelected: (p0) async {
                  final freezeCubit=DiContainer().sl<FreezUnFreezCubit>();
                  if(statusList[p0]=="Delete"){
                    var res= await freezeCubit.delete(widget.model);
                    if(res){
                      if(freezeCubit.isPendingTab){
                        await freezeCubit.getPen();
                      }else{
                        await freezeCubit.getFinal();
                      }
                    }
                  }else{
                    var res= await freezeCubit.update(widget.model.copyWith(requestStatus:statusList[p0] ));
                    if(res){
                      if(freezeCubit.isPendingTab){
                        await freezeCubit.getPen();
                      }else{
                        await freezeCubit.getFinal();
                      }
                    }
                  }
                },

              ),
            ],
          ),

          if(widget.model.attachmentUrl!=null && widget.model.attachmentUrl!="")
            Container(
              margin: EdgeInsets.only(top: 5),
              child: InkWell(
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () async {
                  await FileDownloader.download(
                    url: widget.model.attachmentUrl??"",
                    fileName: "${widget.model.studentName??""}-${widget.model.requestType??""}-${widget.model.srNo??""}",
                    onProgress: (progress) {
                      debugPrint("${(progress * 100).toStringAsFixed(0)}%");
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(text: "Attachment",fontSize: 12,color: AppColor.blueLight,fontWeight: FontWeight.w600,),
                    Icon(Icons.download_rounded,color: AppColor.blueLight,size: 20,),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

final _authCubit=DiContainer().sl<AuthenticationCubit>();

