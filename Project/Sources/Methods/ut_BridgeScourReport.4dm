//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_BridgeScourReport
// User name (OS): charlesmiller
// Date and time: 10/01/09, 13:51:08
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_10  //r001 CJ Miller`10/01/09, 13:51:10     `Create new export for Bridge Scour Category report
	// Modified by: costasmanousakis-(Designer)-(10/2/09 09:02:25)
	Mods_2009_10
	//  `Moved initialization of text variables so they are cleared for each BIN.  
	//  `Added Progress bar
	// Modified by: costasmanousakis-(Designer)-(10/8/09 16:14:17)
	Mods_2009_10
	//  `Added Items 2,41, 61. and 113 in the output; Get Only NBI records
	//  `AddedTownname, Items  19, 27, 29, 71, 100, 104, 106 in the output
End if 
READ ONLY:C145(*)

C_LONGINT:C283($Loop_l; $InnerLoop_l; $SizeofReportArray_l; $Loc_l)
ARRAY TEXT:C222($ReportArray_atxt; 0)
ARRAY TEXT:C222($ReportArray_atxt; 1)
$SizeofReportArray_l:=1
C_TEXT:C284($Tab_txt; $Eol_txt; $PF_FileNumber_txt; $PF_Tip_txt; $PF_AdDate_txt; $NTPDate_txt; $PFType_txt; $ProgramType_txt; $SDFO_txt)

C_BLOB:C604($Blob_blb)

$Tab_txt:=Char:C90(Tab:K15:37)
If (<>PL_LPlatfrm<3)
	$Eol_txt:=Char:C90(Carriage return:K15:38)
Else 
	$Eol_txt:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
End if 
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="PRJ_TypeCode")

SET BLOB SIZE:C606($Blob_blb; 0)
$Blob_blb:=ut_ParseTextToArrayDelim([Parameters:107]Description:2; Char:C90(Carriage return:K15:38))
ARRAY TEXT:C222($PRJ_TypeCode_atxt; 0)
BLOB TO VARIABLE:C533($Blob_blb; $PRJ_TypeCode_atxt)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="PRJ_TypeDescription")

SET BLOB SIZE:C606($Blob_blb; 0)
$Blob_blb:=ut_ParseTextToArrayDelim([Parameters:107]Description:2; Char:C90(Carriage return:K15:38))
ARRAY TEXT:C222($PRJ_TypeDescription_atxt; 0)
BLOB TO VARIABLE:C533($Blob_blb; $PRJ_TypeDescription_atxt)

ALL RECORDS:C47([ScourPriorityRank:108])
QUERY:C277([ScourPriorityRank:108]; [Bridge MHD NBIS:1]FHWARecord:174=True:C214)
ORDER BY:C49([ScourPriorityRank:108]; [ScourPriorityRank:108]Category:5; >; [Bridge MHD NBIS:1]BDEPT:1; >; [ScourPriorityRank:108]BIN:1; >)
$ReportArray_atxt{$SizeofReportArray_l}:="TownName"+$Tab_txt+"BDEPT"+$Tab_txt+"Item 8"+$Tab_txt+"BIN"+$Tab_txt+"Facility Carried"+$Tab_txt+"Facility Under"+$Tab_txt+"Item 2"+$Tab_txt+"Item 19"+$Tab_txt+"Item 27"+$Tab_txt+"Item 29"+$Tab_txt+"Item 71"+$Tab_txt+"Item 100"+$Tab_txt+"Item 104"+$Tab_txt+"Item 106"+$Tab_txt+"Item 41"+$Tab_txt+"Item 58"+$Tab_txt+"Item 59"+$Tab_txt+"Item 60"+$Tab_txt+"Item 62"+$Tab_txt+"Item 61"+$Tab_txt+"Item 113"+$Tab_txt+"SD FO"+$Tab_txt+"Scour Category"+$Tab_txt+"Project No"+$Tab_txt+"Ad Date"+$Tab_txt+"Constr. NTP"+$Tab_txt+"Project Type"+$Tab_txt+"Tip Year"+$Tab_txt+"Program Type"+$Eol_txt

