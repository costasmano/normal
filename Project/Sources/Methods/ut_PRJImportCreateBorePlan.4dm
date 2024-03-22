//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJImportCreateBorePlan
// User name (OS): cjmiller
// Date and time: 06/01/06, 15:23:18
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 
//$1 text to be parsed
//$2 report record type
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 
C_TEXT:C284($1; $2; $BorePlanReport_txt; $ReportType_txt)
$BorePlanReport_txt:=$1
$ReportType_txt:=$2
CREATE RECORD:C68([PRJ_ReportData:118])
[PRJ_ReportData:118]PRJ_ProjectID_l:1:=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1
[PRJ_ReportData:118]RPT_Comments_txt:6:=$BorePlanReport_txt
[PRJ_ReportData:118]RPT_ReportType_s:2:=$ReportType_txt
C_BLOB:C604($Blob_blb)
SET BLOB SIZE:C606($Blob_blb; 0)
$Blob_blb:=ut_PRJParseTextToArray($BorePlanReport_txt)
ARRAY TEXT:C222($ParsedText_atxt; 0)
BLOB TO VARIABLE:C533($Blob_blb; $ParsedText_atxt)
C_DATE:C307($Test_d)
C_TEXT:C284($StringDate_s)  // Command Replaced was o_C_STRING length was 10
DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)

If (Size of array:C274($ParsedText_atxt)=1)
	//ADD N.H. as source
	$StringDate_s:=$ParsedText_atxt{1}
	$Test_d:=Date:C102($StringDate_s)
	If (String:C10($Test_d; 4)=$StringDate_s) | (String:C10($Test_d)=$StringDate_s)  //we have an approval
		[PRJ_ReportData:118]RPT_Received_d:3:=$Test_d
	End if 
Else 
	C_BOOLEAN:C305($Complete_b)
	$Complete_b:=False:C215
	Repeat 
		Case of 
			: (Size of array:C274($ParsedText_atxt)>1)
				Case of 
					: (Position:C15("OK"; $ParsedText_atxt{1})>0)
						$StringDate_s:=$ParsedText_atxt{2}
						$Test_d:=Date:C102($StringDate_s)
						DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)
						If (String:C10($Test_d; 4)=$StringDate_s) | (String:C10($Test_d)=$StringDate_s)  //we have an approval
							[PRJ_ReportData:118]RPT_Approved_d:4:=$Test_d
							DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)
						End if 
					: (Position:C15("received"; $ParsedText_atxt{1})>0)
						$StringDate_s:=$ParsedText_atxt{2}
						$Test_d:=Date:C102($StringDate_s)
						DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)
						If (String:C10($Test_d; 4)=$StringDate_s) | (String:C10($Test_d)=$StringDate_s)  //we have an received
							[PRJ_ReportData:118]RPT_Received_d:3:=$Test_d
							DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)
						End if 
						
					: (Position:C15("Approved"; $ParsedText_atxt{1})>0)
						$StringDate_s:=$ParsedText_atxt{2}
						$Test_d:=Date:C102($StringDate_s)
						DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)
						If (String:C10($Test_d; 4)=$StringDate_s) | (String:C10($Test_d)=$StringDate_s) | (String:C10($Test_d)=$StringDate_s)  //we have an approval
							[PRJ_ReportData:118]RPT_Approved_d:4:=$Test_d
							DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)
						End if 
						
					Else 
						DELETE FROM ARRAY:C228($ParsedText_atxt; 1; 1)
						
				End case 
				
			: (Size of array:C274($ParsedText_atxt)=1)
				$StringDate_s:=$ParsedText_atxt{1}
				$Test_d:=Date:C102($StringDate_s)
				If (String:C10($Test_d; 4)=$StringDate_s) | (String:C10($Test_d)=$StringDate_s)  //we have an approval
					[PRJ_ReportData:118]RPT_Received_d:3:=$Test_d
				End if 
		End case 
		If (Size of array:C274($ParsedText_atxt)<=1)
			$Complete_b:=True:C214
		End if 
	Until ($Complete_b)
End if 
SAVE RECORD:C53([PRJ_ReportData:118])
UNLOAD RECORD:C212([PRJ_ReportData:118])

//End ut_PRJImportCreateBorePlan