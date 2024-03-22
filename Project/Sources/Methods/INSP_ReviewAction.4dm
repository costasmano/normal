//%attributes = {"invisible":true}
// Method: INSP_ReviewAction
// Description
//  ` Action on clicking the approve button
//
// Parameters
// ----------------------------------------------------

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/07/11, 09:58:42
	// ----------------------------------------------------
	
	Mods_2011_10
	// Modified by: costasmanousakis-(Designer)-(10/17/11 12:46:48)
	Mods_2011_10  //Copied to Server on : 10/17/11, 12:46:53
	//  `Added code to do the review actions
	//  `Send emails all the time - not just dbie review and to everybody.
	// Modified by: costasmanousakis-(Designer)-(12/6/11 09:08:56)
	Mods_2011_12
	//  ` Do not send email if it is a final approval
	// Modified by: Costas Manousakis-(Designer)-(1/31/12 11:11:42)
	Mods_2012_01
	//  `Added use of the [Inspections]InDepthReview field for final approval only.
	// Modified by: Costas Manousakis-(Designer)-(4/10/12 13:00:59)
	Mods_2012_04
	//  `Force InspComplete = TRUE when DBIE approves an inspection. to avoid crossing of information intransfers
	// Modified by: Costas Manousakis-(Designer)-(5/14/12 14:49:44)
	Mods_2012_05
	//  `Removed the 'blanking' of the review history upon final approval.
	Mods_2013_03  //r001 ` Change alerts and messages for MBTA based upon group
	//Modified by: Charles Miller (3/12/13 10:53:09)
	// Modified by: Costas Manousakis-(Designer)-(5/15/13 15:29:00)
	Mods_2013_05
	//  `Save the current status of ◊INSP_DBIE_b and ◊INSP_AreaEng_b because it gets set by INSP_GetReviewRules
	// Modified by: Costas Manousakis-(Designer)-(1/15/15 17:36:43)
	Mods_2015_01
	//  `remove version checks - now all is effective
	// Modified by: Costas Manousakis-(Designer)-(4/2/21 14:07:42)
	Mods_2021_04
	//  `Added a check for duplicate inspection reports.
	// Modified by: Costas Manousakis-(Designer)-(4/23/21 17:59:10)
	Mods_2021_04
	//  `added inspection type to the check for dupl insp reports
	// Modified by: Costas Manousakis-(Designer)-(2021-10-25T00:00:00 14:41:05)
	Mods_2021_10
	//  `added Current user, current machine owner and current machine in message
	//  `call INSP_QCSaveApprovalInfo to save the e-sig when approving
	// Modified by: Costas Manousakis-(Designer)-(2022-03-17T00:00:00 16:17:40)
	Mods_2022_03
	//  `added call to Synch_ReturnForward to set the Forward destination in Activity log
	// Modified by: Costas Manousakis-(Designer)-(2023-06-08 12:39:38)
	Mods_2023_06_bug
	//  `correct the case statement to account for more combinations of review status and user approval role(s)
	//  ` ie. allow area engineers to re-review a DBIE review if they are also a DBIE role
	// Modified by: Costas Manousakis-(Designer)-(2023-06-30 13:36:07)
	Mods_2023_06_bug
	//  `fixed error when area engineer is given choise to do a DBIE or an Area review. The action was the opposite of the user choice
End if 

C_BOOLEAN:C305($AreaReqd_b; $DBIEReqd_b; $FixedHeight_b; $FixedWidth_b; $prevAreaEng_b; $prevINSPDBIE_b)
C_DATE:C307($inspdate_d)
C_LONGINT:C283($currID_L; $FinalStage_L; $Height_l; $loop_L; $Pages_l; $Width_l)
C_LONGINT:C283($Win_l)
C_TEXT:C284($AreaEGroupName_txt; $bin_txt; $CurrUser_txt; $DBIEGroupName_txt; $Insp_info_txt; $msg)
C_TEXT:C284($msg_txt; $Review_txt; $Review1_txt; $Review2_txt; $sRevType; $Title_txt)
C_TEXT:C284($type_txt)
C_OBJECT:C1216($param_o)

