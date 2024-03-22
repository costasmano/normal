//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/15/13, 12:52:36
//----------------------------------------------------
//Method: utl_ImportElementDictinary
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_01  //r001 ` 
	//Modified by: Charles Miller (1/15/13 12:52:37)
	
End if 

C_LONGINT:C283($Loop_l)
C_TEXT:C284($FileName_txt)
C_BLOB:C604($Document_blb)
SET BLOB SIZE:C606($Document_blb; 0)
ARRAY TEXT:C222($SelectedFiles_atxt; 0)
ARRAY LONGINT:C221($TimeCreated_al; 0)
$FileName_txt:=Select document:C905(""; "*"; "Select Element Dictionary Import document"; 0; $SelectedFiles_atxt)

If (OK=1)
	DOCUMENT TO BLOB:C525($SelectedFiles_atxt{1}; $Document_blb)
	ARRAY TEXT:C222($Category_atxt; 0)
	ARRAY DATE:C224($Created_ad; 0)
	ARRAY TEXT:C222($Description_atxt; 0)
	ARRAY INTEGER:C220($ElementNo_ai; 0)
	ARRAY TEXT:C222($FullLabel_atxt; 0)
	ARRAY TEXT:C222($FullLabelArch_atxt; 0)
	ARRAY BOOLEAN:C223($IsParent_ab; 0)
	ARRAY INTEGER:C220($Parent_ai; 0)
	ARRAY TEXT:C222($Prefix_atxt; 0)
	C_LONGINT:C283($Offset_l)
	$Offset_l:=0
	
	BLOB TO VARIABLE:C533($Document_blb; $Category_atxt; $Offset_l)
	BLOB TO VARIABLE:C533($Document_blb; $Description_atxt; $Offset_l)
	BLOB TO VARIABLE:C533($Document_blb; $ElementNo_ai; $Offset_l)
	BLOB TO VARIABLE:C533($Document_blb; $FullLabel_atxt; $Offset_l)
	BLOB TO VARIABLE:C533($Document_blb; $FullLabelArch_atxt; $Offset_l)
	BLOB TO VARIABLE:C533($Document_blb; $IsParent_ab; $Offset_l)
	BLOB TO VARIABLE:C533($Document_blb; $Parent_ai; $Offset_l)
	BLOB TO VARIABLE:C533($Document_blb; $Prefix_atxt; $Offset_l)
	
	C_BOOLEAN:C305($Update_b)
	C_TEXT:C284(vsForward)  // Command Replaced was o_C_STRING length was 80
	vsForward:=<>Forward
	READ ONLY:C145(*)
	READ WRITE:C146([ElementDict:30])
	For ($Loop_l; 1; Size of array:C274($ElementNo_ai))
		$Update_b:=False:C215
		
		QUERY:C277([ElementDict:30]; [ElementDict:30]ElementNo:1=$ElementNo_ai{$Loop_l})
		Case of 
			: (Records in selection:C76([ElementDict:30])=0)
				CREATE RECORD:C68([ElementDict:30])
				[ElementDict:30]ElementNo:1:=$ElementNo_ai{$Loop_l}
				LogNewRecord(->[ElementDict:30]ElementNo:1; ->[ElementDict:30]ElementNo:1; ->[ElementDict:30]ElementNo:1; 0; "")
				
				$Update_b:=True:C214
				
		End case 
		
		If ($Update_b)
			
			ARRAY POINTER:C280(ptr_Changes; 0; 0)
			InitChangeStack(1)
			If ([ElementDict:30]Category:3#$Category_atxt{$Loop_l})
				[ElementDict:30]Category:3:=$Category_atxt{$Loop_l}
				PushChange(1; ->[ElementDict:30]Category:3)
			End if 
			If ([ElementDict:30]Description:2#$Description_atxt{$Loop_l})
				[ElementDict:30]Description:2:=$Description_atxt{$Loop_l}
				PushChange(1; ->[ElementDict:30]Description:2)
			End if 
			If ([ElementDict:30]FullLabel:13#$FullLabel_atxt{$Loop_l})
				[ElementDict:30]FullLabel:13:=$FullLabel_atxt{$Loop_l}
				PushChange(1; ->[ElementDict:30]FullLabel:13)
			End if 
			If ([ElementDict:30]FullLabelArch:14#$FullLabelArch_atxt{$Loop_l})
				[ElementDict:30]FullLabelArch:14:=$FullLabelArch_atxt{$Loop_l}
				PushChange(1; ->[ElementDict:30]FullLabelArch:14)
			End if 
			If ([ElementDict:30]IsParent:5#$IsParent_ab{$Loop_l})
				[ElementDict:30]IsParent:5:=$IsParent_ab{$Loop_l}
				PushChange(1; ->[ElementDict:30]IsParent:5)
			End if 
			If ([ElementDict:30]Parent:4#$Parent_ai{$Loop_l})
				[ElementDict:30]Parent:4:=$Parent_ai{$Loop_l}
				PushChange(1; ->[ElementDict:30]Parent:4)
			End if 
			If ([ElementDict:30]Prefix:11#$Prefix_atxt{$Loop_l})
				[ElementDict:30]Prefix:11:=$Prefix_atxt{$Loop_l}
				PushChange(1; ->[ElementDict:30]Prefix:11)
			End if 
			[ElementDict:30]DateModified:8:=Current date:C33
			[ElementDict:30]TimeModified:9:=Current time:C178
			If (Is new record:C668([ElementDict:30]))
				[ElementDict:30]DateCreated:6:=Current date:C33
				[ElementDict:30]TimeCreated:7:=Current time:C178
				PushChange(1; ->[ElementDict:30]DateCreated:6)
				PushChange(1; ->[ElementDict:30]TimeCreated:7)
			End if 
			PushChange(1; ->[ElementDict:30]DateModified:8)
			PushChange(1; ->[ElementDict:30]TimeModified:9)
			
			FlushGrpChgs(1; ->[ElementDict:30]ElementNo:1; ->[ElementDict:30]ElementNo:1; ->[ElementDict:30]ElementNo:1; 0)
			
			SAVE RECORD:C53([ElementDict:30])
		End if 
		
	End for 
	ALERT:C41("Import completed : "+String:C10(Size of array:C274($ElementNo_ai))+" Elements imported")
End if 
UNLOAD RECORD:C212([ElementDict:30])

//End utl_ImportElementDictinary