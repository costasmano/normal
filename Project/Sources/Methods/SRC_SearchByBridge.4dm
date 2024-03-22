//%attributes = {"invisible":true}
// Method: SRC_SearchByBridge
// Description
// Search a table by bridge BIN, BDEPT, or BRKEY
// Parameters
// 1 : Table to search : ptr
// 2 : BIN Field : ptr
// 3 : BDEPT Field : ptr
// 4 : BRKEY Field : ptr
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// ----------------------------------------------------
	//(11/24/2006 17:36:40)
	
	Mods_2006_CM07
	// Modified by: costasmanousakis-(Designer)-(9/28/2007 12:19:27)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/24/2007 09:15:34)
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(1/8/08 11:50:50)
	Mods_2007_CM_5401
	// Modified by: Costas Manousakis-(Designer)-(5/24/13 14:08:27)
	Mods_2013_05
	//  `Added  a check for non-blank search variables after the OK is clicked
	// Modified by: Costas Manousakis-(Designer)-(3/2/20 17:35:27)
	Mods_2020_03_bug
	//  `use new method Center_Window_2 to center on top of current window
End if 
C_POINTER:C301($1; $2; $3; $4)
SRC_DeclareBrgVars
SRC_MasterTable_ptr:=$1
SRC_BINField_ptr:=$2
SRC_BDEPTField_ptr:=$3
SRC_BRKEYField_ptr:=$4
If (Count parameters:C259>4)
	C_BOOLEAN:C305($5)
	SRC_AllowSearchAll_b:=$5
Else 
	SRC_AllowSearchAll_b:=False:C215
End if 

SRC_NewSearchMethod_b:=True:C214
C_LONGINT:C283($vDialogW_L; $vDialogH_L)
COPY NAMED SELECTION:C331(SRC_MasterTable_ptr->; "Temp")
FORM GET PROPERTIES:C674([Dialogs:21]; "Search Bridge"; $vDialogW_L; $vDialogH_L)
Center_Window_2($vDialogW_L; $vDialogH_L; Movable dialog box:K34:7)
DIALOG:C40([Dialogs:21]; "Search Bridge")
CLOSE WINDOW:C154

If (Ok=1)
	If (Records in set:C195("Random Set")=0)
		vBIN:=Replace string:C233(vBIN; " "; "")
		vBDEPT:=Replace string:C233(vBDEPT; " "; "")
		vBDEPT:=Replace string:C233(vBDEPT; "_"; "")
		vBridgeKey:=Replace string:C233(vBridgeKey; " "; "")
		If ((vBIN#"") | (vBDEPT#"") | (vBridgeKey#""))
			CreateRandomSet
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

SRC_AllowSearchAll_b:=False:C215
RegionTitle