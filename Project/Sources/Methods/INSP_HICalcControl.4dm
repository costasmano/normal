//%attributes = {"invisible":true}
// Method: INSP_HICalcControl
// Description
// Control Flow of HI Calculations in a Pontis Inspection
// Parameters
// $1 : $Task_txt ( "CALC" | "INIT"|TODB | ALL)
// $2 : $chgptrstack_L - used for "TODB" task
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/01/10, 12:35:56
	// ----------------------------------------------------
	// ----------------------------------------------------
	
	Mods_2010_02
	// Modified by: costasmanousakis-(Designer)-(5/18/10 11:37:37)
	// Modified by: Costas Manousakis-(Designer)-(4/8/15 17:09:35)
	Mods_2015_04
	//  `adjustment for NBEs
	
End if 
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
Case of 
	: ($Task_txt="INIT")
		C_REAL:C285(INSP_HI_r; INSP_TOTV_r; INSP_CurrV_r)
		INSP_HI_r:=-1
		INSP_TOTV_r:=0
		INSP_CurrV_r:=0
		
	: ($Task_txt="CALC")
		If ([BMS Inspections:44]Inspection ID:1>0)
			
			If (PON_NBEDateOn_b([Inspections:27]Insp Date:78))
				//COPY NAMED SELECTION([PON_ELEM_INSP];"PREHICALCCUSELECTION")
				INSP_HI_r:=PON_CalcInspectionHI([Inspections:27]InspID:2; ->INSP_TOTV_r; ->INSP_CurrV_r)
				//USE NAMED SELECTION("PREHICALCCUSELECTION")
				//CLEAR NAMED SELECTION("PREHICALCCUSELECTION")
			Else 
				COPY NAMED SELECTION:C331([Cond Units:45]; "PREHICALCCUSELECTION")
				INSP_HI_r:=HI_CalcInspectionHI([BMS Inspections:44]Inspection ID:1; ->INSP_TOTV_r; ->INSP_CurrV_r)
				USE NAMED SELECTION:C332("PREHICALCCUSELECTION")
				CLEAR NAMED SELECTION:C333("PREHICALCCUSELECTION")
			End if 
			
		End if 
	: ($Task_txt="TODB")
		C_LONGINT:C283($chgptrstack_L)
		$chgptrstack_L:=3
		If (Count parameters:C259>1)
			C_LONGINT:C283($2)
			$chgptrstack_L:=$2
		End if 
		
		[BMS Inspections:44]INSP_HI:15:=INSP_HI_r
		[BMS Inspections:44]INSP_CurrV:17:=INSP_CurrV_r
		[BMS Inspections:44]INSP_TotV:16:=INSP_TOTV_r
		PushChange($chgptrstack_L; ->[BMS Inspections:44]INSP_HI:15)
		PushChange($chgptrstack_L; ->[BMS Inspections:44]INSP_CurrV:17)
		PushChange($chgptrstack_L; ->[BMS Inspections:44]INSP_TotV:16)
	: ($Task_txt="ALL")
		
		INSP_HICalcControl("INIT")
		INSP_HICalcControl("CALC")
		If (Count parameters:C259>1)
			C_LONGINT:C283($2)
			INSP_HICalcControl("TODB"; $2)
		Else 
			INSP_HICalcControl("TODB")
		End if 
		
End case 