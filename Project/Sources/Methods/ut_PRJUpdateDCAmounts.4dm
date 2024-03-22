//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJRetrieveDCAmounts
// User name (OS): cjmiller
// Date and time: 5/31/07, 10:00:00
// ----------------------------------------------------
// Description
// This method will update design contract ammounts from the retrieve
//
// Parameters
//$1 Name
//$2 Value
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2
End if 
C_TEXT:C284($1; $2; $Name_txt; $Value_txt)
$Name_txt:=$1
$Value_txt:=$2
Case of 
	: (Position:C15("MMARS_TOTAL_AMOUNT"; $Name_txt)>0)
		[PRJ_DesignContracts:123]DC_ESTContractAmt_r:10:=Round:C94(Num:C11($Value_txt); 2)
	: (Position:C15("MMARS_REMAIN_AMOUNT"; $Name_txt)>0)
		[PRJ_DesignContracts:123]DC_RemainingAmount_r:7:=Round:C94(Num:C11($Value_txt); 2)
	: (Position:C15("MMARS_SPENT_AMOUNT"; $Name_txt)>0)
		[PRJ_DesignContracts:123]DC_ActualAmount_r:6:=Round:C94(Num:C11($Value_txt); 2)
End case 

