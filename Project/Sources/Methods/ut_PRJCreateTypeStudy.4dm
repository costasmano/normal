//%attributes = {"invisible":true}
// ----------------------------------------------------
//ut_PRJCreateTypeStudy
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
	Mods_2007_CJM_v5302  //r001 `10/02/07, 10:58:31
	// Modified by: costasmanousakis-(Designer)-(5/23/08 12:01:28)
	Mods_2008_CM_5403  //use param $5 instead of PRJ_utReviewerID_L
End if 
C_TEXT:C284($1; $2; $TypeStudy_txt; $TypeStudyApprovedType_txt)
C_LONGINT:C283($3; $PRJ_utReviewerID_L)
$TypeStudy_txt:=$1
$TypeStudyApprovedType_txt:=$2
$PRJ_utReviewerID_L:=$3
CREATE RECORD:C68([PRJ_TypeStudy:121])
[PRJ_TypeStudy:121]PRJ_ProjectID_l:1:=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1
[PRJ_TypeStudy:121]TYP_Comments_txt:12:=$TypeStudy_txt+Char:C90(13)+$TypeStudyApprovedType_txt+Char:C90(13)
[PRJ_TypeStudy:121]RV_ReviewID_l:2:=$PRJ_utReviewerID_L
C_BLOB:C604($Blob_blb)
SET BLOB SIZE:C606($Blob_blb; 0)
$Blob_blb:=ut_PRJParseTextToArray($TypeStudy_txt)
ARRAY TEXT:C222($ParsedText_atxt; 0)
BLOB TO VARIABLE:C533($Blob_blb; $ParsedText_atxt)
C_DATE:C307($Test_d)
C_TEXT:C284($StringDate_s)  // Command Replaced was o_C_STRING length was 10
If (Size of array:C274($ParsedText_atxt)=1)
	$StringDate_s:=$ParsedText_atxt{1}
	$Test_d:=Date:C102($StringDate_s)
	If (String:C10($Test_d; 4)=$StringDate_s) | (String:C10($Test_d)=$StringDate_s)  //we have an approval
		[PRJ_TypeStudy:121]TYP_Received_d:5:=$Test_d
	End if 
	
Else 
	C_BOOLEAN:C305($Complete_b)
	$Complete_b:=False:C215
	Repeat 
		Case of 
			: (Size of array:C274($ParsedText_atxt)>1)
				$StringDate_s:=$ParsedText_atxt{1}
				$Test_d:=Date:C102($StringDate_s)
				
				Case of 
					: ((String:C10($Test_d; 4)=$StringDate_s) | (String:C10($Test_d)=$StringDate_s))
						DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)
						[PRJ_TypeStudy:121]TYP_Received_d:5:=$Test_d
					: (Position:C15("Approved"; $ParsedText_atxt{1})>0)
						$StringDate_s:=$ParsedText_atxt{2}
						$Test_d:=Date:C102($StringDate_s)
						DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)
						If (String:C10($Test_d; 4)=$StringDate_s) | (String:C10($Test_d)=$StringDate_s) | (String:C10($Test_d)=$StringDate_s)  //we have an approval
							[PRJ_TypeStudy:121]TYP_Approved_d:10:=$Test_d
							DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)
						End if 
					: (Position:C15("OK"; $ParsedText_atxt{1})>0)
						$StringDate_s:=$ParsedText_atxt{2}
						$Test_d:=Date:C102($StringDate_s)
						DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)
						If (String:C10($Test_d; 4)=$StringDate_s) | (String:C10($Test_d)=$StringDate_s)  //we have an approval
							[PRJ_TypeStudy:121]TYP_Approved_d:10:=$Test_d
							DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)
						End if 
					: (Position:C15("received"; $ParsedText_atxt{1})>0)
						$StringDate_s:=$ParsedText_atxt{2}
						$Test_d:=Date:C102($StringDate_s)
						DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)
						If (String:C10($Test_d; 4)=$StringDate_s) | (String:C10($Test_d)=$StringDate_s)  //we have an approval
							[PRJ_TypeStudy:121]TYP_Received_d:5:=$Test_d
							DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)
						End if 
						
					: (Position:C15("comm"; $ParsedText_atxt{1})>0)
						$StringDate_s:=$ParsedText_atxt{2}
						$Test_d:=Date:C102($StringDate_s)
						DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)
						If (String:C10($Test_d; 4)=$StringDate_s) | (String:C10($Test_d)=$StringDate_s)  //we have an approval
							[PRJ_TypeStudy:121]TYP_CommentsToDE_d:11:=$Test_d
							DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)
						End if 
					: (Position:C15("PF/PE"; $ParsedText_atxt{1})>0)
						[PRJ_TypeStudy:121]TYP_Source_s:6:=$ParsedText_atxt{1}
						DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)
						
					Else 
						DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)
						
				End case 
				
		End case 
		If (Size of array:C274($ParsedText_atxt)<=1)
			$Complete_b:=True:C214
		End if 
	Until ($Complete_b)
End if 

SAVE RECORD:C53([PRJ_TypeStudy:121])
UNLOAD RECORD:C212([PRJ_TypeStudy:121])

//End Method ut_PRJCreateTypeStudy