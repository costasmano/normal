//%attributes = {"invisible":true}
If (False:C215)
	//GP P_Personnel
	//Copyright © 1997, Thomas D. Nee, All Rights Reserved.
	//Load personnel data.
	
	// Modified by: ManousakisC (2/14/2006)
	Mods_2006_CM03
	// Modified by: Costas Manousakis-(Designer)-(4/11/18 14:56:29)
	Mods_2018_04
	//  `make all other tables RO, only [personnel] is RW
	Mods_2020_06  //Added new list box output form. Only for designer now
	//Modified by: Chuck (6/25/20 16:03:37)
	
End if 

If (User in group:C338(Current user:C182; "Personnel Admin"))
	
	C_TEXT:C284(MainTitle)  //What is the main window title? ` old C_STRING length 255
	C_TEXT:C284(CurInsp)  //Who is doing the inspection? ` old C_STRING length 5
	C_POINTER:C301(pFile)  //The file that is current
	C_TEXT:C284(DefInLay)  // old C_STRING length 255
	C_TEXT:C284(DefOutLay)  // old C_STRING length 255
	C_LONGINT:C283(vOutputMenuBar_L)
	InitProcessVar
	MainTitle:="Personnel Records"
	CurInsp:=""
	pFile:=->[Personnel:42]
	C_BOOLEAN:C305($useLB_B)
	$useLB_B:=ut_UseListBox(Current method name:C684)
	
	If ($useLB_B)
		DefOutLay:="Inspectors Out_LB"  //Default output layout 
	Else 
		DefOutLay:="Inspectors Out"  //Default output layout 
	End if 
	DefInLay:="Inspectors In"  //Default input layout
	vOutputMenuBar_L:=3
	READ ONLY:C145(*)
	READ WRITE:C146([Personnel:42])
	ModSelSort(->[Personnel:42]; DefInLay; DefOutLay; MainTitle; 620; 450; 1; Plain form window:K39:10; ->[Personnel:42]Last Name:5; ">")
Else 
	ALERT:C41("Your Password does not allow you to use this item.")
End if 