//%attributes = {"invisible":true}
If (False:C215)
	//created: 10/10/2003
	
	// Modified by: costasmanousakis-(Designer)-(10/31/2007 08:31:16)
	Mods_2007_CM12_5302  // declare vars, use form dims
	// Modified by: Costas Manousakis-(Designer)-(3/28/19 14:49:02)
	Mods_2019_03
	//  `use moovable dialog box. copy the temp selection before the dialog
	// Modified by: Costas Manousakis-(Designer)-(4/15/20 18:27:10)
	Mods_2020_04
	//  `use Center_window_2
End if 

COPY NAMED SELECTION:C331([Conslt Address:77]; "Temp")

C_LONGINT:C283($W; $H)
FORM GET PROPERTIES:C674([Dialogs:21]; "Search Conslt Address"; $W; $H)
C_TEXT:C284(vConsltName)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vLastName)  // Command Replaced was o_C_STRING length was 50
Center_Window_2($W; $H; Movable dialog box:K34:7)
DIALOG:C40([Dialogs:21]; "Search Conslt Address")
CLOSE WINDOW:C154

If (Ok=1)
	vConsltName:=f_TrimStr(vConsltName; True:C214; True:C214)
	vLastName:=f_TrimStr(vLastName; True:C214; True:C214)
	If (Records in set:C195("Random Set")=0)
		If ((vConsltName#"") | (vLastName#""))
			CreateRandomSetinConsltAddress
			USE SET:C118("Random Set")
		End if 
	Else 
		USE SET:C118("Random Set")
	End if 
Else 
	USE NAMED SELECTION:C332("Temp")
End if 
CLEAR NAMED SELECTION:C333("Temp")
CLEAR SET:C117("Random Set")
RegionTitle