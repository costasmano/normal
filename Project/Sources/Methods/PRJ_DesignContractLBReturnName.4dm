//%attributes = {"invisible":true}
//Method: PRJ_DesignContractLBReturnName
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 11/19/20, 14:18:42
	// ----------------------------------------------------
	//Created : 
	Mods_2020_11
	
	C_TEXT:C284(PRJ_DesignContractLBReturnName; $0)
	
End if 
//
C_TEXT:C284($0)
QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantNameID_l:1=[PRJ_DesignContracts:123]ConsultantNameID_l:2)
If (Records in selection:C76([Conslt_Name:127])=1)
	$0:=[Conslt_Name:127]ConsultantName_s:2
Else 
	$0:="Unknown"
End if 
//End PRJ_DesignContractLBReturnName