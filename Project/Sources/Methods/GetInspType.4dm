//%attributes = {"invisible":true}
If (False:C215)
	//GetInspType
	//Define inspection type for a new inspection
	//Created : June-2002
	Mods_2005_VN01
	Mods_2009_03  //CJM  r001   `03/06/09, 14:08:02`Upgrade from open form window to open window
	// Modified by: costasmanousakis-(Designer)-(2/16/09 11:42:03)
	Mods_2009_CM_5404  // --- "FREEZETHAW"
	// Modified by: costasmanousakis-(Designer)-(3/19/09 23:35:14)
	Mods_2009_CM_5404  //Copied to Server on : 03/20/09, 08:29:31  ` ("FREEZETHAW")  `- bug fix
	//Window type to Movable dialog box
	// Modified by: costasmanousakis-(Designer)-(1/19/11 09:16:34)
	Mods_2011_01
	//`ADDED Rail type
	// Modified by: Costas Manousakis-(Designer)-(5/7/12 11:26:42)
	Mods_2012_05
	//  `Added Flood DVF
	// Modified by: Costas Manousakis-(Designer)-(11/2/12 19:06:30)
	Mods_2012_11
	//  ` New var INSP_SelectedNewInspType_txt set by page 2 of the [Dialogs];"InspectConfig" dialog
End if 

C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 3
C_LONGINT:C283($FormWindow)
C_LONGINT:C283(r1; r2; r3; r4; r5; r6; r7; r8; r9; r10; r11; r12; r13)  //Command Replaced was o_C_INTEGER
$0:=""

C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt; INSP_SelectedNewInspType_txt)
INSP_SelectedNewInspType_txt:=""
FORM GET PROPERTIES:C674([Dialogs:21]; "InspectConfig"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; (Movable dialog box:K34:7); $Title_txt; "ut_CloseCancel")
//$FormWindow:=Open form window([Dialogs];"InspectConfig";13)
DIALOG:C40([Dialogs:21]; "InspectConfig")
CLOSE WINDOW:C154($Win_l)

If (OK=1)
	Case of 
		: (INSP_SelectedNewInspType_txt#"")
			$0:=INSP_SelectedNewInspType_txt
		: (r1=1)
			If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="@RO")
				$0:="RRR"
			Else 
				$0:="RTN"
			End if 
		: (r2=1)
			$0:="FCR"
		: (r3=1)
			$0:="CMI"
		: (r4=1)
			$0:="CUL"
		: (r5=1)
			$0:="CLD"
		: (r6=1)
			$0:="DAM"
		: (r7=1)
			$0:="DVE"
		: (r8=1)
			$0:="DVL"
		: (r9=1)
			$0:="DVS"
		: (r10=1)
			$0:="RTA"
		: (r11=1)
			$0:="OTH"
		: (r12=1)
			$0:="FRZ"
		: (r13=1)
			$0:="DVF"
			
	End case 
End if 