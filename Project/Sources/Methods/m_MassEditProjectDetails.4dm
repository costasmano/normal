//%attributes = {"invisible":true}
// ----------------------------------------------------
// m_MassEditProjectDetails
// User name (OS): cjmiller
// Date and time: 04/12/07, 13:36:45
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2
End if 
If (Records in set:C195("UserSet")>0)
	C_LONGINT:C283($Wid; $ht)
	FORM GET PROPERTIES:C674([PRJ_ProjectDetails:115]; "Massedit.i"; $Wid; $ht)
	NewWindow($Wid; $ht; 0; Plain window:K34:13)
	DIALOG:C40([PRJ_ProjectDetails:115]; "Massedit.i")
	CLOSE WINDOW:C154
Else 
	ALERT:C41("You must select records to modify")
End if 

//End m_MassEditProjectDetails