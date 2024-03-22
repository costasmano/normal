If (DCM_CUUsedQ1_ar>0)
	C_LONGINT:C283($rowSelect_L)
	$rowSelect_L:=DCM_CUUsedQ1_ar
	EDIT ITEM:C870(DCM_CUUsedQ1_ar; $rowSelect_L)
End if 
