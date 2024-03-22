If (False:C215)
	//Object Method: [Cons Inspection];"Cslt Insp In".cboAssignmentStatus 
	// Modified by: Costas Manousakis-(Designer)-(9/27/16 13:23:54)
	Mods_2016_09
	//  `Use TOL_ListToArray to load the list CONSINS_ASSIGNSTAT for this dropdown
End if 

C_POINTER:C301($pMyself)
$pMySelf:=Self:C308
Case of 
	: (Form event code:C388=On Load:K2:1)
		TOL_ListToArray("CONSINS_ASSIGNSTAT"; Self:C308)
		If ([Cons Inspection:64]AssignStatus:24="")
			Case of 
				: ([Cons Inspection:64]ReqFeeProposal:25#!00-00-00!)
					[Cons Inspection:64]AssignStatus:24:="Active"
			End case 
		End if 
		POPUPMENUC($pMySelf; $pMySelf; ->[Cons Inspection:64]AssignStatus:24)
		
	: (Form event code:C388=On Clicked:K2:4)
		
		POPUPMENUC($pMySelf; $pMySelf; ->[Cons Inspection:64]AssignStatus:24)
		PushChange(1; ->[Cons Inspection:64]AssignStatus:24)
End case 

HIGHLIGHT TEXT:C210([Cons Inspection:64]InspectionDate:28; 1; Length:C16([Cons Inspection:64]InspectionDate:28)+1)