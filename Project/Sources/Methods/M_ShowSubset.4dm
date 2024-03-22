//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: M_ShowSubset
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Jim Steinman
	//Date:  10/1/95
	
	//Purpose: Reduce the current selection to records highlighted by the user 
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	<>fJ_Steinman:=False:C215
	
	// Modified by: costasmanousakis-(Designer)-(4/3/08 16:34:04)
	Mods_2008_CM_5403
End if 

C_LONGINT:C283($LRecsInSet)
$LRecsInSet:=Records in set:C195("UserSet")
If ($LRecsInSet>0)
	USE SET:C118("UserSet")
	C_TEXT:C284(GEN_SORTLISTCMD_txt)
	
	If (GEN_SORTLISTCMD_txt#"")
		EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
	End if 
	
	WindowTitle
Else 
	ALERT:C41("You must first Highlight Records to use!")
End if 
//End of procedure