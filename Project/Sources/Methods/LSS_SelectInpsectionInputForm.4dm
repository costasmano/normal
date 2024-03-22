//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 09/23/14, 14:45:38
// ----------------------------------------------------
// Method: LSS_SelectInpsectionInputForm
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; $2)

C_LONGINT:C283($LBCol_L; $LBRow_L)
LISTBOX GET CELL POSITION:C971(*; "Inspection_LB"; $LBCol_L; $LBRow_L)

If ($LBRow_L>0)
	C_TEXT:C284($InputForm_txt)
	
	
	GOTO SELECTED RECORD:C245([LSS_Inspection:164]; $LBRow_L)
	LSS_PermissionModInspection
	Case of 
		: ([LSS_Inventory:165]LSS_InventoryType_s:28="HS")
			$InputForm_txt:="Input_Sign"
		: ([LSS_Inventory:165]LSS_InventoryType_s:28="LI")
			$InputForm_txt:="Input_Light"
		: ([LSS_Inventory:165]LSS_InventoryType_s:28="SI")
			$InputForm_txt:="Input_Signal"
		: ([LSS_Inventory:165]LSS_InventoryType_s:28="IT")
			$InputForm_txt:="Input_ITS"
		Else 
			
			Case of 
				: ([LSS_Inventory:165]LSS_Category_s:2="Sign")
					$InputForm_txt:="Input_Sign"
				: ([LSS_Inventory:165]LSS_Category_s:2="Signal")
					$InputForm_txt:="Input_Signal"
				: ([LSS_Inventory:165]LSS_Category_s:2="Light")
					$InputForm_txt:="Input_Light"
				: ([LSS_Inventory:165]LSS_Category_s:2="ITS")
					$InputForm_txt:="Input_ITS"
			End case 
			
	End case 
	
	$1->:=$InputForm_txt
	
End if 

$2->:=$LBRow_L
