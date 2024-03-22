// ----------------------------------------------------
// Form Method: "SaveLists"
// User name (OS): charlesmiller
// Date and time: 05/23/11, 13:14:22
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_05  //r002 CJ Miller`05/23/11, 13:14:23      `Fix bugs found during testing of initial release of v11
	// Modified by: Costas Manousakis-(Designer)-(10/30/13 11:42:19)
	Mods_2013_10
	//  `made objects resizable when window grows vertically;
	//  `added buttons to add all and remove all
	//  `adjusted code in the add and remove selected buttons
	// Modified by: Costas Manousakis-(Designer)-(10/10/17 11:15:35)
	Mods_2017_10
	//  `use LIST OF CHOICE LISTS to get lists
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(ProcessLists_atxt; 0)
		ARRAY LONGINT:C221(ProcessListIDS_al; 0)
		ARRAY LONGINT:C221(AvailableListIds_al; 0)
		//QUERY([TableOfLists];[TableOfLists]ListName_s="4DLists")
		ARRAY TEXT:C222(AvailableLists_atxt; 0)
		//ARRAY TEXT(AvailableLists_atxt;Records in selection([TableOfLists]))
		//SELECTION RANGE TO ARRAY(1;Records in selection([TableOfLists]);[TableOfLists]ListValue_s;AvailableLists_atxt)
		ARRAY LONGINT:C221($listNums_aL; 0)
		LIST OF CHOICE LISTS:C957($listNums_aL; AvailableLists_atxt)
		ARRAY LONGINT:C221(AvailableListIds_al; Size of array:C274(AvailableLists_atxt))
		
		Check Box1:=0
		
	: (Form event code:C388=On Unload:K2:2)
		
		//clear all lists
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(AvailableListIds_al))
			If (Is a list:C621(AvailableListIds_al{$loop_L}))
				CLEAR LIST:C377(AvailableListIds_al{$loop_L}; *)
			End if 
		End for 
		For ($loop_L; 1; Size of array:C274(ProcessListIDS_al))
			If (Is a list:C621(ProcessListIDS_al{$loop_L}))
				CLEAR LIST:C377(ProcessListIDS_al{$loop_L}; *)
			End if 
		End for 
		
End case 
//End Form Method: SaveLists