//%attributes = {"invisible":true}
//GP: GModSelection($ptrFile;$InputLayout;$OutputLO;$WinTitle;
//                               $LWidth;$LHeight;$LPosition;$LWindowType;
//                               $ptrSortFld;$SortOrd;$ptrSetFldV)
//Copyright © 1995-1998,  Albert S. Leung, All Rights Reserved.
//Procedure that sets up the main window for a database
//modified 4-dec-2000 : CM
//    added parameters 10 and 11 to sort selection by a specified table field

//$ptrFile = $1 File to look at
//$InputLayout = $2 Default input file
//$OutputLO = $3 Default output file
//$WinTitle = $4 Title of user screen
//$LWidth=$5 Width of window
//$LHeight=$6 Height of window
//$LPosition=$7 Position of window
//$LWindowType=$8 Window type
//$MenuBar=$9 Menu Bar for this selection
//...Optional
//$ptrSortFld=$10 Field to sort selection by : pointer
//$SortOrd=$11 Direction of sort > or < : string

C_POINTER:C301($ptrFile)
C_TEXT:C284($InputLayout)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284($OutputLO)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284($WinTitle)  // Command Replaced was o_C_STRING length was 255
C_POINTER:C301($ptrSortFld)
C_TEXT:C284($SortOrd)  // Command Replaced was o_C_STRING length was 1

C_LONGINT:C283($ParNum)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($RecSel)  // Command Replaced was o_C_STRING length was 255

C_LONGINT:C283($LWidth; $LHeight; $LPosition; $LWindowType; $MenuBar)

$ParNum:=Count parameters:C259

If ($ParNum>=9)  //Don't allow less than 9 parameters
	$ptrFile:=$1
	$InputLayout:=$2
	$OutputLO:=$3
	$WinTitle:=$4
	$LWidth:=$5
	$LHeight:=$6
	$LPosition:=$7
	$LWindowType:=$8
	$MenuBar:=$9
	SHORT_MESSAGE("Retrieving data. Please wait…")
	ALL RECORDS:C47($ptrFile->)
	If ($ParNum>=11)
		$ptrSortFld:=$10
		$SortOrd:=$11
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
	//ControlMenuBar ($MenuBar)
	
	NewWindow($LWidth; $LHeight; $LPosition; $LWindowType)  //Window for this process
	UpdatWindArray(""; Current process:C322)
	SET WINDOW TITLE:C213($WinTitle+" ["+$RecSel+"]")
	ControlMenuBar($MenuBar)
	If ($OutputLO="@_LB")
		DIALOG:C40($ptrFile->; $OutputLO)
	Else 
		MODIFY SELECTION:C204($ptrFile->; *)
	End if 
	UpdatWindArray(""; Current process:C322)
	CLOSE WINDOW:C154
	ControlMenuBar(1)
End if 