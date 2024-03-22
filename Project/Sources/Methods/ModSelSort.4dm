//%attributes = {"invisible":true}
//GP: ModSelSort($ptrFile;$InputLayout;$OutputLO;$WinTitle;
//                               $LWidth;$LHeight;$LPosition;$LWindowType;
//                               $ptrSortFld;$SortOrd;$ptrSetFldV)
//Procedure that sets up the main window for a database
//in addition it creates the region set for the user
//$ptrFile = $1 Table to look at
//$InputLayout = $2 Default input form
//$OutputLO = $3 Default output form
//$WinTitle = $4 Title of user screen
//$LWidth=$5 Width of window
//$LHeight=$6 Height of window
//$LPosition=$7 Position of window
//$LWindowType=$8 Window type
//These are optional
//$ptrSortFld = $9 Sort field
//$SortOrd = $10 Direction of sort
//$ptrSetFld = $11 Field for creating a set
//ptrSetFldV = $12 Field value for set
If (False:C215)
	//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
	
	// Modified by: ManousakisC (2/14/2006)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(4/16/08 09:29:10)
	Mods_2008_CM_5403  //Added additional search params (13,14) cleaned up var declarations.
	// Modified by: costasmanousakis-(Designer)-(11/30/09 12:31:20)
	Mods_2009_11
	//added 3rd pair of search variables
	Mods_2013_02  //r001 ` Make [BridgeInfoLink] read only as it is only read write when creating a new bridge record or running special update code
	//Modified by: Charles Miller (2/26/13 16:38:34)
	Mods_2019_07  //Create new list box NewNBIS_StackInfoform to test as width and height changed
	//Modified by: Chuck Miller (7/18/19 12:51:34)
	Mods_2019_09  //Create method to handle resize of windows between out and input forms
	//Modified by: Chuck Miller (9/26/19 14:51:05)
	// Modified by: Costas Manousakis-(Designer)-(3/31/20 15:37:08)
	Mods_2020_03
	//  `combined the NewNBIS_StackInfo and NewMBTANBIS_StackInfo cases
	Mods_2020_06  //New list bpx form for personnel, Inspectors Out_LB
	//Modified by: Chuck (6/25/20 13:19:22)
	// Modified by: Costas Manousakis-(Designer)-(2022-12-28 15:52:52)
	Mods_2022_12_bug
	//  `use Dialog if output form ends in _LB
End if 
Compiler_Utilities

C_POINTER:C301($ptrFile; $ptrSortFld; $ptrSetFld; $ptrSetFldV)
C_TEXT:C284($InputLayout; $OutputLO; $WinTitle; $RecSel)  // old C_STRING length 255
C_TEXT:C284($SortOrd)  // old C_STRING length 1
C_LONGINT:C283(vOutputMenuBar_L)

C_LONGINT:C283($ParNum)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
C_LONGINT:C283($LWidth; $LHeight; $LPosition; $LWindowType)
C_TEXT:C284(INSP_INSPTYPESBYRESPTREE_txt)
INSP_INSPTYPESBYRESPTREE_txt:=""
$ParNum:=Count parameters:C259

