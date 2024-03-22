//%attributes = {"invisible":true}
//Method: ut_Import_ExportMethods
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/07/19, 13:04:28
	// ----------------------------------------------------
	//Created : 
	Mods_2019_11_bug
End if 
//
C_TEXT:C284($ImportFolder_txt; $4DFolder_txt; $FileName_txt; $MethodPath_txt)

$ImportFolder_txt:=Select folder:C670("Select Import or Export Folder")
C_BLOB:C604($Document_blb)
ARRAY TEXT:C222($NewMethods_atxt; 0)
DOCUMENT LIST:C474($ImportFolder_txt; $NewMethods_atxt; Ignore invisible:K24:16)

CONFIRM:C162("Process "+String:C10(Size of array:C274($NewMethods_atxt))+" files from "+$ImportFolder_txt; "Import"; "Skip")
If (OK=1)
	C_LONGINT:C283($Loop_l)
	CONFIRM:C162("Import or Export"; "Import"; "Export")
	If (OK=1)
		For ($Loop_l; 1; Size of array:C274($NewMethods_atxt))
			$FileName_txt:=Replace string:C233($NewMethods_atxt{$Loop_l}; ".c4d"; "")
			$FileName_txt:=Replace string:C233($FileName_txt; ".txt"; "")
			
			DOCUMENT TO BLOB:C525($ImportFolder_txt+$NewMethods_atxt{$Loop_l}; $Document_blb)
			C_TEXT:C284($Method_txt)
			
			$Method_txt:=BLOB to text:C555($Document_blb; UTF8 text without length:K22:17)
			METHOD SET CODE:C1194($FileName_txt; $Method_txt)
		End for 
	Else 
		For ($Loop_l; 1; Size of array:C274($NewMethods_atxt))
			$FileName_txt:=Replace string:C233($NewMethods_atxt{$Loop_l}; ".c4d"; "")
			$FileName_txt:=Replace string:C233($FileName_txt; ".txt"; "")
			METHOD GET CODE:C1190($FileName_txt; $Method_txt)
			SET BLOB SIZE:C606($Document_blb; 0)
			TEXT TO BLOB:C554($Method_txt; $Document_blb; UTF8 text without length:K22:17)
			BLOB TO DOCUMENT:C526($ImportFolder_txt+"to DEV:"+$NewMethods_atxt{$Loop_l}; $Document_blb)
			
		End for 
		
		
	End if 
	
End if 
//End ut_Import_ExportMethods