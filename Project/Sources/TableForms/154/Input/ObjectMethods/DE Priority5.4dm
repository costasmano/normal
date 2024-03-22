ut_ComboMenuC(Self:C308; ->[RatingRequests:154]ContractNo_L:17)

If ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4))
	RtgReq_Utility("LOADASSIGNMENTS")
	RtgReq_ContrAssign_cb{0}:=[RatingRequests:154]AssignmentNo_L:18
End if 
