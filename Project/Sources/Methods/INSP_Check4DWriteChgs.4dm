//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/15/08, 13:44:48
	// ----------------------------------------------------
	// Method: INSP_Check4DWriteChgs
	// Description
	// Check for 4D Write area changes in Inspection input forms.
	// Called from various project methods and object methods.
	// Does not check for the last object because it can be called after
	// we moved to another page and entered stuff in other fields.
	
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
	Mods_2009_03  //CJM 2004 upgrade   `03/27/09, 11:28:33
	// Modified by: Costas Manousakis-(Designer)-(1/25/12 09:49:36)
	Mods_2012_01
	//Declared the 4D Write Areas
	Mods_2021_Delete
End if 
C_LONGINT:C283(OrientationTextArea; AreaGeneralRemarks)
If (OrientationTextArea>0)
	G_OrientationTxtArea(OrientationTextArea; On Losing Focus:K2:8)
End if 
If (AreaGeneralRemarks>0)
	G_GenRemarksArea(AreaGeneralRemarks; On Losing Focus:K2:8)
End if 
