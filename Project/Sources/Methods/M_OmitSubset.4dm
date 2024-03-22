//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: M_OmitSubset
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Jim Steinman
	//Date:  10/1/95
	
	//Purpose: Reduce current selection to those records NOT highlighted by the user
	
	//modified 28-nov-2000 : Created a tempSet1 from the UserSet because UserSet seems
	//to disappear after the OriginalSelSet is created
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	<>fJ_Steinman:=False:C215
	// Modified by: costasmanousakis-(Designer)-(4/3/08 16:35:01)
	Mods_2008_CM_5403
End if 
//TRACE
C_LONGINT:C283($LRecsInSet)
$LRecsInSet:=Records in set:C195("UserSet")
If ($LRecsInSet>0)
	COPY SET:C600("UserSet"; "TempSet1")
	CREATE SET:C116(pFile->; "OriginalSelSet")
	DIFFERENCE:C122("OriginalSelSet"; "TempSet1"; "NonHighlightedSet")
	USE SET:C118("NonHighlightedSet")
	CLEAR SET:C117("NonHighlightedSet")
	CLEAR SET:C117("OriginalSelSet")
	CLEAR SET:C117("TempSet1")
	C_TEXT:C284(GEN_SORTLISTCMD_txt)
	If (GEN_SORTLISTCMD_txt#"")
		EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
	End if 
	
	WindowTitle
Else 
	ALERT:C41("You must first Highlight Records to omit!")
End if 
//End of procedure
//NO TRACE