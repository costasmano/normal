//%attributes = {"invisible":true}
// ----------------------------------------------------
//User name (OS): Costas Manousakis
//User (4D) : Designer
//Date and time: 01/25/12, 09:02:53
// ----------------------------------------------------
//Method: SCPOA_FillFormPicButtons
//Description
// Finds the checkboxes on the form and assigns the values from the corresponding input form variables
// the check box variables must end with "_P".
// There is also code for the Designer to extract the checkbox variables in the clipboard.
// Meant to be called from the form method.
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Created : 
	Mods_2012_01
	// Modified by: Costas Manousakis-(Designer)-(3/13/12 09:52:32)
	Mods_2012_03
	//  `added  check for  pictures from resource files (format contains ";#" )
End if 
//
ARRAY TEXT:C222($objnames_atxt; 0)
ARRAY POINTER:C280($objptrs_aptr; 0)
ARRAY LONGINT:C221($objPage_aL; 0)
FORM GET OBJECTS:C898($objnames_atxt; $objptrs_aptr; $objPage_aL)

C_LONGINT:C283($loop_L; $DTbl_L; $DFld_L)
C_TEXT:C284($PicButtonList_txt; $VarName_txt; $VarDecl_txt; $objFormat; $Clong_txt)
C_POINTER:C301($sourceVar_ptr)
$PicButtonList_txt:=""
$VarDecl_txt:=""
$Clong_txt:=""
For ($loop_L; 1; Size of array:C274($objnames_atxt))
	$objFormat:=OBJECT Get format:C894(*; $objnames_atxt{$loop_L})
	If ((Position:C15(";?"; $objFormat)>0) | (Position:C15(";#"; $objFormat)>0))
		RESOLVE POINTER:C394($objptrs_aptr{$loop_L}; $VarName_txt; $DTbl_L; $DFld_L)
		$PicButtonList_txt:=$PicButtonList_txt+Char:C90(13)+"` "+$VarName_txt+Char:C90(9)+$objnames_atxt{$loop_L}+Char:C90(9)+$objFormat
		
		If (Position:C15((","+$VarName_txt+","); $VarDecl_txt)<=0)
			$VarDecl_txt:=$VarDecl_txt+","+$VarName_txt+","
			$Clong_txt:=$Clong_txt+"C_longint ("+$VarName_txt+") "+Char:C90(13)
		End if 
		
		If (Substring:C12($VarName_txt; (Length:C16($VarName_txt)-1))="_P")
			$sourceVar_ptr:=Get pointer:C304(Substring:C12($VarName_txt; 1; (Length:C16($VarName_txt)-2)))
			$objptrs_aptr{$loop_L}->:=$sourceVar_ptr->
		End if 
		
	End if 
End for 

If (User in group:C338(<>CurrentUser_Name; "Design Access Group") & Not:C34(<>fCompiled))
	
	$VarDecl_txt:=Replace string:C233($VarDecl_txt; ",,"; ",")
	$VarDecl_txt:=Substring:C12($VarDecl_txt; 2; (Length:C16($VarDecl_txt)-2))
	$PicButtonList_txt:=$PicButtonList_txt+Char:C90(13)+$Clong_txt
	
	SET TEXT TO PASTEBOARD:C523($PicButtonList_txt)
	
End if 

//End SCPOA_FillFormPicButtons