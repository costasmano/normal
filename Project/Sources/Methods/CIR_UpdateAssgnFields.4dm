//%attributes = {"invisible":true}
//Method: CIR_UpdateAssgnFields
//Description
// update records in [Cons Inspection] or [Conslt Rating] with changes to fields
//[Contract Assignments]ReqFeeProposalDate
//[Contract Assignments]NTPdate_verbal
//[Contract Assignments]NTPdate_written
//[Contract Assignments]OverHeadRate
//[Contract Assignments]NetFeeRate
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Jan 16, 2024, 17:35:19
	Mods_2024_01
	// ----------------------------------------------------
	// Modified by: manousakisc-(Designer)-(4/25/2024 18:34:15)
	Mods_2024_04
	//  `added code to account for new field [Contract Assignments]ReqFeeProposalRcd
End if 
//
ARRAY POINTER:C280($fields_ptr; 0)
APPEND TO ARRAY:C911($fields_ptr; ->[Contract Assignments:83]ReqFeeProposalDate:16)
APPEND TO ARRAY:C911($fields_ptr; ->[Contract Assignments:83]ReqFeeProposalRcd:25)
APPEND TO ARRAY:C911($fields_ptr; ->[Contract Assignments:83]NTPdate_verbal:18)
APPEND TO ARRAY:C911($fields_ptr; ->[Contract Assignments:83]NTPdate_written:17)
C_LONGINT:C283($loop_L)
C_BOOLEAN:C305($updateDates_b; $updateRates_b)
$updateDates_b:=False:C215
$updateRates_b:=False:C215
For ($loop_L; 1; Size of array:C274($fields_ptr))
	If ($fields_ptr{$loop_L}->#Old:C35($fields_ptr{$loop_L}->))
		$updateDates_b:=True:C214
	End if 
End for 
ARRAY POINTER:C280($fields_ptr; 0)
APPEND TO ARRAY:C911($fields_ptr; ->[Contract Assignments:83]OverHeadRate:23)
APPEND TO ARRAY:C911($fields_ptr; ->[Contract Assignments:83]NetFeeRate:22)
For ($loop_L; 1; Size of array:C274($fields_ptr))
	If ($fields_ptr{$loop_L}->#Old:C35($fields_ptr{$loop_L}->))
		$updateRates_b:=True:C214
	End if 
End for 

If ($updateDates_b | $updateRates_b)
	// make changes to any [Cons Inspection] or [Conslt Rating] records
	C_TEXT:C284($tablename_; $contrFld; $assignFld; $proceedFld; $NTPVerbalFld; $RFPFld; \
		$costtable; $overheadfld; $Contracttype; $IDFld)
	C_POINTER:C301($tbl_ptr; $Binfld_ptr; $IDFld_ptr; $ContrFld_ptr; $assignFld_ptr; \
		$proceedFld_ptr; $NTPVerbalFld_ptr; $RFPFld_ptr; $RFPRcdFld_ptr)
	If ([Contracts:79]ContractType:2="@Inspection")
		//Inspection contract
		$Contracttype:="Inspection"
		$tablename_:=Table name:C256(->[Cons Inspection:64])
		$contrFld:=Field name:C257(->[Cons Inspection:64]ConContractNo:7)
		$assignFld:=Field name:C257(->[Cons Inspection:64]AssignConNumber:6)
		$costtable:="ConsInspectionID_32_"
		$tbl_ptr:=->[Cons Inspection:64]
		$Binfld_ptr:=->[Cons Inspection:64]BIN:1
		$IDFld_ptr:=->[Cons Inspection:64]ConsInspectionID:32
		$ContrFld_ptr:=->[Cons Inspection:64]ConContractNo:7
		$assignFld_ptr:=->[Cons Inspection:64]AssignConNumber:6
		$proceedFld_ptr:=->[Cons Inspection:64]ProceedConDate:8
		$NTPVerbalFld_ptr:=->[Cons Inspection:64]NTPdate_verbal:35
		$RFPFld_ptr:=->[Cons Inspection:64]ReqFeeProposal:25
		$RFPRcdFld_ptr:=->[Cons Inspection:64]FeeProposalRecvd:27
	Else 
		$Contracttype:="Rating"
		$tablename_:=Table name:C256(->[Conslt Rating:63])
		$contrFld:=Field name:C257(->[Conslt Rating:63]ContractNoRat:14)
		$assignFld:=Field name:C257(->[Conslt Rating:63]AssignNoRat:12)
		$costtable:="ConsltRatingID_30_"
		$tbl_ptr:=->[Conslt Rating:63]
		$Binfld_ptr:=->[Conslt Rating:63]BIN:1
		$IDFld_ptr:=->[Conslt Rating:63]ConsltRatingID:42
		
		$ContrFld_ptr:=->[Conslt Rating:63]ContractNoRat:14
		$assignFld_ptr:=->[Conslt Rating:63]AssignNoRat:12
		$proceedFld_ptr:=->[Conslt Rating:63]ProceedRat:10
		$NTPVerbalFld_ptr:=->[Conslt Rating:63]NTPdate_verbal:50
		$RFPFld_ptr:=->[Conslt Rating:63]ReqFeeProposal:30
		$RFPRcdFld_ptr:=->[Conslt Rating:63]FeeProposalRecvd:22
		
	End if 
	$IDFld:=Field name:C257($IDFld_ptr)
	
	C_OBJECT:C1216($BINsAssigned_o)
	$BINsAssigned_o:=ds:C1482[$tablename_].query($contrFld+" = :1 and "+$assignFld+" = :2"; [Contract Assignments:83]ContractNo:1; [Contract Assignments:83]AssignNo:2)
	If ($BINsAssigned_o.length>0)
		ALERT:C41("Will attempt to update data in "+String:C10($BINsAssigned_o.length)+" Consultant "+\
			$Contracttype+" records")
		C_OBJECT:C1216($rec_o; $lockstatus)
		C_TEXT:C284($lockmessage_txt)
		C_LONGINT:C283($changeStack_L)
		If (Type:C295(ptr_Changes)=Is undefined:K8:13)
			ARRAY POINTER:C280(ptr_Changes; 0; 0)
		End if 
		$changeStack_L:=Size of array:C274(ptr_changes)+1
		For each ($rec_o; $BINsAssigned_o)
			If ($updateDates_b)
				//for these updates have to use 4D classic so changes can be logged in activity log
				QUERY:C277($tbl_ptr->; $IDFld_ptr->=$rec_o[$IDFld])
				If (ut_LoadRecordInteractive($tbl_ptr))
					InitChangeStack($changeStack_L)
					$proceedFld_ptr->:=[Contract Assignments:83]NTPdate_written:17
					$NTPVerbalFld_ptr->:=[Contract Assignments:83]NTPdate_verbal:18
					$RFPFld_ptr->:=[Contract Assignments:83]ReqFeeProposalDate:16
					$RFPRcdFld_ptr->:=[Contract Assignments:83]ReqFeeProposalRcd:25
					
					PushChange($changeStack_L; $proceedFld_ptr)
					PushChange($changeStack_L; $NTPVerbalFld_ptr)
					PushChange($changeStack_L; $RFPFld_ptr)
					PushChange($changeStack_L; $RFPRcdFld_ptr)
					FlushGrpChgs($changeStack_L; ->[Bridge MHD NBIS:1]BIN:3; $Binfld_ptr; $IDFld_ptr; 1)
					SAVE RECORD:C53($tbl_ptr->)
					UNLOAD RECORD:C212($tbl_ptr->)
					
				Else 
					$lockmessage_txt:="Could not load Consultant "+$Contracttype+" for BIN "+$rec_o.BIN+\
						" ! Date values have to be updated manually!"
					ALERT:C41($lockmessage_txt)
				End if 
				
			End if 
			
			If ($updateRates_b)
				//
				
				If ($rec_o[$costtable].length=1)
					//there is a cost record
					C_OBJECT:C1216($cost_o)
					$cost_o:=$rec_o[$costtable][0]
					//$lockstatus:=$cost_o.lock()
					
					If (DB_LockEntityInteractive($cost_o; "for Cost data for Consultant "+$Contracttype+" BIN "+$rec_o.BIN))
						//update negotiated values - base is the salary
						If (([Contract Assignments:83]NetFeeRate:22#0) & ([Contract Assignments:83]OverHeadRate:23#0))
							$cost_o["Neg IndirectCost"]:=$cost_o["Neg Salary"]*[Contract Assignments:83]OverHeadRate:23/100
							$cost_o["Neg NetFee"]:=($cost_o["Neg Salary"]+$cost_o["Neg IndirectCost"])*[Contract Assignments:83]NetFeeRate:22/100
							$cost_o["Act IndirectCost"]:=$cost_o["Act Salary"]*[Contract Assignments:83]OverHeadRate:23/100
							$cost_o["Act NetFee"]:=($cost_o["Act Salary"]+$cost_o["Act IndirectCost"])*[Contract Assignments:83]NetFeeRate:22/100
						End if 
						
						$cost_o["Neg TotalLimitFee"]:=$cost_o["Neg Salary"]+$cost_o["Neg IndirectCost"]+$cost_o["Neg NetFee"]
						$cost_o["Neg TotalCost"]:=$cost_o["Neg TotalLimitFee"]+$cost_o["Neg TotalDirectCost"]
						$cost_o["Act TotalLimitFee"]:=$cost_o["Act Salary"]+$cost_o["Act IndirectCost"]+$cost_o["Act NetFee"]
						$cost_o["Act TotalCost"]:=$cost_o["Act TotalLimitFee"]+$cost_o["Act TotalDirectCost"]
						
						$cost_o.save()
						$lockstatus:=$cost_o.unlock()
					Else 
						C_TEXT:C284($lockmessage_txt)
						$lockmessage_txt:="Could not load Cost data for Consultant "+$Contracttype+" BIN "+$rec_o.BIN+\
							" ! Cost Values have to be updated manually!"
						ALERT:C41($lockmessage_txt)
					End if 
				Else 
					ALERT:C41("Error ! : Could not find cost record for Consultant "+$Contracttype+" for BIN "+$rec_o.BIN)
				End if 
				
			End if 
			
		End for each 
		
	End if 
	
End if 
//End CIR_UpdateAssgnFields   