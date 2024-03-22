//%attributes = {"invisible":true}
//Method: DEV_ReplaceObjecSetColor
//Description
// Replace the _ o _object set color commands in all methods or selected ones
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-06-06T00:00:00, 17:11:48
	// ----------------------------------------------------
	//Created : 
	Mods_2022_06
	
End if 
//

If (User in group:C338(Current user:C182; "Design Access Group"))
	
	CONFIRM:C162("Quit all current progress bars?")
	If (OK=1)
		Progress QUIT(0)
	End if 
	C_BOOLEAN:C305($savetoDB)
	CONFIRM:C162("Save method code changes in database?"; "Save"; "only save to file")
	$savetoDB:=(OK=1)
	CONFIRM:C162("Proceed with replacing all _o_Object set color commands?"; "All"; "Pick individual methods")
	
	ARRAY TEXT:C222($allMethods_atxt; 0)
	METHOD GET PATHS:C1163(Path all objects:K72:16; $allMethods_atxt)
	SORT ARRAY:C229($allMethods_atxt)
	ARRAY TEXT:C222($MethodsFixed_atxt; 0)
	C_BOOLEAN:C305($newMeth_b)
	C_TEXT:C284($meth_txt)
	
	If (OK=1)
		
		C_LONGINT:C283($progr_L)
		
		$progr_L:=Progress New
		Progress SET TITLE($progr_L; "scanning "+String:C10(Size of array:C274($allMethods_atxt))+" methods.")
		Progress SET BUTTON ENABLED($progr_L; True:C214)
		
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($allMethods_atxt))
			Progress SET PROGRESS($progr_L; ($loop_L/Size of array:C274($allMethods_atxt)))
			
			$newMeth_b:=False:C215
			METHOD GET CODE:C1190($allMethods_atxt{$loop_L}; $meth_txt)
			
			$newMeth_b:=DEV_ConvertObjectSetColor(->$meth_txt)
			
			If ($newMeth_b)
				Progress SET MESSAGE($progr_L; $allMethods_atxt{$loop_L})
				
				If ($savetoDB)
					METHOD SET CODE:C1194($allMethods_atxt{$loop_L}; $meth_txt)
				End if 
				
				ut_NewSaveMethod(DEV_MethodPathToName($allMethods_atxt{$loop_L}); $allMethods_atxt{$loop_L}; $meth_txt)
				APPEND TO ARRAY:C911($MethodsFixed_atxt; $allMethods_atxt{$loop_L})
			End if 
			If (Progress Stopped($progr_L))
				$loop_L:=Size of array:C274($allMethods_atxt)+1
			End if 
		End for 
		
		Progress QUIT($progr_L)
		
	Else 
		C_LONGINT:C283($meth_L)
		Repeat 
			$meth_L:=G_PickFromList(->$allMethods_atxt; "Pick a method to convert")
			If ($meth_L>0)
				METHOD GET CODE:C1190($allMethods_atxt{$meth_L}; $meth_txt)
				
				$newMeth_b:=DEV_ConvertObjectSetColor(->$meth_txt)
				
				If ($newMeth_b)
					
					ALERT:C41("Changed method "+$allMethods_atxt{$meth_L})
					If ($savetoDB)
						METHOD SET CODE:C1194($allMethods_atxt{$meth_L}; $meth_txt)
					End if 
					ut_NewSaveMethod(DEV_MethodPathToName($allMethods_atxt{$meth_L}); $allMethods_atxt{$meth_L}; $meth_txt)
					APPEND TO ARRAY:C911($MethodsFixed_atxt; $allMethods_atxt{$meth_L})
				Else 
					ALERT:C41("Method "+$allMethods_atxt{$meth_L}+" not changed")
				End if 
			End if 
			
		Until (OK=0)
		
	End if 
	
	
	If (Size of array:C274($MethodsFixed_atxt)>0)
		
		C_LONGINT:C283($meth_L)
		
		Repeat 
			$meth_L:=G_PickFromList(->$MethodsFixed_atxt; "Pick a method from modified "+String:C10(Size of array:C274($MethodsFixed_atxt)))
			If ($meth_L>0)
				METHOD OPEN PATH:C1213($MethodsFixed_atxt{$meth_L})
			End if 
			
		Until (OK=0)
		C_TEXT:C284($allMethods_txt; $report)
		$allMethods_txt:=ut_ArrayToText(->$MethodsFixed_atxt; Char:C90(Carriage return:K15:38))
		SET TEXT TO PASTEBOARD:C523($allMethods_txt)
		$report:=Select document:C905(""; ".txt"; "Select file to save names of changed methods"; File name entry:K24:17)
		If (OK=1)
			C_BLOB:C604($file_x)
			TEXT TO BLOB:C554($allMethods_txt; $file_x; UTF8 text without length:K22:17)
			BLOB TO DOCUMENT:C526(Document; $file_x)
			SHOW ON DISK:C922(Document)
			
		End if 
		ALERT:C41("List of method names also saved in the pasteboard")
	Else 
		ALERT:C41("No Methods were modified!")
	End if 
	
End if 

//End DEV_ReplaceObjecSetColor