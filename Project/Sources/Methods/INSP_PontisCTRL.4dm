//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/01/10, 12:40:03
	// ----------------------------------------------------
	// Method: INSP_PontisCTRL
	// Description
	// Called from form methods using Pontis inspections
	// 
	// Parameters
	// $1 : $Task_txt ("CLOSEDETAIL"  | "INIT")
	// ----------------------------------------------------
	
	Mods_2010_02
End if 
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
Case of 
	: ($Task_txt="INIT")
		If ([Combined Inspections:90]BMSInspID:3>0)
			If ([BMS Inspections:44]Metric:14)
				tbMetric:=1
				tbEnglish:=0
			Else 
				tbMetric:=0
				tbEnglish:=1
			End if 
			C_LONGINT:C283(INSP_CurrCUID_L)
			INSP_CurrCUID_L:=0
		End if 
		
	: ($Task_txt="CLOSEDETAIL")
		
		RememberCombined
		ARRAY LONGINT:C221($CUIDs_aL; Records in selection:C76([Cond Units:45]))
		SELECTION TO ARRAY:C260([Cond Units:45]Cond Unit ID:1; $CUIDs_aL)
		If (Find in array:C230($CUIDs_aL; INSP_CurrCUID_L)>0)
			GOTO SELECTED RECORD:C245([Cond Units:45]; Find in array:C230($CUIDs_aL; INSP_CurrCUID_L))
		End if 
		
		If (Not:C34(vbInspectionLocked))
			INSP_HICalcControl("Calc")
			INSP_HICalcControl("TODB")
		End if 
		
End case 