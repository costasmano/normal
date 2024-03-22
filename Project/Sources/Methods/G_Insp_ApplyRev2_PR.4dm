//%attributes = {"invisible":true}
If (False:C215)
	//G_Insp_ApplyRev2_PR 
	//Apply changes for Rev2 of Inspection Print forms.
	Mods_2005_CM05
	Mods_2005_CM08
	// Modified by: Costas Manousakis-(Designer)-(7/26/13 17:20:12)
	Mods_2013_07
	//  `added other agencies to the exception list
End if 

If (([Inspections:27]Agency:156#"Mass. Highway @") & ([Inspections:27]Agency:156#"MBTA@") & ([Inspections:27]Agency:156#"DCR@") & ([Inspections:27]Agency:156#"MHD Underwater Oper@") & ([Inspections:27]Agency:156#"MassPort@"))
	If (f_Insp_Revision2([Inspections:27]Insp Date:78))
		OBJECT SET VISIBLE:C603(*; "ConsQC@"; True:C214)
	Else 
		OBJECT SET VISIBLE:C603(*; "ConsQC@"; False:C215)
	End if 
Else 
	OBJECT SET VISIBLE:C603(*; "ConsQC@"; False:C215)
End if 