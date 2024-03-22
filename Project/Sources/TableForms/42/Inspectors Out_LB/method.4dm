//Method: [Personnel].Inspectors Out_LB
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck
	//User (4D) : Designer
	//Date and time: 06/25/20, 13:09:04
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06
	Mods_2020_09  //Add search picker to personnel output list box
	//Modified by: CJ (9/17/20 13:44:01)
	// Modified by: Costas Manousakis-(Designer)-(2021-10-13T00:00:00 16:52:31)
	Mods_2021_10
	//  `added on resize event to redraw listbox
	//  `resized Employer and Active column
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		UNLOAD RECORD:C212(Current form table:C627->)
		If (User in group:C338(Current user:C182; "ReadOnly"))
			OBJECT SET VISIBLE:C603(bzAdd; False:C215)
		End if 
		OBJECT SET VISIBLE:C603(*; "Invisibles@"; False:C215)
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
	: (Form event code:C388=On Resize:K2:27)
		C_POINTER:C301($LB_ptr)
		$LB_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "InspectorsOut_LB")
		REDRAW:C174($LB_ptr->)
		
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
		//REDRAW(◊asWindows)
	: (Form event code:C388=On Selection Change:K2:29)
		ARRAY TEXT:C222($PersonnelSearchArray_atxt; 0)
		GET PROCESS VARIABLE:C371(-1; <>PersonnelSearchArray_atxt; $PersonnelSearchArray_atxt)
		If (Size of array:C274($PersonnelSearchArray_atxt)=0)
			Bridge_FileBridgeSearchArray
		End if 
		
End case 

//End [Personnel].Inspectors Out_LB