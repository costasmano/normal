//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 07/14/15, 11:20:20
//----------------------------------------------------
//Method: LSS_utImportFromAccess
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (7/14/15 11:20:21)
	
End if 
C_TEXT:C284($FolderPath_txt)
ARRAY TEXT:C222($Documents_atxt; 0)
C_POINTER:C301($Tbl_ptr)
C_LONGINT:C283($NumTableRecs_L; $Loop_L; $TableNum_L; $j)
$FolderPath_txt:=Select folder:C670("Select folder to Import Access Data for "+Data file:C490; "")
DOCUMENT LIST:C474($FolderPath_txt; $Documents_atxt)
ON ERR CALL:C155("ut_ChannelOpenError")
For ($Loop_L; 1; Size of array:C274($Documents_atxt))
	If (Position:C15(".txt"; $Documents_atxt{$Loop_L})>0)
		SET CHANNEL:C77(10; $FolderPath_txt+$Documents_atxt{$Loop_L})
		RECEIVE VARIABLE:C81($TableNum_L)
		$Tbl_ptr:=Table:C252($TableNum_L)
		RECEIVE VARIABLE:C81($NumTableRecs_L)
		MESSAGE:C88(<>sCR+"Table "+String:C10($Loop_L)+"/"+String:C10(Size of array:C274($Documents_atxt))+" :"+Table name:C256($Tbl_ptr)+"["+String:C10($NumTableRecs_L)+"]")
		If ($NumTableRecs_L>0)
			For ($j; 1; $NumTableRecs_L)
				RECEIVE RECORD:C79($Tbl_ptr->)
				SAVE RECORD:C53($Tbl_ptr->)
			End for 
			//FLUSH CACHE
			
		End if 
		REDUCE SELECTION:C351($Tbl_ptr->; 0)
		
		
	End if 
End for 
//End LSS_utImportFromAccess

