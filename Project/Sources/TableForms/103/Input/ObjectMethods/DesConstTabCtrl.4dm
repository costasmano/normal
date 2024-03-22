If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/02/09, 15:55:24
	// ----------------------------------------------------
	// Method: Object Method: Tab Control1
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 13:59:39  ` ("WKHRSMODS")
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		Self:C308->:=1
		If (Self:C308->=1)
			OBJECT SET VISIBLE:C603(*; "@DSGN@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "@Constr@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "@DSGN@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "@Constr@"; True:C214)
		End if 
		If ([Work_Estimate:103]Version_L:47=1)
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		If (Self:C308->=1)
			OBJECT SET VISIBLE:C603(*; "@DSGN@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "@Constr@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "@DSGN@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "@Constr@"; True:C214)
		End if 
		
End case 