ARRAY BOOLEAN:C223($complete_a; 0)
ARRAY LONGINT:C221($approved_a; 0)
ARRAY LONGINT:C221($reviewed_a; 0)

$CurrUser_txt:=<>CurrentUser_Name

If (User in group:C338($CurrUser_txt; "MBTA"))
	$Review_txt:="MBTA QC Review"
	$Review1_txt:="MBTA QC Approval"
	$Review2_txt:="MBTA QA Review"
Else 
	$Review_txt:="DBIE Review"
	$Review1_txt:="DBIE Approval"
	$Review2_txt:="Area Engineer Review"
End if 
C_TEXT:C284(vTextMsg; vtPrevRevComments; vtRevComments)

$Insp_info_txt:=[Bridge MHD NBIS:1]BDEPT:1+"("+[Inspections:27]BIN:1+")  Owner: "+[Bridge MHD NBIS:1]Item8 Owner:208+", Inspection Type: "
QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=[Inspections:27]Insp Type:6)
$Insp_info_txt:=$Insp_info_txt+[Inspection Type:31]Description:2+\
Choose:C955([Inspections:27]InspRtnSpcMemFlag:209; " & Spec.Memb."; "")+\
" ("+[Inspections:27]Insp Type:6+")"+" Date: "+String:C10([Inspections:27]Insp Date:78)+\
" Insp.Resp.: "+[Bridge MHD NBIS:1]InspResp:173

C_LONGINT:C283(vApproveLvl; vbAccept; vbReject; INSP_InDepthReview_L)
vApproveLvl:=0
INSP_InDepthReview_L:=0
$prevINSPDBIE_b:=<>INSP_DBIE_b
$prevAreaEng_b:=<>INSP_AreaEng_b
//check if there is a duplicate inspection
$currID_L:=[Inspections:27]InspID:2
$inspdate_d:=[Inspections:27]Insp Date:78
$bin_txt:=[Inspections:27]BIN:1
$type_txt:=[Inspections:27]Insp Type:6
Begin SQL
	select [Inspections].[InspComplete], [Inspections].[InspReviewed], [Inspections].[InspApproved]
	from [Inspections]
	where
	[Inspections].[Insp Date] = :$inspdate_d
	and [inspections].[bin] = :$bin_txt
	and [Inspections].[Insp Type] =  :$type_txt
	and [Inspections].[InspID] <> :$currID_L
	into : $complete_a , :$reviewed_a , :$approved_a ;
End SQL

