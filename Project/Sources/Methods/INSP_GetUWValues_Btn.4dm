//%attributes = {"invisible":true}
// Method: INSP_GetUWValues_Btn
// Description
// Code executed from a form button in inspection input forms to retrieve underwater inspection values.
// 
// Parameters
// $1 :$Alerts_b optional : Show Alerts or not
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/21/06, 09:07:37
	// ----------------------------------------------------
	Mods_2006_CM03
	// Modified by: Costas Manousakis-(Designer)-(10/24/13 11:19:39)
	Mods_2013_10
	//  `use  method  INSP_IsInspRoutine_b to check if inspection is a routine one
End if 
C_BOOLEAN:C305($1; $Alerts_b)
If (Count parameters:C259=1)
	$Alerts_b:=$1
Else 
	$Alerts_b:=True:C214
End if 
G_GetUWRatings($Alerts_b)
//Item 61 same for Routine and Culvert Inspections
If (bIsNumeric([Inspections:27]Item 61 UW:72))
	If (bIsNumeric([Inspections:27]Item 61 Cur:159))
		Case of 
			: (Num:C11([Inspections:27]Item 61 UW:72)<Num:C11([Inspections:27]Item 61 Cur:159))
				[Inspections:27]Item 61:82:=[Inspections:27]Item 61 UW:72
				PushChange(1; ->[Inspections:27]Item 61:82)
			: (Num:C11([Inspections:27]Item 61 Cur:159)<Num:C11([Inspections:27]Item 61 UW:72))
				[Inspections:27]Item 61:82:=[Inspections:27]Item 61 Cur:159
				PushChange(1; ->[Inspections:27]Item 61:82)
		End case 
	Else 
		[Inspections:27]Item 61:82:=[Inspections:27]Item 61 UW:72
		PushChange(1; ->[Inspections:27]Item 61:82)
	End if 
	If ($Alerts_b)
		//Thermometer for Item 61
		G_SetThermometer(->tItem61; [Inspections:27]Item 61:82)
	End if 
	
End if 
//Routine Inspections use Item 60 ; Culvert inspections item 62
Case of 
	: (([Inspections:27]Insp Type:6="CUL") | ([Inspections:27]Insp Type:6="RRC"))
		If (bIsNumeric([Inspections:27]Item 62 UW:165))
			If (bIsNumeric([Inspections:27]Item 62 Cur:172))
				Case of 
					: (Num:C11([Inspections:27]Item 62 UW:165)<Num:C11([Inspections:27]Item 62 Cur:172))
						[Inspections:27]Item 62:113:=[Inspections:27]Item 62 UW:165
						PushChange(1; ->[Inspections:27]Item 62:113)
					: (Num:C11([Inspections:27]Item 62 Cur:172)<Num:C11([Inspections:27]Item 62 UW:165))
						[Inspections:27]Item 62:113:=[Inspections:27]Item 62 Cur:172
						PushChange(1; ->[Inspections:27]Item 62:113)
				End case 
			Else 
				[Inspections:27]Item 62:113:=[Inspections:27]Item 62 UW:165
				PushChange(1; ->[Inspections:27]Item 62:113)
			End if 
			
			If ($Alerts_b)
				//Thermometer for Item 62
				G_SetThermometer(->tItem62; [Inspections:27]Item 62:113)
			End if 
		End if 
		
	: (INSP_IsInspRoutine_b)
		If (bIsNumeric([Inspections:27]Item 60 UW:66))
			If (bIsNumeric([Inspections:27]Item 60 Cur:155))
				Case of 
					: (Num:C11([Inspections:27]Item 60 UW:66)<Num:C11([Inspections:27]Item 60 Cur:155))
						[Inspections:27]Item 60:81:=[Inspections:27]Item 60 UW:66
						PushChange(1; ->[Inspections:27]Item 60:81)
					: (Num:C11([Inspections:27]Item 60 Cur:155)<Num:C11([Inspections:27]Item 60 UW:66))
						[Inspections:27]Item 60:81:=[Inspections:27]Item 60 Cur:155
						PushChange(1; ->[Inspections:27]Item 60:81)
				End case 
			Else 
				[Inspections:27]Item 60:81:=[Inspections:27]Item 60 UW:66
				PushChange(1; ->[Inspections:27]Item 60:81)
			End if 
			
			If ($Alerts_b)
				//Thermometer for Item 60
				G_SetThermometer(->tItem60; [Inspections:27]Item 60:81)
			End if 
		End if 
		
End case 