//%attributes = {"invisible":true}
//GP P_ReviewChanges
//Copyright © 1997, Albert Leung, All Rights Reserved.
//Load changes unsent.
If (False:C215)
	Mods_2004_CM06
	Mods_2005_CM05
	// Modified by: Costas Manousakis-(Designer)-(4/11/16 15:06:35)
	Mods_2016_04_bug
	//  `Change params to modify selection/display selection to display in list even a single record
	// Modified by: Costas Manousakis-(Designer)-(10/28/16 15:21:02)
	Mods_2016_10
	//  `use wiidth of output form for the window
	// Modified by: Costas Manousakis-(Designer)-(3/6/17 09:12:39)
	Mods_2017_03
	//  `added sorting by RefID
	// Modified by: Costas Manousakis-(Designer)-(5/18/18 16:12:54)
	Mods_2018_05
	//  `make sure [owners of data] is RO or RW as needed
	Mods_2020_07  //continue replace of old output forms with list boxes
	//Modified by: CJ (7/6/20 15:20:34)
	Mods_2020_12  // Modifed to add current method name to ut_UseListBox call
	//Modified by: CJ (12/22/20 14:45:46)
	
End if 

C_TEXT:C284(MainTitle)  // Command Replaced was o_C_STRING length was 255//What is the main window title?

MainTitle:="Changes unsent"

pFile:=->[Activity Log:59]

QUERY:C277([Activity Log:59]; [Activity Log:59]Status:9=0)
ORDER BY:C49([Activity Log:59]; [Activity Log:59]RefID:28; >)
FORM SET INPUT:C55([Activity Log:59]; "Input")
C_TEXT:C284($Form_txt)
C_BOOLEAN:C305($useLB_B)
$useLB_B:=ut_UseListBox(Current method name:C684)

If ($useLB_B)
	$Form_txt:="Output_LB"
Else 
	$Form_txt:="Output"
End if 
FORM SET OUTPUT:C54([Activity Log:59]; $Form_txt)

C_TEXT:C284($RecSel)  // Command Replaced was o_C_STRING length was 10
$RecSel:=String:C10(Records in selection:C76([Activity Log:59]))
ControlMenuBar(3)  //blank menu
C_LONGINT:C283($Wid_L; $Ht_L; $Win_L)
FORM GET PROPERTIES:C674([Activity Log:59]; $Form_txt; $Wid_L; $Ht_L)
$Win_L:=ut_OpenNewWindow($Wid_L+10; 550; 2; Plain form window:K39:10; MainTitle+" ["+$RecSel+"]"; "ut_CloseCancel")

//NewWindow ($Wid_L;450;1;Plain window)  //Window for this process
UpdatWindArray(""; Current process:C322)
//SET WINDOW TITLE(MainTitle+" ["+$RecSel+"]")
If ((Current user:C182="Designer") & Macintosh control down:C544 & Macintosh option down:C545)
	READ WRITE:C146([Activity Log:59])
Else 
	READ ONLY:C145([Activity Log:59])
End if 
If ($useLB_B)
	DIALOG:C40([Activity Log:59]; $Form_txt)
Else 
	If ((Current user:C182="Designer") & Macintosh control down:C544 & Macintosh option down:C545)
		READ WRITE:C146([Owners of Data:62])
		MODIFY SELECTION:C204([Activity Log:59]; Multiple selection:K50:3; False:C215; *; *)
	Else 
		READ ONLY:C145([Owners of Data:62])
		DISPLAY SELECTION:C59([Activity Log:59]; Multiple selection:K50:3; False:C215; *; *)
		
	End if 
End if 
UpdatWindArray(""; Current process:C322)
CLOSE WINDOW:C154
ControlMenuBar(1)