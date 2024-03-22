
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 05/23/13, 16:32:02
//----------------------------------------------------
//Method: Object Method: Testing.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_05  //r003 ` 
	//Modified by: Charles Miller (5/23/13 16:32:04)
	
End if 
If (Table name:C256(TableNumber_L)="TableOfLists")
	If (TOL_ListName_txt="")
	Else 
		C_LONGINT:C283($Count_L)
		SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
		QUERY SELECTION:C341([TableOfLists:125]; [TableOfLists:125]ListName_s:1=TOL_ListName_txt)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($Count_L=Records in selection:C76([TableOfLists:125]))
			ACCEPT:C269
		Else 
			ALERT:C41("You can only export [TableOfLists] by [TableOfLists]ListName_s. All records must be the same.")
			
		End if 
	End if 
Else 
	
	ACCEPT:C269
	
End if 
//End Object Method: Testing.Button

