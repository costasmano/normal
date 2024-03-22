//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): vunguyen
	// User name (4D): designer
	// Date and time: 05/26/05, 15:00:00
	// ----------------------------------------------------
	// Method: CM_GetItemsOfSubList
	// Description:
	// Fill in the array with all the items of a Work Type
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(3/25/11 16:33:33)
	Mods_2011_03
	//Get a Count of the list items
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 

C_LONGINT:C283(vCM_HList; $vLSubList)
C_LONGINT:C283($vNumOfItems; $vItemPos; $vRefNum)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($vItemText)  // Command Replaced was o_C_STRING length was 50
ARRAY TEXT:C222(asItemsOfSubList; 0)  //Command Replaced was o_ARRAY string length was 50

vCM_HList:=Load list:C383("Maintenance Work Types")
$vNumOfItems:=0  //number of items in the sublist 
$vItemPos:=0  //position of the parent item in vCM_HList
$vRefNum:=0  //reference ID of the parent item in vCM_HList
$vItemText:=""

If (vCM_HList>0)  //make sure this list is existed
	//hard coding item position, number of items, and item ref in the list
	Case of 
			//Bridge Betterment 
		: ([Contract_Assignment_Maintenance:101]ProjectType:36="Bridge Betterment")
			$vItemPos:=2
			$vNumOfItems:=3
			$vRefNum:=200
			
			//Bridge Maintenance
		: ([Contract_Assignment_Maintenance:101]ProjectType:36="Bridge Maintenance")
			$vItemPos:=3
			$vNumOfItems:=7
			$vRefNum:=300
			
			//Bridge Preservation
		: ([Contract_Assignment_Maintenance:101]ProjectType:36="Bridge Preservation")
			$vItemPos:=4
			$vNumOfItems:=4
			$vRefNum:=400
			
			//Bridge Rehabilitation
		: ([Contract_Assignment_Maintenance:101]ProjectType:36="Bridge Rehabilitation")
			$vItemPos:=5
			$vNumOfItems:=0
			$vRefNum:=500
			
			//Bridge Replacement
		: ([Contract_Assignment_Maintenance:101]ProjectType:36="Bridge Replacement")
			$vItemPos:=6
			$vNumOfItems:=0
			$vRefNum:=600
			
			//Weighted Restricted
		: ([Contract_Assignment_Maintenance:101]ProjectType:36="Weight Restricted")
			$vItemPos:=7
			$vNumOfItems:=2
			$vRefNum:=700
			
	End case 
	
	//get the sublist of each Project Type category 
	GET LIST ITEM:C378(vCM_HList; $vItemPos; $vRefNum; $vItemText; $vLSubList)
	C_LONGINT:C283($i; $vRef)
	If (Is a list:C621($vLSubList))
		$vNumOfItems:=Count list items:C380($vLSubList; *)
		For ($i; 1; $vNumOfItems)
			$vRef:=$vRefNum+$i
			GET LIST ITEM:C378($vLSubList; $i; $vRef; $vItemText)
			INSERT IN ARRAY:C227(asItemsOfSubList; $i)
			asItemsOfSubList{$i}:=$vItemText
		End for 
	End if 
	
	CLEAR LIST:C377(vCM_HList; *)
End if 