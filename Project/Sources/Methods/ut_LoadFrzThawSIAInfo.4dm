//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/30/07, 10:59:42
	// ----------------------------------------------------
	// Method: ut_LoadFrzThawSIAInfo
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM08
	Mods_2009_03  //CJM  r001   `03/06/09, 14:41:31`Upgrade from open form window to open window
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
End if 
C_LONGINT:C283(FRZ_DISTNO)
C_TEXT:C284(FRZ_List1File; FRZ_List2File; FRZ_List3File)
C_LONGINT:C283($Tempwin)
C_BOOLEAN:C305($TestOK)

C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)
FORM GET PROPERTIES:C674([Dialogs:21]; "FreezeThawListInput"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
//$Tempwin:=Open form window([Dialogs];"FreezeThawListInput")
DIALOG:C40([Dialogs:21]; "FreezeThawListInput")
CLOSE WINDOW:C154($Win_l)
If (OK=1)
	$TestOK:=((FRZ_DISTNO#0) & (Test path name:C476(FRZ_List1File)=1) & (Test path name:C476(FRZ_List2File)=1) & (Test path name:C476(FRZ_List3File)=1))
	If ($TestOK)
		
		C_TIME:C306($dImportFile)
		ARRAY TEXT:C222($BinsList1_as; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY TEXT:C222($BinsList2_as; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY TEXT:C222($BinsList3_as; 0)  //Command Replaced was o_ARRAY string length was 3
		C_TEXT:C284($Buffer_txt)
		
		$dImportFile:=Open document:C264(FRZ_List1File; "TEXT")
		While (OK=1)
			RECEIVE PACKET:C104($dImportFile; $Buffer_txt; <>sCR)
			If (Substring:C12($Buffer_txt; 1; 1)=<>sLF)
				$Buffer_txt:=Substring:C12($Buffer_txt; 2)
			End if 
			If ($Buffer_txt#"")
				$BIN:=Substring:C12($Buffer_txt; 1; 3)
				INSERT IN ARRAY:C227($BinsList1_as; 0)
				$BinsList1_as{1}:=$BIN
			End if 
		End while 
		CLOSE DOCUMENT:C267($dImportFile)
		C_TEXT:C284($BIN)  // Command Replaced was o_C_STRING length was 3
		$dImportFile:=Open document:C264(FRZ_List2File; "TEXT")
		While (OK=1)
			RECEIVE PACKET:C104($dImportFile; $Buffer_txt; <>sCR)
			If (Substring:C12($Buffer_txt; 1; 1)=<>sLF)
				$Buffer_txt:=Substring:C12($Buffer_txt; 2)
			End if 
			If ($Buffer_txt#"")
				$BIN:=Substring:C12($Buffer_txt; 1; 3)
				INSERT IN ARRAY:C227($BinsList2_as; 0)
				$BinsList2_as{1}:=$BIN
			End if 
		End while 
		CLOSE DOCUMENT:C267($dImportFile)
		
		$dImportFile:=Open document:C264(FRZ_List3File; "TEXT")
		While (OK=1)
			RECEIVE PACKET:C104($dImportFile; $Buffer_txt; <>sCR)
			If (Substring:C12($Buffer_txt; 1; 1)=<>sLF)
				$Buffer_txt:=Substring:C12($Buffer_txt; 2)
			End if 
			If ($Buffer_txt#"")
				$BIN:=Substring:C12($Buffer_txt; 1; 3)
				INSERT IN ARRAY:C227($BinsList3_as; 0)
				$BinsList3_as{1}:=$BIN
			End if 
		End while 
		CLOSE DOCUMENT:C267($dImportFile)
		
		C_LONGINT:C283(<>ProgressPID; $NumRecords; $CurrRecNum)
		C_LONGINT:C283($NumUpdated; $ListIndex)
		ARRAY LONGINT:C221($NumUpdated_aL; 4)
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]InspResp:173="DIST"+String:C10(FRZ_DISTNO))
		$NumRecords:=Records in selection:C76([Bridge MHD NBIS:1])
		<>ProgressPID:=StartProgress("Freeze Thaw Update"; "None"; "Bridge Records")
		$CurrRecNum:=0
		$NumUpdated:=0
		UpdateProgress(0; $NumRecords)
		FIRST RECORD:C50([Bridge MHD NBIS:1])
		While (Not:C34(End selection:C36([Bridge MHD NBIS:1])))
			
			If (ut_LoadRecordInteractive(->[Bridge MHD NBIS:1]))
				Case of 
					: (Find in array:C230($BinsList1_as; [Bridge MHD NBIS:1]BIN:3)>0)
						$ListIndex:=2
					: (Find in array:C230($BinsList2_as; [Bridge MHD NBIS:1]BIN:3)>0)
						$ListIndex:=3
					: (Find in array:C230($BinsList3_as; [Bridge MHD NBIS:1]BIN:3)>0)
						$ListIndex:=4
					Else 
						$ListIndex:=1
				End case 
				If (<>aFreezeThawCode{$ListIndex}#[Bridge MHD NBIS:1]FreezeThaw:225)
					[Bridge MHD NBIS:1]FreezeThaw:225:=<>aFreezeThawCode{$ListIndex}
					LogChanges(->[Bridge MHD NBIS:1]FreezeThaw:225; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
					SAVE RECORD:C53([Bridge MHD NBIS:1])
					$NumUpdated:=$NumUpdated+1
					$NumUpdated_aL{$ListIndex}:=$NumUpdated_aL{$ListIndex}+1
				End if 
				
			Else 
				//Skip it 
			End if 
			
			$CurrRecNum:=$CurrRecNum+1
			If (($CurrRecNum%20)=0)
				UpdateProgress($CurrRecNum; $NumRecords)
				//FLUSH CACHE
			End if 
			
			NEXT RECORD:C51([Bridge MHD NBIS:1])
		End while 
		POST OUTSIDE CALL:C329(<>ProgressPID)
		C_TEXT:C284($msg)
		$msg:="Updated "+String:C10($NumUpdated)+" Bridge Records!"
		$msg:=$Msg+<>sCR+"To List 1 "+String:C10($NumUpdated_aL{2})
		$msg:=$Msg+<>sCR+"To List 2 "+String:C10($NumUpdated_aL{3})
		$msg:=$Msg+<>sCR+"To List 3 "+String:C10($NumUpdated_aL{4})
		$msg:=$Msg+<>sCR+"Off List "+String:C10($NumUpdated_aL{1})
		ALERT:C41($Msg)
		$msg:=""
	Else 
		ALERT:C41("Missing or bad info in dialog!")
	End if 
	
	
End if 