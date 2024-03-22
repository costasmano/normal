//%attributes = {"invisible":true}
//Method: LSS_CustomSearch
//Description
//
// Parameters
// $1 : $task_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/22/15, 13:50:43
	// ----------------------------------------------------
	//Created : 
	Mods_2015_05
	
	// Modified by: Costas Manousakis-(Designer)-(12/12/15 12:24:54)
	Mods_2015_12_bug
	//  `Set the window title after closing the Dialog
	// Modified by: Costas Manousakis-(Designer)-(5/13/16 16:18:44)
	Mods_2016_05_bug
	//  `account for Route Suffix 
	
	C_TEXT:C284(LSS_CustomSearch; $1)
End if 
//
C_TEXT:C284($task_txt)
$task_txt:="Start"
If (Count parameters:C259>0)
	$task_txt:=$1
End if 

Case of 
	: ($task_txt="Find")
		C_BOOLEAN:C305($dataThere_b)
		$dataThere_b:=False:C215
		CREATE EMPTY SET:C140([LSS_Inventory:165]; "LSS_FoundSet")
		SET QUERY DESTINATION:C396(Into set:K19:2; "LSS_FoundSet")
		If (LSS_SearchTwnCode_txt#"")
			QUERY:C277([LSS_Inventory:165];  & ; [LSS_Inventory:165]LSS_StructureNumber_s:6=(LSS_SearchTwnCode_txt+"@"); *)
			$dataThere_b:=True:C214
		End if 
		If (LSS_SearchStrClass_txt#"")
			QUERY:C277([LSS_Inventory:165];  & ; [LSS_Inventory:165]LSS_Category_s:2=LSS_SearchStrClass_txt; *)
			$dataThere_b:=True:C214
			
		End if 
		If (LSS_SearchRoutType_txt#"")
			QUERY:C277([LSS_Inventory:165];  & ; [LSS_Inventory:165]LSS_Route_s:9=(LSS_SearchRoutType_txt+"@"); *)
			$dataThere_b:=True:C214
		End if 
		If (LSS_SearchRouteNum_L>0)
			C_TEXT:C284($rtFormat_txt)
			
			If (LSS_RouteSuffix_L=0)
				$rtFormat_txt:="0000"
			Else 
				$rtFormat_txt:="000A"
			End if 
			
			QUERY:C277([LSS_Inventory:165];  & ; [LSS_Inventory:165]LSS_Route_s:9=("@"+String:C10(LSS_SearchRouteNum_L; $rtFormat_txt)+"@"); *)
			$dataThere_b:=True:C214
		End if 
		If (LSS_SearchRoutDir_txt#"")
			QUERY:C277([LSS_Inventory:165];  & ; [LSS_Inventory:165]LSS_Route_s:9=("@"+LSS_SearchRoutDir_txt); *)
			$dataThere_b:=True:C214
		End if 
		If (LSS_SearchStartMile_r>0)
			QUERY:C277([LSS_Inventory:165];  & ; [LSS_Inventory:165]LSS_MilePoint_r:8>=LSS_SearchStartMile_r; *)
			$dataThere_b:=True:C214
		End if 
		If (LSS_SearchEndMile_r>0)
			QUERY:C277([LSS_Inventory:165];  & ; [LSS_Inventory:165]LSS_MilePoint_r:8<=LSS_SearchEndMile_r; *)
			$dataThere_b:=True:C214
		End if 
		If (LSS_SearchDistr_aL>1)
			QUERY:C277([LSS_Inventory:165];  & ; [LSS_Inventory:165]LSS_District_L:3=LSS_SearchDistr_aL{LSS_SearchDistr_aL}; *)
			$dataThere_b:=True:C214
		End if 
		If (LSS_SearchSIN_L>0)
			QUERY:C277([LSS_Inventory:165];  & ; [LSS_Inventory:165]LSS_StructureNumber_s:6=("@"+String:C10(LSS_SearchSIN_L; "00000")); *)
			$dataThere_b:=True:C214
			
		End if 
		If ($dataThere_b)
			QUERY:C277([LSS_Inventory:165])
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			UNION:C120("LSS_CustomSearch"; "LSS_FoundSet"; "LSS_CustomSearch")
			CLEAR SET:C117("LSS_FoundSet")
		End if 
		If (Records in set:C195("LSS_CustomSearch")>0)
			OBJECT SET ENABLED:C1123(*; "LSS_DoneSearch"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			LSS_SearchNumFound_L:=Records in set:C195("LSS_CustomSearch")
		End if 
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
	: ($task_txt="DONE")
		If (Records in set:C195("LSS_CustomSearch")>0)
			USE SET:C118("LSS_CustomSearch")
			LSS_SortInventory
			COPY NAMED SELECTION:C331([LSS_Inventory:165]; "InventorySet")
		Else 
			ALERT:C41("No Records Found!!!")
		End if 
		CLEAR SET:C117("LSS_CustomSearch")
		
	: ($task_txt="Start")
		ARRAY TEXT:C222(LSS_RouteDirection_as; 7)  //Command Replaced was o_ARRAY string length was 2
		LSS_RouteDirection_as{1}:=""
		LSS_RouteDirection_as{2}:="N"
		LSS_RouteDirection_as{3}:="S"
		LSS_RouteDirection_as{4}:="E"
		LSS_RouteDirection_as{5}:="W"
		LSS_RouteDirection_as{6}:="NS"
		LSS_RouteDirection_as{7}:="EW"
		ARRAY TEXT:C222(LSS_RouteDesignation_atxt; 4)
		LSS_RouteDesignation_atxt{1}:=""
		LSS_RouteDesignation_atxt{2}:="Interstate"
		LSS_RouteDesignation_atxt{3}:="MA Highway"
		LSS_RouteDesignation_atxt{4}:="US Highway"
		
		ARRAY TEXT:C222(LSS_StructureClass_atxt; 5)
		LSS_StructureClass_atxt{1}:=""
		LSS_StructureClass_atxt{2}:="Highway Sign"
		LSS_StructureClass_atxt{3}:="Lighting"
		LSS_StructureClass_atxt{4}:="Signal"
		LSS_StructureClass_atxt{5}:="Intelligent Structure"
		ARRAY LONGINT:C221(LSS_SearchDistr_aL; 0)
		ARRAY LONGINT:C221(LSS_SearchDistr_aL; 7)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 2; Size of array:C274(LSS_SearchDistr_aL))
			LSS_SearchDistr_aL{$loop_L}:=$loop_L-1
		End for 
		C_LONGINT:C283(LSS_SearchRouteNum_L; LSS_SearchSIN_L; LSS_DoneSearch; LSS_SearchNumFound_L)
		C_REAL:C285(LSS_SearchStartMile_r; LSS_SearchEndMile_r)
		C_TEXT:C284(LSS_SearchTwnCode_txt; LSS_SearchStrClass_txt; LSS_SearchRoutType_txt; LSS_SearchRoutDir_txt)
		LSS_SearchNumFound_L:=0
		
		C_LONGINT:C283($win_L)
		CREATE EMPTY SET:C140([LSS_Inventory:165]; "LSS_CustomSearch")
		$win_L:=Open form window:C675([LSS_Inventory:165]; "CustomSearch")
		DIALOG:C40([LSS_Inventory:165]; "CustomSearch")
		CLOSE WINDOW:C154
		If (OK=1)
			WIN_SetWindowTitle(->[LSS_Inventory:165])
		End if 
	: ($task_txt="CANCEL")
		CLEAR SET:C117("LSS_CustomSearch")
		LSS_SearchNumFound_L:=0
End case 

//End LSS_CustomSearch