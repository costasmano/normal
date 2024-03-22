//%attributes = {"invisible":true}
If (False:C215)
	//created: 10/10/2003
	//M_SearchTownAddress 
	// Modified by: Costas Manousakis-(Designer)-(3/28/19 11:55:45)
	Mods_2019_03
	//  `use moovable dialog box. copy the temp selection before the dialog
	// Modified by: Costas Manousakis-(Designer)-(4/15/20 18:28:16)
	Mods_2020_04
	//  `Use center_window_2
End if 

COPY NAMED SELECTION:C331([Town Address:78]; "Temp")
C_LONGINT:C283($W; $L)
FORM GET PROPERTIES:C674([Dialogs:21]; "Search Town Address"; $W; $L)
Center_Window_2($W; $L; Movable dialog box:K34:7)

DIALOG:C40([Dialogs:21]; "Search Town Address")
CLOSE WINDOW:C154

If (Ok=1)
	If (Records in set:C195("Random Set")=0)
		C_TEXT:C284($vTown)
		$vTown:=f_TrimStr(aTownName_{0}; True:C214; True:C214)
		
		If ($vTown#" ")
			CreateRandomSetinTownAddress
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