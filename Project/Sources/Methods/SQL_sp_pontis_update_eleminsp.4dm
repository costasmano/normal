//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// SQL_sp_pontis_update_eleminsp
	// User name (OS): 
	// Date and time: 05/31/05, 10:56:15
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CJM04
End if 
If (False:C215)
	insp_Environment_l:=[Cond Units:45]Environment:4
	insp_TotalQty_r:=0
	insp_CondState1_r:=[Cond Units:45]CondState1:10
	insp_CondState2_r:=[Cond Units:45]CondState2:11
	insp_CondState3_r:=[Cond Units:45]CondState3:12
	insp_CondState4_r:=[Cond Units:45]CondState4:13
	insp_CondState5_r:=[Cond Units:45]CondState5:14
End if 
C_TEXT:C284($0; $SQLStatement_txt; $Notes_txt)
C_TEXT:C284($SingleQuote_s; $QuoteMark_s)  // Command Replaced was o_C_STRING length was 1
$SingleQuote_s:=Char:C90(39)
$QuoteMark_s:=Char:C90(34)

$SQLStatement_txt:=""

C_TEXT:C284($Spaces_txt)
$SQLStatement_txt:=$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item8:206)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([BMS Inspections:44]Span Group No:3)+", "
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+String:C10([BMS Inspections:44]Insp Date:4; 7)+$SingleQuote_s+", "
$SQLStatement_txt:=$SQLStatement_txt+String:C10([BMS Elements:47]Element No:2)+", "
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
$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94(insp_CondState5_r; 6))+", "

$Notes_txt:=Substring:C12(SQL_SetUpStrings(insp_CondUnitComments_txt); 1; 250)
$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+$Notes_txt+$SingleQuote_s+" "

$0:=$SQLStatement_txt

//End SQL_sp_pontis_update_eleminsp