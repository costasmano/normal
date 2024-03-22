//Method: [Activity Log].Input.View_Data
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/11/18, 10:49:27
	// ----------------------------------------------------
	//Created : 
	Mods_2018_12  //Add ability to view pictures/text/and 4d write areas form activity log input form
	//Modified by: Chuck Miller (12/11/18 13:53:23)
	// Modified by: Costas Manousakis-(Designer)-(3/31/20 18:46:20)
	Mods_2020_03
	//  `fixed cleaning of other vars in case of "Picture"
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
	: (Form event code:C388=On Clicked:K2:4)
		C_PICTURE:C286(v_36_003_p)
		C_BLOB:C604(v_86_003_blb)
		C_TEXT:C284(v_58_005_txt)
		CLEAR VARIABLE:C89(v_36_003_p)
		CLEAR VARIABLE:C89(v_86_003_blb)
		CLEAR VARIABLE:C89(v_58_005_txt)
		ARRAY TEXT:C222($Types_atxt; 0)
		ARRAY TEXT:C222($FieldNames_atxt; 0)
		ARRAY LONGINT:C221($Locations_aL; 0)
		C_LONGINT:C283($Offset_L)
		C_LONGINT:C283($FieldNumber_L; $Selection_L)
		C_TEXT:C284($Type_txt; $FieldName_txt; $QueryBy_txt)
		
		Repeat 
			BLOB TO VARIABLE:C533(v_59_010_blb; $Type_txt; $Offset_L)  //get the type(Text/Picture/Blob)
			If (OK=1)
				BLOB TO VARIABLE:C533(v_59_010_blb; $FieldName_txt; $Offset_L)  //get the type(Text/Picture/Blob)
				$QueryBy_txt:=$QueryBy_txt+$Type_txt+"-"+$FieldName_txt+Char:C90(1)
				APPEND TO ARRAY:C911($Types_atxt; $Type_txt)
				APPEND TO ARRAY:C911($FieldNames_atxt; $FieldName_txt)
			End if 
		Until (OK=0)
		$Selection_L:=Pop up menu:C542($QueryBy_txt)
		$Offset_L:=0
		C_LONGINT:C283($ItemNumber_L)
		$ItemNumber_L:=1
		//$Selection_L:=$Selection_L-1
		Repeat 
			BLOB TO VARIABLE:C533(v_59_027_blb; $FieldNumber_L; $Offset_L)  //get the type(Text/Picture/Blob)
			Case of 
				: ($Types_atxt{$ItemNumber_L}="BLOB")
					BLOB TO VARIABLE:C533(v_59_027_blb; v_86_003_blb; $Offset_L)
				: ($Types_atxt{$ItemNumber_L}="TEXT")
					BLOB TO VARIABLE:C533(v_59_027_blb; v_58_005_txt; $Offset_L)
				: ($Types_atxt{$ItemNumber_L}="Picture")
					BLOB TO VARIABLE:C533(v_59_027_blb; v_36_003_p; $Offset_L)
			End case 
			$ItemNumber_L:=$ItemNumber_L+1
		Until ($ItemNumber_L>$Selection_L)
		$ItemNumber_L:=$ItemNumber_L-1
		
		Case of 
			: ($Types_atxt{$ItemNumber_L}="BLOB")
				CLEAR VARIABLE:C89(v_58_005_txt)
				CLEAR VARIABLE:C89(v_36_003_p)
			: ($Types_atxt{$ItemNumber_L}="TEXT")
				CLEAR VARIABLE:C89(v_86_003_blb)
				CLEAR VARIABLE:C89(v_36_003_p)
			: ($Types_atxt{$ItemNumber_L}="Picture")
				CLEAR VARIABLE:C89(v_86_003_blb)
				CLEAR VARIABLE:C89(v_58_005_txt)
		End case 
		C_LONGINT:C283($Win_L)
		
		$Win_L:=Open form window:C675([Activity Log:59]; "ViewExtras"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
		DIALOG:C40([Activity Log:59]; "ViewExtras")
End case 
//End [Activity Log].Input.View_Data