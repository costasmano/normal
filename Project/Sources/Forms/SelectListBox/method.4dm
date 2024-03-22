
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 12/27/11, 15:20:44
//----------------------------------------------------
//Method: Form Method: SelectListBox
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_12  //r003
	//Modified by: Charles Miller (12/27/11 15:20:45)
	Mods_2013_01  //r001 ` Added if shift down to display designer stuff
	//Modified by: Charles Miller (1/15/13 16:15:44)
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		If (Not:C34(Is compiled mode:C492)) & (Shift down:C543)
			OBJECT SET VISIBLE:C603(*; "ForDesigner@"; True:C214)
		Else 
			If ((Current user:C182="Designer") | (Current user:C182="Administrator")) & (Shift down:C543)
				
				OBJECT SET VISIBLE:C603(*; "ForDesigner@"; True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*; "ForDesigner@"; False:C215)
			End if 
		End if 
		SET MENU BAR:C67("LB_Custom")
		
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
		REDRAW:C174(SelectListBox)
		
End case 
//End Form Method: SelectListBox