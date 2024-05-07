If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(2/21/2006 15:34:57)
	Mods_2006_CM03
	// Modified by: Costas Manousakis-(Designer)-(2024-01-16 17:31:09)
	Mods_2024_01
	//  `update any related cons insp or cons rating records
	// Modified by: Costas Manousakis-(Designer)-(2024-04-29 09:58:53)
	Mods_2024_04
	//  `added checks on dates 
End if 

If (Form event code:C388=On Clicked:K2:4)
	
	//check for unique assignment number before saving it
	
	C_LONGINT:C283($vlRecCount)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $vlRecCount)
	
	QUERY:C277([Contract Assignments:83]; [Contract Assignments:83]ContractNo:1=[Contracts:79]ContractNo:1; *)
	QUERY:C277([Contract Assignments:83];  & ; [Contract Assignments:83]AssignNo:2=[Contract Assignments:83]AssignNo:2)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	//check the dates
	C_COLLECTION:C1488($errmsg_)
	$errmsg_:=New collection:C1472
	C_LONGINT:C283($maxBackDate_L)
	$maxBackDate_L:=Num:C11(ut_GetSysParameter("CIR_MaxBackDate"; "60"))
	
	If ($maxBackDate_L<=0)
		$maxBackDate_L:=60
	End if 
	
	If ([Contract Assignments:83]ReqFeeProposalDate:16#Old:C35([Contract Assignments:83]ReqFeeProposalDate:16))
		If ([Contract Assignments:83]ReqFeeProposalDate:16>Current date:C33)
			$errmsg_.push("Request Fee date is in the future!")
		End if 
		If ([Contract Assignments:83]ReqFeeProposalDate:16>!00-00-00!) & \
			([Contract Assignments:83]ReqFeeProposalDate:16<Add to date:C393(Current date:C33; 0; 0; -$maxBackDate_L))
			$errmsg_.push("Request Fee date cannot be "+String:C10($maxBackDate_L)+" days ago!")
		End if 
		
	End if 
	
	If ([Contract Assignments:83]ReqFeeProposalRcd:25#Old:C35([Contract Assignments:83]ReqFeeProposalRcd:25))
		
		If ([Contract Assignments:83]ReqFeeProposalRcd:25>Current date:C33)
			$errmsg_.push("Fee Proposal received date is in the future!")
		End if 
		If ([Contract Assignments:83]ReqFeeProposalRcd:25>!00-00-00!) & \
			([Contract Assignments:83]ReqFeeProposalRcd:25<Add to date:C393(Current date:C33; 0; 0; -$maxBackDate_L))
			$errmsg_.push("Fee Proposal received date cannot be "+String:C10($maxBackDate_L)+" days ago!")
		End if 
		
	End if 
	
	
	If ([Contract Assignments:83]NTPdate_verbal:18#Old:C35([Contract Assignments:83]NTPdate_verbal:18))
		
		If ([Contract Assignments:83]NTPdate_verbal:18>Current date:C33)
			$errmsg_.push("NTP Verbal date is in the future!")
		End if 
		If ([Contract Assignments:83]NTPdate_verbal:18>!00-00-00!) & \
			([Contract Assignments:83]NTPdate_verbal:18<Add to date:C393(Current date:C33; 0; 0; -$maxBackDate_L))
			$errmsg_.push("NTP Verbal date cannot be "+String:C10($maxBackDate_L)+" days ago!")
		End if 
		
	End if 
	
	
	If ([Contract Assignments:83]NTPdate_written:17#Old:C35([Contract Assignments:83]NTPdate_written:17))
		
		If ([Contract Assignments:83]NTPdate_written:17>Current date:C33)
			$errmsg_.push("NTP Written date is in the future!")
		End if 
		If ([Contract Assignments:83]NTPdate_written:17>!00-00-00!) & \
			([Contract Assignments:83]NTPdate_written:17<Add to date:C393(Current date:C33; 0; 0; -$maxBackDate_L))
			$errmsg_.push("NTP Written date cannot be "+String:C10($maxBackDate_L)+" days ago!")
		End if 
		
	End if 
	
	If ([Contract Assignments:83]ReqFeeProposalDate:16#!00-00-00!)
		
		If ([Contract Assignments:83]ReqFeeProposalRcd:25<[Contract Assignments:83]ReqFeeProposalDate:16) & \
			([Contract Assignments:83]ReqFeeProposalRcd:25#!00-00-00!)
			$errmsg_.push("The Fee Proposal received date is before the Request Fee date!")
		End if 
		
		//NTP dates must also be after the req fee date
		If ([Contract Assignments:83]NTPdate_verbal:18<[Contract Assignments:83]ReqFeeProposalDate:16) & \
			([Contract Assignments:83]NTPdate_verbal:18#!00-00-00!)
			$errmsg_.push("The NTP Verbal date is before the Request Fee date!")
		End if 
		If ([Contract Assignments:83]NTPdate_written:17<[Contract Assignments:83]ReqFeeProposalDate:16) & \
			([Contract Assignments:83]NTPdate_verbal:18#!00-00-00!)
			$errmsg_.push("The NTP Writen date is before the Request Fee date!")
		End if 
		
	Else 
		
		If ([Contract Assignments:83]ReqFeeProposalRcd:25>!00-00-00!)
			$errmsg_.push("There is a Fee proposal received date when there is not Request Fee date!")
		End if 
		
	End if   // reqfeeproposal # 0/0/0
	
	
	If ([Contract Assignments:83]ReqFeeProposalRcd:25#!00-00-00!)
		// if the fee proposal date # 00/0/0 NTP dates must be after 
		If ([Contract Assignments:83]NTPdate_verbal:18<[Contract Assignments:83]ReqFeeProposalRcd:25) & \
			([Contract Assignments:83]NTPdate_verbal:18#!00-00-00!)
			$errmsg_.push("The NTP Verbal date is before the Fee proposal received date!")
		End if 
		If ([Contract Assignments:83]NTPdate_written:17<[Contract Assignments:83]ReqFeeProposalRcd:25) & \
			([Contract Assignments:83]NTPdate_verbal:18#!00-00-00!)
			$errmsg_.push("The NTP Writen date is before the Fee proposal received date!")
		End if 
		
	End if   // feeproprecd # 0/0/0
	
	
	Case of 
		: (($vlRecCount>0) & (Is new record:C668([Contract Assignments:83])))
			ALERT:C41("This assignment number is already being used. Please enter a different one!")
		: ($errmsg_.length>0)
			//date errors
			ALERT:C41("Errors were found in date values :\n"+$errmsg_.join("\n"))
		Else 
			//start of Mods_2024_01
			//update any changes of rates, RFP, NTP written , verbal to Cons Insp or Cons Rtg records
			// need to do this before saving record so we can check if any of the required fields changed
			CIR_UpdateAssgnFields
			//end of Mods_2024_01
			
			SAVE RECORD:C53([Contract Assignments:83])
			
			//update approx and actual spent in [Contracts]  
			CIR_RecalcAssgnFunds(True:C214)  //update/Save Contracts record
			
			
			CANCEL:C270
	End case 
	
End if 