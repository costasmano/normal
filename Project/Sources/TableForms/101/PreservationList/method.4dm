//Method: Form Method: [Contract_Assignment_Maintenance]PreservationList
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/28/12, 14:42:53
	// ----------------------------------------------------
	//Created : 
	Mods_2013_10
	// Modified by: Costas Manousakis-(Designer)-(10/22/13 15:44:17)
	Mods_2013_10
	//  `for PreservationEdit group
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/17/17 13:40:53)
	
End if 

C_LONGINT:C283($WL_L; $WT_L; $WR_L; $WB_L; $OL_L; $OT_L; $OR_L; $OB_L)

Case of 
	: (Form event code:C388=On Load:K2:1)
		InDoubleClick_B:=False:C215
		
		If (Not:C34(Is compiled mode:C492))
			OBJECT SET VISIBLE:C603(*; "ForDesigner@"; True:C214)
		Else 
			If (Current user:C182="Designer") | (Current user:C182="Administrator")
				OBJECT SET VISIBLE:C603(*; "ForDesigner@"; True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*; "ForDesigner@"; False:C215)
				OBJECT GET COORDINATES:C663(*; "ForDesigner@"; $OL_L; $OT_L; $OR_L; $OB_L)
				OBJECT GET COORDINATES:C663(*; "SelectListBox"; $WL_L; $WT_L; $WR_L; $WB_L)
				C_LONGINT:C283($lbResize_L)
				$lbResize_L:=$OB_L-$WB_L
				OBJECT MOVE:C664(*; "SelectListBox"; 0; 0; 0; $lbResize_L)
			End if 
		End if 
		SET MENU BAR:C67("LB_Custom")
		
		If ((GRP_UserInGroup("PreservationEdit")=1) | User in group:C338(<>CurrentUser_Name; "Design Access Group"))
			OBJECT SET ENABLED:C1123(*; "bAddAssignment"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		Else 
			OBJECT SET ENABLED:C1123(*; "bAddAssignment"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
		
	: (Form event code:C388=On Resize:K2:27)
		
		C_BOOLEAN:C305($DisplayHorizontalScrollBar_b)
		$DisplayHorizontalScrollBar_b:=True:C214
		OBJECT SET SCROLLBAR:C843(*; "SelectListBox"; $DisplayHorizontalScrollBar_b; True:C214)
		If (False:C215)
			GET WINDOW RECT:C443($WL_L; $WT_L; $WR_L; $WB_L)
			ut_Send2Clipboard(ut_ReturnTimeStampFromDate(Current date:C33(*); Current time:C178(*))+Char:C90(13))
			ut_Send2Clipboard("W : "+String:C10($WL_L)+" ; "+String:C10($WT_L)+" ; "+String:C10($WR_L)+" ; "+String:C10($WB_L)+Char:C90(13))
			
			OBJECT GET COORDINATES:C663(*; "SelectListBox"; $OL_L; $OT_L; $OR_L; $OB_L)
			ut_Send2Clipboard("LB : "+String:C10($OL_L)+" ; "+String:C10($OT_L)+" ; "+String:C10($OR_L)+" ; "+String:C10($OB_L)+Char:C90(13))
			
			OBJECT GET COORDINATES:C663(*; "ForDesigner@"; $OL_L; $OT_L; $OR_L; $OB_L)
			ut_Send2Clipboard("ForDes : "+String:C10($OL_L)+" ; "+String:C10($OT_L)+" ; "+String:C10($OR_L)+" ; "+String:C10($OB_L)+Char:C90(13))
			
		End if 
		
		FILTER EVENT:C321
End case 
//End Form Method: [Contract_Assignment_Maintenance]PreservationList