//Method: [TIN_Inspections].Input.Tab Control
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 01/09/18, 16:40:55
	// ----------------------------------------------------
	//Created : 
	Mods_2018_01
	// Modified by: Costas Manousakis-(Designer)-(6/23/21 12:20:55)
	Mods_2021_WP
	//  `
End if 
//
If (Form current page:K67:6=1)
	
	NTI_SaveAndUpdateComments_WP(False:C215)
	
End if 
C_LONGINT:C283($NewPage_L)
$NewPage_L:=tab control
FORM GOTO PAGE:C247(TAB CONTROL)
C_BOOLEAN:C305($Enabled_B)
$Enabled_B:=True:C214
Case of 
	: (Tab Control{$NewPage_L}="Comments")
	: (Tab Control{$NewPage_L}="NTE")
	: (Tab Control{$NewPage_L}="Images")
	: (Tab Control{$NewPage_L}="Postings")
	Else 
		$Enabled_B:=False:C215
End case 


OBJECT SET VISIBLE:C603(*; "vPrintPreview"; $Enabled_B)
OBJECT SET ENABLED:C1123(*; "vPrintPreview"; $Enabled_B)

//End [TIN_Inspections].Input.Tab Control