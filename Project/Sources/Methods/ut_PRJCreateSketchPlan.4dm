//%attributes = {"invisible":true}
// ----------------------------------------------------
//ut_PRJCreateSketchPlan
// User name (OS): cjmiller
// Date and time: 04/28/06, 14:58:11
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJMv2  //05/09/07, 10:54:36`Add reviewer id
	// Modified by: costasmanousakis-(Designer)-(5/23/08 12:01:28)
	Mods_2008_CM_5403  //use param $5 instead of PRJ_utReviewerID_L
	Mods_2011_06  // CJ Miller`06/14/11, 13:37:40      ` Fix bug where wrong variable $HydroReport_txt used replaced with $SketchPlanReview_txt
End if 
C_TEXT:C284($1; $2; $3; $4; $SketchPlan_txt; $SketchPlanReview_txt; $SketchPlanSigned_txt; $SketchPlanResponse_txt)
C_LONGINT:C283($5; $PRJ_utReviewerID_L)
$SketchPlan_txt:=$1
$SketchPlanReview_txt:=$2
$SketchPlanSigned_txt:=$3
$SketchPlanResponse_txt:=$4
$PRJ_utReviewerID_L:=$5
CREATE RECORD:C68([PRJ_SketchPlans:120])
[PRJ_SketchPlans:120]SKT_SubmissionNumber_l:3:=1
[PRJ_SketchPlans:120]PRJ_ProjectID_l:1:=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1
[PRJ_SketchPlans:120]SKT_Comments_txt:4:=""
[PRJ_SketchPlans:120]RV_ReviewID_l:2:=$PRJ_utReviewerID_L
If ($SketchPlan_txt#"")
	[PRJ_SketchPlans:120]SKT_Comments_txt:4:="Received Comments"+Char:C90(13)+$SketchPlan_txt+Char:C90(13)
	//lets take care of received column which is $SketchPlan_txt
	C_BLOB:C604($Blob_blb)
	SET BLOB SIZE:C606($Blob_blb; 0)
	$Blob_blb:=ut_PRJParseTextToArray($SketchPlan_txt)
	ARRAY TEXT:C222($ParsedText_atxt; 0)
	BLOB TO VARIABLE:C533($Blob_blb; $ParsedText_atxt)
	C_DATE:C307($Test_d; $Oldest_d)
	C_TEXT:C284($StringDate_s)  // Command Replaced was o_C_STRING length was 10
	C_LONGINT:C283($Loop_l)
	For ($Loop_l; 1; Size of array:C274($ParsedText_atxt))
		$StringDate_s:=$ParsedText_atxt{$Loop_l}
		$Test_d:=Date:C102($StringDate_s)
		If ((String:C10($Test_d; 4)=$StringDate_s) | (String:C10($Test_d)=$StringDate_s))
			If ($Test_d>[PRJ_SketchPlans:120]SKT_Recieved_d:5)
				[PRJ_SketchPlans:120]SKT_Recieved_d:5:=$Test_d
			End if 
		End if 
	End for 
End if 
If ($SketchPlanReview_txt#"")
	[PRJ_SketchPlans:120]SKT_Comments_txt:4:=[PRJ_SketchPlans:120]SKT_Comments_txt:4+Char:C90(13)+"Review Comments"+Char:C90(13)+$SketchPlanReview_txt+Char:C90(13)
	C_BLOB:C604($Blob_blb)
	SET BLOB SIZE:C606($Blob_blb; 0)
	$Blob_blb:=ut_PRJParseTextToArray($SketchPlanReview_txt)  //$HydroReport_txt)
	ARRAY TEXT:C222($ParsedText_atxt; 0)
	BLOB TO VARIABLE:C533($Blob_blb; $ParsedText_atxt)
	C_DATE:C307($Test_d)
	C_TEXT:C284($StringDate_s)  // Command Replaced was o_C_STRING length was 10
	If (Size of array:C274($ParsedText_atxt)=1)
		$StringDate_s:=$ParsedText_atxt{1}
		$Test_d:=Date:C102($StringDate_s)
		If (String:C10($Test_d; 4)=$StringDate_s) | (String:C10($Test_d)=$StringDate_s)
			[PRJ_SketchPlans:120]SKT_CommentsToDE_d:11:=$Test_d
		End if 
		
	Else 
		C_BOOLEAN:C305($Complete_b)
		$Complete_b:=False:C215
		
		Repeat 
			Case of 
				: (Size of array:C274($ParsedText_atxt)>1)
					Case of 
						: (Position:C15("Geo"; $ParsedText_atxt{1})>0)
							If ($ParsedText_atxt{2}="OK")
								DELETE FROM ARRAY:C228($ParsedText_atxt; 2; 1)
							End if 
							If (Size of array:C274($ParsedText_atxt)>=2)
								$StringDate_s:=$ParsedText_atxt{2}
								$Test_d:=Date:C102($StringDate_s)
								DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)
								If (String:C10($Test_d; 4)=$StringDate_s) | (String:C10($Test_d)=$StringDate_s) | (String:C10($Test_d)=$StringDate_s)  //we have an approval
									[PRJ_SketchPlans:120]SKT_ReceivedFromGeotech_d:9:=$Test_d
									DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)
								End if 
							End if 
						: (Position:C15("Hyd"; $ParsedText_atxt{1})>0)
							If ($ParsedText_atxt{2}="OK")
								DELETE FROM ARRAY:C228($ParsedText_atxt; 2; 1)
							End if 
							If (Size of array:C274($ParsedText_atxt)>=2)
								$StringDate_s:=$ParsedText_atxt{2}
								$Test_d:=Date:C102($StringDate_s)
								DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)
								If (String:C10($Test_d; 4)=$StringDate_s) | (String:C10($Test_d)=$StringDate_s) | (String:C10($Test_d)=$StringDate_s)  //we have an approval
									[PRJ_SketchPlans:120]SKT_ReceivedFromHydro_d:10:=$Test_d
									DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)
								End if 
							End if 
						Else 
							DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)
							
					End case 
					
					
			End case 
			If (Size of array:C274($ParsedText_atxt)<=1)
				$Complete_b:=True:C214
			End if 
		Until ($Complete_b)
	End if 
