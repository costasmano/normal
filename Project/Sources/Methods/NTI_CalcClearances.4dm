//%attributes = {"invisible":true}
//Method: NTI_CalcClearances
//Description
// Calculate and update the Clearance fields in feet from feet and inches in input form
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/20/18, 14:21:32
	// ----------------------------------------------------
	//Created : 
	Mods_2018_04_bug
End if 
//

C_LONGINT:C283($Number_L)
$Number_L:=(Feet_L*12)+Inches_L
If ([TIN_Inspections:184]ActualFieldMeasure_L:26#$Number_L)
	[TIN_Inspections:184]ActualFieldMeasure_L:26:=$Number_L
End if 
$Number_L:=(Feet1_L*12)+Inches1_L
If ([TIN_Inspections:184]PostedClearance_L:27#$Number_L)
	[TIN_Inspections:184]PostedClearance_L:27:=$Number_L
End if 

//End NTI_CalcClearances