//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 05/23/13, 17:18:29
//----------------------------------------------------
//Method: utl_ImportElementCat
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_05  //r003 ` 
	//Modified by: Charles Miller (5/23/13 17:20:38)
	
End if 
C_LONGINT:C283($Loop_l)
C_TEXT:C284($FileName_txt)
C_BLOB:C604($Document_blb)
SET BLOB SIZE:C606($Document_blb; 0)
ARRAY TEXT:C222($SelectedFiles_atxt; 0)
ARRAY LONGINT:C221($TimeCreated_al; 0)
C_LONGINT:C283($Offset_L)

$FileName_txt:=Select document:C905(""; "*"; "Select [Element Cat] Import document"; 0; $SelectedFiles_atxt)
C_BOOLEAN:C305($Flush_b)
If (OK=1)
	$Offset_L:=0
	ARRAY TEXT:C222($ElementCode_atxt; 0)
	ARRAY BOOLEAN:C223($ElementCulvert_ab; 0)
	ARRAY TEXT:C222($ElementDescription_atxt; 0)
	ARRAY BOOLEAN:C223($ElementRegular_ab; 0)
	
	DOCUMENT TO BLOB:C525($SelectedFiles_atxt{1}; $Document_blb)
	BLOB TO VARIABLE:C533($Document_blb; $ElementCode_atxt; $Offset_L)
	BLOB TO VARIABLE:C533($Document_blb; $ElementCulvert_ab; $Offset_L)
	BLOB TO VARIABLE:C533($Document_blb; $ElementDescription_atxt; $Offset_L)
	BLOB TO VARIABLE:C533($Document_blb; $ElementRegular_ab; $Offset_L)
	For ($Loop_l; 1; Size of array:C274($ElementCode_atxt))
		ARRAY POINTER:C280(ptr_Changes; 0; 0)
		InitChangeStack(1)
		$Flush_b:=False:C215
		QUERY:C277([Element Cat:32]; [Element Cat:32]Code:1=$ElementCode_atxt{$Loop_l})
		If (Records in selection:C76([Element Cat:32])=0)
			$Flush_b:=True:C214
			CREATE RECORD:C68([Element Cat:32])
			[Element Cat:32]Code:1:=$ElementCode_atxt{$Loop_l}
			LogNewRecord(->[Element Cat:32]Code:1; ->[Element Cat:32]Code:1; ->[Element Cat:32]Code:1; 0; "")
		Else 
			If (ut_LoadRecord(->[Element Cat:32]))
			End if 
		End if 
		If ([Element Cat:32]CulvertElement:3#$ElementCulvert_ab{$Loop_l})
			[Element Cat:32]CulvertElement:3:=$ElementCulvert_ab{$Loop_l}
			PushChange(1; ->[Element Cat:32]CulvertElement:3)
			$Flush_b:=True:C214
		End if 
		If ([Element Cat:32]Description:2#$ElementDescription_atxt{$Loop_l})
			[Element Cat:32]Description:2:=$ElementDescription_atxt{$Loop_l}
			PushChange(1; ->[Element Cat:32]Description:2)
			$Flush_b:=True:C214
		End if 
		If ([Element Cat:32]RegularElement:4#$ElementRegular_ab{$Loop_l})
			[Element Cat:32]RegularElement:4:=$ElementRegular_ab{$Loop_l}
			PushChange(1; ->[Element Cat:32]RegularElement:4)
			$Flush_b:=True:C214
		End if 
		If ($Flush_b)
			FlushGrpChgs(1; ->[Element Cat:32]Code:1; ->[Element Cat:32]Code:1; ->[Element Cat:32]Code:1; 0)
		End if 
		
	End for 
	
	ALERT:C41("Import Complete :"+String:C10(Size of array:C274($ElementCode_atxt))+" Element Categories imported!")
End if 
//End utl_ImportElementCat