//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/15/15, 14:48:07
//----------------------------------------------------
//Method: LSS_InitChangeStacks
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/15/15 14:48:09)
	
End if 
ARRAY POINTER:C280(ptr_Changes; 0; 0)
InitChangeStack(1)  //[LSS_Inspection]
InitChangeStack(2)  //[LSS_Accessibility]
InitChangeStack(3)  //[LSS_ElementInspection]
InitChangeStack(4)  //[LSS_DMeter]
InitChangeStack(5)  //[LSS_Photos]
InitChangeStack(6)  //[LSS_SignPanel]
InitChangeStack(7)  //[LSS_TeamMembers]
InitChangeStack(8)  //[LSS_TowerDistance]
InitChangeStack(9)  //[LSS_UT]
InitChangeStack(10)  //[LSS_UtResult]
InitChangeStack(11)  //[LSS_VerticalClearance]
InitChangeStack(12)  //[LSS_Inventory]
//End LSS_InitChangeStacks

