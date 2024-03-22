//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/29/09, 10:18:59
	// ----------------------------------------------------
	// Method: ut_updateNBIRecords
	// Description
	// Update [Bridge MHD NBIS] records from an NBI input data file. like the MFINPUT.dat submitted to FHWA
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_05
End if 

C_TIME:C306($dImportFile)
C_TEXT:C284($tBuffer; $tNBI; $primary)
C_LONGINT:C283($counter; $recnum)
C_TEXT:C284($item8)  // Command Replaced was o_C_STRING length was 15
C_TEXT:C284($brkey)  // Command Replaced was o_C_STRING length was 12
C_TEXT:C284($sdate)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283(vBIN_Dec)

//Initialize bridge key array
ALL RECORDS:C47([Bridge MHD NBIS:1])
ARRAY TEXT:C222($aitem8; Records in selection:C76([Bridge MHD NBIS:1]))  //Command Replaced was o_ARRAY string length was 15
ARRAY TEXT:C222($aBrKey; Records in selection:C76([Bridge MHD NBIS:1]))  //Command Replaced was o_ARRAY string length was 12
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item8:206; $aitem8; [Bridge MHD NBIS:1]Bridge Key:2; $aBrKey)
C_BOOLEAN:C305($BlankDB_b)
$BlankDB_b:=(Records in table:C83([Bridge MHD NBIS:1])=0)

NewWindow(400; 50; 0; 4; "Importing")
$counter:=0
$dImportFile:=Open document:C264(""; "TEXT")  //Prompt user
If (Ok=1)
	START TRANSACTION:C239
	//read in the first record
	RECEIVE PACKET:C104($dImportFile; $tBuffer; <>sCR)
	$tNBI:=$tBuffer
	$counter:=$counter+1
	// 2-10-2000 : CM - Line removed
	//RECEIVE PACKET($dImportFile;$tBuffer;1)  `read in line feed character
	While (Ok=1)
		// 2-10-2000 : CM
		// Modification to account for CRLF or just CR records
		If (Substring:C12($tNBI; 1; 1)=<>sLF)
			//if 1st char is a LF then skip it    
			$tNBI:=Substring:C12($tNBI; 2)
		End if 
		
		$item8:=Substring:C12($tNBI; 4; 15)
		$recnum:=Find in array:C230($aitem8; $item8)
		
		If ($recnum>0)
			GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; $recnum)
			GOTO XY:C161(1; 1)  // 2-10-2000 : CM 
			MESSAGE:C88("Updating record "+$item8)
			//     10-10-2000 : CM Else statement that was here moved to bottom of routine
			//     to avoid creating new records
			LoadNBIData($tNBI)
			SAVE RECORD:C53([Bridge MHD NBIS:1])  //Save record resets the Ok variable so we must read a record
			//     10-10-2000 : CM This Else statement moved from  top of IF($recnum>0)
		Else 
			//   10-10-2000 : CM
			GOTO XY:C161(1; 1)  // 2-10-2000 : CM 
			MESSAGE:C88("Import Record "+String:C10($counter)+" with Bridge Key "+$item8+" not found in Database")
			$primary:=Substring:C12($tNBI; 19; 1)
			Case of 
				: (Not:C34($BlankDB_b))
					//If it is not a blank DB we don't do anything.
					
				: (($primary="1") | ($primary=" "))
					//    10-10-2000 : CM   commented out following code ******    
					GOTO XY:C161(1; 1)  // 2-10-2000 : CM 
					MESSAGE:C88("Creating Record "+$item8)
					CREATE RECORD:C68([Bridge MHD NBIS:1])
					//    Inc_Sequence ("BIN";->vBIN_Dec)
					[Bridge MHD NBIS:1]BDEPT:1:=Substring:C12($item8; 1; 6)
					[Bridge MHD NBIS:1]BIN:3:=Substring:C12($item8; 7; 3)
					[Bridge MHD NBIS:1]Item8:206:=$item8
					[Bridge MHD NBIS:1]Item8 Owner:208:=Substring:C12($item8; 10; 3)
					[Bridge MHD NBIS:1]Item8 BridgeCat:207:=Substring:C12($item8; 13; 3)
					LoadNBIData($tNBI)
					If (([Bridge MHD NBIS:1]Item8 BridgeCat:207="NBI") | ([Bridge MHD NBIS:1]Item8 BridgeCat:207="634"))
						[Bridge MHD NBIS:1]FHWARecord:174:=True:C214
					End if 
					SAVE RECORD:C53([Bridge MHD NBIS:1])  //Save record resets the Ok variable so we must read a record
				Else 
					//Secondary
					GOTO XY:C161(1; 1)  // 2-10-2000 : CM 
					MESSAGE:C88("Creating Secondary Record "+$item8+" -"+$primary)
					CREATE RECORD:C68([NBIS Secondary:3])
					[NBIS Secondary:3]BIN:1:=Substring:C12($item8; 7; 3)
					[NBIS Secondary:3]Item8:38:=$item8
					[NBIS Secondary:3]Bridge Key:34:=Substring:C12($item8; 1; 12)
					LoadNBIData($tNBI; "Secondary")
					SAVE RECORD:C53([NBIS Secondary:3])
					
			End case 
			
		End if 
		If ($counter%40=0)
			//FLUSH CACHE
		End if 
		//read in a record-this must follow
		RECEIVE PACKET:C104($dImportFile; $tBuffer; <>sCR)
		$tNBI:=$tBuffer
		$counter:=$counter+1
		//  2-10-2000 : CM - Line removed
		//RECEIVE PACKET($dImportFile;$tBuffer;1)  `read in line feed character for a DOS
	End while 
	CONFIRM:C162("Save Transaction?"; "Save"; "Cancel")
	If (ok=1)
		VALIDATE TRANSACTION:C240
	Else 
		CANCEL TRANSACTION:C241
	End if 
	
	CLOSE DOCUMENT:C267($dImportFile)
End if 
CLOSE WINDOW:C154