//%attributes = {"invisible":true}
//Method: PON_ValidateElemInput
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/19/15, 16:43:37
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
	// Modified by: Costas Manousakis-(Designer)-(10/25/16 17:08:25)
	Mods_2016_10
	//  `make sure scale factor is not 0 (zero)
End if 
//
C_BOOLEAN:C305($0)

C_BOOLEAN:C305($elemInpValid_b)
// assume true
$elemInpValid_b:=True:C214
//make sure scale factor is not 0 (zero)
If ([PON_ELEM_INSP:179]ELEM_SCALE_FACTOR:8=0)
	[PON_ELEM_INSP:179]ELEM_SCALE_FACTOR:8:=1
End if 
C_TEXT:C284($Message_txt)
$Message_txt:=""
If ([PON_ELEM_INSP:179]ELEM_QUANTITY:7<=0)
	$Message_txt:=$Message_txt+Char:C90(13)+"Element Quantity cannot be zero or less!"
	$elemInpValid_b:=False:C215
End if 
If (([PON_ELEM_INSP:179]ELEM_QTYSTATE1:13<0) | ([PON_ELEM_INSP:179]ELEM_QTYSTATE2:14<0) | ([PON_ELEM_INSP:179]ELEM_QTYSTATE3:15<0) | ([PON_ELEM_INSP:179]ELEM_QTYSTATE4:16<0))
	// any of the states is neg
	$Message_txt:=$Message_txt+Char:C90(13)+"Quantities in States Cannot be less than zero!!  Please Adjust!"
	$elemInpValid_b:=False:C215
	
End if 
If (([PON_ELEM_INSP:179]ELEM_QTYSTATE1:13+[PON_ELEM_INSP:179]ELEM_QTYSTATE2:14+[PON_ELEM_INSP:179]ELEM_QTYSTATE3:15+[PON_ELEM_INSP:179]ELEM_QTYSTATE4:16)#[PON_ELEM_INSP:179]ELEM_QUANTITY:7)
	// Quantities in States do not match Total
	$Message_txt:=$Message_txt+Char:C90(13)+"Quantities in States do not match Total Quantity!!  Please Adjust!"
	$elemInpValid_b:=False:C215
End if 

If (Not:C34(PON_VERIFYUNIQELEM_b([PON_ELEM_INSP:179]ELEM_KEY:3; [PON_ELEM_INSP:179]ENVKEY:5; [PON_ELEM_INSP:179]ELEM_PARENT_KEY:4; [PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19)))
	$Message_txt:=$Message_txt+Char:C90(13)+"There exists a duplicate Element with same Number / Enviroment / Parent / Grandparent combination!"
	$elemInpValid_b:=False:C215
End if 
//need to check sum of total quantities in defects must be less than or equal to total q
C_TEXT:C284($temp_txt)
$temp_txt:=PON_VerifyQuantity
If ($temp_txt#"")
	$Message_txt:=$Message_txt+Char:C90(13)+$temp_txt
	$elemInpValid_b:=False:C215
End if 

If (Not:C34($elemInpValid_b))
	ALERT:C41($Message_txt)
End if 

$0:=$elemInpValid_b
//End PON_ValidateElemInput