//[Bridge MHD NBIS];"Other Info"
//Popupmenu for InspResp
If (False:C215)
	Mods_2019_09  //Add code to check and make sure all data is filled before enabling the save button
	//Modified by: Chuck Miller (9/17/19 11:50:29)
End if 
POPUPMENUC(->aInspRdes_; ->aInspRcod_; ->[Bridge MHD NBIS:1]InspResp:173)
If (Form event code:C388=On Load:K2:1)
	aInspRdes_:=0
	aInspRdes_{0}:="Select Inspection Responsibility..."
Else 
	If (Form event code:C388=On Clicked:K2:4)
		PushChange(1; ->[Bridge MHD NBIS:1]InspResp:173)
	End if 
	
End if 