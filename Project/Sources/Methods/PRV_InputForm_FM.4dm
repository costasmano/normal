//%attributes = {"invisible":true}
// Method: PRV_InputForm_FM
// Description
// 
// 
// Parameters
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 06/04/12, 10:41:36
	// ----------------------------------------------------
	// First Release
	Mods_2012_06
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Close Detail:K2:24)
		
	: ($FormEvent_L=On Load:K2:1)
		InDoubleClick_B:=False:C215
		PRV_Variables("INIT")
		PRV_Variables("LOAD")
		PRV_CTRLSelections("LOADALL")
		PRV_CTRLListBoxes("SETUPALL")
		PRV_FillPersonnelDropDowns(->PRV_PreservReviewer_ai; ->PRV_PreservReviewer_atxt; "PreservationReviewers")
		APPEND TO ARRAY:C911(PRV_PreservReviewer_atxt; "")
		APPEND TO ARRAY:C911(PRV_PreservReviewer_ai; 0)
		If (Find in array:C230(PRV_PreservReviewer_ai; [Contract_Assignment_Maintenance:101]ProjectManagerID_L:39)>0)
			PRV_PreservReviewer_txt:=PRV_PreservReviewer_atxt{Find in array:C230(PRV_PreservReviewer_ai; [Contract_Assignment_Maintenance:101]ProjectManagerID_L:39)}
		Else 
			PRV_PreservReviewer_txt:=""
		End if 
		
		If (PRV_LockedAssignment_b)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENTERABLE:C238(*; "DE@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "PRV_AssignbValidate"; False:C215)
			OBJECT SET VISIBLE:C603(*; "PRV_DELASSIGN_BTN"; False:C215)
			OBJECT SET VISIBLE:C603(*; "DE Add@"; False:C215)
		End if 
		
		C_LONGINT:C283($WLEFT_L; $WTop_l; $WRight_l; $WBottom_l; $Horizontal_l)
		C_LONGINT:C283($OLEFT_L; $OTop_l; $ORight_l; $OBottom_l)
		GET WINDOW RECT:C443($WLEFT_L; $WTop_l; $WRight_l; $WBottom_l)
		OBJECT GET COORDINATES:C663(*; "PRV_AssgnTabControl_atxt@"; $OLEFT_L; $OTop_l; $ORight_l; $OBottom_l)
		
		$Horizontal_l:=($WRight_l-$WLEFT_L)-($ORight_l-$OLEFT_L)
		//TRACE
		//MOVE OBJECT(*;"PRV_AssgnTabControl_atxt@";0;0;$Horizontal_l;0)
		PRV_FORM_LOADED_b:=True:C214
		
	: ($FormEvent_L=On Validate:K2:3)
		
	: ($FormEvent_L=On Unload:K2:2)
		PRV_CTRLSelections("CLEARALL")
		READ WRITE:C146([Contract_Assignment_Maintenance:101])
End case 
//End PRV_InputForm_FM