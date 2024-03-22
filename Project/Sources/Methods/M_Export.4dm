//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: M_Export
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Jim Steinman
	//Date:  10/1/95
	
	//Purpose:  This procedure prepares data for exporting
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	<>fJ_Steinman:=False:C215
	
	//Modified: 10/5 2/95
	//Why: To handle custom export editor
	
	<>fK_Wilbur:=False:C215
	
End if 

If (Current user:C182="Designer")
	EXPORT DATA:C666("")
Else 
	ExprtImprtDlog("Export")
End if 