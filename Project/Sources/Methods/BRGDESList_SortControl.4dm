//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/01/08, 08:12:25
	// ----------------------------------------------------
	// Method: BRGDESList_SortControl
	// Description
	// Control sorting in the Bridge Design List screens
	// 
	// Parameters
	// $1 : text : Action (INIT | APPLYSORT | SETBUTTON)
	// $2 : $Btn_ptr : Pointer to button variable (Optional used only for SETBUTTON action
	// ----------------------------------------------------
	
	Mods_2008_CM_5403
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2013_03  //r001 ` Make sure to not reset value of GEN_SORTLISTCMD_txt when = "mbta_SortRecords"
	//Modified by: Charles Miller (3/7/13 13:42:48)
End if 
C_TEXT:C284($1)
Case of 
	: ($1="INIT")
		C_LONGINT:C283(vSortPROJIS; vSortContract; vSortCity; vSortItem8; vSortPrjType; vSortADVDate; vSortDesigner)
		
		vSortPROJIS:=0
		vSortContract:=0
		vSortCity:=0
		vSortItem8:=1
		vSortPrjType:=0
		vSortADVDate:=0
		vSortDesigner:=0
		ARRAY POINTER:C280(BRGDESList_SortPtr_ap; 7)
		ARRAY POINTER:C280(BRGDESList_SortFld_ap; 7)
		BRGDESList_SortPtr_ap{1}:=->vSortPROJIS
		BRGDESList_SortPtr_ap{2}:=->vSortContract
		BRGDESList_SortPtr_ap{3}:=->vSortCity
		BRGDESList_SortPtr_ap{4}:=->vSortPrjType
		BRGDESList_SortPtr_ap{5}:=->vSortADVDate
		BRGDESList_SortPtr_ap{6}:=->vSortDesigner
		BRGDESList_SortPtr_ap{7}:=->vSortItem8
		ARRAY POINTER:C280(BRGDESList_SortFld_ap; 7)
		BRGDESList_SortFld_ap{1}:=->[Bridge Design:75]PROJIS:2
		BRGDESList_SortFld_ap{2}:=->[Bridge Design:75]ContractNumber:33
		BRGDESList_SortFld_ap{3}:=->[Bridge MHD NBIS:1]Town Name:175
		BRGDESList_SortFld_ap{4}:=->[Bridge Design:75]ProjectType:7
		BRGDESList_SortFld_ap{5}:=->[Bridge Design:75]ADVDate:4
		BRGDESList_SortFld_ap{6}:=->[Bridge Design:75]Designer:5
		BRGDESList_SortFld_ap{7}:=->[Bridge MHD NBIS:1]Item8:206
		
		C_TEXT:C284(GEN_SORTLISTCMD_txt)
		If (GEN_SORTLISTCMD_txt="mbta_SortRecords")
		Else 
			GEN_SORTLISTCMD_txt:="BRGDESList_SortControl("+<>sQU+"APPLYSORT"+<>sQU+")"
		End if 
	: ($1="APPLYSORT")
		SET CURSOR:C469(4)
		C_LONGINT:C283($i)
		For ($i; 1; Size of array:C274(BRGDESList_SortFld_ap))
			Case of 
				: (BRGDESList_SortPtr_ap{$i}->=1)
					ORDER BY:C49([Bridge Design:75]; BRGDESList_SortFld_ap{$i}->; >)
				: (BRGDESList_SortPtr_ap{$i}->=2)
					ORDER BY:C49([Bridge Design:75]; BRGDESList_SortFld_ap{$i}->; <)
			End case 
		End for 
		SET CURSOR:C469(0)
		REDRAW WINDOW:C456
		
	: ($1="SETBUTTON")
		C_POINTER:C301($2; $Btn_ptr)
		$Btn_ptr:=$2
		For ($i; 1; Size of array:C274(BRGDESList_SortPtr_ap))
			If (BRGDESList_SortPtr_ap{$i}#$Btn_ptr)
				BRGDESList_SortPtr_ap{$i}->:=0
			End if 
		End for 
		If (($Btn_ptr->=0) | ($Btn_ptr->=2))
			$Btn_ptr->:=1
		Else 
			$Btn_ptr->:=2
		End if 
		
End case 