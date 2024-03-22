//Method: [Conslt Rating];"Cslt Rating In".DE assign_list
//Description
// new assignment number dropdown
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
			[Conslt Rating:63]AssignRatCons:5:=$me_ptr->{$choice_L}
			C_OBJECT:C1216($assign_o)
			$assign_o:=ds:C1482["Contract Assignments"].query("ContractNo = :1 & AssignNo = :2"; [Conslt Rating:63]ContractNoRat:14; [Conslt Rating:63]AssignRatCons:5)
			If ($assign_o.length=1)
				[Conslt Rating:63]ReqFeeProposal:30:=$assign_o[0].ReqFeeProposalDate
				[Conslt Rating:63]ProceedRat:10:=$assign_o[0].NTPdate_written
				[Conslt Rating:63]NTPdate_verbal:50:=$assign_o[0].NTPdate_verbal
				
				If ($assign_o[0].OverHeadRate#0) & ($assign_o[0].OverHeadRate#[Cons Inspection Cost:76]OverheadRate:40)
					[Cons Inspection Cost:76]OverheadRate:40:=$assign_o[0].OverHeadRate
					overheadRate:=$assign_o[0].OverHeadRate
				End if 
				If ($assign_o[0].NetFeeRate#0) & ($assign_o[0].NetFeeRate#netFeeRate)
					netFeeRate:=$assign_o[0].NetFeeRate
				End if 
				
			Else 
				ALERT:C41("The assignment number ["+\
					String:C10([Conslt Rating:63]AssignRatCons:5)+"] is not found in Contract Assignments for ["+\
					[Conslt Rating:63]ContractNoRat:14+"]! Please define it first.")
			End if 
		End if 
		
End case 

//End [Conslt Rating];"Cslt Insp In".DE assign_list   