If ($ParNum>=8)  //Don't allow less than 8 parameters
	C_TEXT:C284($TypeList_txt)
	$TypeList_txt:=INSP_InspTypesUtil("LOADTYPES")
	C_POINTER:C301($1)
	C_TEXT:C284($2; $3; $4)  // Command Replaced was C_STRING length was 255
	C_LONGINT:C283($5; $6; $7; $8)
	$ptrFile:=$1
	$InputLayout:=$2
	$OutputLO:=$3
	$WinTitle:=$4
	$LWidth:=$5
	$LHeight:=$6
	$LPosition:=$7
	$LWindowType:=$8
	SHORT_MESSAGE("Retrieving data. Please wait…")
	If ($ParNum>=12)
		C_POINTER:C301($11; $12)
		$ptrSetFld:=$11
		$ptrSetFldV:=$12
		QUERY:C277($ptrFile->; $ptrSetFld->=$ptrSetFldv->; *)
		If ($ParNum>=14)
			C_POINTER:C301($13; $14)
			$ptrSetFld:=$13
			$ptrSetFldV:=$14
			QUERY:C277($ptrFile->;  | ; $ptrSetFld->=$ptrSetFldv->; *)
		End if 
		If ($ParNum>=16)
			C_POINTER:C301($15; $16)
			$ptrSetFld:=$15
			$ptrSetFldV:=$16
			QUERY:C277($ptrFile->;  | ; $ptrSetFld->=$ptrSetFldv->; *)
		End if 
		
		QUERY:C277($ptrFile->)
	Else 
		ALL RECORDS:C47($ptrFile->)
	End if 
	If ($ParNum>=10)
		C_POINTER:C301($9)
		C_TEXT:C284($10)  // Command Replaced was o_C_STRING length was 1
		$ptrSortFld:=$9
		$SortOrd:=$10
		
		If ($SortOrd="<")
			ORDER BY:C49($ptrFile->; $ptrSortFld->; <)
		Else 
			ORDER BY:C49($ptrFile->; $ptrSortFld->; >)
		End if 
	End if 
	
	CLOSE WINDOW:C154
	FORM SET INPUT:C55($ptrFile->; $InputLayout)
	FORM SET OUTPUT:C54($ptrFile->; $OutputLO)
	$RecSel:=String:C10(Records in selection:C76($ptrFile->))
	If (vOutputMenuBar_L>0)
		ControlMenuBar(vOutputMenuBar_L)
	Else 
		ControlMenuBar(2)
	End if 
	
	If (Table name:C256($ptrFile)="Bridge MHD NBIS")
		READ ONLY:C145([BridgeInfoLink:149])
		COPY NAMED SELECTION:C331($ptrFile->; "UserRegionA")
	End if 
	C_LONGINT:C283($win_l)
	$win_l:=ut_OpenNewWindow($LWidth; $LHeight; $LPosition; $LWindowType; $WinTitle+" ["+$RecSel+"]"; "ut_CloseCancel")
	//NewWindow ($LWidth;$LHeight;$LPosition;$LWindowType)  //Window for this process
	UpdatWindArray(""; Current process:C322)
	//SET WINDOW TITLE($WinTitle+" ["+$RecSel+"]")
	//Start change Oct-2001-->
	//If (Current user="Designer")
	C_BOOLEAN:C305($useListBox_B)
	$useListBox_B:=($OutputLO="PG_Output_LB") | \
		($OutputLO="NewNBIS_StackInfo") | \
		($OutputLO="NewMBTANBIS_StackInfo") | \
		($OutputLO="@_LB")
	Case of 
		: ($useListBox_B)
			C_LONGINT:C283($FW; $FL; $Wl; $Wt; $WR; $WB)
			GET WINDOW RECT:C443($Wl; $Wt; $WR; $WB)
			FORM GET PROPERTIES:C674($ptrFile->; $OutputLO; $FW; $FL)
			SET WINDOW RECT:C444($Wl; $Wt; ($Wl+$FW); $WB)
			DIALOG:C40($ptrFile->; $OutputLO)
			
		Else 
			//Else 
			If (User in group:C338(Current user:C182; "ReadWrite"))
				MODIFY SELECTION:C204($ptrFile->; *)
			Else 
				DISPLAY SELECTION:C59($ptrFile->; *)
			End if 
	End case 
	//--> end change Oct-2001  
	UpdatWindArray(""; Current process:C322)
	If (Table name:C256($ptrFile)="Bridge MHD NBIS")
		CLEAR NAMED SELECTION:C333("UserRegionA")
	End if 
	CLOSE WINDOW:C154
	ControlMenuBar(1)
End if 