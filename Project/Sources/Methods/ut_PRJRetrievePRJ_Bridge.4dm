//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJRetrievePRJ_Bridge
// User name (OS): charlesmiller
// Date and time: 11/12/08, 15:40:22
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_07  //r001 `07/09/09, 10:32:44   `Fix defect where bdept not filled in included bin records
	Mods_2009_07  //r003 `07/27/09, 10:38:08   `Fix errors when SQL calls fail
	Mods_2010_03  //r004 CJ Miller`03/24/10, 11:17:12      `Add code to assign newest Bin when more than one [Bridge MHD NBIS] record found
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2012_03  //r001 `Fix beg where call to PRJ_CreateIncludedBINRecord was passing in concatenated BDEPT
	//Modified by: Charles Miller (3/20/12 16:27:05)
	Mods_2013_09  //r001 `removed file number from project details when project ibnfo removes it
	Mods_2019_06_bug  //Modify sql server retrieves to not use ODBC plugin but native 4D SQL
	//Modified by: Chuck Miller (6/18/19 11:13:10)
	Mods_2019_11_bug  //Moved Project retrieve code from development into bug fix 
	//and back as there were a few changes made in testing
	//Modified by: Chuck Miller (11/5/19 13:28:12)
	
End if 
C_BOOLEAN:C305($0)
$0:=True:C214
C_TEXT:C284($EOL)
If (<>PL_LPlatfrm<3)
	$EOL:=Char:C90(Carriage return:K15:38)
Else 
	$EOL:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
End if 
C_TIME:C306($StartTime_tm; $RemainingTime_tm; $SQLDocument_tm)
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Begin Retrieve Project Bridge "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+$EOL
$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
CLOSE DOCUMENT:C267($SQLDocument_tm)
PRJ_SQLRetrieveStats_txt:=""
C_LONGINT:C283($win; $Count_l; $InnerLoop_l)
//$win:=ut_OpenNewWindow (500;200;5;4;"Retrieving Project Bridges")
C_OBJECT:C1216($progressObj_o)
$progressObj_o:=ProgressNew("Updating Project Bridges"; 0; False:C215; ""; 3)

