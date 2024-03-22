//%attributes = {"invisible":true}
//Method: ut_ShowText
//  `Launch a separate window to display a text.
// Parameters
// $0 : ProcessID_L : process Id created
// $1 : vtExtraText : text to be displayed
// $2 : vsExtraTextLabel : Label of text (optional)
// $3 : $TextDispWinTitle : title of the window (optional)
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/16/12, 09:28:27
	// ----------------------------------------------------
	//Created : 
	Mods_2012_03
End if 
//
//
C_LONGINT:C283($0)
C_LONGINT:C283($procID_L)
C_TEXT:C284($1)
C_TEXT:C284(vtExtraText; $TextDispWinTitle)
C_TEXT:C284(vsExtraTextLabel)  // Command Replaced was o_C_STRING length was 132
C_TEXT:C284($opt_txt)
vsExtraTextLabel:="Display Text"
$TextDispWinTitle:="Display Text Window"
vtExtraText:=$1
$opt_txt:=""
$procID_L:=0
If (Count parameters:C259>1)
	C_TEXT:C284($2)
	vsExtraTextLabel:=$2
End if 
If (Count parameters:C259>2)
	C_TEXT:C284($3)
	$TextDispWinTitle:=$3
End if 
If (Count parameters:C259>3)
	C_TEXT:C284($4)
	$opt_txt:=$4
End if 

Case of 
	: ($opt_txt="")  //without a run option start a new process
		
		$procID_L:=New process:C317(Current method name:C684; 0; Current method name:C684; vtExtraText; vsExtraTextLabel; $TextDispWinTitle; "RUN"; *)
		vtExtraText:=""
		vsExtraTextLabel:=""
	: ($opt_txt="RUN")
		C_LONGINT:C283($Width_l; $Height_l; $Pages_l)
		C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
		C_TEXT:C284($Title_txt)
		FORM GET PROPERTIES:C674([Dialogs:21]; "GetInspExtraCmts"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
		C_LONGINT:C283($winType_L)
		$winType_L:=Plain window:K34:13
		SET MENU BAR:C67("BlankMenu")  // to allow Edit actions
		CENTER_WINDOW($Width_l; $Height_l; Plain window:K34:13; $TextDispWinTitle)
		DIALOG:C40([Dialogs:21]; "GetInspExtraCmts")
		CLOSE WINDOW:C154
		
		vtExtraText:=""
		vsExtraTextLabel:=""
		
End case 
$0:=$procID_L

//End ut_ShowText