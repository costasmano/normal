//Method: [Cons Inspection];"Cslt Insp In".DE assign_list
//Description
// New assignment number dropdown
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Jan 11, 2024, 17:53:05
	Mods_2024_01
	// ----------------------------------------------------
	
End if 
//
C_LONGINT:C283($FormEvent_L)
$FormEvent_L:=Form event code:C388
C_POINTER:C301($me_ptr)
$me_ptr:=OBJECT Get pointer:C1124(Object current:K67:2)
Case of 
		
	: ($FormEvent_L=On Data Change:K2:15)
		C_LONGINT:C283($choice_L)
		$choice_L:=$me_ptr->
		If ($choice_L>0)
			[Cons Inspection:64]AssignConNumber:6:=$me_ptr->{$choice_L}
			C_OBJECT:C1216($assign_o)
			$assign_o:=ds:C1482["Contract Assignments"].query("ContractNo = :1 & AssignNo = :2"; [Cons Inspection:64]ConContractNo:7; [Cons Inspection:64]AssignConNumber:6)
			If ($assign_o.length=1)
				[Cons Inspection:64]ReqFeeProposal:25:=$assign_o[0].ReqFeeProposalDate
				[Cons Inspection:64]ProceedConDate:8:=$assign_o[0].NTPdate_written
				[Cons Inspection:64]NTPdate_verbal:35:=$assign_o[0].NTPdate_verbal
				
				If ($assign_o[0].OverHeadRate#0) & ($assign_o[0].OverHeadRate#[Cons Inspection Cost:76]OverheadRate:40)
					[Cons Inspection Cost:76]OverheadRate:40:=$assign_o[0].OverHeadRate
					overheadRate:=$assign_o[0].OverHeadRate
				End if 
				If ($assign_o[0].NetFeeRate#0) & ($assign_o[0].NetFeeRate#netFeeRate)
					netFeeRate:=$assign_o[0].NetFeeRate
				End if 
				
			Else 
				ALERT:C41("The assignment number ["+\
					String:C10([Cons Inspection:64]AssignConNumber:6)+"] is not found in Contract Assignments for ["+\
					[Cons Inspection:64]ConContractNo:7+"]! Please define it first.")
			End if 
		End if 
		
End case 

//End [Cons Inspection];"Cslt Insp In".DE assign_list   