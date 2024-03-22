If (False:C215)
	//Form method [Cons Inspection];"Cslt Insp In"
	
	// Modified by: costasmanousakis-(Designer)-(12/7/2005 14:52:11)
	Mods_2005_CM20
	// Modified by: costasmanousakis-(Designer)-(4/3/2006 12:42:59)
	Mods_2006_CM03
	// Modified by: ManousakisC (4/24/2006)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(4/17/2007 08:51:05)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(10/31/2007 14:31:25)
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(12/10/10 11:20:18)
	Mods_2010_12
	//  `Added checkbox CRTG_AutoCalc_L and adjusted the code in the Actual Costs
	//  `Salary, Indirect Cost and Net Fee objects to not do calculations based on the overhead rates
	//  `if the checkbox is checked;
	//  `Also adjusted location, size and display format of the objects on negotiated and actual pages
	// Modified by: Costas Manousakis-(Designer)-(11/5/12 11:38:15)
	Mods_2012_11
	//  `Re arranged nav, del, cancel, save buttons to allow more space between them 
	// Modified by: Costas Manousakis-(Designer)-(8/24/16 14:27:15)
	Mods_2016_08
	//  `assigned "Enter" key to the save button - otherwise costs were not saved
	// Modified by: Costas Manousakis-(Designer)-(8/30/16 16:41:46)
	Mods_2016_08
	//  `made remarks/comments fields to resize veritcal - added vertical scroll bar - also Rectangle2 on page 1 to grow vertical
	// Modified by: Costas Manousakis-(Designer)-(3/25/19 17:01:04)
	Mods_2019_03_bug
	//  `enabled on data change event in form events; added code to handle when costs were changed  -CallReference #623
	// Modified by: Costas Manousakis-(Designer)-(2024-01-08 15:56:20)
	Mods_2024_01
	//  `removed accept action from save button
	//  `added dropdowns for contract no and assignment. 
	//  `made fields [Cons Inspection]ConContractNo [Cons Inspection]AssignConNumber [Cons Inspection]ReqFeeProposal
	//  ` [Cons Inspection]NTPdate_verbal [Cons Inspection]ProceedConDate  not enterable and transparent and deleted object methods.
	//  `added definition of dropdowns On Load for contract num and assignment num by searching for open inspection contracts.
	//  //Move code in On Validate to the Save button
	
End if 

