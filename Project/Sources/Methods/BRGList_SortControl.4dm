//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/01/08, 08:15:55
	// ----------------------------------------------------
	// Method: BRGList_SortControl
	// Description
	// Control sorting in the Bridge List screens
	// 
	// Parameters
	// $1 : text : Action (INIT | APPLYSORT | SETBUTTON)
	// $2 : $Btn_ptr : Pointer to button variable (Optional used only for SETBUTTON action
	// ----------------------------------------------------
	
	Mods_2008_CM_5403
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2013_03  //r001 ` Make sure to not reset value of GEN_SORTLISTCMD_txt when = "mbta_SortRecords"
	//Modified by: Charles Miller (3/7/13 13:42:48)
	// Modified by: Costas Manousakis-(Designer)-(3/29/13 14:05:43)
	Mods_2013_03
	//  `Added sort by Line name for MBTA 
End if 
C_TEXT:C284($1)


Case of 
	: ($1="INIT")
		C_LONGINT:C283(vSortBDEPT; vSortItem8; vSortBIN; vSortItem7; vSortItem6a; vSortBrName; vSortBrMIlePost; vSortLine; vSortType)
		vSortBDEPT:=1
		vSortItem8:=0
		vSortBIN:=0
		vSortItem7:=0
		vSortItem6a:=0
		vSortBrName:=0
		ARRAY POINTER:C280(BRGList_SortPtr_ap; 6)
		BRGList_SortPtr_ap{1}:=->vSortBDEPT
		BRGList_SortPtr_ap{2}:=->vSortItem8
		BRGList_SortPtr_ap{3}:=->vSortBIN
		BRGList_SortPtr_ap{4}:=->vSortItem7
		BRGList_SortPtr_ap{5}:=->vSortItem6a
		BRGList_SortPtr_ap{6}:=->vSortBrName
		
		ARRAY POINTER:C280(BRGList_SortFld_ap; 6)
		BRGList_SortFld_ap{1}:=->[Bridge MHD NBIS:1]BDEPT:1
		BRGList_SortFld_ap{2}:=->[Bridge MHD NBIS:1]Item8:206
		BRGList_SortFld_ap{3}:=->[Bridge MHD NBIS:1]BIN:3
		BRGList_SortFld_ap{4}:=->[Bridge MHD NBIS:1]Item7:65
		BRGList_SortFld_ap{5}:=->[Bridge MHD NBIS:1]Item6A:63
		BRGList_SortFld_ap{6}:=->[Bridge MHD NBIS:1]Bridge Name:29
		C_TEXT:C284(GEN_SORTLISTCMD_txt)
		If (CurInsp="MBTA")
			vSortLine:=0
			vSortType:=0
			INSERT IN ARRAY:C227(BRGList_SortPtr_ap; 0; 1)
			INSERT IN ARRAY:C227(BRGList_SortFld_ap; 0; 1)
			BRGList_SortPtr_ap{1}:=->vSortType
			BRGList_SortFld_ap{1}:=->[Bridge MHD NBIS:1]BDEPT:1
			APPEND TO ARRAY:C911(BRGList_SortPtr_ap; ->vSortBrMIlePost)
			APPEND TO ARRAY:C911(BRGList_SortFld_ap; ->[Bridge MHD NBIS:1]Item11:67)
			APPEND TO ARRAY:C911(BRGList_SortPtr_ap; ->vSortLine)
			APPEND TO ARRAY:C911(BRGList_SortFld_ap; ->[Bridge MHD NBIS:1]RRBranch:210)
			
			GEN_SORTLISTCMD_txt:="mbta_SortRecords"
			mbta_SortRecords
		Else 
			GEN_SORTLISTCMD_txt:="BRGList_SortControl("+<>sQU+"APPLYSORT"+<>sQU+")"
		End if 
		
	: ($1="APPLYSORT")
		SET CURSOR:C469(4)
		C_LONGINT:C283($i)
		For ($i; 1; Size of array:C274(BRGList_SortFld_ap))
			Case of 
				: (BRGList_SortPtr_ap{$i}->=1)
					ORDER BY:C49([Bridge MHD NBIS:1]; BRGList_SortFld_ap{$i}->; >)
				: (BRGList_SortPtr_ap{$i}->=2)
					ORDER BY:C49([Bridge MHD NBIS:1]; BRGList_SortFld_ap{$i}->; <)
			End case 
		End for 
		SET CURSOR:C469(0)
		REDRAW WINDOW:C456
		
	: ($1="SETBUTTON")
		C_POINTER:C301($2; $Btn_ptr)
		$Btn_ptr:=$2
		For ($i; 1; Size of array:C274(BRGList_SortPtr_ap))
			If (BRGList_SortPtr_ap{$i}#$Btn_ptr)
				BRGList_SortPtr_ap{$i}->:=0
			End if 
		End for 
		If (($Btn_ptr->=0) | ($Btn_ptr->=2))
			$Btn_ptr->:=1
		Else 
			$Btn_ptr->:=2
		End if 
		
End case 