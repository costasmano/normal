If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(2023-10-24 17:39:04)
	Mods_2023_10
	//  `modified to use DS to keep [Contract Assignments] unlocked
End if 

PushChange(1; Self:C308)

// Start of Mods_2023_10

C_OBJECT:C1216($assign_o)
$assign_o:=ds:C1482["Contract Assignments"].query("ContractNo = :1 AND AssignNo= :2"; [Conslt Rating:63]ContractNoRat:14; [Conslt Rating:63]AssignNoRat:12).first()

If (Not:C34($assign_o=Null:C1517))
	[Conslt Rating:63]ReqFeeProposal:30:=$assign_o.ReqFeeProposalDate
	[Conslt Rating:63]ProceedRat:10:=$assign_o.NTPdate_written  //NTPdate_written    
	[Conslt Rating:63]NTPdate_verbal:50:=$assign_o.NTPdate_verbal
	
	PushChange(1; ->[Conslt Rating:63]ReqFeeProposal:30)
	PushChange(1; ->[Conslt Rating:63]ProceedRat:10)
	PushChange(1; ->[Conslt Rating:63]NTPdate_verbal:50)
	
Else 
	ALERT:C41("Contract and assignment number is not found in Contract Assignments!  Please define it first.")
End if 
// end of Mods_2023_10
