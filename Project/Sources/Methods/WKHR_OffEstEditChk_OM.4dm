//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/19/08, 08:21:44
	// ----------------------------------------------------
	// Method: WKHR_OffEstEditChk_OM
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5403("WKHRS")
End if 
C_LONGINT:C283($FormEvent)
If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$FormEvent:=$1
Else 
	$FormEvent:=Form event code:C388
End if 

Case of 
	: ($FormEvent=On Load:K2:1)
		C_LONGINT:C283(WKHR_OfficeEstEdit_L)
		WKHR_OfficeEstEdit_L:=Num:C11(f_Boolean2String(WKHR_OfficeEstEdit_b; "10"))
	: ($FormEvent=On Clicked:K2:4)
		WKHR_OfficeEstEdit_b:=(WKHR_OfficeEstEdit_L=1)
		
End case 