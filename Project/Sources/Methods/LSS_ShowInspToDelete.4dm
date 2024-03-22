//%attributes = {"invisible":true}
C_LONGINT:C283($Width_l; $Height_l)
FORM GET PROPERTIES:C674([LSS_Inspection:164]; "LSS_InspectionLB"; $Width_l; $Height_l)

ut_OpenNewWindow($Width_l; $Height_l; 0; Plain window:K34:13; "Show Inpsectiobns to delete"; "ut_CloseCancel")
DIALOG:C40([LSS_Inspection:164]; "LSS_InspectionLB")
CLOSE WINDOW:C154
