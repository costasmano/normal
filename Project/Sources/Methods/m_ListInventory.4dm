//%attributes = {"invisible":true}
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(2/15/15 19:03:19)
	Mods_2015_02
	//  `added code to fill the  LSS_town arrays - copy from global arrays
	Mods_2015_07_bug  // Add SHORT_MESSAGE ("Retrieving data. Please wait…")
	//Modified by: administrator (7/7/15 13:08:25)
	Mods_2015_08_bug  //Change the way display of structure type occurs
	//Modified by: administrator (9/1/15 14:40:24)
	// Modified by: Costas Manousakis-(Designer)-(11/4/15 11:46:29)
	Mods_2015_11_bug
	//  `should not initialize ◊NextNumberArray_al ; done in "on Startup"
	Mods_2019_06  //Add code to make sure windows open and take into account 13" mac books
	//Modified by: Chuck Miller (6/4/19 13:52:21)
End if 


If (Count parameters:C259=0)
	C_LONGINT:C283($LPid_L)
	$LPid_L:=LSpawnProcess(Current method name:C684; <>LStackSize; "Ancillary"; True:C214; False:C215; "RUN")
Else 
	C_TEXT:C284($1)
	C_TEXT:C284(vsForward)  // Command Replaced was o_C_STRING length was 80
	vsForward:=<>Forward
	READ ONLY:C145(*)
	SHORT_MESSAGE("Retrieving data. Please wait…")
	
	LSS_SetUp
	
	C_LONGINT:C283($scrWidth_l; $scrHeight_l)
	
	//LSS_SetKeyMask  
	$scrWidth_l:=Screen width:C187
	$scrHeight_l:=Screen height:C188
	ALL RECORDS:C47([LSS_Inventory:165])
	C_LONGINT:C283($Width_L; $Height_L)
	SET MENU BAR:C67("Blankmenu")
	UpdatWindArray(""; Current process:C322)
	
	ORDER BY:C49([LSS_Inventory:165]; [LSS_Inventory:165]LSS_Category_s:2; >; [LSS_Inventory:165]LSS_StructureNumber_s:6; >)
	COPY NAMED SELECTION:C331([LSS_Inventory:165]; "InventorySet")
	CLOSE WINDOW:C154
	
	FORM GET PROPERTIES:C674([LSS_Inventory:165]; "ListBoxOutput"; $Width_L; $Height_L)
	
	$Height_L:=800
	
	If ($scrHeight_l-20<$Height_L)
		$Height_L:=$scrHeight_l-120
	End if 
	If ($scrWidth_l<$Width_L)
		$Width_L:=$scrWidth_l-40
	End if 
	ut_OpenNewWindow($Width_L; $Height_L; 2; Plain window:K34:13)
	DIALOG:C40([LSS_Inventory:165]; "ListBoxOutput")
	CLEAR NAMED SELECTION:C333("InventorySet")
	
	UpdatWindArray(""; Current process:C322)
End if 