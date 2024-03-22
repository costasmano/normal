//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/15/13, 10:41:58
//----------------------------------------------------
//Method: utl_ImportNewInspectionTypes
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_01  //r001 ` 
	//Modified by: Charles Miller (1/15/13 10:42:00)
	
End if 
C_LONGINT:C283($Loop_l; $Size_L)
C_TEXT:C284($FileName_txt)
ARRAY TEXT:C222($SelectedFiles_atxt; 0)
C_BLOB:C604($Document_blb)
SET BLOB SIZE:C606($Document_blb; 0)
$FileName_txt:=Select document:C905(""; "*"; "Select Inspection Type document to Import"; 0; $SelectedFiles_atxt)
If (OK=1)
	DOCUMENT TO BLOB:C525($SelectedFiles_atxt{1}; $Document_blb)
	ARRAY TEXT:C222($Code_atxt; $Size_L)
	ARRAY TEXT:C222($Description_atxt; $Size_L)
	ARRAY TEXT:C222($ElementNumbers_atxt; $Size_L)
	C_LONGINT:C283($Offset_l)
	$Offset_l:=0
	BLOB TO VARIABLE:C533($Document_blb; $Code_atxt; $Offset_l)
	BLOB TO VARIABLE:C533($Document_blb; $Description_atxt; $Offset_l)
	BLOB TO VARIABLE:C533($Document_blb; $ElementNumbers_atxt; $Offset_l)
	C_BOOLEAN:C305($Update_b)
	C_TEXT:C284(vsForward)  // Command Replaced was o_C_STRING length was 80
	vsForward:=<>Forward
	READ ONLY:C145(*)
	READ WRITE:C146([Inspection Type:31])
	For ($Loop_l; 1; Size of array:C274($Code_atxt))
		$Update_b:=True:C214
		
		QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=$Code_atxt{$Loop_l})
		Case of 
			: (Records in selection:C76([Inspection Type:31])=0)
				CREATE RECORD:C68([Inspection Type:31])
				[Inspection Type:31]Code:1:=$Code_atxt{$Loop_l}
				LogNewRecord(->[Inspection Type:31]Code:1; ->[Inspection Type:31]Code:1; ->[Inspection Type:31]Code:1; 0; "")
			: ([Inspection Type:31]Description:2#$Description_atxt{$Loop_l})
			: ([Inspection Type:31]ElementNumbers_txt:4#$ElementNumbers_atxt{$Loop_l})
			Else 
				$Update_b:=False:C215
		End case 
		
		If ($Update_b)
			
			ARRAY POINTER:C280(ptr_Changes; 0; 0)
			InitChangeStack(1)
			If (Not:C34(Is new record:C668([Inspection Type:31])))
				If (ut_LoadRecord(->[Inspection Type:31]))
				End if 
			End if 
			
			If ([Inspection Type:31]Description:2#$Description_atxt{$Loop_l})
				[Inspection Type:31]Description:2:=$Description_atxt{$Loop_l}
				PushChange(1; ->[Inspection Type:31]Description:2)
			End if 
			
			If ([Inspection Type:31]ElementNumbers_txt:4#$ElementNumbers_atxt{$Loop_l})
				[Inspection Type:31]ElementNumbers_txt:4:=$ElementNumbers_atxt{$Loop_l}
				PushChange(1; ->[Inspection Type:31]ElementNumbers_txt:4)
			End if 
			
			FlushGrpChgs(1; ->[Inspection Type:31]Code:1; ->[Inspection Type:31]Code:1; ->[Inspection Type:31]Code:1; 0)
			
			SAVE RECORD:C53([Inspection Type:31])
		End if 
	End for 
	ALERT:C41("Import complete : "+String:C10(Size of array:C274($Code_atxt))+" Inspection Types imported")
End if 
UNLOAD RECORD:C212([Inspection Type:31])
//End utl_ImportNewInspectionTypes