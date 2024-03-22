//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/14/08, 09:17:16
	// ----------------------------------------------------
	// Method: SIA_BridgeRankOM
	// Description
	// Object method for the Bridge rank objects on SIA forms
	// 
	// Parameters
	// $1 : $FormEvent (Long - Optional)
	// ----------------------------------------------------
	
	Mods_2008_CM_5403
	
	// Modified by: Costas Manousakis-()-(1/12/12 10:40:13)
	Mods_2012_01
	//  `Allow everyone access to the Rank
End if 
C_LONGINT:C283($FormEvent)
If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$FormEvent:=$1
Else 
	$FormEvent:=Form event code:C388
End if 
C_REAL:C285(HealthIndexPct_r)

Case of 
	: (($FormEvent=On Load:K2:1) | ($FormEvent=On Printing Detail:K2:18) | ($FormEvent=On Display Detail:K2:22))
		OBJECT SET VISIBLE:C603(*; "@_Rank@"; (True:C214 | User in group:C338(<>CurrentUser_Name; "BridgeRankDisplay") | (<>CurrentUser_Name="Designer")))
		HealthIndexPct_r:=([Bridge MHD NBIS:1]HealthIndex:222*100)
		
End case 