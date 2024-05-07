//Method: [LSS_Inventory];"Edit_SIN".GetNew_I_N
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Apr 11, 2024, 18:52:13
	Mods_2024_04
	// ----------------------------------------------------
	
End if 
//
C_TEXT:C284($Route_txt; $Type_txt)
C_LONGINT:C283($Distr_L; $MaxNumber_L; $MinIDnumber_L; $MaxIDnumber_L)
$Route_txt:=Substring:C12([LSS_Inventory:165]LSS_Route_s:9; 1; 5)+"%"
$Distr_L:=[LSS_Inventory:165]LSS_District_L:3
$Type_txt:=[LSS_Inventory:165]LSS_InventoryType_s:28
$MinIDnumber_L:=([LSS_Inventory:165]LSS_District_L:3*100000)
$MaxIDnumber_L:=(([LSS_Inventory:165]LSS_District_L:3+1)*100000)
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
	and
	[LSS_Inventory].[LSS_IdentificationNumber_L] > :$MinIDnumber_L
	and
	[LSS_Inventory].[LSS_IdentificationNumber_L] < :$MaxIDnumber_L
	into :$MaxNumber_L;
End SQL

Case of 
	: ($MaxNumber_L=0)
		$MaxNumber_L:=1
	Else 
		$MaxNumber_L:=$MaxNumber_L+1
End case 

LSS_SIN_2_L:=$MaxNumber_L-([LSS_Inventory:165]LSS_District_L:3*100000)

v_165_005_l:=[LSS_Inventory:165]LSS_District_L:3*100000+LSS_SIN_2_L
v_165_006_txt:=Substring:C12(v_165_006_txt; 1; Length:C16(v_165_006_txt)-6)
v_165_006_txt:=v_165_006_txt+String:C10(v_165_005_l)

//End [LSS_Inventory].Edit_SIN.GetNew_I_N   