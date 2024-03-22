//%attributes = {"invisible":true}
//GP P_ReviewLogged
//Copyright © 1997, Albert Leung, All Rights Reserved.
//Look at activity log for sent changes.
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(10/19/11 08:25:47)
	Mods_2011_10
	//  `Changed window type to plain window
	// Modified by: Costas Manousakis-(Designer)-(4/11/16 15:08:10)
	Mods_2016_04_bug
	//  `Change params to display selection to display in list even a single record
	// Modified by: Costas Manousakis-(Designer)-(10/28/16 15:21:02)
	Mods_2016_10
	//  `use wiidth of output form for the window
	// Modified by: Costas Manousakis-(Designer)-(3/6/17 09:12:39)
	Mods_2017_03
	//  `added sorting by RefID
	Mods_2022_05  //Continue coding and testing changes from modify selection to use of list boxes
	//Modified by: Chuck Miller (5/31/22 12:55:33)
End if 


C_TEXT:C284(MainTitle)  // Command Replaced was o_C_STRING length was 255//What is the main window title?

MainTitle:="Changes sent"

pFile:=->[Activity Log:59]

QUERY:C277([Activity Log:59]; [Activity Log:59]Status:9=1)
ORDER BY:C49([Activity Log:59]; [Activity Log:59]RefID:28; >)
FORM SET INPUT:C55([Activity Log:59]; "Input")
FORM SET OUTPUT:C54([Activity Log:59]; "Output")
C_TEXT:C284($RecSel)  // Command Replaced was o_C_STRING length was 10
$RecSel:=String:C10(Records in selection:C76([Activity Log:59]))
ControlMenuBar(2)
C_LONGINT:C283($Wid_L; $Ht_L)
C_TEXT:C284($Form_txt)
C_BOOLEAN:C305($useLB_B)
$useLB_B:=ut_UseListBox(Current method name:C684)

If ($useLB_B)
	$Form_txt:="Output_LB"
Else 
	$Form_txt:="Output"
End if 

C_LONGINT:C283($Win_L)
FORM GET PROPERTIES:C674([Activity Log:59]; $Form_txt; $Wid_L; $Ht_L)
$Win_L:=ut_OpenNewWindow($Wid_L+10; 550; 2; Plain form window:K39:10; MainTitle+" ["+$RecSel+"]"; "ut_CloseCancel")

//NewWindow ($Wid_L;450;1;Plain window)  //Window for this process
UpdatWindArray(""; Current process:C322)
SET WINDOW TITLE:C213(MainTitle+" ["+$RecSel+"]")
If ($useLB_B)
	DIALOG:C40([Activity Log:59]; $Form_txt)
Else 
	DISPLAY SELECTION:C59([Activity Log:59]; Multiple selection:K50:3; False:C215; *; *)
End if 
UpdatWindArray(""; Current process:C322)
CLOSE WINDOW:C154
ControlMenuBar(1)