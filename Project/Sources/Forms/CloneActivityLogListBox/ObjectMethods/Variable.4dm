
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 03/15/12, 16:12:38
//----------------------------------------------------
//Method: Object Method: CloneActivityLogListBox.StartRefID_l
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_03  //r001
	//Modified by: Charles Miller (3/15/12 16:12:39)
	
End if 
SQL_SelectByRef_txt:=""
Case of 
	: (StartRefID_l=0) & (EndRefID_l=0)
		
	: (EndRefID_l>StartRefID_l)
		SQL_SelectByRef_txt:="WHERE [RefID]>=:StartRefID_l AND  [RefID]<=:EndRefID_l"
	: (EndRefID_l<StartRefID_l)
		SQL_SelectByRef_txt:="WHERE [RefID]>=:StartRefID_l"
		EndRefID_l:=0
	Else 
		
End case 
//End Object Method: CloneActivityLogListBox.StartRefID_l

