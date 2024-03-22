//%attributes = {"invisible":true}
//Method: NTI_DoReviewInspection
//Description
// Perform review on TIN inspections
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/27/16, 09:22:42
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(9/1/16 11:25:09)
	Mods_2016_09
	//  `added test code to do review
	// Modified by: Costas Manousakis-(Designer)-(9/20/17 15:09:31)
	Mods_2017_09
	//  `enabled the review actions
	//  `Use method Mail_SendTINRevuNotif for emailing
	// Modified by: Costas Manousakis-(Designer)-(6/3/19 13:14:44)
	Mods_2019_06_bug
	//  `Do not mark inspection as Complete when doing DBIE approval (it should already be complete)
	// Modified by: Costas Manousakis-(Designer)-(2021-12-10T00:00:00 12:34:56)
	Mods_2021_12_bug
	//  `Load RO the required [Nti_tunnelinfo], use method FM_ReturnInspectionTitle to show the inspection title
	//  `format the description better
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//Add call to Synch_ReturnForward to reset new style vsForward
	//Modified by: Chuck Miller (1/11/22 14:41:42)
	
End if 
//

C_TEXT:C284($Review_txt; $Review1_txt; $Review2_txt)
C_TEXT:C284($CurrUser_txt; $Insp_info_txt)
$CurrUser_txt:=<>CurrentUser_Name

$Review_txt:="DTIE Review"
$Review1_txt:="DTIE Approval"
$Review2_txt:="Tunnel Engineer Review"

If (User in group:C338($CurrUser_txt; "MBTA"))
	$Review_txt:="MBTA QC Review"
	$Review1_txt:="MBTA QC Approval"
	$Review2_txt:="MBTA QA Review"
Else 
End if 

C_TEXT:C284($Insp_info_txt; $msg; $sRevType; vTextMsg; vtPrevRevComments; vtRevComments; $InspTypeDescr)

C_BOOLEAN:C305($DBIEReqd_b; $AreaReqd_b)
C_LONGINT:C283($FinalStage_L)

//need the [NTI_TunnelInfo] record
READ ONLY:C145([NTI_TunnelInfo:181])
QUERY:C277([NTI_TunnelInfo:181]; [NTI_TunnelInfo:181]NTI_i1_s:6=[TIN_Inspections:184]NTI_i1_S:1)
$InspTypeDescr:=f_CapitalizeTxt(Replace string:C233(FM_ReturnInspectionTitle; "Inspection"; ""))

$Insp_info_txt:=[TIN_Inspections:184]NTI_i1_S:1+"\rTown: "+[NTI_TunnelInfo:181]NTI_TownName_s:71
$Insp_info_txt:=$Insp_info_txt+"\rTunnel Name: "+[NTI_TunnelInfo:181]NTI_i2_s:7
$Insp_info_txt:=$Insp_info_txt+"\rDistrict: "+[NTI_TunnelInfo:181]NTI_i6_s:11+",\rInspection Type: "
//QUERY([Inspection Type];[Inspection Type]Code=[TIN_Inspections]InspType)
//$Insp_info_txt:=$Insp_info_txt+[Inspection Type]Description+FM_ReturnInspectionTitle 
$Insp_info_txt:=$Insp_info_txt+$InspTypeDescr
$Insp_info_txt:=$Insp_info_txt+" ("+[TIN_Inspections:184]InspType:21+")"+"\rDate: "+String:C10([TIN_Inspections:184]InspDate:3)
NTI_GetInspRequirements([TIN_Inspections:184]InspType:21; ->$DBIEReqd_b; ->$AreaReqd_b)