//6/2003: Modified to add cost data
//8/2003: Added vbNewInspRec

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		C_BOOLEAN:C305(vbNewInspRec)
		
		CIR_GetRates([Cons Inspection:64]ConContractNo:7; [Cons Inspection:64]AssignConNumber:6)
		
		OBJECT SET VISIBLE:C603(*; "costsDIR_@"; False:C215)
		Case of 
			: (User in group:C338(Current user:C182; "Conslt Rating - ReadOnly"))
				
				OBJECT SET ENTERABLE:C238(*; "costs@"; False:C215)
				
				InitChangeStack(1)
				If (Is new record:C668([Cons Inspection:64]))
					If (vbNewInspRec=False:C215)
						vbNewInspRec:=True:C214
						[Cons Inspection:64]BIN:1:=[Bridge MHD NBIS:1]BIN:3  //```````````````
						Inc_Sequence("ConsInsp"; ->[Cons Inspection:64]ConsInspectionID:32)
						CREATE RECORD:C68([Cons Inspection Cost:76])
						[Cons Inspection Cost:76]ConsInspectionID:1:=[Cons Inspection:64]ConsInspectionID:32
						SAVE RECORD:C53([Cons Inspection Cost:76])
					Else 
						vbNewInspRec:=False:C215
						CANCEL:C270
					End if 
				Else 
					vbNewInspRec:=False:C215
				End if 
				RELATE MANY:C262([Cons Inspection:64])
				FIRST RECORD:C50([Cons Inspection Cost:76])
				
			: ((User in group:C338(Current user:C182; "Conslt Rating - ReadWrite")) | (Current user:C182="Designer"))
				
				InitChangeStack(1)
				If (Is new record:C668([Cons Inspection:64]))
					If (vbNewInspRec=False:C215)
						vbNewInspRec:=True:C214
						[Cons Inspection:64]BIN:1:=[Bridge MHD NBIS:1]BIN:3  //```````````````
						Inc_Sequence("ConsInsp"; ->[Cons Inspection:64]ConsInspectionID:32)
						CREATE RECORD:C68([Cons Inspection Cost:76])
						[Cons Inspection Cost:76]ConsInspectionID:1:=[Cons Inspection:64]ConsInspectionID:32
						SAVE RECORD:C53([Cons Inspection Cost:76])
					Else 
						vbNewInspRec:=False:C215
						CANCEL:C270
					End if 
				Else 
					vbNewInspRec:=False:C215
				End if 
				RELATE MANY:C262([Cons Inspection:64])
				FIRST RECORD:C50([Cons Inspection Cost:76])
				ut_LoadRecordInteractive(->[Cons Inspection Cost:76])
				//````````````````````Default value of Proj Manager = Current user
				If ((Uppercase:C13(Current user:C182)="BRUCE SYLVIA") & ([Cons Inspection:64]ProjManager:26=""))
					[Cons Inspection:64]ProjManager:26:="BJS"
				End if 
				If (User in group:C338(Current user:C182; "Bridge Insp Engineer"))
					OBJECT SET ENABLED:C1123(*; "cboAssignmentStatus"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				Else 
					OBJECT SET ENABLED:C1123(*; "cboAssignmentStatus"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				End if 
				
			Else   //``` Case Else
				
				If (Is new record:C668([Cons Inspection:64]))
					CANCEL:C270
				Else 
					OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
					OBJECT SET VISIBLE:C603(*; "costs@"; False:C215)
					_O_OBJECT SET COLOR:C271(*; "Field@"; <>Color_Not_editable)
					//DISABLE BUTTON(*;"@@")
					OBJECT SET ENABLED:C1123(*; "btnCancel@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
					OBJECT SET ENABLED:C1123(*; "btnPrint@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
					OBJECT SET ENABLED:C1123(*; "DE @"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
					//SET VISIBLE(*;"DE btnDelete@";False)
				End if 
		End case 
		
		//form event=on load
		C_LONGINT:C283(vMonth; vYear)  //Command Replaced was o_C_INTEGER
		vMonth:=Month of:C24([Cons Inspection:64]InspMonth:34)
		vYear:=Year of:C25([Cons Inspection:64]InspMonth:34)
		
		//start of Mods_2024_01
		
		C_OBJECT:C1216($contracts_o)
		$contracts_o:=ds:C1482.Contracts.query("ContractType =  :1 & ContractStatus = :2"; "@insp@"; "open").orderByFormula("num(this.ContractNo)"; dk ascending:K85:31)
		
		ARRAY TEXT:C222($contr_atxt; 0)
		ARRAY TEXT:C222($stat_atxt; 0)
		ARRAY TEXT:C222($cons_atxt; 0)
		COLLECTION TO ARRAY:C1562($contracts_o.toCollection("ContractNo, ContractType, ConsltName"); \
			$contr_atxt; "ContractNo"; $stat_atxt; "ContractType"; $cons_atxt; "ConsltName")
		
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($stat_atxt))
			$stat_atxt{$loop_L}:=$contr_atxt{$loop_L}+" - "+$stat_atxt{$loop_L}+" "+$cons_atxt{$loop_L}
		End for 
		
		C_POINTER:C301($contrdrpdwn_ptr; $assigndrpdwn_ptr)
		$contrdrpdwn_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "DE contrno_list")
		$assigndrpdwn_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "DE assign_list")
		COPY ARRAY:C226($stat_atxt; $contrdrpdwn_ptr->)
		$loop_L:=Find in array:C230($stat_atxt; ([Cons Inspection:64]ConContractNo:7+" @"))
		
		If ($loop_L>0)
			$contrdrpdwn_ptr->:=$loop_L
		End if 
		
		//get non-zero assigments for the contract
		ARRAY LONGINT:C221($assignments_aL; 0)
		
		If ([Cons Inspection:64]ConContractNo:7#"")
			C_OBJECT:C1216($assignments_o)
			$assignments_o:=ds:C1482["Contract Assignments"].query("ContractNo = :1 & AssignNo > 0"; [Cons Inspection:64]ConContractNo:7).orderBy("AssignNo DESC")
			
			If ($assignments_o.length>0)
				
				COLLECTION TO ARRAY:C1562($assignments_o.toCollection("AssignNo"); $assignments_aL; "AssignNo")
				
			End if 
			
			
		End if 
		COPY ARRAY:C226($assignments_aL; $assigndrpdwn_ptr->)
		$assigndrpdwn_ptr->:=0
		$loop_L:=Find in array:C230($assignments_aL; [Cons Inspection:64]AssignConNumber:6)
		
		If ($loop_L>0)
			$assigndrpdwn_ptr->:=$loop_L
		End if 
		
		If ((User in group:C338(Current user:C182; "Conslt Rating - ReadWrite")) | User in group:C338(Current user:C182; "Design Access Group"))
			
			//see if we need to update values from the contract/assignment if we have any
			C_OBJECT:C1216($contrassign_o)
			$contrassign_o:=ds:C1482[Table name:C256(->[Contract Assignments:83])].query("ContractNo = :1 & AssignNo = :2"; [Cons Inspection:64]ConContractNo:7; [Cons Inspection:64]AssignConNumber:6)
			If ($contrassign_o.length=1)
				//update dates
				
				[Cons Inspection:64]ReqFeeProposal:25:=$contrassign_o[0].ReqFeeProposalDate
				[Cons Inspection:64]ProceedConDate:8:=$contrassign_o[0].NTPdate_written
				[Cons Inspection:64]NTPdate_verbal:35:=$contrassign_o[0].NTPdate_verbal
				// also need to update costs in [Cons Inspection Cost]` 
				//  [Cons Inspection Cost] record is saved in the Save button object method
				If ((netFeeRate#0) & (overheadRate#0))
					[Cons Inspection Cost:76]Neg IndirectCost:4:=[Cons Inspection Cost:76]Neg Salary:3*overheadRate/100
					[Cons Inspection Cost:76]Neg NetFee:5:=([Cons Inspection Cost:76]Neg Salary:3+[Cons Inspection Cost:76]Neg IndirectCost:4)*netFeeRate/100
					[Cons Inspection Cost:76]Act IndirectCost:23:=[Cons Inspection Cost:76]Act Salary:22*overheadRate/100
					[Cons Inspection Cost:76]Act NetFee:24:=([Cons Inspection Cost:76]Act Salary:22+[Cons Inspection Cost:76]Act IndirectCost:23)*netFeeRate/100
				End if 
				
				[Cons Inspection Cost:76]Neg TotalLimitFee:6:=[Cons Inspection Cost:76]Neg Salary:3+[Cons Inspection Cost:76]Neg IndirectCost:4+[Cons Inspection Cost:76]Neg NetFee:5
				[Cons Inspection Cost:76]Neg TotalCost:19:=[Cons Inspection Cost:76]Neg TotalLimitFee:6+[Cons Inspection Cost:76]Neg TotalDirectCost:18
				
				[Cons Inspection Cost:76]Act TotalLimitFee:25:=[Cons Inspection Cost:76]Act Salary:22+[Cons Inspection Cost:76]Act IndirectCost:23+[Cons Inspection Cost:76]Act NetFee:24
				[Cons Inspection Cost:76]Act TotalCost:38:=[Cons Inspection Cost:76]Act TotalLimitFee:25+[Cons Inspection Cost:76]Act TotalDirectCost:37
				
				//check one of the totals.
				// if there was a change in the rates , only need to check one of the totals
				If ([Cons Inspection Cost:76]Neg TotalCost:19#Old:C35([Cons Inspection Cost:76]Neg TotalCost:19))
					ALERT:C41("Costs have been updated due to changes in rates of the assignment. You must Save this record for the updates to be saved.")
				End if 
				
			End if 
			
		End if 
		
		// end of Mods_2024_01
		
		OBJECT SET ENTERABLE:C238([Cons Inspection:64]InspRecvd_ME:37; False:C215)
		CIR_InitInspTypeChkboxes
		
	: (Form event code:C388=On Validate:K2:3)
		
	: (Form event code:C388=On Unload:K2:2)
		OBJECT SET ENABLED:C1123(*; "@@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		UNLOAD RECORD:C212([Cons Inspection Cost:76])
		
	: (Form event code:C388=On Data Change:K2:15)
		
		If (Modified record:C314([Cons Inspection Cost:76]) & Not:C34(Modified record:C314([Cons Inspection:64])))
			//if the costs were modified, force the validate event.
			[Cons Inspection:64]ProjManager:26:=[Cons Inspection:64]ProjManager:26
		End if 
End case 