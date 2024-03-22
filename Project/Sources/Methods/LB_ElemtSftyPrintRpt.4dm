//%attributes = {"invisible":true}
// ----------------------------------------------------
//User name (OS): Costas Manousakis
//User (4D) : Designer
//Date and time: 01/13/12, 16:51:31
// ----------------------------------------------------
//Method: LB_ElemtSftyPrintRpt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Created : 
	Mods_2012_01
End if 
//
//Save current set
CREATE SET:C116([ElementsSafety:29]; "TotalElmtsFound")
COPY NAMED SELECTION:C331([ElementsSafety:29]; "ELMTSSFTYPREPRINT")
//Find Bridge records
RELATE ONE SELECTION:C349([ElementsSafety:29]; [Inspections:27])
RELATE ONE SELECTION:C349([Inspections:27]; [Bridge MHD NBIS:1])
ORDER BY:C49([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1; >)
M_DeficientElementRpt
USE NAMED SELECTION:C332("ELMTSSFTYPREPRINT")
CLEAR NAMED SELECTION:C333("ELMTSSFTYPREPRINT")
CLEAR SET:C117("TotalElmtsFound")
//End LB_ElemtSftyPrintRpt