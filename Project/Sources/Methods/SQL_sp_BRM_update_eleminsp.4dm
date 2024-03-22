//%attributes = {"invisible":true}
//Method: SQL_sp_BRM_update_eleminsp
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/30/19, 14:44:46
	// ----------------------------------------------------
	//Created : 
	Mods_2019_04
	
	C_TEXT:C284(SQL_sp_BRM_update_eleminsp; $0)
End if 
//

If (True:C214)
	insp_Environment_l:=[PON_ELEM_INSP:179]ENVKEY:5
	insp_TotalQty_r:=[PON_ELEM_INSP:179]ELEM_QUANTITY:7
	insp_CondState1_r:=[PON_ELEM_INSP:179]ELEM_QTYSTATE1:13
	insp_CondState2_r:=[PON_ELEM_INSP:179]ELEM_QTYSTATE2:14
	insp_CondState3_r:=[PON_ELEM_INSP:179]ELEM_QTYSTATE3:15
	insp_CondState4_r:=[PON_ELEM_INSP:179]ELEM_QTYSTATE4:16
	insp_CondUnitComments_txt:=[PON_ELEM_INSP:179]ELEM_NOTES:20
End if 
C_TEXT:C284($0; $SQLStatement_txt; $Notes_txt)
C_TEXT:C284($SingleQuote_s; $QuoteMark_s)  // Command Replaced was o_C_STRING length was 1
$SingleQuote_s:=Char:C90(39)
$QuoteMark_s:=Char:C90(34)

$SQLStatement_txt:=""

C_TEXT:C284($Spaces_txt)
$SQLStatement_txt:=$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item8:206)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([PON_ELEM_INSP:179]STRUNITKEY:6)+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+String:C10([Inspections:27]Insp Date:78; 7)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([PON_ELEM_INSP:179]ELEM_KEY:3)+", "
Case of 
	: (insp_Environment_l<=0)
		$SQLStatement_txt:=$SQLStatement_txt+"2, "
	: (insp_Environment_l>4)
		$SQLStatement_txt:=$SQLStatement_txt+"2, "
	Else 
		$SQLStatement_txt:=$SQLStatement_txt+String:C10(insp_Environment_l)+", "
End case 
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94(insp_TotalQty_r; 7))+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94(insp_CondState1_r; 6))+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94(insp_CondState2_r; 6))+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94(insp_CondState3_r; 6))+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94(insp_CondState4_r; 6))+", "

$Notes_txt:=Substring:C12(SQL_SetUpStrings(insp_CondUnitComments_txt); 1; 3990)
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+$Notes_txt+$SingleQuote_s+" , "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([PON_ELEM_INSP:179]ELEM_PARENT_KEY:4)+" "

$0:=$SQLStatement_txt

//End SQL_sp_BRM_update_eleminsp