C_LONGINT:C283(vApproveLvl; vbAccept; vbReject; INSP_InDepthReview_L)
vApproveLvl:=0
INSP_InDepthReview_L:=0
C_TEXT:C284($DBIEGroupName_txt; $AreaEGroupName_txt)
C_BOOLEAN:C305($prevINSPDBIE_b; $prevAreaEng_b)
$prevINSPDBIE_b:=<>INSP_DBIE_b
$prevAreaEng_b:=<>INSP_AreaEng_b
Case of 
	: (Not:C34([TIN_Inspections:184]Complete:4))
		ALERT:C41("Inspection for "+$Insp_info_txt+"\rNot Complete Yet!")
		
	: ($DBIEReqd_b & ([TIN_Inspections:184]InspReview:5#BMS Approved) & <>INSP_DBIE_b)
		//DBIE Review
		$sRevType:=$Review_txt  //DBIE Review "
		vApproveLvl:=1
	: ($DBIEReqd_b & ([TIN_Inspections:184]InspReview:5=BMS Approved) & <>INSP_DBIE_b & (Not:C34(<>INSP_AreaEng_b)) & ([TIN_Inspections:184]InspApproval:6#BMS Approved))
		//DBIE Re-Review
		G_MyConfirm("You have already approved Inspection for "+$Insp_info_txt+"!\rDo you want to repeat the Review?")
		If (OK=1)
			$sRevType:=$Review_txt  //DBIE Review "
			vApproveLvl:=1
		End if 
		
	: ($AreaReqd_b & ([TIN_Inspections:184]InspApproval:6#BMS Approved) & (([TIN_Inspections:184]InspReview:5#BMS Approved) & $DBIEReqd_b) & <>INSP_AreaEng_b)
		ALERT:C41("Inspection for "+$Insp_info_txt+"\rDoes not have "+$Review1_txt+" !!")
		
	: ($AreaReqd_b & ([TIN_Inspections:184]InspApproval:6#BMS Approved) & ([TIN_Inspections:184]InspReview:5=BMS Approved) & <>INSP_AreaEng_b)
		//AE Review
		$sRevType:=$Review2_txt  //"Area Engineer Review "
		vApproveLvl:=2
		
	: ($AreaReqd_b & ([TIN_Inspections:184]InspApproval:6=BMS Approved) & <>INSP_AreaEng_b)
		//AE Review
		G_MyConfirm("You have already approved Inspection for "+$Insp_info_txt+"!\rDo you want to repeat the Review?")
		If (OK=1)
			$sRevType:=$Review2_txt  //"Area Engineer Review "
			vApproveLvl:=2
		End if 
		
	Else 
		ALERT:C41("Cannot Review Inspection "+$Insp_info_txt)
End case 
If (vApproveLvl>0)
	If (ut_LoadRecordInteractive(->[TIN_Inspections:184]))
		vsForward:=Synch_ReturnForward([NTI_TunnelInfo:181]NTI_i6_s:11; [NTI_TunnelInfo:181]NTI_InspResp:73; ""; [TIN_Inspections:184]TeamLeader:11)
		
		$msg:=$sRevType+" Stage for "+$InspTypeDescr+" Inspection "
		$msg:=$msg+<>sCR+"dated : "+String:C10([TIN_Inspections:184]InspDate:3)
		$msg:=$msg+<>sCR+"for  Tunnel Num. : "+[TIN_Inspections:184]NTI_i1_S:1+"?"
		vTextMsg:=$msg
		vbAccept:=0
		vbReject:=0
		vtPrevRevComments:=$Review_txt+" :"+<>sCR+[TIN_Inspections:184]InspReviewComments:17+<>sCR+(15*"-")+<>sCR
		vtPrevRevComments:=vtPrevRevComments+$Review2_txt+" :"+<>sCR+[TIN_Inspections:184]InspApproveComments:16
		
		vtRevComments:=""
		
		C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
		C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
		C_TEXT:C284($Title_txt)
		FORM GET PROPERTIES:C674([Dialogs:21]; "ApproveInsp"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
		$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
		//$tempWin:=Open form window([Dialogs];"ApproveInsp")
		DIALOG:C40([Dialogs:21]; "ApproveInsp")
		CLOSE WINDOW:C154($Win_l)
		Case of 
			: (vApproveLvl=2)  //Final Approval
				Case of 
						
					: (vbAccept=1)
						
						
						InitChangeStack(1)
						[TIN_Inspections:184]InspApproval:6:=BMS Approved  //mark inspection as accepted 
						//[TIN_Inspections]InDepthReview:=INSP_InDepthReview_L
						PushChange(1; ->[TIN_Inspections:184]InspApproval:6)
						//PushChange (1;->[TIN_Inspections]InDepthReview)
						[TIN_Inspections:184]InspApproveDate:18:=Current date:C33(*)
						PushChange(1; ->[TIN_Inspections:184]InspApproveDate:18)
						FlushGrpChgs(1; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[TIN_Inspections:184]NTI_i1_S:1; ->[TIN_Inspections:184]InspectionID:2; 1)
						G_CleanUpInspection  //Clean up the inspection tables.
						
					: (vbReject=1)
						InitChangeStack(1)
						[TIN_Inspections:184]InspApproval:6:=BMS Rejected  //mark inspection as rejected
						[TIN_Inspections:184]InspReview:5:=BMS Not Reviewed  //mark inspection as not reviewed
						If ([TIN_Inspections:184]InspApproveComments:16="")
							[TIN_Inspections:184]InspApproveComments:16:=<>CurrentUser_Name+" - "+String:C10(Current date:C33(*); Internal date short:K1:7)+" : "+vtRevComments  //copy comments
						Else 
							[TIN_Inspections:184]InspApproveComments:16:=[TIN_Inspections:184]InspApproveComments:16+<>sCR+<>sCR+<>CurrentUser_Name+" - "+String:C10(Current date:C33(*); Internal date short:K1:7)+" : "+vtRevComments  //copy comments
						End if 
						[TIN_Inspections:184]Complete:4:=False:C215  //mark inspection as incomplete
						PushChange(1; ->[TIN_Inspections:184]InspApproval:6)
						PushChange(1; ->[TIN_Inspections:184]InspReview:5)
						PushChange(1; ->[TIN_Inspections:184]InspApproveComments:16)
						PushChange(1; ->[TIN_Inspections:184]Complete:4)
						FlushGrpChgs(1; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[TIN_Inspections:184]NTI_i1_S:1; ->[TIN_Inspections:184]InspectionID:2; 1)
				End case 
				SAVE RECORD:C53([TIN_Inspections:184])  // save inspections record
				
			: (vApproveLvl=1)  //DBIE Approval or rejection
				//Above water inspections do data transfer to SIA at a DBIE approval          
				Case of 
					: (vbAccept=1)
						InitChangeStack(1)
						[TIN_Inspections:184]InspReview:5:=BMS Approved  //mark inspection as approved
						//[TIN_Inspections]Complete:=True  //mark inspection as completed
						[TIN_Inspections:184]InspReviewDate:19:=Current date:C33(*)
						PushChange(1; ->[TIN_Inspections:184]InspReviewDate:19)
						PushChange(1; ->[TIN_Inspections:184]InspReview:5)
						//PushChange (1;->[TIN_Inspections]Complete)
						FlushGrpChgs(1; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[TIN_Inspections:184]NTI_i1_S:1; ->[TIN_Inspections:184]InspectionID:2; 1)
						SAVE RECORD:C53([TIN_Inspections:184])  // save inspections record
						
					: (vbReject=1)
						InitChangeStack(1)
						[TIN_Inspections:184]InspReview:5:=BMS Rejected  //mark inspection as rejected
						If ([TIN_Inspections:184]InspReviewComments:17="")
							[TIN_Inspections:184]InspReviewComments:17:=<>CurrentUser_Name+" - "+String:C10(Current date:C33(*); Internal date short:K1:7)+" : "+vtRevComments  //copy comments
						Else 
							[TIN_Inspections:184]InspReviewComments:17:=[TIN_Inspections:184]InspReviewComments:17+<>sCR+<>sCR+<>CurrentUser_Name+" - "+String:C10(Current date:C33(*); Internal date short:K1:7)+" : "+vtRevComments  //copy comments
						End if 
						[TIN_Inspections:184]Complete:4:=False:C215  //mark inspection as incomplete
						PushChange(1; ->[TIN_Inspections:184]InspReview:5)
						PushChange(1; ->[TIN_Inspections:184]InspReviewComments:17)
						PushChange(1; ->[TIN_Inspections:184]Complete:4)
						FlushGrpChgs(1; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[TIN_Inspections:184]NTI_i1_S:1; ->[TIN_Inspections:184]InspectionID:2; 1)
						SAVE RECORD:C53([TIN_Inspections:184])  // save inspections record
				End case 
				
		End case 
		//Send notification for all DBIE reviews OR only Area Eng rejections
		If ((((vbAccept=1) | (vbReject=1)) & (vApproveLvl=1)) | ((vApproveLvl=2) & (vbReject=1)))
			Mail_SendTINRevuNotif
		End if 
		
	End if 
	
End if 

$prevINSPDBIE_b:=<>INSP_DBIE_b
$prevAreaEng_b:=<>INSP_AreaEng_b

//End NTI_DoReviewInspection