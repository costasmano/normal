//%attributes = {"invisible":true}
//Method: INSP_ReportIncompleteInsp
//Description
// Report on inspections that have not been completed within 60 days of insp date or
// exceeded 90 days. will send emails to team leader/dbie and summary texts to ABIE and BIE.
// code extracted from original version of Server_ReportIncompleteInsp
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/29/18, 09:42:15
	// ----------------------------------------------------
	//Created : 
	Mods_2018_06_bug
	// Modified by: Costas Manousakis-(Designer)-(9/17/18 11:48:17)
	Mods_2018_09_bug
	//  `fixed bug when attempting to add to array $DistrictNotes_atxt data for dive inspection - it should not be done - set $position_L to 0 for dive.
	// Modified by: Costas Manousakis-(Designer)-(2/15/19 11:49:04)
	Mods_2019_02_bug
	//  `changed format of inspection date to internal date short so that the full year is shown. CallReference #604
	//  `also changed template "LateInspectionsBody" to use #4DEVAL string(date;internal date short). CallReference #604
	
	Mods_2019_03_bug  //Fix bug where email sent to wrong person when there was nothing late in dist 1 and 2
	//Modified by: Chuck Miller (3/28/19 17:38:32)
	Mods_2020_05_bug
	//  `use at least 3 chars from the consultant name when searching addresses
	// Modified by: Costas Manousakis-(Designer)-(2022-01-11T00:00:00 18:54:21)
	Mods_2022_01
	//  `use ut_ReturnUserDocFolder to set the folder path - takes into account when running on server
	//  `use parameter "PRODSERVERIP" to get the production server IP
	// Modified by: Costas Manousakis-(Designer)-(2023-12-22 17:39:13)
	Mods_2023_12
	//  `added summary for UW inspections - summary sent to BIE and UWE 
	//  `consider the Acting ID in [pers_groups] if the Primary ID is not defined. Include [Pers_groups][Acting] field
	//  `in the SQL calls
