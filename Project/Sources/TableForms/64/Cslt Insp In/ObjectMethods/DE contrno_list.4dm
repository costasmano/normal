//Method: [Cons Inspection];"Cslt Insp In".DE contrno_list
//Description
// new contract number dropdown list
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Jan 11, 2024, 15:06:13
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
$typePopup_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "DE cboContractType")

Case of 
	: ($FormEvent_L=On Load:K2:1)
		
	: ($FormEvent_L=On Data Change:K2:15)
		C_LONGINT:C283($choice_L)
		$choice_L:=$this_->
		
		Case of 
			: ($choice_L=0)  // did not select anything
			: ([Cons Inspection:64]ConContractNo:7=Substring:C12($this_->{$choice_L}; 1; Position:C15(" "; $this_->{$choice_L})-1))  // same contract already
			Else 
				// contract number changed
				C_BOOLEAN:C305($makechange_b)
				If (Num:C11([Cons Inspection:64]ConContractNo:7)=0)
					//current contr num is zero - go ahead with change
					$makechange_b:=True:C214
				Else 
					//changing contract number- verify
					CONFIRM:C162("Change Contract number from "+[Cons Inspection:64]ConContractNo:7+" to "+Substring:C12($this_->{$choice_L}; 1; Position:C15(" "; $this_->{$choice_L})-1)+"?"+\
						" This will reset other assignment info"; "Change"; "Cancel")
					$makechange_b:=(OK=1)
					
				End if 
				
				If ($makechange_b)
					
					[Cons Inspection:64]ConContractNo:7:=Substring:C12($this_->{$choice_L}; 1; Position:C15(" "; $this_->{$choice_L})-1)
					PushChange(1; ->[Cons Inspection:64]ConContractNo:7)
					C_OBJECT:C1216($contr_o)
					$contr_o:=ds:C1482.Contracts.query("ContractNo = :1"; [Cons Inspection:64]ConContractNo:7)
					
					//since contract number changed - clear out other assignement fields
					//clear the assignment number list
					ARRAY LONGINT:C221($assigndropdwn_ptr->; 0)
					$assigndropdwn_ptr->:=0
					//clear consultant name and conctract type
					[Cons Inspection:64]ContractType:36:=""
					[Cons Inspection:64]AssignConName:5:=""
					[Cons Inspection:64]AssignConNumber:6:=0
					[Cons Inspection:64]ReqFeeProposal:25:=!00-00-00!
					[Cons Inspection:64]ProceedConDate:8:=!00-00-00!
					[Cons Inspection:64]NTPdate_verbal:35:=!00-00-00!
					[Cons Inspection:64]AssignStatus:24:=""
					[Cons Inspection:64]FeeProposalRecvd:27:=!00-00-00!
					//reset dropdowns
					POPUPMENUC($typePopup_ptr; $typePopup_ptr; ->[Cons Inspection:64]ContractType:36; On Load:K2:1)
					$assigndropdwn_ptr->:=0
					cboAssignmentStatus:=0
					
					//perform checking
					
					Case of 
						: ($contr_o.length=0)
							// in case contract was deleted after dropdown values were created
							ALERT:C41("The contract number ["+[Cons Inspection:64]ConContractNo:7+"] is not found in Contracts!  Please define it first.")
							
						: ($contr_o[0].ContractStatus="CLOSED")
							ALERT:C41("The status of this contract number is CLOSED.")
						: ($contr_o[0].ContractType="@Rating")
							ALERT:C41("This contract ["+[Cons Inspection:64]ConContractNo:7+"] number is for RATINGS only!")
						Else 
							//contract number changed
							
							[Cons Inspection:64]ContractType:36:=Substring:C12($contr_o[0].ContractType; 1; Position:C15(" "; $contr_o[0].ContractType)-1)
							PushChange(1; ->[Cons Inspection:64]ContractType:36)
							
							Case of 
								: ([Cons Inspection:64]ContractType:36="Regular")
									cboContractType:=2
								: ([Cons Inspection:64]ContractType:36="Complex")
									cboContractType:=3
								: ([Cons Inspection:64]ContractType:36="BRI")
									cboContractType:=4
								Else 
									cboContractType:=0
							End case 
							
							[Cons Inspection:64]AssignConName:5:=$contr_o[0].ConsltName
							[Cons Inspection Cost:76]OverheadRate:40:=$contr_o[0].OverheadRate
							
							netFeeRate:=$contr_o[0].NetFeeRate
							overheadRate:=$contr_o[0].OverheadRate
							
							//get non-zero assigments for the contract and assign to the assignment no field
							C_OBJECT:C1216($assignments_o)
							$assignments_o:=ds:C1482["Contract Assignments"].query("ContractNo = :1 & AssignNo > 0"; [Cons Inspection:64]ConContractNo:7).orderBy("AssignNo DESC")
							
							ARRAY LONGINT:C221($assignments_aL; 0)
							
							If ($assignments_o.length>0)
								COLLECTION TO ARRAY:C1562($assignments_o.toCollection("AssignNo"); $assignments_aL; "AssignNo")
								
							End if 
							COPY ARRAY:C226($assignments_aL; $assigndropdwn_ptr->)
							
					End case 
					
				Else 
					//no change - revert the dropdown
					$choice_L:=Find in array:C230($this_->; ([Cons Inspection:64]ConContractNo:7+" @"))
					
					If ($choice_L>0)
						$this_->:=$choice_L
					Else 
						$this_->:=0
					End if 
					
				End if 
				
		End case 
		
	: ($FormEvent_L=On Clicked:K2:4)
		
End case 

//End [Cons Inspection];"Cslt Insp In".DE contrno_list   