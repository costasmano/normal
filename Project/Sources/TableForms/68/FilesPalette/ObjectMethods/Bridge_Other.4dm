If (False:C215)
	//Script: bOther [Dialogs];"FilesPalette"
	//ACI University Programming Classes
	//Created By: Jim Steinman
	//Date:  10/5/95
	
	// Modified by: manousakisc (1/12/2023)
	// if current user is massport - open the massport window
	
End if 

If (User in group:C338(<>CurrentUser_Name; "MassPort"))
	M_MPA
Else 
	M_OtherAgc
End if 

//End of script