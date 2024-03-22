//%attributes = {"invisible":true,"publishedSql":true,"executedOnServer":true}
//Method: ut_ReturnBackupInfo
//Description
// Return info about backup status from server. Will execute on server.
// Parameters
// $1 : $BackupInfo_txt
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): Charles Miller
	//Date and time: 02/14/12, 13:17:30
	//----------------------------------------------------
	Mods_2012_02  //r003`Add code to return backup info available from sql function
	//Modified by: Charles Miller (2/14/12 13:17:31)
	Mods_2012_08  //r001 `Adjust how errors are returned by comparing backup size to disk space
	//Also returned text about this error as well as back up status when not = 0
	//Modified by: Charles Miller (8/23/12 13:21:50)
	Mods_2019_06  //Add code to return create date and time and Mod date and time for last backup
	//Modified by: Chuck Miller (6/11/19 11:48:24)
	Mods_2020_04  //Modified to make sure no errors occur whn running on a test platform
	//Modified by: Chuck (4/28/20 15:47:59)
	Mods_2022_02  //Modified as xml document has changed location and format
	// Modified by: Costas Manousakis-(Designer)-(2022-12-13 19:08:03)
	Mods_2022_12_bug
	//  `fixed getting volume attributes for windows
	//  `modified/added info to the return message
	//  `added information from backuphistroy.json file in the backup folder
	// Modified by: Costas Manousakis-(Designer)-(2023-09-19 17:08:40)
	Mods_2023_09
	//  `declared $dataFromhistory at the start of declarations
	// Modified by: Costas Manousakis-(Designer)-(2023-10-10 14:08:55)
	Mods_2023_10
	//  `don't raise error if the next backup date is 00/00/00 ie no scheduled backup
End if 
//TRACE
C_TEXT:C284($0; $Return_txt)
C_TEXT:C284($Bstat_txt)
C_LONGINT:C283($Bstat_L)
C_DATE:C307($lastB_d; $NextB_d)
C_TIME:C306($LastB_t; $NextB_t)
C_LONGINT:C283($loop_L; $totSize_L; $Position_l; $NumberFound_l)
C_REAL:C285($Size_r; $totSize_r; $CalculatedFree_r; $CalculatedBackup_r; $vSize; $vUsed; $vFree)

C_TEXT:C284($backFolder_txt; $backupXML_txt; $PriorityReason_txt; $wildCard; $BackupNumber_txt)
C_BLOB:C604($XMLBlob_x)
C_TEXT:C284($XML_ref_s; $FirstChld_s; $SecondChild_s; $Child3_s; $Child4_s)  // Command Replaced was o_C_STRING length was 16
C_TEXT:C284($ChildName; $ChildValue; $BackupName_txt; $BackupVol_txt; $Backuppath_txt; $dataFromhistory)
C_BOOLEAN:C305($BULocked_B; $BUInvisible_B)
C_DATE:C307($BUCreated_D; $BUModified_D)
C_TIME:C306($BUModified_tm; $BUCreated_tm)

C_BOOLEAN:C305($Complete_b; $Priority_b)
ARRAY TEXT:C222($VolList_atxt; 0)

$PriorityReason_txt:=""
$totSize_r:=0
$NumberFound_l:=0

GET BACKUP INFORMATION:C888(Last backup date:K54:1; $lastB_d; $LastB_t)

GET BACKUP INFORMATION:C888(Last backup status:K54:2; $Bstat_L; $Bstat_txt)

GET BACKUP INFORMATION:C888(Next backup date:K54:3; $NextB_d; $NextB_t)
$Return_txt:=""
$Return_txt:=$Return_txt+"Application file: "+Application file:C491+Char:C90(Carriage return:K15:38)
$Return_txt:=$Return_txt+"Structure file: "+Structure file:C489+Char:C90(Carriage return:K15:38)
$Return_txt:=$Return_txt+"Data file: "+Data file:C490+Char:C90(Carriage return:K15:38)
$Return_txt:=$Return_txt+"Machine Name: "+Current machine:C483+Char:C90(Carriage return:K15:38)
$Return_txt:=$Return_txt+"Last Backup on: "+String:C10($lastB_d)+"-"+String:C10($LastB_t)+Char:C90(Carriage return:K15:38)+"Status: "+String:C10($Bstat_L)+" ("+$Bstat_txt+")"+Char:C90(Carriage return:K15:38)


C_TEXT:C284($backFolder_txt; $backupXML_txt; $XML_ChildRef_txt; $XML_ref_txt)
$backupXML_txt:=Get 4D file:C1418(Current backup settings file:K5:29)

