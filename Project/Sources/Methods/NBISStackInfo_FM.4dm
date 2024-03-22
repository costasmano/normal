//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/14/13, 12:09:57
//----------------------------------------------------
//Method: NBISStackInfo_FM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_02  //r001 ` Created so that we can have two nbis stack info forms
	//NBIS Stack Info
	//NBIS Stack Info MBTA
	//Modified by: Charles Miller (2/14/13 12:09:58)
	Mods_2019_06  //Add new button to move scanned bin request form
	//Modified by: Chuck Miller (6/27/19 10:55:55)
	Mods_2019_07  //Create new list box NewNBIS_StackInfoform to test as width and height changed
	//Modified by: Chuck Miller (7/18/19 12:51:34)
End if 
C_LONGINT:C283($vlWL; $vlWT; $vlWR; $vlWB; vlNBIStckWinW; vlNBIStckWinH; $fw; $fH)
C_LONGINT:C283(vNBIOPENDETAIL_L)


Case of 
		
		//: (Form event=On Clicked)
		//OBJECT SET ENABLED(*;"BinRequest";Records in set("UserSet")=1)
	: (Form event code:C388=On Load:K2:1)
		
		READ ONLY:C145([Element Cat:32])
		READ ONLY:C145([ElementDict:30])
		READ ONLY:C145([Inspection Type:31])
		
		If (User in group:C338(Current user:C182; "New Bridge Access"))
			OBJECT SET ENABLED:C1123(bzAdd; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET VISIBLE:C603(*; "BinRequest"; True:C214)
			OBJECT SET ENABLED:C1123(*; "BinRequest"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "BinRequest"; False:C215)
			OBJECT SET ENABLED:C1123(bzAdd; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		OBJECT SET ENABLED:C1123(*; "DeleteNBIRec"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		BRGList_SortControl("INIT")
		vNBIOPENDETAIL_L:=0
	: (Form event code:C388=On Display Detail:K2:22)
		
	: (Form event code:C388=On Open Detail:K2:23)
		vNBIOPENDETAIL_L:=1
		
	: (Form event code:C388=On Close Detail:K2:24)
		vNBIOPENDETAIL_L:=0
		SET WINDOW RECT:C444($vlWL; $vlWT; $vlWR; $vlWB)
		//GET WINDOW RECT($vlWL;$vlWT;$vlWR;$vlWB)
		//SET WINDOW RECT($vlWL;$vlWT;$vlWL+vlNBIStckWinW;$vlWT+vlNBIStckWinH)
		vlNBIStckWinW:=0  //Set this so that the On Open does not re-size when using rec navigati
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
		OBJECT SET ENABLED:C1123(*; "BinRequest"; False:C215)
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
	: (Form event code:C388=On Resize:K2:27)
		//REDRAW WINDOW
		C_POINTER:C301($LB_ptr)
		$LB_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "NBISStack_LB")
		REDRAW:C174($LB_ptr->)
		
		//REDRAW(◊asWindows)
End case 
//End NBISStackInfo_FM

