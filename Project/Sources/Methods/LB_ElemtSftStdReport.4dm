//%attributes = {"invisible":true}
// ----------------------------------------------------
//User name (OS): Costas Manousakis
//User (4D) : Designer
//Date and time: 01/17/12, 08:07:16
// ----------------------------------------------------
//Method: LB_ElemtSftStdReport
//Description
// Run the standard report for the ElementsSafety listbox.

// Parameters
// ----------------------------------------------------
If (False:C215)
	//Created : 
	Mods_2012_01
End if 
//

C_BOOLEAN:C305(vIncludeComments)
If (Count parameters:C259>0)
	C_BOOLEAN:C305($1)
	vIncludeComments:=$1
Else 
	vIncludeComments:=False:C215
End if 

COPY NAMED SELECTION:C331([ElementsSafety:29]; "PREREPORTSELECTION")
CREATE SET:C116([ElementsSafety:29]; "TotalElmtsFound")
READ ONLY:C145([Inspections:27])
READ ONLY:C145([Bridge MHD NBIS:1])
RELATE ONE SELECTION:C349([ElementsSafety:29]; [Inspections:27])
RELATE ONE SELECTION:C349([Inspections:27]; [Bridge MHD NBIS:1])
ORDER BY:C49([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1; >)
//SET AUTOMATIC RELATIONS(False;False)
M_DeficientElementRpt

USE NAMED SELECTION:C332("PREREPORTSELECTION")
CLEAR NAMED SELECTION:C333("PREREPORTSELECTION")
CLEAR SET:C117("TotalElmtsFound")

//End LB_ElemtSftStdReport