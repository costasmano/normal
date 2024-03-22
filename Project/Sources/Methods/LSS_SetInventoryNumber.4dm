//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 04/29/14, 15:54:17
//----------------------------------------------------
//Method: LSS_SetInventoryNumber
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_08_bug
	//Make sure mile point truncates to be part of structure number
	//Modified by: administrator (8/13/15 13:47:28)
	// Modified by: Costas Manousakis-(Designer)-(12/23/15 15:40:34)
	Mods_2015_12_bug
	//  `added the case for LSS_RouteSuffix_L
	Mods_2018_02_bug  //Fix problem where duplicate structure numbers can be created
	//Modified by: Chuck Miller (2/27/18 13:53:23)
	Mods_2018_03_bug  //Re-adjust how and when get next number
	//Modified by: Chuck Miller (3/20/18 15:36:11)
	
End if 
C_BOOLEAN:C305($UpdateSIN_B)
$UpdateSIN_B:=True:C214
If (Count parameters:C259=1)
	C_BOOLEAN:C305($1)
	$UpdateSIN_B:=$1
	
End if 

OBJECT SET ENABLED:C1123(*; "SaveRecord"; False:C215)
//_ o_DISABLE BUTTON(bValidate)
OBJECT SET ENABLED:C1123(*; "EditIDNum@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 

Case of 
	: (LSS_TownCode_s="")
		
	: ([LSS_Inventory:165]LSS_District_L:3=0)
		
	: ([LSS_Inventory:165]LSS_MilePoint_r:8=0)
		
	: ([LSS_Inventory:165]LSS_RouteDirection_s:14="")
	: ([LSS_Inventory:165]LSS_InventoryType_s:28="")
		
	: (LSS_Route_L=0)
	: (LSS_RouteDesignation_s="")
		
	Else 
		C_TEXT:C284($Type_txt; $Route_txt)
		C_BOOLEAN:C305($GetaNewMaxNumber_B)
		$GetaNewMaxNumber_B:=False:C215
		If (Is new record:C668([LSS_Inventory:165])) & (LSS_SIN_2_L=0)
			
			$GetaNewMaxNumber_B:=True:C214
		Else 
			Case of 
				: (Not:C34($UpdateSIN_B))
					$MaxNumber_L:=LSS_SIN_2_L-1
				: ([LSS_Inventory:165]LSS_Route_s:9#Old:C35([LSS_Inventory:165]LSS_Route_s:9))
					$GetaNewMaxNumber_B:=True:C214
				: ([LSS_Inventory:165]LSS_InventoryType_s:28#Old:C35([LSS_Inventory:165]LSS_InventoryType_s:28))
					$GetaNewMaxNumber_B:=True:C214
				: ([LSS_Inventory:165]LSS_District_L:3#Old:C35([LSS_Inventory:165]LSS_District_L:3))
					$GetaNewMaxNumber_B:=True:C214
				Else 
					
					$GetaNewMaxNumber_B:=False:C215
					
					
			End case 
			
			
		End if 
		C_LONGINT:C283($MaxNumber_L; $Distr_L; $SINDistr_L)
		$Type_txt:=[LSS_Inventory:165]LSS_InventoryType_s:28
		If (LSS_RouteSuffix_L=0)
			$Route_txt:=LSS_RouteDesignation_s+String:C10(LSS_Route_L; "0000")+"%"
			[LSS_Inventory:165]LSS_Route_s:9:=LSS_RouteDesignation_s+String:C10(LSS_Route_L; "0000")+Substring:C12([LSS_Inventory:165]LSS_RouteDirection_s:14; 1; 1)
		Else 
			$Route_txt:=LSS_RouteDesignation_s+String:C10(LSS_Route_L; "000A")+"%"
			[LSS_Inventory:165]LSS_Route_s:9:=LSS_RouteDesignation_s+String:C10(LSS_Route_L; "000A")+Substring:C12([LSS_Inventory:165]LSS_RouteDirection_s:14; 1; 1)
		End if 
		$Distr_L:=[LSS_Inventory:165]LSS_District_L:3
		$SINDistr_L:=([LSS_Inventory:165]LSS_IdentificationNumber_L:5\100000)
		If ($GetaNewMaxNumber_B)
			Begin SQL
				select max ([LSS_Inventory].[LSS_IdentificationNumber_L])
				from
				[LSS_Inventory]
				where
				[LSS_Inventory].[LSS_Route_s] LIKE :$Route_txt
				and
				[LSS_Inventory].[LSS_InventoryType_s] = :$Type_txt
				and
				[LSS_Inventory].[LSS_District_L] = :$Distr_L
				into :$MaxNumber_L;
			End SQL
		End if 
		Case of 
			: ($MaxNumber_L=0)
				[LSS_Inventory:165]LSS_IdentificationNumber_L:5:=([LSS_Inventory:165]LSS_District_L:3*100000)+1
			: (LSS_SIN_2_L#0)
				
			Else 
				[LSS_Inventory:165]LSS_IdentificationNumber_L:5:=$MaxNumber_L+1
		End case 
		
		LSS_SIN_2_L:=[LSS_Inventory:165]LSS_IdentificationNumber_L:5-([LSS_Inventory:165]LSS_District_L:3*100000)
		
		C_LONGINT:C283($MilePost_L)
		$MilePost_L:=Trunc:C95([LSS_Inventory:165]LSS_MilePoint_r:8; 0)
		
		
		//[LSS_Inventory]LSS_StructureNumber_s:=LSS_TownCode_s+"-"+[LSS_Inventory]LSS_InventoryType_s+"-"+[LSS_Inventory]LSS_Route_s+Substring([LSS_Inventory]LSS_RouteDirection_s;1;1)+"-"+String($MilePost_L;"000")+"-"+String([LSS_Inventory]LSS_District_L)+String([LSS_Inventory]LSS_IdentificationNumber_L;"00000")
		If (Is new record:C668([LSS_Inventory:165]))
			[LSS_Inventory:165]LSS_StructureNumber_s:6:=LSS_TownCode_s+"-"+[LSS_Inventory:165]LSS_InventoryType_s:28+"-"+[LSS_Inventory:165]LSS_Route_s:9+"-"+String:C10($MilePost_L; "000")+"-"+String:C10([LSS_Inventory:165]LSS_IdentificationNumber_L:5; "000000")
		Else 
			v_165_006_txt:=LSS_TownCode_s+"-"+[LSS_Inventory:165]LSS_InventoryType_s:28+"-"+[LSS_Inventory:165]LSS_Route_s:9+"-"+String:C10($MilePost_L; "000")+"-"+String:C10([LSS_Inventory:165]LSS_IdentificationNumber_L:5; "000000")
			
		End if 
		OBJECT SET ENABLED:C1123(*; "SaveRecord"; True:C214)
		OBJECT SET ENABLED:C1123(bValidate; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(*; "TrapEnter_L"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(*; "EditIDNum@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		
End case 

//End LSS_SetInventoryNumber