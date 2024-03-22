//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/13/10, 11:09:13
	// ----------------------------------------------------
	// Method: Method: DCM_EditContrQ_OM
	// Description
	// Edit the contract Item quantity
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_12
End if 


C_LONGINT:C283($rowSelect_L)
$rowSelect_L:=-1
If (ITMLB_ItemQ_ar>0)
	$rowSelect_L:=ITMLB_ItemQ_ar
Else 
	If (Size of array:C274(LineItems_lb)>0)
		$rowSelect_L:=1
	End if 
	
End if 

If ($rowSelect_L>0)
	If (ITMLB_ItemNos_as{$rowSelect_L}="999@")
		OBJECT SET ENTERABLE:C238(ITMLB_ItemQ_ar; True:C214)
		EDIT ITEM:C870(ITMLB_ItemQ_ar; $rowSelect_L)
	Else 
		ALERT:C41("Can only modify Contract quantities for 999 Items!")
	End if 
End if 