//Method: [Conslt Rating];"Cslt Rating In".DE contrno_list
//Description
// New contract number dropdown
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Jan 12, 2024, 15:06:13
	Mods_2024_01
	// ----------------------------------------------------
	
End if 
//
C_LONGINT:C283($FormEvent_L)
$FormEvent_L:=Form event code:C388
C_POINTER:C301($this_)
$this_:=OBJECT Get pointer:C1124(Object current:K67:2)
C_POINTER:C301($assigndropdwn_ptr)
$assigndropdwn_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "DE assign_list")
C_POINTER:C301($typePopup_ptr)
$typePopup_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "cboContractType")

Case of 
	: ($FormEvent_L=On Load:K2:1)
		
	: ($FormEvent_L=On Data Change:K2:15)
		C_LONGINT:C283($choice_L)
		$choice_L:=$this_->
		
		
		Case of 
			: ($choice_L=0)  // did not select anything
			: ([Conslt Rating:63]ContractNoRat:14=Substring:C12($this_->{$choice_L}; 1; Position:C15(" "; $this_->{$choice_L})-1))  // same contract already
			Else 
				// contract number changed
				C_BOOLEAN:C305($makechange_b)
				If (Num:C11([Conslt Rating:63]ContractNoRat:14)=0)
					//current contr num is zero - go ahead with change
					$makechange_b:=True:C214
				Else 
					//changing contract number- verify
					CONFIRM:C162("Change Contract number from "+[Conslt Rating:63]ContractNoRat:14+" to "+Substring:C12($this_->{$choice_L}; 1; Position:C15(" "; $this_->{$choice_L})-1)+"?"+\
						" This will reset other assignment info"; "Change"; "Cancel")
					$makechange_b:=(OK=1)
					
				End if 
				
				If ($makechange_b)
					//proceed with the change
					
					[Conslt Rating:63]ContractNoRat:14:=Substring:C12($this_->{$choice_L}; 1; Position:C15(" "; $this_->{$choice_L})-1)
					PushChange(1; ->[Conslt Rating:63]ContractNoRat:14)
					
					//clear the assignment number list
					ARRAY LONGINT:C221($assigndropdwn_ptr->; 0)
					//since contract number changed - clear out other assignement fields
					[Conslt Rating:63]ContractType:48:=""
					[Conslt Rating:63]AssignRatCons:5:=""
					[Conslt Rating:63]AssignNoRat:12:=0
					[Conslt Rating:63]AssignPhase:51:=""
					[Conslt Rating:63]AssignNoRat:12:=0
					[Conslt Rating:63]ReqFeeProposal:30:=!00-00-00!
					[Conslt Rating:63]ProceedRat:10:=!00-00-00!
					[Conslt Rating:63]NTPdate_verbal:50:=!00-00-00!
					[Conslt Rating:63]AssignStatus:43:=""
					[Conslt Rating:63]FeeProposalRecvd:22:=!00-00-00!
					//reset dropdowns
					$assigndropdwn_ptr->:=0
					cboAssignmentStatus:=0
					POPUPMENUC($typePopup_ptr; $typePopup_ptr; ->[Conslt Rating:63]ContractType:48; On Load:K2:1)
					
					C_OBJECT:C1216($contr_o)
					$contr_o:=ds:C1482.Contracts.query("ContractNo = :1"; [Conslt Rating:63]ContractNoRat:14)
					
					//perform checking
					
					Case of 
						: ($contr_o.length=0)
							ALERT:C41("The contract number ["+[Conslt Rating:63]ContractNoRat:14+"] is not found in Contracts!  Please define it first.")
							
							GOTO OBJECT:C206(*; "Field10")
						: ($contr_o[0].ContractStatus="CLOSED")
							ALERT:C41("The status of this contract number is CLOSED.")
						: ($contr_o[0].ContractType="@Inspection")
							ALERT:C41("This contract ["+[Conslt Rating:63]ContractNoRat:14+"] number is for INSPECTIONS only!")
						Else 
							//contract number changed
							
							[Conslt Rating:63]ContractType:48:=Substring:C12($contr_o[0].ContractType; 1; Position:C15(" "; $contr_o[0].ContractType)-1)
							PushChange(1; ->[Conslt Rating:63]ContractType:48)
							
							POPUPMENUC(Self:C308; Self:C308; ->[Conslt Rating:63]ContractType:48; On Load:K2:1)
							
							[Conslt Rating:63]AssignRatCons:5:=$contr_o[0].ConsltName
							[Conslt Rating Cost:74]OverheadRate:40:=$contr_o[0].OverheadRate
							
							netFeeRate:=$contr_o[0].NetFeeRate
							overheadRate:=$contr_o[0].OverheadRate
							
							//get non-zero assigments for the contract and assign to the assignment no field
							C_OBJECT:C1216($assignments_o)
							$assignments_o:=ds:C1482["Contract Assignments"].query("ContractNo = :1 & AssignNo > 0"; [Conslt Rating:63]ContractNoRat:14).orderBy("AssignNo DESC")
							
							ARRAY LONGINT:C221($assignments_aL; 0)
							
							If ($assignments_o.length>0)
								COLLECTION TO ARRAY:C1562($assignments_o.toCollection("AssignNo"); $assignments_aL; "AssignNo")
								
							End if 
							COPY ARRAY:C226($assignments_aL; $assigndropdwn_ptr->)
							
					End case 
					
				Else 
					//no change - revert the dropdown
					$choice_L:=Find in array:C230($this_->; ([Conslt Rating:63]ContractNoRat:14+" @"))
					
					If ($choice_L>0)
						$this_->:=$choice_L
					Else 
						$this_->:=0
					End if 
					
				End if 
				
		End case 
		
	: ($FormEvent_L=On Clicked:K2:4)
		
End case 

//End [Conslt Rating];"Cslt Insp In".DE contrno_list   