End if 


If ($SketchPlanSigned_txt#"")
	[PRJ_SketchPlans:120]SKT_Comments_txt:4:=[PRJ_SketchPlans:120]SKT_Comments_txt:4+Char:C90(13)+"Signed Comments"+Char:C90(13)+$SketchPlanSigned_txt+Char:C90(13)
	C_BLOB:C604($Blob_blb)
	SET BLOB SIZE:C606($Blob_blb; 0)
	$Blob_blb:=ut_PRJParseTextToArray($SketchPlanSigned_txt)
	ARRAY TEXT:C222($ParsedText_atxt; 0)
	BLOB TO VARIABLE:C533($Blob_blb; $ParsedText_atxt)
	C_DATE:C307($Test_d; $Oldest_d)
	C_TEXT:C284($StringDate_s)  // Command Replaced was o_C_STRING length was 10
	C_LONGINT:C283($Loop_l)
	For ($Loop_l; 1; Size of array:C274($ParsedText_atxt))
		$StringDate_s:=$ParsedText_atxt{$Loop_l}
		$Test_d:=Date:C102($StringDate_s)
		If ((String:C10($Test_d; 4)=$StringDate_s) | (String:C10($Test_d)=$StringDate_s))
			If ($Test_d>[PRJ_SketchPlans:120]SKT_ChiefEngApproval_d:13)
				[PRJ_SketchPlans:120]SKT_ChiefEngApproval_d:13:=$Test_d
			End if 
		End if 
	End for 
	
	
End if 
If ($SketchPlanResponse_txt#"")
	[PRJ_SketchPlans:120]SKT_Comments_txt:4:=[PRJ_SketchPlans:120]SKT_Comments_txt:4+Char:C90(13)+"Response Comments"+Char:C90(13)+$SketchPlanResponse_txt+Char:C90(13)
	C_BLOB:C604($Blob_blb)
	SET BLOB SIZE:C606($Blob_blb; 0)
	$Blob_blb:=ut_PRJParseTextToArray($SketchPlanSigned_txt)
	ARRAY TEXT:C222($ParsedText_atxt; 0)
	BLOB TO VARIABLE:C533($Blob_blb; $ParsedText_atxt)
	C_DATE:C307($Test_d; $Oldest_d)
	C_TEXT:C284($StringDate_s)  // Command Replaced was o_C_STRING length was 10
	C_LONGINT:C283($Loop_l)
	For ($Loop_l; 1; Size of array:C274($ParsedText_atxt))
		$StringDate_s:=$ParsedText_atxt{$Loop_l}
		$Test_d:=Date:C102($StringDate_s)
		If ((String:C10($Test_d; 4)=$StringDate_s) | (String:C10($Test_d)=$StringDate_s))
			If ($Test_d>[PRJ_SketchPlans:120]SKT_CommentsToDE_d:11)
				[PRJ_SketchPlans:120]SKT_CommentsToDE_d:11:=$Test_d
			End if 
		End if 
	End for 
	
End if 

SAVE RECORD:C53([PRJ_SketchPlans:120])
UNLOAD RECORD:C212([PRJ_SketchPlans:120])

//End method ut_PRJCreateSketchPlan