//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/23/09, 09:25:24
	// ----------------------------------------------------
	// Method: SR_PrintSelection
	// Description
	// 
	// 
	// Parameters
	DIALOG:C40([Status Report:69]; "P_StatusReport_MDOT_5D")
	DIALOG:C40([Status Report:69]; "P_StatusReport_HI")
	DIALOG:C40([Status Report:69]; "P_StatusReport_MDOT")
	// ----------------------------------------------------
	
	Mods_2009_12
	
	// Modified by: costasmanousakis-(Designer)-(3/7/11 18:05:33)
	Mods_2011_03
	//  `use method STATREP_DefaultPrintForm
End if 

C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($Recs; $RecsHiLighted; $RecsToPrint)
C_TEXT:C284($text)

$Recs:=Records in selection:C76([Status Report:69])
$RecsHiLighted:=Records in set:C195("UserSet")
If ($RecsHiLighted>0)
	$RecsToPrint:=$RecsHiLighted
Else 
	$RecsToPrint:=$Recs
End if 


If ($RecsToPrint>0)
	If ($RecsToPrint>10)
		$text:="Do you really want to print "+String:C10($RecsToPrint)+" Bridge Status Reports?"
		CONFIRM:C162($text)
	End if 
	If (Ok=1)
		C_TEXT:C284($printform)  // Command Replaced was o_C_STRING length was 40
		
		$printform:="P_StatusReport_HI"
		
		If (<>CurrentUser_Name="Designer")
			CONFIRM:C162("choose form"; "NEW"; "OLD")
			If (OK=1)
				$printform:="P_StatusReport_HI"
			End if 
		End if 
		C_BOOLEAN:C305($printRec_b)
		//_O_PAGE SETUP([Status Report]; $printform)
		FORM SET OUTPUT:C54([Status Report:69]; $printform)
		READ ONLY:C145([Status Report:69])
		PRINT SETTINGS:C106
		FIRST RECORD:C50([Status Report:69])
		For ($i; 1; $Recs)
			//PrepStatusRep ` removed this call - is called in form method
			$printRec_b:=True:C214
			If ($RecsHiLighted>0)
				If (Is in set:C273("UserSet"))
				Else 
					$printRec_b:=False:C215
				End if 
				
			End if 
			
			If ($printRec_b)
				$printform:=STATREP_DefaultPrintForm(STATREP_ReportType; [Status Report:69]Date_Created:1)
				Print form:C5([Status Report:69]; $printform)
				If ($i<$Recs)
					PAGE BREAK:C6(>)
				End if 
				
			End if 
			NEXT RECORD:C51([Status Report:69])
		End for 
		PAGE BREAK:C6
		READ WRITE:C146([Status Report:69])
	End if 
Else 
	BEEP:C151
	ALERT:C41("No records have been selected!")
End if 