//%attributes = {"invisible":true}
If (False:C215)
	//G_Insp_FontAlert
	//Method to display an Alert about font incompatibilities
	//between Mac and Win platforms.
	
	//``SJH 3/29/04 - Display alert message if font is Geneva and printing from PC
	
	Mods_2004_CM12
	// Modified by: costasmanousakis-(Designer)-(11/10/2006 19:46:51)
	MODS_2007_CM04
End if 
C_BOOLEAN:C305(vInsp_FontAlertShown)
If (Not:C34(vInsp_FontAlertShown))
	
	If (vInspFontName="Geneva")
		vInspFontSize:=10
		If (<>PL_LPlatfrm=3)  //if PC platform (false is for counting total page num)      
			C_TEXT:C284($alertMessage)
			$alertMessage:="Please be aware that the text alignment and the total page number may be "
			$alertMessage:=$alertMessage+"different from the Macintosh version."
			ALERT:C41($alertMessage)
		End if 
	End if 
	vInsp_FontAlertShown:=True:C214
End if 
