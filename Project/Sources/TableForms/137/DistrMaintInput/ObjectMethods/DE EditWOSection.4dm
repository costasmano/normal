C_POINTER:C301(DCM_WO_Write_ptr)
DCM_WO_Write_ptr:=->DCM_WO_Deficiency_x
C_LONGINT:C283(DCM_4DWriteArea_L)
C_LONGINT:C283($W_L; $h_L)
FORM GET PROPERTIES:C674([DCM_WorkOrders:137]; "DCM_4DWriteDlg"; $W_L; $h_L)
NewWindow($W_L; $h_L; 0; Plain window:K34:13)
DIALOG:C40([DCM_WorkOrders:137]; "DCM_4DWriteDlg")
CLOSE WINDOW:C154