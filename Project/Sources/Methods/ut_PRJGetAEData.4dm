//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJGetAEData
// User name (OS): cjmiller
// Date and time: 03/02/06, 12:19:58
// ----------------------------------------------------
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_07  //r001 `07/23/09, 10:21:30   `Add call to AE to retrieve additional [PRJ_ConstructionProject] data
	Mods_2009_07  //r003 `07/27/09, 10:44:38   `Fix errors when SQL calls fail
	// Modified by: costasmanousakis-(Designer)-(6/11/10 15:04:18)
	Mods_2010_06
	//  `Modified storing of sp_RTRVAEContData arrays to account for the new method of storing the data in 
	//  `field [PRJ_ConstructionProject]CP_AEData_blb.
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2013_04  //r001 ` Add AEAward date [PRJ_ConstructionProject]
	//Modified by: Charles Miller (4/4/13 15:09:16)
	Mods_2017_05  //[PRJ_ConstructionProject]AEAward_d is not returned
	//Modified by: Chuck Miller (5/11/17 16:22:14)
	Mods_2019_06_bug  //Modify sql server retrieves to not use ODBC plugin but native 4D SQL
	//Modified by: Chuck Miller (6/18/19 11:13:10)
	Mods_2019_10_bug  //Modified Poject retrieve to create CSV files for all returned data
	//Modified by: Chuck Miller (10/24/19 11:07:37)
	Mods_2019_11_bug  //Moved Project retrieve code from development into bug fix 
	//and back as there were a few changes made in testing
	//Modified by: Chuck Miller (11/5/19 13:28:12)
	
End if 
C_TEXT:C284($EOL)
If (<>PL_LPlatfrm<3)
	$EOL:=Char:C90(Carriage return:K15:38)
Else 
	$EOL:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
End if 

READ WRITE:C146([PRJ_ConstructionProject:116])
C_TIME:C306($SQLDocument_tm)

C_TEXT:C284($Part1_txt; $Part2_txt)
C_BOOLEAN:C305($Complete_b; $Proceed_b)
C_LONGINT:C283($Count_l)
ARRAY LONGINT:C221($LockedRecords_al; 0)
$Count_l:=1
C_LONGINT:C283($Offset_l)
C_LONGINT:C283($NumberUpdated_l; $NumberAdded_l; $ArrayPosition_l; $NumberSkipped_l; $SizeOfArray_l; $win)
C_BOOLEAN:C305($Proceed_b)
ARRAY TEXT:C222($AE_ContractNumber_as; 0)  //Command Replaced was o_ARRAY string length was 50
ARRAY TEXT:C222($AE_LOCATION_atxt; 0)
ARRAY LONGINT:C221($AE_FileNumber_al; 0)
C_TIME:C306($StartTime_tm; $RemainingTime_tm)
ARRAY TEXT:C222($AE_Item_No_as; 0)
ARRAY TEXT:C222($AE_Units_as; 0)
ARRAY TEXT:C222($AE_ItemDescpt_atxt; 0)
ARRAY REAL:C219($AE_CONTQ_ar; 0)
ARRAY REAL:C219($AE_CONTR_Price_ar; 0)
C_LONGINT:C283($Loop_L)

