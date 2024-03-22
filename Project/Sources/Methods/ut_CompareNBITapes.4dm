//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/31/08, 09:44:38
	// ----------------------------------------------------
	// Method: ut_CompareNBITapes
	// Description
	// Compare the Item 8s from two NBI tapes to come up
	// with any changes to Item 8 of records.
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5403
End if 
C_TIME:C306($OldNBIdata_file; $NewNBIData_file)

ALERT:C41("Select old NBI data file")
$OldNBIdata_file:=Open document:C264(""; "TEXT")
If (OK=1)
	ALERT:C41("Select new NBI data file")
	$NewNBIData_file:=Open document:C264(""; "TEXT")
	If (OK=1)
		ARRAY TEXT:C222($OldItem8_as; 6000)  //Command Replaced was o_ARRAY string length was 15
		ARRAY TEXT:C222($OldBIN_as; 6000)  //Command Replaced was o_ARRAY string length was 3
		ARRAY TEXT:C222($NewItem8_as; 6000)  //Command Replaced was o_ARRAY string length was 15
		ARRAY TEXT:C222($NewBIN_as; 6000)  //Command Replaced was o_ARRAY string length was 3
		C_TEXT:C284($tBuffer; $item5_txt)
		C_LONGINT:C283($counter_L)
		$counter_L:=0
		SHORT_MESSAGE("Loading old data...")
		RECEIVE PACKET:C104($OldNBIdata_file; $tBuffer; <>sCR)
		While (Ok=1)
			If (Substring:C12($tBuffer; 1; 1)=<>sLF)
				$tBuffer:=Substring:C12($tBuffer; 2)
			End if 
			
			$item5_txt:=Substring:C12($tBuffer; 19; 9)
			If (Substring:C12($item5_txt; 1; 1)="1")
				$counter_L:=$counter_L+1
				$OldItem8_as{$Counter_L}:=Substring:C12($tBuffer; 4; 15)
				$OldBIN_as{$Counter_L}:=Substring:C12($OldItem8_as{$Counter_L}; 7; 3)
			End if 
			RECEIVE PACKET:C104($OldNBIdata_file; $tBuffer; <>sCR)
		End while 
		ARRAY TEXT:C222($OldItem8_as; $counter_L)  //Command Replaced was o_ARRAY string length was 15
		ARRAY TEXT:C222($OldBIN_as; $counter_L)  //Command Replaced was o_ARRAY string length was 3
		CLOSE WINDOW:C154
		SHORT_MESSAGE("Loading New data...")
		$counter_L:=0
		RECEIVE PACKET:C104($NewNBIData_file; $tBuffer; <>sCR)
		While (Ok=1)
			If (Substring:C12($tBuffer; 1; 1)=<>sLF)
				$tBuffer:=Substring:C12($tBuffer; 2)
			End if 
			$item5_txt:=Substring:C12($tBuffer; 19; 9)
			If (Substring:C12($item5_txt; 1; 1)="1")
				$counter_L:=$counter_L+1
				$NewItem8_as{$Counter_L}:=Substring:C12($tBuffer; 4; 15)
				$NewBIN_as{$Counter_L}:=Substring:C12($NewItem8_as{$Counter_L}; 7; 3)
			End if 
			RECEIVE PACKET:C104($NewNBIData_file; $tBuffer; <>sCR)
			
		End while 
		ARRAY TEXT:C222($NewItem8_as; $counter_L)  //Command Replaced was o_ARRAY string length was 15
		ARRAY TEXT:C222($NewBIN_as; $counter_L)  //Command Replaced was o_ARRAY string length was 3
		CLOSE WINDOW:C154
		SHORT_MESSAGE("Comparing "+String:C10(Size of array:C274($NewBIN_as))+" new to "+String:C10(Size of array:C274($OldBIN_as))+" old....")
		SORT ARRAY:C229($OldBIN_as; $OldItem8_as)
		SORT ARRAY:C229($NewBIN_as; $NewItem8_as)
		C_LONGINT:C283($i; $k)
		For ($i; 1; Size of array:C274($NewItem8_as))
			$k:=Find in array:C230($OldBIN_as; $NewBIN_as{$i})
			If ($k>0)
				If ($OldItem8_as{$k}#$NewItem8_as{$i})
					ALERT:C41("Item 8 changed for BIN "+$NewBIN_as{$i}+" from "+$OldItem8_as{$k}+" to "+$NewItem8_as{$i})
				End if 
			End if 
			
		End for 
		CLOSE WINDOW:C154
		ALERT:C41("Done")
		CLOSE DOCUMENT:C267($NewNBIData_file)
	End if 
	
	CLOSE DOCUMENT:C267($OldNBIdata_file)
End if 