Case of 
	: (Size of array:C274($complete_a)>0)
		//duplicate inspection exists!
		For ($loop_L; 1; Size of array:C274($complete_a))
			
			Case of 
				: ([Inspections:27]Insp Type:6="D@")  //dive inspection
					$msg_txt:=$msg_txt+String:C10($loop_L)+" - Complete :"+Choose:C955($complete_a{$loop_L}; "Y"; "N")+\
						" , UWOE Review :"+Choose:C955($approved_a{$loop_L}; " "; "Rejected"; "Approved")+Char:C90(13)
				: ([Inspections:27]Insp Type:6="FRZ")  //freeze thaw inspection
					$msg_txt:=$msg_txt+String:C10($loop_L)+" - Complete :"+Choose:C955($complete_a{$loop_L}; "Y"; "N")+\
						" , DBIE Review :"+Choose:C955($reviewed_a{$loop_L}; " "; "Rejected"; "Approved")+Char:C90(13)
				Else 
					$msg_txt:=$msg_txt+String:C10($loop_L)+" - Complete :"+Choose:C955($complete_a{$loop_L}; "Y"; "N")+\
						" , DBIE Review :"+Choose:C955($reviewed_a{$loop_L}; " "; "Rejected"; "Approved")+\
						" , Area Review :"+Choose:C955($approved_a{$loop_L}; " "; "Rejected"; "Approved")+Char:C90(13)
			End case 
			
		End for 
		READ ONLY:C145([Inspection Type:31])
		QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=[Inspections:27]Insp Type:6)
		ALERT:C41("There were other inspections found for BIN "+[Inspections:27]BIN:1\
			+" with the same date ("+String:C10([Inspections:27]Insp Date:78)\
			+") and type ("+[Inspection Type:31]Description:2\
			+Choose:C955([Inspections:27]InspRtnSpcMemFlag:209; " & Spec.Memb."; "")+") as the current inspection."+Char:C90(13)\
			+"This must be resolved before proceeding with the review of the current inspection!"+Char:C90(13)\
			+"The current status of these inspections is"+Char:C90(13)+$msg_txt)
		
	: (Not:C34([Inspections:27]InspComplete:168))
		ALERT:C41("Inspection "+$Insp_info_txt+" Not Complete Yet!")
		
	: (Not:C34(INSP_GetReviewRules([Bridge MHD NBIS:1]Item8 Owner:208; [Inspections:27]Insp Type:6; \
		->$DBIEReqd_b; ->$AreaReqd_b; ->$FinalStage_L; \
		[Bridge MHD NBIS:1]InspResp:173; ->$DBIEGroupName_txt; ->$AreaEGroupName_txt; \
		[Inspections:27]DBrInspEngr:3)))
		ALERT:C41("Error getting Review rules for this inspection "+$Insp_info_txt+"!")
		
	: (([Inspections:27]Insp Type:6="DV@") & Not:C34(<>INSP_UOEng_b))
		ALERT:C41("You are not the Underwater Operations Engineer for Inspection "+$Insp_info_txt)
		
	: (([Inspections:27]Insp Type:6="DV@") & <>INSP_UOEng_b)
		//Dive inspection review
		If ([Inspections:27]InspApproved:167#BMS Approved)
			$sRevType:="UW Engineer Review "
			vApproveLvl:=2
		Else 
			CONFIRM:C162("You have already approved Inspection "+$Insp_info_txt+"! Do you want to repeat the Review?")
			If (OK=1)
				$sRevType:="UW Engineer Review "
				vApproveLvl:=2
			End if 
			
		End if 
		
	: ($DBIEReqd_b & ([Inspections:27]InspReviewed:12#BMS Approved) & \
		<>INSP_DBIE_b & ($FinalStage_L>0))
		//DBIE Review
		
		If (False:C215)
			If (INSP_ReviewerAllowed_b($DBIEGroupName_txt; [Inspections:27]DBrInspEngr:3))
				$sRevType:=$Review_txt  //DBIE Review "
				vApproveLvl:=1
			Else 
				ALERT:C41("You, "+<>CurrentUser_Name+", are not allowed to do a "+$Review_txt+" for "+$Insp_info_txt+" !!")
			End if 
		Else 
			$sRevType:=$Review_txt  //DBIE Review "
			vApproveLvl:=1
		End if 
		
	: ($DBIEReqd_b & ([Inspections:27]InspReviewed:12=BMS Approved) & \
		<>INSP_DBIE_b & (Not:C34(<>INSP_AreaEng_b)) & \
		($FinalStage_L>0) & \
		([Inspections:27]InspApproved:167#BMS Approved))
		//has been approved by DBIE - and DBIE (not Area) - can repeat the review \
			 before it is approved by AreaEngineer.
		If (False:C215)
			If (INSP_ReviewerAllowed_b($DBIEGroupName_txt; [Inspections:27]DBrInspEngr:3))
				CONFIRM:C162("You have already approved Inspection "+$Insp_info_txt+"! Do you want to repeat the Review?")
				If (OK=1)
					$sRevType:=$Review_txt  //DBIE Review "
					vApproveLvl:=1
				End if 
				
			Else 
				ALERT:C41("You, "+<>CurrentUser_Name+", are not allowed to do a "+$Review_txt+" for "+$Insp_info_txt+" !!")
			End if 
		Else 
			
			CONFIRM:C162("Inspection "+$Insp_info_txt+" has already been approved! Do you want to repeat the Review?")
			If (OK=1)
				$sRevType:=$Review_txt  //DBIE Review "
				vApproveLvl:=1
			End if 
			
		End if 
		
	: ($DBIEReqd_b & ([Inspections:27]InspReviewed:12=BMS Approved) & \
		([Inspections:27]InspApproved:167#BMS Approved) & \
		<>INSP_DBIE_b & <>INSP_AreaEng_b & \
		($FinalStage_L>0)\
		)
		//inspection has been approved by DBIE and NOT by Area Engineer \
			- user is a DBIE and Area engineer\
			- user can choose whether to do a DBIE review again, or do an Area review
		CONFIRM:C162("Do you wish to repeat the "+$Review_txt+" or, do a "+$Review2_txt; $Review2_txt; $Review_txt)
		If (OK#1)
			//repeat dBIE review
			$sRevType:=$Review_txt  //DBIE Review "
			vApproveLvl:=1
		Else 
			// do Area review
			$sRevType:=$Review2_txt  //"Area Engineer Review"
			vApproveLvl:=2
		End if 
		
	: ($AreaReqd_b & ([Inspections:27]InspApproved:167#BMS Approved) & \
		(([Inspections:27]InspReviewed:12#BMS Approved) & $DBIEReqd_b) & \
		<>INSP_AreaEng_b & ($FinalStage_L>1))
		// inspection requires area review - \
			has not been approved yet, \
			 requires DBIE review but is not approved by DBIE - Cannot review
		If (False:C215)
			If (INSP_ReviewerAllowed_b($AreaEGroupName_txt))
				ALERT:C41("Inspection "+$Insp_info_txt+" Does not have "+$Review1_txt+" !!")
				
			Else 
				ALERT:C41("You, "+<>CurrentUser_Name+", are not allowed to do an "+$Review2_txt+" for "+$Insp_info_txt+" !!")
			End if 
		Else 
			ALERT:C41("Inspection "+$Insp_info_txt+" Does not have "+$Review1_txt+" !!")
		End if 
		
	: ($AreaReqd_b & ([Inspections:27]InspApproved:167#BMS Approved) & \
		(([Inspections:27]InspReviewed:12=BMS Approved) | Not:C34($DBIEReqd_b)) & \
		<>INSP_AreaEng_b & ($FinalStage_L>1))
		//Insp has been approved by DBIE or DBIE review is not required,
		//   user can do an Area Eng Review
		If (False:C215)
			
			If (INSP_ReviewerAllowed_b($AreaEGroupName_txt))
				$sRevType:=$Review2_txt  //"Area Engineer Review"
				vApproveLvl:=2
			Else 
				ALERT:C41("You, "+<>CurrentUser_Name+", are not allowed to do an "+$Review2_txt+" for "+$Insp_info_txt+" !!")
			End if 
		Else 
			$sRevType:=$Review2_txt  //"Area Engineer Review"
			vApproveLvl:=2
			
		End if 
		
	: ($AreaReqd_b & ([Inspections:27]InspApproved:167=BMS Approved) & \
		<>INSP_AreaEng_b & ($FinalStage_L>1))
		//Inspection has been approved, user is an area engineer for the inspection \
			  then could repeat the review
		
		If (False:C215)
			If (INSP_ReviewerAllowed_b($AreaEGroupName_txt))
				CONFIRM:C162("You have already approved Inspection "+$Insp_info_txt+"! Do you want to repeat the Review?")
				If (OK=1)
					$sRevType:=$Review2_txt  //"Area Engineer Review "
					vApproveLvl:=2
				End if 
				
			Else 
				ALERT:C41("You, "+<>CurrentUser_Name+", are not allowed to do an "+$Review2_txt+" for "+$Insp_info_txt+" !!")
			End if 
			
		Else 
			
			CONFIRM:C162("You have already approved Inspection "+$Insp_info_txt+"! Do you want to repeat the Review?")
			If (OK=1)
				$sRevType:=$Review2_txt  //"Area Engineer Review "
				vApproveLvl:=2
			End if 
			
		End if 
		
	Else 
		ALERT:C41("Cannot Review Inspection "+$Insp_info_txt+"\n"+\
			"Current Review status : "+$Review_txt+" : "+Choose:C955([Inspections:27]InspReviewed:12; "-"; "Reject"; "Approve")+" , "+\
			$Review2_txt+" : "+Choose:C955([Inspections:27]InspApproved:167; "-"; "Reject"; "Approve")+"\n"+\
			"Requires "+$Review_txt+" : "+Choose:C955($DBIEReqd_b; "Yes"; "No")+\
			" , Requires "+$Review2_txt+" : "+Choose:C955($AreaReqd_b; "Yes"; "No")+\
			"\nYour current roles for this report : \n"+\
			$Review_txt+" : "+Choose:C955(<>INSP_DBIE_b; "Allowed"; "Not Allowed")+" , "+\
			$Review2_txt+" : "+Choose:C955(<>INSP_AreaEng_b; "Allowed"; "Not Allowed"))
		
End case 

If (vApproveLvl>0)
	If (ut_LoadRecordInteractive(->[Inspections:27]))
		vsForward:=Synch_ReturnForward([Bridge MHD NBIS:1]Item2:60; [Bridge MHD NBIS:1]InspResp:173; [Inspections:27]Insp Type:6; [Inspections:27]TeamLeader:4)
		
		$msg:=$sRevType+" Stage for "+[Inspection Type:31]Description:2+" Inspection "
		$msg:=$msg+<>sCR+"dated : "+String:C10([Inspections:27]Insp Date:78)
		$msg:=$msg+<>sCR+"for  BIN : "+[Inspections:27]BIN:1+"?"
		vTextMsg:=INSP_QCAddNoticeToMsg($msg)
		vbAccept:=0
		vbReject:=0
		vtPrevRevComments:=$Review_txt+" :"+<>sCR+[Inspections:27]InspRevCmts:170+<>sCR+(15*"-")+<>sCR
		vtPrevRevComments:=vtPrevRevComments+$Review2_txt+" :"+<>sCR+[Inspections:27]InspApprCmts:169
		
		vtRevComments:=""
		
		FORM GET PROPERTIES:C674([Dialogs:21]; "ApproveInsp"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
		$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
		//$tempWin:=Open form window([Dialogs];"ApproveInsp")
		DIALOG:C40([Dialogs:21]; "ApproveInsp")
		CLOSE WINDOW:C154($Win_l)
		Case of 
			: (vApproveLvl=2)  //Final Approval
				Case of 
						
					: (vbAccept=1)
						
						Case of 
							: ([Inspections:27]Insp Type:6="DV@")  //Dive  Inspection
								INSP_DiveDates2SIA
							: (Not:C34($DBIEReqd_b))
								INSP_InspData2SIA
						End case 
						
						InitChangeStack(1)
						If ([Inspections:27]InspAIEReviewDate:223=!00-00-00!)
							[Inspections:27]InspAIEReviewDate:223:=Current date:C33(*)
							PushChange(1; ->[Inspections:27]InspAIEReviewDate:223)
						End if 
						[Inspections:27]InspApproved:167:=BMS Approved  //mark inspection as accepted
						[Inspections:27]InDepthReview:5:=INSP_InDepthReview_L
						PushChange(1; ->[Inspections:27]InspApproved:167)
						PushChange(1; ->[Inspections:27]InDepthReview:5)
						[Inspections:27]InspAreaEngApprDate:207:=Current date:C33(*)
						PushChange(1; ->[Inspections:27]InspAreaEngApprDate:207)
						
						OB SET:C1220($param_o; "type"; "ae"; "fieldptr"; ->[Inspections:27]RatingFeedBack:203; "stack"; 1)
						INSP_QCSaveApprovalInfo($param_o)
						
						//[Inspections]InspApprCmts:=""  `remove comments from review fields
						//[Inspections]InspRevCmts:=""
						//PushChange (1;->[Inspections]InspRevCmts)
						//PushChange (1;->[Inspections]InspApprCmts)
						FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
						G_CleanUpInspection  //Clean up the inspection tables.
						
					: (vbReject=1)
						InitChangeStack(1)
						If ([Inspections:27]InspAIEReviewDate:223=!00-00-00!)
							[Inspections:27]InspAIEReviewDate:223:=Current date:C33(*)
							PushChange(1; ->[Inspections:27]InspAIEReviewDate:223)
						End if 
						[Inspections:27]InspApproved:167:=BMS Rejected  //mark inspection as rejected
						[Inspections:27]InspReviewed:12:=BMS Not Reviewed  //mark inspection as not reviewed
						If ([Inspections:27]InspApprCmts:169="")
							[Inspections:27]InspApprCmts:169:=<>CurrentUser_Name+" - "+String:C10(Current date:C33(*); Internal date short:K1:7)+" : "+vtRevComments  //copy comments
						Else 
							[Inspections:27]InspApprCmts:169:=[Inspections:27]InspApprCmts:169+<>sCR+<>sCR+<>CurrentUser_Name+" - "+String:C10(Current date:C33(*); Internal date short:K1:7)+" : "+vtRevComments  //copy comments
						End if 
						[Inspections:27]InspComplete:168:=False:C215  //mark inspection as incomplete
						PushChange(1; ->[Inspections:27]InspApproved:167)
						PushChange(1; ->[Inspections:27]InspReviewed:12)
						PushChange(1; ->[Inspections:27]InspApprCmts:169)
						PushChange(1; ->[Inspections:27]InspComplete:168)
						FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
				End case 
				SAVE RECORD:C53([Inspections:27])  // save inspections record
				
			: (vApproveLvl=1)  //DBIE Approval or rejection
				//Above water inspections do data transfer to SIA at a DBIE approval
				Case of 
					: (vbAccept=1)
						INSP_InspData2SIA
						InitChangeStack(1)
						If ([Inspections:27]InspDBIEReviewDate:222=!00-00-00!)  //first time any review is done
							[Inspections:27]InspDBIEReviewDate:222:=Current date:C33(*)
							PushChange(1; ->[Inspections:27]InspDBIEReviewDate:222)
						End if 
						[Inspections:27]InspReviewed:12:=BMS Approved  //mark inspection as approved
						[Inspections:27]InspComplete:168:=True:C214  //mark inspection as completed
						[Inspections:27]InspDBIEApprDate:206:=Current date:C33(*)
						PushChange(1; ->[Inspections:27]InspDBIEApprDate:206)
						If ([Inspections:27]InspDBIE1stApprDate:225=!00-00-00!)  //first time it was approved
							[Inspections:27]InspDBIE1stApprDate:225:=Current date:C33(*)
							PushChange(1; ->[Inspections:27]InspDBIE1stApprDate:225)
						End if 
						PushChange(1; ->[Inspections:27]InspReviewed:12)
						PushChange(1; ->[Inspections:27]InspComplete:168)
						OB SET:C1220($param_o; "type"; "dbie"; "fieldptr"; ->[Inspections:27]RatingFeedBack:203; "stack"; 1)
						INSP_QCSaveApprovalInfo($param_o)
						FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
						SAVE RECORD:C53([Inspections:27])
						
					: (vbReject=1)
						InitChangeStack(1)
						If ([Inspections:27]InspDBIEReviewDate:222=!00-00-00!)  //first time any review is done
							[Inspections:27]InspDBIEReviewDate:222:=Current date:C33(*)
							PushChange(1; ->[Inspections:27]InspDBIEReviewDate:222)
						End if 
						[Inspections:27]InspReviewed:12:=BMS Rejected  //mark inspection as rejected
						If ([Inspections:27]InspRevCmts:170="")
							[Inspections:27]InspRevCmts:170:=<>CurrentUser_Name+" - "+String:C10(Current date:C33(*); Internal date short:K1:7)+" : "+vtRevComments  //copy comments
						Else 
							[Inspections:27]InspRevCmts:170:=[Inspections:27]InspRevCmts:170+<>sCR+<>sCR+<>CurrentUser_Name+" - "+String:C10(Current date:C33(*); Internal date short:K1:7)+" : "+vtRevComments  //copy comments
						End if 
						[Inspections:27]InspComplete:168:=False:C215  //mark inspection as incomplete
						PushChange(1; ->[Inspections:27]InspReviewed:12)
						PushChange(1; ->[Inspections:27]InspRevCmts:170)
						PushChange(1; ->[Inspections:27]InspComplete:168)
						FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
						SAVE RECORD:C53([Inspections:27])
				End case 
				
		End case 
		//Send notification for all DBIE reviews OR only Area Eng rejections
		If ((((vbAccept=1) | (vbReject=1)) & (vApproveLvl=1)) | ((vApproveLvl=2) & (vbReject=1)))
			Mail_SendInspRevuNotif
		End if 
		
	End if 
	
End if 

$prevINSPDBIE_b:=<>INSP_DBIE_b
$prevAreaEng_b:=<>INSP_AreaEng_b