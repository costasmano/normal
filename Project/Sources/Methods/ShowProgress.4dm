//%attributes = {"invisible":true}
If (False:C215)
	// Procedure: ShowProgress
	// $1	Longint	4D Open code representing function result.
	//
	// called by StartProgress, receives window title and
	// desired page/termination method from encrypted
	// process name [ see TN #31 ]. Opens window and selects
	// appropriate page of layout.
	
	// Preconditions : None
	
	// Assumptions : None
	//
	// Created 4/30/94 —Forrest Swilling
	//Modified 12-dec-2000 - CM
	// Modified by: Costas Manousakis-(Designer)-(3/16/16 17:07:41)
	Mods_2016_03_bug
	//  `moved the setting of ◊Ready  from here to the end of the onload event of the dialog[ Dialogs];"Progress")
End if 

C_TEXT:C284($Name; $Title; $Termination)  // Command Replaced was o_C_STRING length was 32
C_LONGINT:C283($State; $Time)
C_LONGINT:C283($Divider; $sw; $sh)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($progrWind; $windowPos)
PROCESS PROPERTIES:C336(Current process:C322; $Name; $State; $Time)
$Divider:=Position:C15(";"; $Name)
$Title:=Substring:C12($Name; 2; $Divider-2)
$Termination:=Substring:C12($Name; $Divider+1)
$windowPos:=6  //param for NewWindow method : 1/3 from top and centered
<>Progress:=0
<>Remaining:=0
<>Page:=Position:C15($Termination[[1]]; "BKN")+1  // target 2nd, 3rd or 4th page of dialog
<>Abort:=False:C215
$sw:=Screen width:C187/2
$sh:=Screen height:C188/2
//◊Ready:=True  `tell StartProgress we are ready
C_LONGINT:C283(<>vtProgressSt_ms)
C_TEXT:C284(<>TimeRemaining)  // Command Replaced was o_C_STRING length was 120
<>vtProgressSt_ms:=Milliseconds:C459
NewWindow(290; 90; $windowPos; 4; $Title)  //use NewWindow method to place window

// made window with border and title-CM
//$progrWind:=Open window($sw-145;$sh-45;$sw+145;$sh+45;4;$Title;"")
DIALOG:C40([Dialogs:21]; "Progress")
//CLOSE WINDOW($progrWind)
CLOSE WINDOW:C154
If ((<>Page=3) | (<>Page=4))
	ON EVENT CALL:C190("")
End if 