If (SQL_Direct("sp_RTRVPRJ_Bridge"))
	
	UNLOAD RECORD:C212([PRJ_ProjectDetails:115])
	READ WRITE:C146([PRJ_ProjectDetails:115])
	C_TIME:C306($StartTime_tm; $RemainingTime_tm)
	C_TEXT:C284($Body_txt; $To_txt; $From_txt; $Subject_txt)
	$StartTime_tm:=Current time:C178(*)
	C_LONGINT:C283($Loop_l; $SizeOfArray_l; $NewRecords_l; $ErrorCount_l; $Deletedrecords_l; $UpdatedRecords_l)
	$NewRecords_l:=0
	$UpdatedRecords_l:=0
	$SizeOfArray_l:=Size of array:C274(PRJ_PROJECT_NO_al)
	$Body_txt:=""
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Retrieved "+String:C10($SizeOfArray_l)+" potential Proj Bridge records"+$EOL
	C_BOOLEAN:C305($SendEmail_b)
	$SendEmail_b:=False:C215
	ARRAY TEXT:C222($BDeptAndFileNumber_atxt; 0)
	ARRAY TEXT:C222($BDeptAndFileNumber_atxt; $SizeOfArray_l)
	OB SET:C1220($progressObj_o; "total"; $SizeOfArray_l)
	For ($Loop_l; 1; $SizeOfArray_l)
		UpdateProgressNew($progressObj_o; $Loop_l)
		//GOTO XY(5;2)
		//MESSAGE("Updating "+String($Loop_l)+" out of "+String($SizeOfArray_l))
		//GOTO XY(5;5)
		//$RemainingTime_tm:=(($SizeOfArray_l/$Loop_l)-1)*(Current time(*)-$StartTime_tm)
		//MESSAGE("Estimated time remaining is "+Time string($RemainingTime_tm))
		//GOTO XY(5;7)
		//MESSAGE("Elapsed time is "+Time string(Current time(*)-$StartTime_tm))
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1=PRJ_BDEPT_atxt{$Loop_l})
		
		If (Records in selection:C76([Bridge MHD NBIS:1])=0)
			If (PRJ_BDEPT_atxt{$Loop_l}="various")
			Else 
				QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="MAIL_TRANSFCHKLIST")
				$SendEmail_b:=True:C214
				If (Length:C16($Body_txt)>25000)
					$To_txt:="Manousakis Costas (MHD) <costas.manousakis@MHD.state.ma.us>"
					If (Records in selection:C76([Parameters:107])=1)
						$To_txt:=[Parameters:107]Description:2
					End if 
					$From_txt:=$To_txt
					$Subject_txt:="Missing BDEPT's  from sp_RTRVPRJ_Bridge"
					
					If (ut_SendEmail($To_txt; $From_txt; ""; ""; $Body_txt; $Subject_txt; True:C214))
						
					End if 
					$SendEmail_b:=False:C215
					$Body_txt:=""
				End if 
				$ErrorCount_l:=$ErrorCount_l+1
				$Body_txt:=$Body_txt+"Error retrieve  BDEPT returned that does not exist. The BDEPT is "+PRJ_BDEPT_atxt{$Loop_l}+". The Project is "+String:C10(PRJ_PROJECT_NO_al{$Loop_l})+"."+Char:C90(13)
			End if 
		Else 
			$BDeptAndFileNumber_atxt{$Loop_l}:=PRJ_BDEPT_atxt{$Loop_l}+"-"+String:C10(PRJ_PROJECT_NO_al{$Loop_l})
			QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileNumber_l:3=PRJ_PROJECT_NO_al{$Loop_l})
			Case of 
				: (Records in selection:C76([PRJ_ProjectFile:117])>1)
					QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="MAIL_TRANSFCHKLIST")
					$To_txt:="Manousakis Costas (MHD) <costas.manousakis@MHD.state.ma.us>"
					If (Records in selection:C76([Parameters:107])=1)
						$To_txt:=[Parameters:107]Description:2
					End if 
					$From_txt:=$To_txt
					$Body_txt:="More than one project file record found for file number "+String:C10(PRJ_PROJECT_NO_al{$Loop_l})
					$Subject_txt:="Duplicate file number from sp_RTRVPRJ_Bridge"
					$ErrorCount_l:=$ErrorCount_l+1
					If (ut_SendEmail($To_txt; $From_txt; ""; ""; $Body_txt; $Subject_txt; True:C214))
						
					End if 
				: (Records in selection:C76([PRJ_ProjectFile:117])=1)
					
					SET QUERY DESTINATION:C396(Into set:K19:2; "ProjectDetailSet")
					QUERY:C277([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PF_FileID_l:3=[PRJ_ProjectFile:117]PF_FileID_l:1)
					C_BOOLEAN:C305($Create_b)
					$Create_b:=False:C215
					If (Records in set:C195("ProjectDetailSet")=0)
						//create detail record
						$Create_b:=True:C214
					Else 
						
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						USE SET:C118("ProjectDetailSet")
						QUERY SELECTION:C341([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5="@"+PRJ_BDEPT_atxt{$Loop_l}+"@")
						If (Records in selection:C76([PRJ_ProjectDetails:115])=0)
							USE SET:C118("ProjectDetailSet")
							SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]PRJ_ProjectID_l:1; $ProjectIDs_al)
							QUERY WITH ARRAY:C644([PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1; $ProjectIDs_al)
							SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_l)
							QUERY SELECTION:C341([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BDEPT_s:3=PRJ_BDEPT_atxt{$Loop_l})
							SET QUERY DESTINATION:C396(Into current selection:K19:1)
							If ($Count_l=0)
								$Create_b:=True:C214
							End if 
							//if no detail record 
							//query invluded bins if no included bin rcord create
						End if 
						
					End if 
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					If ($Create_b)
						If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DUM")
						Else 
							$NewRecords_l:=$NewRecords_l+1
							CREATE RECORD:C68([PRJ_ProjectDetails:115])
							Inc_Sequence("PRJ_ProjectID_l"; ->[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
							[PRJ_ProjectDetails:115]PRJ_Comments_txt:10:="Record  created during SQL import on via sp_RTRVPRJ_Bridge "+String:C10(Current date:C33(*); 7)+Char:C90(Carriage return:K15:38)
							[PRJ_ProjectDetails:115]PF_FileID_l:3:=[PRJ_ProjectFile:117]PF_FileID_l:1
							PRJ_AdditionalBridges
							
							If (Records in selection:C76([Bridge MHD NBIS:1])=1)
								[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34:=[Bridge MHD NBIS:1]BIN:3
								PRJ_CreateIncludedBINRecord([Bridge MHD NBIS:1]BIN:3; [Bridge MHD NBIS:1]BDEPT:1)
							Else 
								[PRJ_ProjectDetails:115]PRJ_Comments_txt:10:=[PRJ_ProjectDetails:115]PRJ_Comments_txt:10+"Multiple included BIN records created, not all of which may be correct. "+Char:C90(Carriage return:K15:38)
								ARRAY DATE:C224($Created_ad; 0)
								SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $Bins_as; [Bridge MHD NBIS:1]DateCreated:192; $Created_ad)
								MULTI SORT ARRAY:C718($Created_ad; <; $Bins_as; >)
								[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34:=$Bins_as{1}
								For ($InnerLoop_l; 1; Size of array:C274($Bins_as))
									PRJ_CreateIncludedBINRecord($Bins_as{$InnerLoop_l}; PRJ_BDEPT_atxt{$Loop_l})
								End for 
							End if 
							[PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5:=PRJ_DEBridgeNo_s
							[PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8:=Get_Town_Name(Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6))
							
							SAVE RECORD:C53([PRJ_ProjectDetails:115])
							UNLOAD RECORD:C212([PRJ_ProjectDetails:115])
						End if 
					End if 
				Else 
					//skip me and add to report
			End case 
			
		End if 
		
	End for 
	Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))
	
	
	
	//OK let's remove file IDs from those items that are no longer assigned
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	QUERY:C277([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PF_FileID_l:3>0)
	SET QUERY DESTINATION:C396(Into set:K19:2; "$PRJDetailSet")
	QUERY SELECTION:C341([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_Comments_txt:10="@Record  created during SQL import on via sp_RTRVPRJ_Bridge@")
	C_TEXT:C284($BDeptAndFileNumber_txt)
	C_LONGINT:C283($ArrayPosition_L)
	USE SET:C118("$PRJDetailSet")
	CLEAR SET:C117("$PRJDetailSet")
	
	C_LONGINT:C283($RemovedCount_L)
	
	$progressObj_o:=ProgressNew("Updating Projects Details"; Records in selection:C76([PRJ_ProjectDetails:115]); False:C215; ""; 3)
	
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	For ($Loop_l; 1; Records in selection:C76([PRJ_ProjectDetails:115]))
		UpdateProgressNew($progressObj_o; $Loop_l)
		GOTO SELECTED RECORD:C245([PRJ_ProjectDetails:115]; $Loop_l)
		PRJ_PFFileID_L:=[PRJ_ProjectDetails:115]PF_FileID_l:3
		PRJ_DEProjectFileNo_l:=0
		
		PRJ_DEProjectFileNo_l:=PRJ_ReturnFileNumber(PRJ_PFFileID_L)
		
		
		
		$BDeptAndFileNumber_txt:=Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6)+"-"+String:C10(PRJ_DEProjectFileNo_l)
		$ArrayPosition_L:=Find in array:C230($BDeptAndFileNumber_atxt; $BDeptAndFileNumber_txt)
		If ($ArrayPosition_L<1)
			If (ut_LoadRecord(->[PRJ_ProjectDetails:115]; 5))
				[PRJ_ProjectDetails:115]PRJ_Comments_txt:10:="Record removed from "+String:C10(PRJ_DEProjectFileNo_l)+" on "+String:C10(Current date:C33; 7)+Char:C90(Carriage return:K15:38)+[PRJ_ProjectDetails:115]PRJ_Comments_txt:10
				[PRJ_ProjectDetails:115]PF_FileID_l:3:=0
				SAVE RECORD:C53([PRJ_ProjectDetails:115])
				UNLOAD RECORD:C212([PRJ_ProjectDetails:115])
				$RemovedCount_L:=$RemovedCount_L+1
			End if 
			
		End if 
	End for 
	Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))
	
	
	
	If ($SendEmail_b)
		$To_txt:="Manousakis Costas (MHD) <costas.manousakis@MHD.state.ma.us>"
		If (Records in selection:C76([Parameters:107])=1)
			$To_txt:=[Parameters:107]Description:2
		End if 
		$From_txt:=$To_txt
		If ($ErrorCount_l>1)
			$Subject_txt:=String:C10($ErrorCount_l)+" Missing BDEPTs from sp_RTRVPRJ_Bridge"
		Else 
			$Subject_txt:=String:C10($ErrorCount_l)+" Missing BDEPT from sp_RTRVPRJ_Bridge"
		End if 
		If (ut_SendEmail($To_txt; $From_txt; ""; ""; $Body_txt; $Subject_txt; True:C214))
			
		End if 
	End if 
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"created "+String:C10($NewRecords_l)+" Proj Bridge records"+$EOL
	If ($ErrorCount_l>0)
		PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"created email for "+String:C10($ErrorCount_l)+" errors"+$EOL
	End if 
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Reset File Number to 0 for "+String:C10($RemovedCount_L)+" count Proj Bridge records"+$EOL
Else 
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Call to sp_RTRVPRJ_Bridge Failed"+$Eol
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+SQL_ReturnErrorDescriptions+$eol
	$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
	SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
	CLOSE DOCUMENT:C267($SQLDocument_tm)
	PRJ_SQLRetrieveStats_txt:=""
	$0:=False:C215
End if 
CLOSE WINDOW:C154
CLEAR SET:C117("ProjectDetailSet")
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"End Retrieve Project Bridge "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+$Eol
$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
CLOSE DOCUMENT:C267($SQLDocument_tm)
PRJ_SQLRetrieveStats_txt:=""
//End ut_PRJRetrievePRJ_Bridge