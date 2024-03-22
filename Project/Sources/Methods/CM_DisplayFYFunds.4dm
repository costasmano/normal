//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/09/06, 22:45:00
	// ----------------------------------------------------
	// Method: CM_DisplayFYFunds
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CMz1
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
End if 
C_TEXT:C284(CurrentFY_s)  // Command Replaced was o_C_STRING length was 10
ARRAY REAL:C219(arr_CM_FYFundAlloc_r; 0)
ARRAY INTEGER:C220(arr_CM_FYAlloc_I; 0)
C_REAL:C285(AvailFunds_R; CurrentFYFunds_R)
C_LONGINT:C283($CurreFY_I)
CurrentFY_s:=String:C10(F_FiscalYear(Current date:C33(*)))
AvailFunds_R:=[Contract_Maintenance:97]TotalEncumbered:16-vActualPaid
CurrentFYFunds_R:=AvailFunds_R
QUERY:C277([CM_ExtTimeFYAlloc:111]; [CM_ExtTimeFYAlloc:111]EOT_ID_L:2=[ExtendTime_Maintenance:98]EOT_ID:2)
ORDER BY:C49([CM_ExtTimeFYAlloc:111]; [CM_ExtTimeFYAlloc:111]FYear_I:4)
If (Records in selection:C76([CM_ExtTimeFYAlloc:111])>0)
	//GET THE first fiscal year
	GOTO SELECTED RECORD:C245([CM_ExtTimeFYAlloc:111]; 1)
	$CurreFY_I:=[CM_ExtTimeFYAlloc:111]FYear_I:4
	CurrentFY_s:=String:C10($CurreFY_I)
	QUERY SELECTION:C341([CM_ExtTimeFYAlloc:111]; [CM_ExtTimeFYAlloc:111]FYear_I:4>$CurreFY_I)
	ORDER BY:C49([CM_ExtTimeFYAlloc:111]; [CM_ExtTimeFYAlloc:111]FYear_I:4)
	
	SELECTION TO ARRAY:C260([CM_ExtTimeFYAlloc:111]FYear_I:4; arr_CM_FYAlloc_I; [CM_ExtTimeFYAlloc:111]FYAmmount_R:3; arr_CM_FYFundAlloc_r)
End if 