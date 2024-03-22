//%attributes = {"invisible":true}
//Method: LSS_PrintDamageInspection
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 07/19/18, 12:09:16
	// ----------------------------------------------------
	//Created : 
	Mods_2018_07
	//
	// Modified by: Costas Manousakis-(Designer)-(2/23/21 11:04:56)
	Mods_2021_02
	//  `added G_PrintOptions to correctly pick the Letter paper
	Mods_2021_Delete
End if 
//

SET PRINT OPTION:C733(Orientation option:K47:2; 1)
SET PRINT OPTION:C733(Paper option:K47:1; "Letter")
SET PRINT OPTION:C733(Scale option:K47:3; 100)
G_PrintOptions
SET PRINT PREVIEW:C364(False:C215)
vPageNo:=2

If (<>ShowPrint)  //| (Not(Is compiled mode))
	PRINT SETTINGS:C106
End if 
If (OK=1)
	G_PrintOptions
	VSINSPDEPARTMENT:="MASSACHUSETTS DEPARTMENT OF TRANSPORTATION"
	CLEAR VARIABLE:C89(LSS_ElemListBackColor_AL)
	C_LONGINT:C283($Loop_l; $Count_L; $Page1ElementCount_L)
	
	C_BOOLEAN:C305($RemoveElement_B)
	SET QUERY DESTINATION:C396(Into set:K19:2; "$ElemInspSet")
	QUERY:C277([LSS_ElementInspection:163]; [LSS_ElementInspection:163]LSS_InspectionId_s:3=[LSS_Inspection:164]LSS_InspectionId_s:1)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	ARRAY LONGINT:C221(LSS_HeaderPosition_aL; 0)
	ARRAY LONGINT:C221(LSS_HeaderPosition_aL; Size of array:C274(LSS_ElementHeader_ab))
	If ([LSS_Inventory:165]LSS_Category_s:2="Sign") | ([LSS_Inventory:165]LSS_InventoryType_s:28="HS")
		$Page1ElementCount_L:=4
	Else 
		$Page1ElementCount_L:=5
	End if 
	
	For ($Loop_l; Size of array:C274(LSS_ElementHeader_ab); 1; -1)
		USE SET:C118("$ElemInspSet")
		SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
		QUERY SELECTION:C341([LSS_ElementInspection:163]; [LSS_ElementInspection:163]LSS_ElementId_L:2=v_163_002_aL{$Loop_l})
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If (LSS_ElementHeader_ab{$Loop_l}=True:C214)
			$HeaderPosition_L:=$Loop_l
		End if 
		Case of 
				//: (LSS_ElementHeader_ab{$Loop_l}=True)
			: ($Count_L>0)
				Case of 
					: (v_163_004_atxt{$Loop_l}="N") | (v_163_004_atxt{$Loop_l}="")
						DELETE FROM ARRAY:C228(v_163_002_aL; $Loop_l; 1)
						DELETE FROM ARRAY:C228(v_163_006_atxt; $Loop_l; 1)
						DELETE FROM ARRAY:C228(v_163_005_atxt; $Loop_l; 1)
						DELETE FROM ARRAY:C228(v_163_008_atxt; $Loop_l; 1)
						DELETE FROM ARRAY:C228(v_163_004_atxt; $Loop_l; 1)
						DELETE FROM ARRAY:C228(v_163_007_atxt; $Loop_l; 1)
						DELETE FROM ARRAY:C228(LSS_HeaderPosition_aL; $Loop_l; 1)
						DELETE FROM ARRAY:C228(LSS_ElementHeader_ab; $Loop_l; 1)
					Else 
						
				End case 
				
			Else 
				DELETE FROM ARRAY:C228(v_163_002_aL; $Loop_l; 1)
				DELETE FROM ARRAY:C228(v_163_006_atxt; $Loop_l; 1)
				DELETE FROM ARRAY:C228(v_163_005_atxt; $Loop_l; 1)
				DELETE FROM ARRAY:C228(v_163_008_atxt; $Loop_l; 1)
				DELETE FROM ARRAY:C228(v_163_004_atxt; $Loop_l; 1)
				DELETE FROM ARRAY:C228(v_163_007_atxt; $Loop_l; 1)
				DELETE FROM ARRAY:C228(LSS_ElementHeader_ab; $Loop_l; 1)
				DELETE FROM ARRAY:C228(LSS_HeaderPosition_aL; $Loop_l; 1)
		End case 
		
	End for 
	$Loop_l:=1
	C_LONGINT:C283($HeaderPosition_L; $Start_L; $LinePosition_L)
	//C_BOOLEAN($Complete_B)
	//$Complete_B:=False
	//ARRAY BOOLEAN($DeleteMe_aB;0)
	//ARRAY BOOLEAN($DeleteMe_aB;Size of array(LSS_ElementHeader_ab))
	
	//Repeat 
	
	//Case of 
	//: (LSS_ElementHeader_ab{$Loop_l}) & (Not(LSS_ElementHeader_ab{$Loop_l+1}))
	//$HeaderPosition_L:=$Loop_l
	//$Loop_l:=$Loop_l+1
	
	//: (LSS_ElementHeader_ab{$Loop_l}) & ($Loop_l=Size of array(LSS_ElementHeader_ab))
	//$DeleteMe_aB{$Loop_l}:=True
	//  //DELETE FROM ARRAY(v_163_002_aL;$Loop_l;1)
	//  //DELETE FROM ARRAY(v_163_006_atxt;$Loop_l;1)
	//  //DELETE FROM ARRAY(v_163_005_atxt;$Loop_l;1)
	//  //DELETE FROM ARRAY(v_163_008_atxt;$Loop_l;1)
	//  //DELETE FROM ARRAY(v_163_004_atxt;$Loop_l;1)
	//  //DELETE FROM ARRAY(v_163_007_atxt;$Loop_l;1)
	//  //DELETE FROM ARRAY(LSS_ElementHeader_ab;$Loop_l;1)
	//  //DELETE FROM ARRAY(LSS_HeaderPosition_aL;$Loop_l;1)
	//$Loop_l:=$Loop_l+1
	//: (LSS_ElementHeader_ab{$Loop_l}) & (LSS_ElementHeader_ab{$Loop_l+1})
	//$DeleteMe_aB{$Loop_l}:=True
	//  //DELETE FROM ARRAY(v_163_002_aL;$Loop_l;1)
	//  //DELETE FROM ARRAY(v_163_006_atxt;$Loop_l;1)
	//  //DELETE FROM ARRAY(v_163_005_atxt;$Loop_l;1)
	//  //DELETE FROM ARRAY(v_163_008_atxt;$Loop_l;1)
	//  //DELETE FROM ARRAY(v_163_004_atxt;$Loop_l;1)
	//  //DELETE FROM ARRAY(v_163_007_atxt;$Loop_l;1)
	//  //DELETE FROM ARRAY(LSS_ElementHeader_ab;$Loop_l;1)
	//  //DELETE FROM ARRAY(LSS_HeaderPosition_aL;$Loop_l;1)
	//$Loop_l:=$Loop_l+1
	
	//Else 
	//LSS_HeaderPosition_aL{$Loop_l}:=v_163_002_aL{$HeaderPosition_L}
	//$Loop_l:=$Loop_l+1
	//End case 
	
	//$Complete_B:=($Loop_l=Size of array(v_163_002_aL))
	//Until ($Complete_B)
	//$Loop_l:=Size of array(v_163_002_aL)
	//$DeleteMe_aB{$Loop_l}:=LSS_ElementHeader_ab{$Loop_l}
	
	//For ($Loop_l;Size of array(v_163_002_aL);1;-1)
	//If ($DeleteMe_aB{$Loop_l})
	//DELETE FROM ARRAY(v_163_002_aL;$Loop_l;1)
	//DELETE FROM ARRAY(v_163_006_atxt;$Loop_l;1)
	//DELETE FROM ARRAY(v_163_005_atxt;$Loop_l;1)
	//DELETE FROM ARRAY(v_163_008_atxt;$Loop_l;1)
	//DELETE FROM ARRAY(v_163_004_atxt;$Loop_l;1)
	//DELETE FROM ARRAY(v_163_007_atxt;$Loop_l;1)
	//DELETE FROM ARRAY(LSS_ElementHeader_ab;$Loop_l;1)
	//DELETE FROM ARRAY(LSS_HeaderPosition_aL;$Loop_l;1)
	
	//End if 
	//End for 
	
	
	
	
	ARRAY TEXT:C222(v_163_014_atxt; 0)  //LSS_DamageWeldCondition_s
	ARRAY TEXT:C222(v_163_013_atxt; 0)  //LSS_DamagePreviousCondition_s
	
	ARRAY TEXT:C222(LSS_Crack_atxt; 0)
	
	ARRAY LONGINT:C221(LSS_Page1Postions_aL; 0)
	ARRAY BOOLEAN:C223(LSS_AddtoCommentsPAGE_AB; 0)
	ARRAY LONGINT:C221(LSS_ElementRecordNo_aL; 0)
	$Loop_l:=Size of array:C274(LSS_ElementHeader_ab)
	ARRAY TEXT:C222(LSS_Crack_atxt; $Loop_l)
	ARRAY TEXT:C222(v_163_014_atxt; $Loop_l)  //LSS_DamageWeldCondition_s
	ARRAY TEXT:C222(v_163_013_atxt; $Loop_l)  //LSS_DamagePreviousCondition_sARRAY TEXT(v_163_012_atxt;$Loop_l)  //LSS_DamageCurrentCondition_s
	//ARRAY LONGINT(LSS_ElementRecordNo_aL;$Loop_l)
	ARRAY LONGINT:C221(LSS_Page1Postions_aL; $Page1ElementCount_L)
	ARRAY BOOLEAN:C223(LSS_AddtoCommentsPAGE_AB; $Loop_l)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	For ($Loop_l; 1; Size of array:C274(LSS_ElementHeader_ab))
		If (Not:C34(LSS_ElementHeader_ab{$Loop_l}))
			USE SET:C118("$ElemInspSet")
			QUERY SELECTION:C341([LSS_ElementInspection:163]; [LSS_ElementInspection:163]LSS_ElementId_L:2=v_163_002_aL{$Loop_l})
			If ([LSS_ElementInspection:163]LSS_DamageCrack_B:11)
				LSS_Crack_atxt{$Loop_l}:="Y"
			Else 
				LSS_Crack_atxt{$Loop_l}:="N"
			End if 
			v_163_014_atxt{$Loop_l}:=[LSS_ElementInspection:163]LSS_DamageWeldCondition_s:14
			
			v_163_013_atxt{$Loop_l}:=[LSS_ElementInspection:163]LSS_DamagePreviousCondition_s:13
			
			LSS_AddtoCommentsPAGE_AB{$Loop_l}:=Length:C16(v_163_008_atxt{$Loop_l})><>vLimitCharDAM
		End if 
		If ($Loop_l>$Page1ElementCount_L)
			APPEND TO ARRAY:C911(LSS_ElementRecordNo_aL; Record number:C243([LSS_ElementInspection:163]))
		Else 
			LSS_Page1Postions_aL{$Loop_l}:=$Loop_l
		End if 
		
	End for 
	
	CLEAR SET:C117("$ElemInspSet")
	
	LSS_CountandPrintDamagePages($Page1ElementCount_L)
	
	
End if 
//End LSS_PrintDamageInspection