If (SQL_Direct("sp_RTRVAEContractNo"))
	
	$SizeOfArray_l:=Size of array:C274(AE_ContractNumber_as)
	$StartTime_tm:=Current time:C178(*)
	//$win:=ut_OpenNewWindow (500;200;5;4;"Updating Construction Contract AE Data")
	C_OBJECT:C1216($progressObj_o)
	$progressObj_o:=ProgressNew("Updating Construction Contract AE Data"; $SizeOfArray_l; False:C215; ""; 3)
	
	Repeat 
		UpdateProgressNew($progressObj_o; $Count_l)
		//GOTO XY(5;2)
		//MESSAGE("Updating "+String($Count_l)+" out of "+String($SizeOfArray_l))
		//GOTO XY(5;5)
		//$RemainingTime_tm:=(($SizeOfArray_l/$Count_l)-1)*(Current time(*)-$StartTime_tm)
		//MESSAGE("Estimated time remaining is "+Time string($RemainingTime_tm))
		//GOTO XY(5;7)
		//MESSAGE("Elapsed time is "+Time string(Current time(*)-$StartTime_tm))
		$Proceed_b:=True:C214
		//AE_ContractNumber_as;->AE_LOCATION_atxt;->
		QUERY:C277([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5=AE_ContractNumber_as{$Count_l})
		QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileNumber_l:3=AE_FileNumber_al{$Count_l})
		If (Records in selection:C76([PRJ_ConstructionProject:116])=0)
			If (Records in selection:C76([PRJ_ProjectFile:117])=0)
				$NumberSkipped_l:=$NumberSkipped_l+1
				$Proceed_b:=False:C215
				PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Skipped file number "+String:C10(AE_FileNumber_al{$Count_l})+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
				
			Else 
				$NumberAdded_l:=$NumberAdded_l+1
				CREATE RECORD:C68([PRJ_ConstructionProject:116])
				[PRJ_ConstructionProject:116]PF_FileID_l:11:=[PRJ_ProjectFile:117]PF_FileID_l:1
				Inc_Sequence("CP_ConstructionProj"; ->[PRJ_ConstructionProject:116]CP_ConstructionProjectID_l:1)
				[PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5:=AE_ContractNumber_as{$Count_l}
				SAVE RECORD:C53([PRJ_ConstructionProject:116])
			End if 
		Else 
			$NumberUpdated_l:=$NumberUpdated_l+1
		End if 
		If ($Proceed_b)
			If (ut_LoadRecord(->[PRJ_ConstructionProject:116]))
				If ([PRJ_ConstructionProject:116]PF_FileID_l:11#[PRJ_ProjectFile:117]PF_FileID_l:1)
					PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"asking to change Construction contract  "+[PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
					$Part2_txt:=" --->To file No  "+String:C10([PRJ_ProjectFile:117]PF_FileNumber_l:3)
					
					QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileID_l:1=[PRJ_ConstructionProject:116]PF_FileID_l:11)
					$Part1_txt:=" --->From file No  "+String:C10([PRJ_ProjectFile:117]PF_FileNumber_l:3)
					PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+$Part1_txt+$Part2_txt+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
					
				End if 
				
				[PRJ_ConstructionProject:116]CP_AEDescription_txt:22:=AE_ContractDescpt_atxt{$Count_l}
				[PRJ_ConstructionProject:116]CP_AELocation_s:23:=AE_LOCATION_atxt{$Count_l}
				//[PRJ_ConstructionProject]AEAward_d:=Date(AE_AwardDate_atxt{$Count_l})
				
				If (SQL_Direct("sp_RTRVAEContData"))
					If (Size of array:C274(AE_Item_No_as)>0)
						For ($Loop_L; 1; Size of array:C274(AE_Item_No_as))
							APPEND TO ARRAY:C911($AE_Item_No_as; AE_Item_No_as{$Loop_L})
							APPEND TO ARRAY:C911($AE_Units_as; AE_Units_as{$Loop_L})
							APPEND TO ARRAY:C911($AE_ItemDescpt_atxt; AE_ItemDescpt_atxt{$Loop_L})
							APPEND TO ARRAY:C911($AE_CONTQ_ar; AE_CONTQ_ar{$Loop_L})
							APPEND TO ARRAY:C911($AE_CONTR_Price_ar; AE_CONTR_Price_ar{$Loop_L})
						End for 
						C_BLOB:C604($SQLArrays_x; $LocalArrays_x)
						C_LONGINT:C283($offset_L)
						$offset_L:=0
						BLOB TO VARIABLE:C533([PRJ_ConstructionProject:116]CP_AEData_blb:21; $SQLArrays_x; $offset_L)
						BLOB TO VARIABLE:C533([PRJ_ConstructionProject:116]CP_AEData_blb:21; $LocalArrays_x; $offset_L)
						SET BLOB SIZE:C606($SQLArrays_x; 0)
						VARIABLE TO BLOB:C532(AE_Item_No_as; $SQLArrays_x; *)
						VARIABLE TO BLOB:C532(AE_Units_as; $SQLArrays_x; *)
						VARIABLE TO BLOB:C532(AE_ItemDescpt_atxt; $SQLArrays_x; *)
						VARIABLE TO BLOB:C532(AE_CONTQ_ar; $SQLArrays_x; *)
						VARIABLE TO BLOB:C532(AE_CONTR_Price_ar; $SQLArrays_x; *)
						SET BLOB SIZE:C606([PRJ_ConstructionProject:116]CP_AEData_blb:21; 0)
						VARIABLE TO BLOB:C532($SQLArrays_x; [PRJ_ConstructionProject:116]CP_AEData_blb:21)
						VARIABLE TO BLOB:C532($LocalArrays_x; [PRJ_ConstructionProject:116]CP_AEData_blb:21; *)
						SET BLOB SIZE:C606($SQLArrays_x; 0)
						SET BLOB SIZE:C606($LocalArrays_x; 0)
						
					Else 
						If ([PRJ_ConstructionProject:116]CP_AELocation_s:23="District@")
							SET BLOB SIZE:C606([PRJ_ConstructionProject:116]CP_AEData_blb:21; 0)
						End if 
					End if 
				Else 
					PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Call to sp_RTRVAEContData Failed for "+"[PRJ_ConstructionProject]CP_ConstructionContractNo_s "+[PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5+$Eol
					PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+SQL_ReturnErrorDescriptions+$eol
					$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
					SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
					CLOSE DOCUMENT:C267($SQLDocument_tm)
					PRJ_SQLRetrieveStats_txt:=""
					
				End if 
				
				SAVE RECORD:C53([PRJ_ConstructionProject:116])
				UNLOAD RECORD:C212([PRJ_ConstructionProject:116])
			Else 
				APPEND TO ARRAY:C911($AE_ContractNumber_as; AE_ContractNumber_as{$Count_l})
				APPEND TO ARRAY:C911($AE_LOCATION_atxt; AE_LOCATION_atxt{$Count_l})
				APPEND TO ARRAY:C911($AE_FileNumber_al; AE_FileNumber_al{$Count_l})
				APPEND TO ARRAY:C911($AE_ContractDescpt_atxt; AE_ContractDescpt_atxt{$Count_l})
				//ARRAY TEXT(;0)
				
			End if 
		End if 
		If (Length:C16(PRJ_SQLRetrieveStats_txt)>25000)
			$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
			SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
			CLOSE DOCUMENT:C267($SQLDocument_tm)
			PRJ_SQLRetrieveStats_txt:=""
		End if 
		$Count_l:=$Count_l+1
		If ($Count_l>Size of array:C274(AE_ContractNumber_as))
			If (Size of array:C274($AE_ContractNumber_as)>0)
				COPY ARRAY:C226($AE_ContractNumber_as; AE_ContractNumber_as)
				COPY ARRAY:C226($AE_LOCATION_atxt; AE_LOCATION_atxt)
				COPY ARRAY:C226($AE_FileNumber_al; AE_FileNumber_al)
				COPY ARRAY:C226($AE_ContractDescpt_atxt; AE_ContractDescpt_atxt)
				ARRAY TEXT:C222($AE_ContractNumber_as; 0)  //Command Replaced was o_ARRAY string length was 50
				ARRAY TEXT:C222($AE_LOCATION_atxt; 0)
				ARRAY TEXT:C222($AE_ContractDescpt_atxt; 0)
				ARRAY LONGINT:C221($AE_FileNumber_al; 0)
				$Count_l:=1
			Else 
				$Complete_b:=True:C214
				
			End if 
		End if 
	Until ($Complete_b)
	//CLOSE WINDOW
	Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))
	C_TEXT:C284($FolderName_txt)
	C_TEXT:C284($result_txt)
	COPY ARRAY:C226($AE_Item_No_as; AE_Item_No_as)
	COPY ARRAY:C226($AE_Units_as; AE_Units_as)
	COPY ARRAY:C226($AE_ItemDescpt_atxt; AE_ItemDescpt_atxt)
	COPY ARRAY:C226($AE_CONTQ_ar; AE_CONTQ_ar)
	COPY ARRAY:C226($AE_CONTR_Price_ar; AE_CONTR_Price_ar)
	$Result_txt:=ut_ArraysToText(","; \
		->AE_Item_No_as; \
		->AE_Units_as; \
		->AE_ItemDescpt_atxt; \
		->AE_CONTQ_ar; \
		->AE_CONTR_Price_ar)
	ARRAY TEXT:C222(AE_Item_No_as; 0)
	ARRAY TEXT:C222(AE_Units_as; 0)
	ARRAY TEXT:C222(AE_ItemDescpt_atxt; 0)
	ARRAY REAL:C219(AE_CONTQ_ar; 0)
	ARRAY REAL:C219(AE_CONTR_Price_ar; 0)
	
	C_TEXT:C284($Path_txt; $FileName_txt)
	$Path_txt:=ut_PRJ_CreateFolderPath("CSV_OutPut")
	
	C_TEXT:C284($FileName_txt)
	$FileName_txt:="sp_RTRVAEContData-"+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178; "a")+".csv"
	C_TIME:C306($Doc_tm)
	$Doc_tm:=Create document:C266($Path_txt+$FileName_txt)
	CLOSE DOCUMENT:C267($Doc_tm)
	TEXT TO DOCUMENT:C1237($Path_txt+$FileName_txt; $Result_txt; UTF8 text without length:K22:17)
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Newly Retrieved and updated AE contract data -> "+String:C10($NumberAdded_l)+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Updated AE contract data  -> "+String:C10($NumberUpdated_l)+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Skipped AE contract data  -> "+String:C10($NumberSkipped_l)+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
Else 
	
	
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Call to sp_RTRVAEContractNo Failed"+$Eol
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+SQL_ReturnErrorDescriptions+$eol
	$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
	SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
	CLOSE DOCUMENT:C267($SQLDocument_tm)
	PRJ_SQLRetrieveStats_txt:=""
End if 


//End ut_PRJGetAEData