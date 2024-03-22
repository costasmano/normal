If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/07/08, 15:22:30
	// ----------------------------------------------------
	// Method: Form Method: LatLongControl
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5403
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283(FileInput; Center_chk; MaxArraySize; File_Header)
		C_TEXT:C284(SourceFile_txt)
		C_REAL:C285(Center_Lat; Center_Lon; vRadiusR; vMinRadius_r)
		FileInput:=0
		Center_chk:=0
		OBJECT SET ENTERABLE:C238(*; "File@"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "Center@"; False:C215)
		OBJECT SET ENABLED:C1123(*; "OKBtn"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(*; "File@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		
End case 
