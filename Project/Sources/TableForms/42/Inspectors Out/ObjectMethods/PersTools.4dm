If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/22/08, 09:41:48
	// ----------------------------------------------------
	// Method: Object Method: PersTools_atxt
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
	// Modified by: costasmanousakis-(Administrator)-(12/12/11 10:28:24)
	Mods_2011_12
	//  `Access given to Design Access Group
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (User in group:C338(<>CurrentUser_Name; "Design Access Group"))
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_TEXT:C284($cmd)
		C_LONGINT:C283($indx)
		$indx:=Self:C308->
		$cmd:=Self:C308->{$indx}
		If ($cmd#". @")
			
			EXECUTE FORMULA:C63($cmd)
		End if 
		
End case 
