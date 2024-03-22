If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/16/07, 22:59:47
	// ----------------------------------------------------
	// Method: Object Method: aHL_ReportTemplates
	// Description
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM10
	// Modified by: costasmanousakis-(Designer)-(9/24/08 21:14:13)
	Mods_2008_CM_5404  // ("HLISTSELECT")
	//  `Use new method TMPL_HListOnSelect to act on the selected item.
	// Modified by: costasmanousakis-(Designer)-(12/23/10 09:58:06)
	Mods_2010_12
	//  `Save the selected item no in a process variable
End if 
C_LONGINT:C283($ItemPos)

Case of 
	: (Form event code:C388=On Double Clicked:K2:5)
		$ItemPos:=TMPL_HListOnSelect
		If ($ItemPos>0)
			TMPL_HLSelectedItem_L:=$ItemPos
			ACCEPT:C269
		End if 
	: (Form event code:C388=On Clicked:K2:4)
		$ItemPos:=TMPL_HListOnSelect
		If ($ItemPos>0)
			TMPL_HList_OM($ItemPos)
		End if 
		
End case 