End if 
//
//TRACE
Startup_PL
Compiler_MailUtils
C_BOOLEAN:C305($InTest_B)
C_TEXT:C284($PathToFolder_txt; $InspDate_txt; $SummaryDate_txt)
//$ServerIP_txt:=ut_ReturnServerIP 
$InTest_B:=(ut_ReturnServerIP#ut_GetSysParameter("PRODSERVERIP"; "146.243.135.242"))

$SummaryDate_txt:=String:C10(Year of:C25(Current date:C33); "0000")+String:C10(Month of:C24(Current date:C33); "00")+String:C10(Day of:C23(Current date:C33); "00")

$PathToFolder_txt:=ut_ReturnUserDocFolder
$PathToFolder_txt:=$PathToFolder_txt+"Incomplete Inspections"
If (Test path name:C476($PathToFolder_txt)=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($PathToFolder_txt)
	
End if 

$PathToFolder_txt:=$PathToFolder_txt+Folder separator:K24:12+$SummaryDate_txt
If (Test path name:C476($PathToFolder_txt)=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($PathToFolder_txt)
	
End if 
$PathToFolder_txt:=$PathToFolder_txt+Folder separator:K24:12
ARRAY TEXT:C222($EmailAddress_atxt; 0)
ARRAY LONGINT:C221($PersonnelIds_aL; 0)
ARRAY TEXT:C222($Names_atxt; 0)

ARRAY TEXT:C222($GroupNames_atxt; 0)

ARRAY LONGINT:C221($DistIDS_AL; 0)
ARRAY LONGINT:C221($BridgeInspIDS_AL; 0)
ARRAY TEXT:C222($INSP_SelType_atxt; 0)
ARRAY TEXT:C222($INSP_SelTypeCode_atxt; 0)

ARRAY TEXT:C222($DistrictBIE_atxt; 0)
ARRAY LONGINT:C221($DistBIEIDS_AL; 0)

ARRAY TEXT:C222($UWInspEngineer_atxt; 0)
ARRAY LONGINT:C221($UWInspEngineer_AL; 0)

//start of Mods_2023_12 

ARRAY LONGINT:C221($DistIDS2_AL; 0)
ARRAY LONGINT:C221($BridgeInspIDS2_AL; 0)
ARRAY LONGINT:C221($DistBIEIDS2_AL; 0)
ARRAY LONGINT:C221($UWInspEngineer2_AL; 0)

Begin SQL
	select
	[Inspection Type].[Code], 
	[Inspection Type].[Description]
	from
	[Inspection Type]
	into
	:$INSP_SelTypeCode_atxt, 
	:$INSP_SelType_atxt;
	
	
	select
	[Personnel].[EmailAddress_s],
	[Personnel].[Person ID],
	CONCAT(CONCAT([Personnel].[First Name],' '),[Personnel].[Last Name]),
	[Personnel].[Employer]
	from
	[Personnel]
	into
	:$EmailAddress_atxt, 
	:$PersonnelIds_aL,
	:$Names_atxt;
	
	select
	[PERS_Groups].[PERS_GroupName_s], 
	[PERS_Groups].[PERS_Primary],
	[PERS_Groups].[PERS_Acting]
	from
	[PERS_Groups]
	where
	[PERS_Groups].[PERS_GroupName_s] like 'AreaEngineer D%'
	order by [PERS_Groups].[PERS_GroupName_s] ASC
	into
	:$GroupNames_atxt, 
	:$DistIDS_AL,
	:$DistIDS2_AL;
	
	select
	[PERS_Groups].[PERS_Primary],
	[PERS_Groups].[PERS_Acting]
	from
	[PERS_Groups]
	where
	[PERS_Groups].[PERS_GroupName_s] = 'BridgeInspectionEngineer'
	into
	:$BridgeInspIDS_AL,
	:$BridgeInspIDS2_AL;
	
	
	select
	[PERS_Groups].[PERS_GroupName_s], 
	[PERS_Groups].[PERS_Primary],
	[PERS_Groups].[PERS_Acting]
	from
	[PERS_Groups]
	where
	[PERS_Groups].[PERS_GroupName_s] like 'DISTRICTBIE%'
	into
	:$DistrictBIE_atxt, 
	:$DistBIEIDS_AL,
	:$DistBIEIDS2_AL;
	
	select
	[PERS_Groups].[PERS_GroupName_s], 
	[PERS_Groups].[PERS_Primary],
	[PERS_Groups].[PERS_Acting]
	from
	[PERS_Groups]
	where
	[PERS_Groups].[PERS_GroupName_s] like 'UWInspEngineer%'
	into
	:$UWInspEngineer_atxt, 
	:$UWInspEngineer_AL,
	:$UWInspEngineer2_AL;
	
End SQL

//end of Mods_2023_12 

C_LONGINT:C283($Loop_L; $Position_L)
ARRAY TEXT:C222($DistrictNotes_atxt; 0)

ARRAY TEXT:C222($DistrictEmails_atxt; 0)
ARRAY TEXT:C222($DistrictNotes_atxt; Size of array:C274($DistIDS_AL))

ARRAY TEXT:C222($DistrictEmails_atxt; Size of array:C274($DistIDS_AL))
C_LONGINT:C283($loop_L)

//start of Mods_2023_12 
//use the Acting ID if the primary is 0
For ($loop_L; 1; Size of array:C274($DistBIEIDS_AL))
	If ($DistBIEIDS_AL{$loop_L}=0) & ($DistBIEIDS2_AL{$loop_L}#0)
		$DistBIEIDS_AL{$loop_L}:=$DistBIEIDS2_AL{$loop_L}
	End if 
End for 
//end of Mods_2023_12 

For ($Loop_L; 1; Size of array:C274($DistIDS_AL))
	
	//start of Mods_2023_12 
	If ($DistIDS_AL{$Loop_L}=0) & ($DistIDS2_AL{$Loop_L}#0)
		$DistIDS_AL{$Loop_L}:=$DistIDS2_AL{$Loop_L}
	End if 
	//end of Mods_2023_12 
	
	$Position_L:=Find in array:C230($PersonnelIds_aL; $DistIDS_AL{$Loop_L})
	If ($Position_L>0)
		$DistrictEmails_atxt{$Loop_L}:=$EmailAddress_atxt{$Position_L}
	End if 
End for 
SORT ARRAY:C229($GroupNames_atxt; $DistIDS_AL; $DistrictNotes_atxt; $DistrictEmails_atxt)

C_TEXT:C284($BIE_Email_txt; $UWInspEmail_txt)

//start of Mods_2023_12 
If ($BridgeInspIDS_AL{1}=0) & ($BridgeInspIDS2_AL{1}#0)
	$BridgeInspIDS_AL{1}:=$BridgeInspIDS2_AL{1}
End if 
//end of Mods_2023_12 
$Position_L:=Find in array:C230($PersonnelIds_aL; $BridgeInspIDS_AL{1})
If ($Position_L>0)
	$BIE_Email_txt:=$EmailAddress_atxt{$Position_L}
End if 

//start of Mods_2023_12 
If ($UWInspEngineer_AL{1}=0) & ($UWInspEngineer2_AL{1}#0)
	$UWInspEngineer_AL{1}:=$UWInspEngineer2_AL{1}
End if 
//end of Mods_2023_12 

$Position_L:=Find in array:C230($PersonnelIds_aL; $UWInspEngineer_AL{1})
If ($Position_L>0)
	$UWInspEmail_txt:=$EmailAddress_atxt{$Position_L}
End if 

READ ONLY:C145(*)
// NOW GET INSPECTION RECORDS

QUERY:C277([Inspections:27]; [Inspections:27]InspCompleteDate:221=!00-00-00!; *)
QUERY:C277([Inspections:27];  & ; [Inspections:27]TeamLeader:4#0; *)
QUERY:C277([Inspections:27];  & ; [Inspections:27]InspComplete:168=False:C215; *)
QUERY:C277([Inspections:27];  & ; [Inspections:27]InspReviewed:12=0; *)
QUERY:C277([Inspections:27];  & ; [Inspections:27]InspApproved:167=0; *)
QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6#"FRZ"; *)
QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6#"RR@"; *)
QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6#"T@"; *)
QUERY:C277([Inspections:27];  & ; [Bridge MHD NBIS:1]InspResp:173="DIST@")

QUERY SELECTION:C341([Inspections:27]; [Bridge MHD NBIS:1]FHWARecord:174=True:C214)
C_LONGINT:C283($Loop_L)
ARRAY LONGINT:C221($record60_Al; 0)
ARRAY LONGINT:C221($record90_Al; 0)
ARRAY LONGINT:C221($recordNumbers_al; 0)
ARRAY LONGINT:C221($recordIDs_aL; 0)
ARRAY DATE:C224($Insp_ad; 0)

C_DATE:C307($query_GT60_d; $query_GT90_d)
$query_GT60_d:=Add to date:C393(Current date:C33; 0; 0; -60)
$query_GT90_d:=Add to date:C393(Current date:C33; 0; 0; -90)
SELECTION TO ARRAY:C260([Inspections:27]; $recordNumbers_al; [Inspections:27]Insp Date:78; $Insp_ad; [Inspections:27]InspID:2; $recordIDs_aL)

For ($Loop_l; 1; Size of array:C274($Insp_ad))
	
	Case of 
		: ($Insp_ad{$Loop_L}<=$query_GT90_d)
			APPEND TO ARRAY:C911($record90_Al; $recordNumbers_al{$Loop_L})
			
		: ($Insp_ad{$Loop_L}<=$query_GT60_d)
			APPEND TO ARRAY:C911($record60_Al; $recordNumbers_al{$Loop_L})
			
	End case 
	
End for 
CREATE SELECTION FROM ARRAY:C640([Inspections:27]; $record90_Al)
CREATE SET:C116([Inspections:27]; "NinetySet")
CREATE SELECTION FROM ARRAY:C640([Inspections:27]; $record60_Al)
CREATE SET:C116([Inspections:27]; "SixtySet")
UNION:C120("NinetySet"; "SixtySet"; "SixtySet")
USE SET:C118("SixtySet")
CLEAR SET:C117("SixtySet")
CLEAR SET:C117("NinetySet")

ORDER BY:C49([Inspections:27]; [Bridge MHD NBIS:1]InspResp:173; >; [Inspections:27]Insp Date:78; >)

C_TEXT:C284($TOEmailAddr_txt; $From_txt; $EmailBody_txt; $EmailSubj_txt)

C_TEXT:C284($SummaryHeader_txt)
$SummaryHeader_txt:="Criteria"+Char:C90(Tab:K15:37)+\
"Company"+Char:C90(Tab:K15:37)+\
"Team Leader"+Char:C90(Tab:K15:37)+\
"BIN"+Char:C90(Tab:K15:37)+\
"BDEPT"+Char:C90(Tab:K15:37)+\
"Item 8"+Char:C90(Tab:K15:37)+\
"Insp. Resp."+Char:C90(Tab:K15:37)+\
"Inspection Type"+Char:C90(Tab:K15:37)+\
"Inspection Date"+Char:C90(Carriage return:K15:38)

C_LONGINT:C283($ArrayPos_L)
C_TEXT:C284($lateInspectionsTemplate_txt)

$From_txt:=ut_GetSysParameter("MAIL_BRGSTATFROM"; "Costas.Manousakis@MHD.state.ma.us")
$lateInspectionsTemplate_txt:=ut_GetSysParameter("LateInspectionsBody")
C_BLOB:C604($Report_blb)
C_BOOLEAN:C305($Priority_B)
C_LONGINT:C283($CurrentRecordNumber_L)
For ($Loop_l; 1; Records in selection:C76([Inspections:27]))
	GOTO SELECTED RECORD:C245([Inspections:27]; $Loop_L)
	
	$CurrentRecordNumber_L:=Record number:C243([Inspections:27])
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[Inspections:27]BIN:1)
	$TOEmailAddr_txt:=""
	$ArrayPos_L:=Find in array:C230($INSP_SelTypeCode_atxt; [Inspections:27]Insp Type:6)
	If ($ArrayPos_L>0)
		v_27_006_txt:=$INSP_SelType_atxt{$ArrayPos_L}
	Else 
		v_27_006_txt:=[Inspections:27]Insp Type:6
	End if 
	
	C_TEXT:C284($DistrictReport_txt)
	
	Case of 
		: (Find in array:C230($record90_Al; $CurrentRecordNumber_L)>0)
			$EmailSubj_txt:="ALERT! "+v_27_006_txt+" Inspection for "+[Bridge MHD NBIS:1]BDEPT:1+" ("+[Inspections:27]BIN:1+") > 90 days old"
			$Priority_B:=True:C214
			$DistrictReport_txt:=" > 90 days days"
		Else 
			$EmailSubj_txt:="WARNING! "+v_27_006_txt+" Inspection for "+[Bridge MHD NBIS:1]BDEPT:1+" ("+[Inspections:27]BIN:1+") > 60 and < 90 days old"
			$DistrictReport_txt:=" > 60 and < 90 days"
			$Priority_B:=False:C215
	End case 
	C_LONGINT:C283($TLPos_L; $DBIEPos_L)
	$TLPos_L:=Find in array:C230($PersonnelIds_aL; [Inspections:27]TeamLeader:4)
	
	If ($TLPos_L>0)
		If ($TOEmailAddr_txt="")
			$TOEmailAddr_txt:=$EmailAddress_atxt{$TLPos_L}
		Else 
			$TOEmailAddr_txt:=$TOEmailAddr_txt+", "+$EmailAddress_atxt{$TLPos_L}
		End if 
	End if 
	
	C_BOOLEAN:C305($DiveReport_b)  //  start of Mods_2023_!2
	If ([Inspections:27]Insp Type:6="DV@")
		$Position_L:=0  // summary is not sent for Dive inspecitons
		//for dive inspections send to the UW engineer
		If ($TOEmailAddr_txt="")
			$TOEmailAddr_txt:=$UWInspEmail_txt
		Else 
			$TOEmailAddr_txt:=$TOEmailAddr_txt+", "+$UWInspEmail_txt
		End if 
		$DiveReport_b:=True:C214  //  start of Mods_2023_12
	Else 
		$Position_L:=Find in array:C230($DistrictBIE_atxt; "DistrictBIE"+Replace string:C233([Bridge MHD NBIS:1]InspResp:173; "DIST"; ""))
		If ($Position_L>0)
			$DBIEPos_L:=Find in array:C230($PersonnelIds_aL; $DistBIEIDS_AL{$Position_L})
			If ($DBIEPos_L>0)
				If ($TOEmailAddr_txt="")
					$TOEmailAddr_txt:=$EmailAddress_atxt{$DBIEPos_L}
				Else 
					$TOEmailAddr_txt:=$TOEmailAddr_txt+", "+$EmailAddress_atxt{$DBIEPos_L}
				End if 
			End if 
		End if 
		$DiveReport_b:=False:C215  //  start of Mods_2023_12
	End if 
	
	
	CLEAR VARIABLE:C89(v_27_156_txt)
	
	If ($TLPos_L>0)
		v_27_156_txt:=[Inspections:27]Agency:156+Char:C90(Tab:K15:37)+$Names_atxt{$TLPos_L}+Char:C90(Tab:K15:37)
	Else 
		v_27_156_txt:=[Inspections:27]Agency:156+Char:C90(Tab:K15:37)+"Missing Name for TL ID "+String:C10([Inspections:27]TeamLeader:4)+Char:C90(Tab:K15:37)
	End if 
	If ([Inspections:27]Agency:156="Mass. Highway@") | ([Inspections:27]Agency:156="MHD Underwater@")
	Else 
		QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsltName:2=(Substring:C12([Inspections:27]Agency:156; 1; \
			MaxNum((Length:C16([Inspections:27]Agency:156)\2); 3))\
			+"@"))
		QUERY SELECTION:C341([Conslt Address:77]; [Conslt Address:77]Func_Insp:20=True:C214)
		QUERY SELECTION:C341([Conslt Address:77]; [Conslt Address:77]Email:18#"")
		If ($TOEmailAddr_txt="")
			$TOEmailAddr_txt:=[Conslt Address:77]Email:18
		Else 
			$TOEmailAddr_txt:=$TOEmailAddr_txt+", "+[Conslt Address:77]Email:18
		End if 
		
	End if 
	
	PROCESS 4D TAGS:C816($lateInspectionsTemplate_txt; $EmailBody_txt)
	
	//$EmailBody_txt:="BIN is "+[Inspections]BIN+Char(Carriage return)
	//$EmailBody_txt:=$EmailBody_txt+"BDEPT is "+[Bridge MHD NBIS]BDEPT+Char(Carriage return)
	//$EmailBody_txt:=$EmailBody_txt+"ITEM8 is "+[Bridge MHD NBIS]Item8+Char(Carriage return)
	//$EmailBody_txt:=$EmailBody_txt+"ITEM7 is "+[Bridge MHD NBIS]Item7+Char(Carriage return)
	//$EmailBody_txt:=$EmailBody_txt+"ITEM6A is "+[Bridge MHD NBIS]Item6A+Char(Carriage return)
	//$EmailBody_txt:=$EmailBody_txt+"Inspection Date is "+String([Inspections]Insp Date)+Char(Carriage return)
	
	//append notes for summary by each district - no summary for Dive.
	If ($Position_L>0)
		
		$DistrictNotes_atxt{$Position_L}:=$DistrictNotes_atxt{$Position_L}+\
			$DistrictReport_txt+Char:C90(Tab:K15:37)+\
			v_27_156_txt+\
			[Inspections:27]BIN:1+Char:C90(Tab:K15:37)+\
			[Bridge MHD NBIS:1]BDEPT:1+Char:C90(Tab:K15:37)+\
			[Bridge MHD NBIS:1]Item8:206+Char:C90(Tab:K15:37)+\
			[Bridge MHD NBIS:1]InspResp:173+Char:C90(Tab:K15:37)+\
			v_27_006_txt+Char:C90(Tab:K15:37)+\
			String:C10([Inspections:27]Insp Date:78; Internal date short:K1:7)+Char:C90(Carriage return:K15:38)
	End if 
	
	//  start of Mods_2023_12
	C_TEXT:C284($DiveReport_txt)
	If ($DiveReport_b)
		$DiveReport_txt:=$DiveReport_txt+\
			$DistrictReport_txt+Char:C90(Tab:K15:37)+\
			v_27_156_txt+\
			[Inspections:27]BIN:1+Char:C90(Tab:K15:37)+\
			[Bridge MHD NBIS:1]BDEPT:1+Char:C90(Tab:K15:37)+\
			[Bridge MHD NBIS:1]Item8:206+Char:C90(Tab:K15:37)+\
			[Bridge MHD NBIS:1]InspResp:173+Char:C90(Tab:K15:37)+\
			v_27_006_txt+Char:C90(Tab:K15:37)+\
			String:C10([Inspections:27]Insp Date:78; Internal date short:K1:7)+Char:C90(Carriage return:K15:38)
	End if 
	//  end of Mods_2023_12
	
	SET BLOB SIZE:C606($Report_blb; 0)
	TEXT TO BLOB:C554("subj is "+$EmailSubj_txt+Char:C90(Carriage return:K15:38); $Report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554("To Email is "+$TOEmailAddr_txt+Char:C90(Carriage return:K15:38); $Report_blb; UTF8 text without length:K22:17; *)
	TEXT TO BLOB:C554("Body is "+$EmailBody_txt+Char:C90(Carriage return:K15:38); $Report_blb; UTF8 text without length:K22:17; *)
	$InspDate_txt:=String:C10(Year of:C25([Inspections:27]Insp Date:78); "0000")+String:C10(Month of:C24([Inspections:27]Insp Date:78); "00")+String:C10(Day of:C23([Inspections:27]Insp Date:78); "00")
	BLOB TO DOCUMENT:C526($PathToFolder_txt+$InspDate_txt+"_"+[Inspections:27]BIN:1+"_"+[Bridge MHD NBIS:1]BDEPT:1+"_"+[Inspections:27]Insp Type:6+".txt"; $Report_blb)
	
	If (Not:C34($InTest_B))
		ut_SendEmail($TOEmailAddr_txt; $From_txt; ""; ""; $EmailBody_txt; $EmailSubj_txt; $Priority_B)
		DELAY PROCESS:C323(Current process:C322; 5*60)  //wait 5 seconds so it does not look bad to the mail server
	End if 
	
End for 

For ($Loop_L; 1; Size of array:C274($DistrictNotes_atxt))
	If ($DistrictNotes_atxt{$Loop_L}="")
		
	Else 
		$GroupNames_atxt{$Loop_L}:=Replace string:C233($GroupNames_atxt{$Loop_L}; "AreaEngineer "; "")
		//TEXT TO DOCUMENT($PathToFolder_txt+"District_Summary_"+$SummaryDate_txt+"_"+$GroupNames_atxt{$Loop_L}+".txt";$SummaryHeader_txt+$DistrictNotes_atxt{$Loop_L};UTF8 text without length;Document with CRLF)
		
		TEXT TO DOCUMENT:C1237($PathToFolder_txt+"District_Summary_"+$SummaryDate_txt+"_D"+String:C10($Loop_L)+".txt"; $SummaryHeader_txt+$DistrictNotes_atxt{$Loop_L}; UTF8 text without length:K22:17; Document with CRLF:K24:20)
	End if 
End for 

C_TEXT:C284($lastEmail_txt)
C_LONGINT:C283($LastID_L)
$lastEmail_txt:=$DistrictEmails_atxt{1}
$LastID_L:=$DistIDS_AL{1}
ARRAY TEXT:C222(MAILAttachments_atxt; 0)
ARRAY TEXT:C222($MAILAttachments_atxt; 0)
$EmailSubj_txt:="Summary Email of Incomplete Inspections"
If ($InTest_B)
	$EmailSubj_txt:="THIS IS A TEST OF "+$EmailSubj_txt
End if 
For ($Loop_L; 1; Size of array:C274($DistrictNotes_atxt))
	If ($DistrictNotes_atxt{$Loop_L}#"")
		//If ($LastID_L#$DistIDS_AL{$Loop_L})
		APPEND TO ARRAY:C911(MAILAttachments_atxt; $PathToFolder_txt+"District_Summary_"+$SummaryDate_txt+"_D"+String:C10($Loop_L)+".txt")
		APPEND TO ARRAY:C911($MailAttachments_atxt; $PathToFolder_txt+"District_Summary_"+$SummaryDate_txt+"_D"+String:C10($Loop_L)+".txt")  // this is for BIE
		
		//If (Size of array(MAILAttachments_atxt)>0)
		$lastEmail_txt:=$DistrictEmails_atxt{$Loop_L}
		ut_SendEmail($lastEmail_txt; $From_txt; $From_txt; ""; "Summary of Incomplete Inspections"; $EmailSubj_txt)
		ARRAY TEXT:C222(MAILAttachments_atxt; 0)
		
	End if 
	
End for 
//If (Size of array(MAILAttachments_atxt)>0)

//ut_SendEmail ($lastEmail_txt;$From_txt;$From_txt;"";"Summary of Incomplete Inspections";$EmailSubj_txt)
//ARRAY TEXT(MAILAttachments_atxt;0)

//End if 

//  start of Mods_2023_12
If ($DiveReport_txt#"")
	TEXT TO DOCUMENT:C1237($PathToFolder_txt+"UW_Summary_"+$SummaryDate_txt+".txt"; $SummaryHeader_txt+$DiveReport_txt; UTF8 text without length:K22:17; Document with CRLF:K24:20)
	ARRAY TEXT:C222(MAILAttachments_atxt; 0)
	APPEND TO ARRAY:C911(MAILAttachments_atxt; $PathToFolder_txt+"UW_Summary_"+$SummaryDate_txt+".txt")
	
	ut_SendEmail($UWInspEmail_txt; $From_txt; $From_txt; ""; "Summary of UW Incomplete Inspections"; $EmailSubj_txt)
	
	APPEND TO ARRAY:C911($MAILAttachments_atxt; $PathToFolder_txt+"UW_Summary_"+$SummaryDate_txt+".txt")
End if 
//  end of Mods_2023_12

COPY ARRAY:C226($MAILAttachments_atxt; MAILAttachments_atxt)

If (Size of array:C274(MAILAttachments_atxt)>0)
	
	ut_SendEmail($BIE_Email_txt; $From_txt; $From_txt; ""; "Summary of Incomplete Inspections"; $EmailSubj_txt)
	
End if 

//End INSP_ReportIncompleteInsp