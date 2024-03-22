//[Bridge MHD NBIS];"Other Info"
//Popupmenu for InspResp
If (False:C215)
	// Modified by: Chuck Miller-(Designer)-(8/24/17 14:54:52)
	Mods_2017_08_bug  //replace _ o _during
	
End if 

POPUPMENUC(->aInspRdes_; ->aInspRcod_; ->[Bridge MHD NBIS:1]InspResp:173)
If (Form event code:C388=On Clicked:K2:4)
	If (Old:C35([Bridge MHD NBIS:1]InspResp:173)#[Bridge MHD NBIS:1]InspResp:173)
		
		PushChange(1; ->[Bridge MHD NBIS:1]InspResp:173)
	End if 
End if 