If (Test path name:C476($backupXML_txt)=Is a document:K24:1)
	
	DOCUMENT TO BLOB:C525($backupXML_txt; $XMLBlob_x)
	
	$XML_ref_txt:=DOM Parse XML variable:C720($XMLBlob_x)
	
	$XML_ChildRef_txt:=DOM Find XML element:C864($XML_ref_txt; "Preferences4D/Backup/Settings/General/DestinationFolder")
	DOM GET XML ELEMENT VALUE:C731($XML_ChildRef_txt; $BackupPath_txt)
	$XML_ChildRef_txt:=DOM Find XML element:C864($XML_ref_txt; "Preferences4D/Backup/Settings/Advanced/SetNumber/Value")
	DOM GET XML ELEMENT VALUE:C731($XML_ChildRef_txt; $BackupNumber_txt)
	C_LONGINT:C283($loop_L; $totSize_L; $Position_l; $NumberFound_l)
	C_REAL:C285($Size_r; $totSize_r)
	$totSize_r:=0
	$NumberFound_l:=0
	
	If (Test path name:C476($Backuppath_txt)=Is a folder:K24:2)
		DOCUMENT LIST:C474($Backuppath_txt; $FileList_atxt)
		For ($loop_l; Size of array:C274($FileList_atxt); 1; -1)
			$NumberFound_l:=$NumberFound_l+1
			$Size_r:=0
			Case of 
				: (Position:C15(".4BK"; $FileList_atxt{$loop_l})>0)
					$Size_r:=Get document size:C479($Backuppath_txt+$FileList_atxt{$loop_l})
					
				: (Position:C15(".4BL"; $FileList_atxt{$loop_l})>0)
					$Size_r:=Get document size:C479($Backuppath_txt+$FileList_atxt{$loop_l})
					
				Else 
					DELETE FROM ARRAY:C228($FileList_atxt; $loop_l; 1)
					$NumberFound_l:=$NumberFound_l-1
			End case 
			If ($Size_r<0)
				$Size_r:=$Size_r*-1
			End if 
			$totSize_r:=$totSize_r+$Size_r
		End for 
		
		//get the backuphistory.json
		C_OBJECT:C1216($backupHistory_o)
		C_TEXT:C284($backupHistory_txt; $dataFromhistory)
		C_REAL:C285($StrbkupsSize; $LastBkupSize)
		C_LONGINT:C283($startNumb; $endNumb; $bkups_L)
		$bkups_L:=0
		If (Test path name:C476($Backuppath_txt+"backuphistory.json")=Is a document:K24:1)
			$backupHistory_txt:=Document to text:C1236($Backuppath_txt+"backuphistory.json")
			$backupHistory_o:=JSON Parse:C1218($backupHistory_txt)
			ARRAY TEXT:C222($structurenames_atxt; 0)
			OB GET PROPERTY NAMES:C1232($backupHistory_o; $structurenames_atxt)
			C_LONGINT:C283($currstr_L)
			$currstr_L:=Find in array:C230($structurenames_atxt; "@"+Structure file:C489+"@")
			
			If ($currstr_L>0)
				
				C_COLLECTION:C1488($strbackups_c)
				$strbackups_c:=OB Get:C1224($backupHistory_o; $structurenames_atxt{$currstr_L})
				C_OBJECT:C1216($bkup_o)
				For each ($bkup_o; $strbackups_c)
					If (Test path name:C476($bkup_o.backupPath)=Is a document:K24:1)
						$bkups_L:=$bkups_L+1
						$StrbkupsSize:=$StrbkupsSize+Get document size:C479($bkup_o.backupPath)
						$LastBkupSize:=Get document size:C479($bkup_o.backupPath)
						If ($startNumb=0)
							$startNumb:=$bkup_o.backupNumber
						End if 
						$endNumb:=$bkup_o.backupNumber
						If (Test path name:C476($bkup_o.logPath)=Is a document:K24:1)
							//there is also a .4BL file - add it's size too
							$StrbkupsSize:=$StrbkupsSize+Get document size:C479($bkup_o.logPath)
							$LastBkupSize:=$LastBkupSize+Get document size:C479($bkup_o.logPath)
						End if 
					End if 
				End for each 
				
			End if 
			
			$dataFromhistory:="\n\nInfo from backuphistory.json\nFor structure file "+Structure file:C489+" found "+String:C10($bkups_L)+" backup sets\n"+\
				"Start from "+String:C10($startNumb)+" ending at "+String:C10($endNumb)+"\n"+\
				"Total size .4BK and .4BL = "+String:C10($StrbkupsSize/(1024*1024); "###,###,###.0 MB")+"\n"+\
				"Size of last backup set = "+String:C10($LastBkupSize/(1024*1024); "###,###,###.0 MB")+"\n"
		End if 
		
	Else 
		If ($PriorityReason_txt="")
			$PriorityReason_txt:="Backup path not found"
		Else 
			$PriorityReason_txt:=$PriorityReason_txt+"Backup path not found"+Char:C90(Carriage return:K15:38)
		End if 
		$Priority_b:=True:C214
	End if 
	
	$BackupVol_txt:=Substring:C12($Backuppath_txt; 1; Position:C15(Folder separator:K24:12; $Backuppath_txt))
	$BackupVol_txt:=Replace string:C233($BackupVol_txt; Folder separator:K24:12; "")
	ARRAY TEXT:C222($VolList_atxt; 0)
	VOLUME LIST:C471($VolList_atxt)
	C_REAL:C285($vSize; $vUsed; $vFree)
	
	If (Is Windows:C1573)
		If (Find in array:C230($VolList_atxt; $BackupVol_txt+"\\")>0)  //in windows volume list includes the backslash
			VOLUME ATTRIBUTES:C472($BackupVol_txt; $vSize; $vUsed; $vFree)  //backslash not needed for attributes
		End if 
	Else 
		If (Find in array:C230($VolList_atxt; $BackupVol_txt)>0)
			VOLUME ATTRIBUTES:C472($BackupVol_txt; $vSize; $vUsed; $vFree)
		End if 
	End if 
	
	$vFree:=$vFree/1024/1024
	
	C_REAL:C285($CalculatedFree_r; $CalculatedBackup_r)
	$CalculatedFree_r:=$vFree
	$CalculatedBackup_r:=(($totSize_r/1024)/1024)
	C_TEXT:C284($PriorityReason_txt)
	$PriorityReason_txt:=""
	If ($Bstat_L#0)
		$Priority_b:=True:C214
		$PriorityReason_txt:="Last back up status was "+String:C10($Bstat_L)+Char:C90(Carriage return:K15:38)
	End if 
	If (($CalculatedBackup_r*2)>=$CalculatedFree_r)
		$Priority_b:=True:C214
		$PriorityReason_txt:=$PriorityReason_txt+" "+$BackupNumber_txt+" Backups of size "+String:C10($CalculatedBackup_r; "###,###,###.0")+" MB."
		$PriorityReason_txt:=$PriorityReason_txt+" is bigger than remaining space of "+String:C10($CalculatedFree_r; "###,###,###.0")+" MB."+Char:C90(Carriage return:K15:38)
	End if 
	
	If ($bkups_L>0)
		//found backups using backuphistory.json
		If ((2.5*$LastBkupSize)/(1024*1024)>=$CalculatedFree_r)
			$Priority_b:=True:C214
			$dataFromhistory:=$dataFromhistory+"\n *********** \n"+\
				"2.5 * Size of last backup set ("+\
				String:C10((2*$LastBkupSize)/(1024*1024); "###,###,###.0 MB")+") is bigger than remaining space of "+\
				String:C10($CalculatedFree_r; "###,###,###.0 MB")+"\n *********** \n\n"
		End if 
		
	End if 
	//: ($vFree<200000)
	//$Priority_b:=True
	If (Size of array:C274($FileList_atxt)>0)
		$BackupName_txt:=Substring:C12($FileList_atxt{1}; 1; Position:C15("["; $FileList_atxt{1})-1)+"- from 1 to "+String:C10($NumberFound_l)+Char:C90(Carriage return:K15:38)
	Else 
		$BackupName_txt:="No backups yet performed "+Char:C90(Carriage return:K15:38)
	End if 
	$Return_txt:=$Return_txt+"Backup on volume: "+$BackupVol_txt+Char:C90(Carriage return:K15:38)
	$Return_txt:=$Return_txt+"Backup set: "+$BackupName_txt
	$Return_txt:=$Return_txt+"Keeping : "+$BackupNumber_txt+" sets\n"
	$Return_txt:=$Return_txt+"Backup Size: "+String:C10($CalculatedBackup_r; "###,###,###.0")+" MB."+Char:C90(Carriage return:K15:38)
	$Return_txt:=$Return_txt+"Available space on volume "+$BackupVol_txt+" = "+String:C10($vFree; "###,###,###.0")+" MB."+Char:C90(Carriage return:K15:38)
	
End if 
$Return_txt:=$Return_txt+"Next Backup on: "+String:C10($NextB_d)+"-"+String:C10($NextB_t)
C_BOOLEAN:C305($SendWithAtention_b)
C_LONGINT:C283($Difference_L; $CDayofWeek_L; $LDayofWeek_L)
$Difference_L:=Current date:C33-$lastB_d
Case of 
	: ($NextB_d=!00-00-00!)
		//if there is no next backup - no need for error
	: ($Difference_L>2)
		$SendWithAtention_b:=True:C214
		$PriorityReason_txt:="More than two days since last backup!"
	: ($Difference_L>1)
		$CDayofWeek_L:=Day number:C114(Current date:C33)
		$LDayofWeek_L:=Day number:C114($lastB_d)
		If ($CDayofWeek_L=Monday:K10:13) & ($LDayofWeek_L=Saturday:K10:18)
			// if we are checking Monday and last backup was Saturday - no error yet
		Else 
			$PriorityReason_txt:="More than one day since last backup!"
			$SendWithAtention_b:=True:C214
		End if 
	Else 
		
End case 
If ($SendWithAtention_b | $Priority_b)
	$Return_txt:="Priority Message!!\n"+$PriorityReason_txt+"\n"+$Return_txt
Else 
	
End if 
$0:=$Return_txt+$dataFromhistory
//End ut_ReturnBackupInfo