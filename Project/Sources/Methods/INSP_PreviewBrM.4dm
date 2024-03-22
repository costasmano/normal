//%attributes = {"invisible":true}
//Method: INSP_PreviewBrM
//Description
//  ` used in Preview of a Pontis or NBE tab in an inspection input form
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/15/15, 12:55:23
	// ----------------------------------------------------
	//Created : 
	Mods_2015_04
	// Modified by: Costas Manousakis-(Designer)-(7/8/16 01:07:53)
	Mods_2016_08
	//  //use NTI_Preview
	// Modified by: Costas Manousakis-(Designer)-(9/14/16 16:37:05)
	Mods_2016_09
	//  //use NTI_PrintNTEList for Cond Units also
End if 
//
If (PON_NBEDateOn_b([Inspections:27]Insp Date:78))
	If (False:C215)
		FORM SET OUTPUT:C54([PON_ELEM_INSP:179]; "Print")
		PRINT SELECTION:C60([PON_ELEM_INSP:179]; >)
		FORM SET OUTPUT:C54([PON_ELEM_INSP:179]; "Output")
		PAGE BREAK:C6
	Else 
		NTI_Preview(->[PON_ELEM_INSP:179])
	End if 
Else 
	ORDER BY:C49([Cond Units:45]; [BMS Elements:47]Element No:2; [Cond Units:45]Environment:4)
	If (False:C215)
		FORM SET OUTPUT:C54([Cond Units:45]; "Cond Units Prt 2")
		PRINT SELECTION:C60([Cond Units:45]; >)
		FORM SET OUTPUT:C54([Cond Units:45]; "Cond Units Out")
	Else 
		C_LONGINT:C283(vPageno)
		vPageno:=0
		NTI_PrintNTEList(->[Cond Units:45]; "Cond Units Prt 2")
	End if 
	PAGE BREAK:C6
End if 

//End INSP_PreviewBrM