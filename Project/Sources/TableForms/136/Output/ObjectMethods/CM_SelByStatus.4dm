If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/07/08, 11:44:56
	// ----------------------------------------------------
	// Method: Object Method: CM_SelByStatus
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM_5401
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(CM_SelByStatus; 0)
		DISTINCT VALUES:C339([DCM_Contracts:136]ContractStatus:7; CM_SelByStatus)
		SORT ARRAY:C229(CM_SelByStatus)
		CM_SelByStatus{0}:="NoneSelected"
		CM_SelByStatus:=0
		INSERT IN ARRAY:C227(CM_SelByStatus; 1)
		CM_SelByStatus{1}:="Show ALL"
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($pickedItm_L)
		$pickedItm_L:=CM_SelByStatus
		If (CM_SelByStatus{CM_SelByStatus}#CM_SelByStatus{0})
			If ($pickedItm_L#1)
				QUERY:C277([DCM_Contracts:136]; [DCM_Contracts:136]ContractStatus:7=CM_SelByStatus{CM_SelByStatus})
			Else 
				ALL RECORDS:C47([DCM_Contracts:136])
			End if 
			CM_SelByStatus{0}:=CM_SelByStatus{$pickedItm_L}
			DCM_SortOutputList("SORT")
			RegionTitle
			
		End if 
End case 
