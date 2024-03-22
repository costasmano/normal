//%attributes = {"invisible":true}
//Method: SR_StatusRptPrint_FM
//Description
//  ` form method for the printed bridge status reports
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 3/13/13, 09:34:16
	// ----------------------------------------------------
	//Created : 
	Mods_2013_03
	// Modified by: Costas Manousakis-(Designer)-(5/18/18 13:48:16)
	Mods_2018_05
	//  `adjust text of SD an FO labels depending on the calculation method of the report
	//  `Load the note in multistyled text for the new form "P_StatusReport_MDOT_POFA"
End if 
//

Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		C_BOOLEAN:C305(STATREP_ENGLISH_b)
		C_TEXT:C284(STATREP_D_A_Units)
		If (STATREP_ENGLISH_b)
			STATREP_D_A_Units:="Sq.Ft."
		Else 
			STATREP_D_A_Units:="Sq.M."
		End if 
		PrepStatusRep
		Startup_PL
		OBJECT SET VISIBLE:C603(*; "Win@"; <>WindowsPL_b)
		OBJECT SET VISIBLE:C603(*; "Mac@"; <>MacPL_b)
		C_TEXT:C284($StyleNote_txt)
		
		C_POINTER:C301($note_ptr)
		$note_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "ReportNote1")
		If (Not:C34(Is nil pointer:C315($note_ptr)))
			C_DATE:C307(v_69_001_d)  //this var is referenced as the date in the note
			v_69_001_d:=Date:C102(ut_GetSysParameter("NewBridgeCondStatus"; ""; "Value"))  //date referenced in the styled text
			$StyleNote_txt:=ut_GetSysParameter("STATREP_NEWNOTE")
			$note_ptr->:=$StyleNote_txt
		End if 
		
		If ([Status Report:69]SD_Calc_New_b:265)
			OBJECT SET TITLE:C194(*; "OldSD@"; "Poor (SD)")
			OBJECT MOVE:C664(*; "OldSD@"; 0; -12; 0; 12)
			OBJECT SET TITLE:C194(*; "OldFO@"; "Fair")
		End if 
		
End case 
//End SR_StatusRptPrint_FM