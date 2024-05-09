//%attributes = {"invisible":true}
//Method: LSS_ContractsToStorage
//Description
// save the collection in systemparameter LSS_Contracts to Storage
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Mar 28, 2024, 11:26:06
	Mods_2024_LSS_1
	// ----------------------------------------------------
	
End if 
//

C_TEXT:C284($ancContracts_txt)
$ancContracts_txt:=ut_GetSysParameter("LSS_Contracts")
C_COLLECTION:C1488($ancContracts_c)
C_BOOLEAN:C305(4DError_b)
4DError_b:=False:C215
ON ERR CALL:C155("4D_Errors")
$ancContracts_c:=JSON Parse:C1218($ancContracts_txt; Is collection:K8:32)
ON ERR CALL:C155("")
If (4DError_b)
	4DError_b:=False:C215
	$ancContracts_c:=New collection:C1472  //the collection will be blank
End if 

If (Storage:C1525.LSS_Contracts=Null:C1517)
	Use (Storage:C1525)
		Storage:C1525.LSS_Contracts:=New shared collection:C1527
	End use 
End if 
Use (Storage:C1525.LSS_Contracts)
	OB_CopyToSharedCollection($ancContracts_c; Storage:C1525.LSS_Contracts)
End use 
//End LSS_ContractsToStorage   