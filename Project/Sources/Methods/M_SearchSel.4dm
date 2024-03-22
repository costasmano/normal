//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: M_SearchSel
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Jim Steinman
	//Date:  10/1/95
	
	//Purpose: Displays 4D's built-in Search Editor
	// with Selection in selection Checkbox checked.
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	<>fJ_Steinman:=False:C215
	// Modified by: costasmanousakis-(Designer)-(4/3/08 16:37:25)
	Mods_2008_CM_5403
	// Modified by: costasmanousakis-(Designer)-(1/24/11 13:43:46)
	Mods_2011_01
	//  ` Added setting Auto Relations to True True before the search
	// Modified by: Costas Manousakis-(Designer)-(9/13/16 14:46:57)
	Mods_2016_09
	//  // Make sure QuerySelection is done in selection by intersecting the results with the start set.
	
End if 

C_BOOLEAN:C305($AutoOne_b; $AutoMany_b)
GET AUTOMATIC RELATIONS:C899($AutoOne_b; $AutoMany_b)
SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
CREATE SET:C116(pFile->; "PREQUERYSELSET")
QUERY SELECTION:C341(pFile->)
If (OK=1)
	CREATE SET:C116(pFile->; "POSTQUERYSELSET")
	INTERSECTION:C121("PREQUERYSELSET"; "POSTQUERYSELSET"; "POSTQUERYSELSET")
	USE SET:C118("POSTQUERYSELSET")
	CLEAR SET:C117("POSTQUERYSELSET")
	C_TEXT:C284(GEN_SORTLISTCMD_txt)
	If (GEN_SORTLISTCMD_txt#"")
		EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
	End if 
	
End if 
CLEAR SET:C117("PREQUERYSELSET")

WindowTitle
SET AUTOMATIC RELATIONS:C310($AutoOne_b; $AutoMany_b)
//End of procedure