<>ProgressPID:=StartProgress("ScourRptExport"; "Button"; "Bridge Scour Report Export")
UpdateProgress(0; Records in selection:C76([ScourPriorityRank:108]))  //start it

SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
FIRST RECORD:C50([ScourPriorityRank:108])

For ($Loop_l; 1; Records in selection:C76([ScourPriorityRank:108]))
	RELATE ONE:C42([ScourPriorityRank:108]BIN:1)
	QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2=[ScourPriorityRank:108]BIN:1)
	ARRAY LONGINT:C221($LongintIDs_al; 0)
	SELECTION RANGE TO ARRAY:C368(1; Records in selection:C76([PRJ_ProjectDetailsIncludedBINS:122]); [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1; $LongintIDs_al)
	
	QUERY WITH ARRAY:C644([PRJ_ProjectDetails:115]PRJ_ProjectID_l:1; $LongintIDs_al)
	SELECTION RANGE TO ARRAY:C368(1; Records in selection:C76([PRJ_ProjectDetails:115]); [PRJ_ProjectDetails:115]PF_FileID_l:3; $LongintIDs_al)
	
	//get the correct project record?
	QUERY WITH ARRAY:C644([PRJ_ProjectFile:117]PF_FileID_l:1; $LongintIDs_al)
	
	ORDER BY:C49([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5; <)
	
	If (False:C215)
		QR REPORT:C197([PRJ_ProjectFile:117]; Char:C90(1))
	End if 
	REDUCE SELECTION:C351([PRJ_ProjectFile:117]; 1)
	LOAD RECORD:C52([PRJ_ProjectFile:117])
	QUERY SELECTION:C341([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PF_FileID_l:3=[PRJ_ProjectFile:117]PF_FileID_l:1)
	
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+[Bridge MHD NBIS:1]Town Name:175+$Tab_txt
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+[Bridge MHD NBIS:1]BDEPT:1+$Tab_txt
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+[Bridge MHD NBIS:1]Item8:206+$Tab_txt
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+[ScourPriorityRank:108]BIN:1+$Tab_txt
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+[Bridge MHD NBIS:1]Item7:65+$Tab_txt
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+[Bridge MHD NBIS:1]Item6A:63+$Tab_txt
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+[Bridge MHD NBIS:1]Item2:60+$Tab_txt
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+String:C10([Bridge MHD NBIS:1]Item19:91)+$Tab_txt
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+String:C10([Bridge MHD NBIS:1]Item27:83)+$Tab_txt
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+String:C10([Bridge MHD NBIS:1]Item29:88)+$Tab_txt
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+[Bridge MHD NBIS:1]Item71:145+$Tab_txt
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+[Bridge MHD NBIS:1]Item100:121+$Tab_txt
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+f_Boolean2String([Bridge MHD NBIS:1]Item104:119; "YN")+$Tab_txt
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+String:C10([Bridge MHD NBIS:1]Item106:84)+$Tab_txt
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+[Bridge MHD NBIS:1]Item41:141+$Tab_txt
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+[Bridge MHD NBIS:1]Item58:130+$Tab_txt
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+[Bridge MHD NBIS:1]Item59:131+$Tab_txt
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+[Bridge MHD NBIS:1]Item60:132+$Tab_txt
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+[Bridge MHD NBIS:1]Item62:134+$Tab_txt
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+[Bridge MHD NBIS:1]Item61:133+$Tab_txt
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+[Bridge MHD NBIS:1]Item113:151+$Tab_txt
	
	$SDFO_txt:=""
	Case of 
		: ([Bridge MHD NBIS:1]StructDef:103)
			$SDFO_txt:="SD"
		: ([Bridge MHD NBIS:1]FunctObs:106)
			$SDFO_txt:="FO"
	End case 
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+$SDFO_txt+$Tab_txt
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+[ScourPriorityRank:108]Category:5+$Tab_txt
	
	$PF_FileNumber_txt:=""
	$PF_Tip_txt:=""
	$PF_AdDate_txt:=""
	$NTPDate_txt:=""
	$PFType_txt:=""
	$ProgramType_txt:=""
	If ([PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5>=!2000-01-01!)
		QUERY:C277([PRJ_ATTRFileNoXrefs:131]; [PRJ_ATTRFileNoXrefs:131]PF_FileNumber_l:2=[PRJ_ProjectFile:117]PF_FileNumber_l:3)
		
		SELECTION RANGE TO ARRAY:C368(1; Records in selection:C76([PRJ_ATTRFileNoXrefs:131]); [PRJ_ATTRFileNoXrefs:131]ATTR_ID_l:1; $LongintIDs_al)
		QUERY WITH ARRAY:C644([PRJ_Attributes:130]ATTR_ID_l:1; $LongintIDs_al)
		ARRAY TEXT:C222($Programs_as; 0)  //Command Replaced was o_ARRAY string length was 65
		ARRAY TEXT:C222($Programs_atxt; 0)
		SELECTION RANGE TO ARRAY:C368(1; Records in selection:C76([PRJ_Attributes:130]); [PRJ_Attributes:130]ATTR_Name_s:2; $Programs_as)
		If ([PRJ_ProjectDetails:115]CP_ConstructionProjectID_l:2>0)
			QUERY:C277([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CP_ConstructionProjectID_l:1=[PRJ_ProjectDetails:115]CP_ConstructionProjectID_l:2)
			If ([PRJ_ConstructionProject:116]CP_NTP_d:12>!2000-01-01!)
				$NTPDate_txt:=String:C10([PRJ_ConstructionProject:116]CP_NTP_d:12; Internal date short:K1:7)
			End if 
		End if 
		
		$Loc_l:=Find in array:C230($PRJ_TypeCode_atxt; [PRJ_ProjectFile:117]PF_TypeCode_s:17)
		If ($Loc_l>0)
			$PFType_txt:=$PRJ_TypeDescription_atxt{$Loc_l}
		End if 
		
		For ($InnerLoop_l; 1; Size of array:C274($Programs_as))
			If ($InnerLoop_l>1)
				$ProgramType_txt:=$ProgramType_txt+", "+$Programs_as{$InnerLoop_l}
			Else 
				$ProgramType_txt:=$Programs_as{$InnerLoop_l}
			End if 
			
		End for 
		$PF_FileNumber_txt:=String:C10([PRJ_ProjectFile:117]PF_FileNumber_l:3)
		$PF_AdDate_txt:=String:C10([PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5; Internal date short:K1:7)
		$PF_Tip_txt:=[PRJ_ProjectFile:117]PF_TIP_s:7
	End if 
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+$PF_FileNumber_txt+$Tab_txt
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+$PF_AdDate_txt+$Tab_txt
	
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+$NTPDate_txt+$Tab_txt
	
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+$PFType_txt+$Tab_txt
	
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+$PF_Tip_txt+$Tab_txt
	
	$ReportArray_atxt{$SizeofReportArray_l}:=$ReportArray_atxt{$SizeofReportArray_l}+$ProgramType_txt+$Eol_txt
	If (Length:C16($ReportArray_atxt{$SizeofReportArray_l})>25000)
		APPEND TO ARRAY:C911($ReportArray_atxt; "")
		$SizeofReportArray_l:=$SizeofReportArray_l+1
	End if 
	
	If (($Loop_l%20)=0)
		UpdateProgress($Loop_l; Records in selection:C76([ScourPriorityRank:108]))
	End if 
	
	NEXT RECORD:C51([ScourPriorityRank:108])
	
	If (<>Abort)
		$Loop_l:=Records in selection:C76([ScourPriorityRank:108])+1
	End if 
	
End for 

POST OUTSIDE CALL:C329(<>ProgressPID)

C_TEXT:C284($Path_txt)
$Path_txt:=Select folder:C670("Select folder to save Bridge Scour Category Export")
$Path_txt:=$Path_txt+"BrdgScourCat_"+ut_ReturnTimeStampFromDate(Current date:C33(*); Current time:C178(*))+".txt"

C_TIME:C306($Doc_tm)

$Doc_tm:=Create document:C266($Path_txt)
For ($Loop_l; 1; Size of array:C274($ReportArray_atxt))
	SEND PACKET:C103($Doc_tm; $ReportArray_atxt{$Loop_l})
End for 
CLOSE DOCUMENT:C267($Doc_tm)

//End ut_BridgeScourReport