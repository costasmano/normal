If (False:C215)
	//Form Method: [Conslt Rating];"Cslt Rating In"
	ARRAY TEXT:C222(cboConsRatPriority; 0)
	ARRAY TEXT:C222(cboConsRatLevel; 0)
	ARRAY TEXT:C222(cboContractType; 0)
	ARRAY TEXT:C222(cboConsRatsource; 0)
	ARRAY TEXT:C222(cboConsRatColor; 0)
	ARRAY TEXT:C222(cboAssignmentStatus; 0)
	
	Mods_2004_CM12
	// Modified by: costasmanousakis-(Designer)-(12/7/2005 12:37:42)
	Mods_2005_CM20
	// Modified by: costasmanousakis-(Designer)-(12/21/2005 15:24:09)
	Mods_2005_CM20
	// Modified by: costasmanousakis-(Designer)-(1/3/2007 10:00:19) 
	Mods_2007_CM01
	// Modified by: costasmanousakis-(Designer)-(9/19/2007 09:08:52)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/31/2007 14:09:00)
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(11/10/08 11:05:47)
	Mods_2008_CM_5404
	//  `Use method CIR_GetRates
	// Modified by: costasmanousakis-(Designer)-(6/9/10 09:37:13)
	Mods_2010_06
	//  `Added code to adjust form window size when loading the form
	//  `Also changed the form resize properties,  and added a new header bar
	//  `Added the option for a White rating : Gusset plate rating
	// Modified by: costasmanousakis-(Designer)-(9/17/10 10:42:33)
	Mods_2010_09
	//  `Added option "Review" to cboContractType
	// Modified by: costasmanousakis-(Designer)-(10/8/10 10:33:20)
	Mods_2010_10
	//  `Added a 5th page for the review section and a tab control to direct the users to the
	//  `proper page.
	// Modified by: costasmanousakis-(Designer)-(12/10/10 11:20:18)
	Mods_2010_12
	//  `Added checkbox CRTG_AutoCalc_L and adjusted the code in the Actual Costs
	//  `Salary, Indirect Cost and Net Fee objects to not do calculations based on the overhead rates
	//  `if the checkbox is checked;
	//  `Also adjusted location, size and display format of the objects on negotiated and actual pages
	// Modified by: costasmanousakis-(Designer)-(1/14/11 16:52:31)
	Mods_2011_01
	//  `added missing ENABLE BUTTON(*;"CRTG_PageTab@") when read-only
	// Modified by: costasmanousakis-(Designer)-(9/28/11 14:27:30)
	Mods_2011_09
	//  `Added new fields [Conslt Rating]DateReceivedByROUnit1,2,3,4 [Conslt Rating]NBISLetterPostStatus_s
	//  `and a drop down to populate the NBISLetterPostStatus_s
	//  `Adjusted the size of the form
	// Modified by: costasmanousakis-(Designer)-(10/3/11 10:18:14)
	Mods_2011_10
	//  `Named the object for NBISLetterPostStatus_s to "Display9".  since it was not named like that it would not display when
	//  `the pulldown was clicked the first time; it required a second click.
	// Modified by: Costas Manousakis-(Designer)-(5/7/12 11:58:20)
	Mods_2012_05
	//  `Adjusted form margins from 0 horiz to 19
	// Modified by: Costas Manousakis-(Designer)-(11/5/12 11:35:41)
	Mods_2012_11
	//  `Re-arranged delete, save and cancel buttons to put more space between them
	// Modified by: Costas Manousakis-(Designer)-(2/24/16 11:49:31)
	Mods_2016_02_bug
	//  `moved CRTGMaintTools button in page 5 to a better spot.
	// Modified by: Costas Manousakis-(Designer)-(8/30/16 16:44:49)
	Mods_2016_08
	//  `made sure comments/remarks  fields on pages  2,3 ,4 are set to grow vertical and  have vertical scroll bar - 
	//  `also increased vert size 
	// Modified by: Costas Manousakis-(Designer)-(3/25/19 17:01:04)
	Mods_2019_03_bug
	//  `enabled on data change event in form events; added code to handle when costs were changed -CallReference #623
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		C_BOOLEAN:C305(vbNewRtgRec)
		C_TEXT:C284($CurrUser_txt)
		$CurrUser_txt:=Current user:C182
		CIR_GetRates([Conslt Rating:63]ContractNoRat:14; [Conslt Rating:63]AssignNoRat:12)
		
		OBJECT SET VISIBLE:C603(*; "costsDIR_@"; False:C215)
		Case of 
			: ((User in group:C338($CurrUser_txt; "Conslt Rating - ReadWrite")) | ($CurrUser_txt="Designer"))
				CRTG_LoadReviewerLists
				InitChangeStack(1)
				If (Is new record:C668([Conslt Rating:63]))
					If (vbNewRtgRec=False:C215)
						vbNewRtgRec:=True:C214
						[Conslt Rating:63]BIN:1:=[Bridge MHD NBIS:1]BIN:3
						Inc_Sequence("ConsRtg"; ->[Conslt Rating:63]ConsltRatingID:42)
						CREATE RECORD:C68([Conslt Rating Cost:74])
						[Conslt Rating Cost:74]ConsltRatingID:1:=[Conslt Rating:63]ConsltRatingID:42
						SAVE RECORD:C53([Conslt Rating Cost:74])
					Else 
						vbNewRtgRec:=False:C215
						CANCEL:C270
					End if 
				Else 
					vbNewRtgRec:=False:C215
				End if 
				If (User in group:C338($CurrUser_txt; "Bridge Insp Engineer"))
					OBJECT SET ENABLED:C1123(*; "cboAssignmentStatus"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
					QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="ConsRtgStatus")
				Else 
					OBJECT SET ENABLED:C1123(*; "cboAssignmentStatus"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
					QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="ConsRtgStatus"; *)
					QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListSequence_l:3=0)
				End if 
				ORDER BY:C49([TableOfLists:125]; [TableOfLists:125]ListSequence_l:3; >; [TableOfLists:125]ListValue_s:2; >)
				SELECTION TO ARRAY:C260([TableOfLists:125]ListValue_s:2; cboFillRtgStatus)
				CRTG_ToolBox_OM(Form event code:C388)
				RELATE MANY:C262([Conslt Rating:63])
				FIRST RECORD:C50([Conslt Rating Cost:74])
				ut_LoadRecordInteractive(->[Conslt Rating Cost:74])
				
			: (Read only state:C362([Conslt Rating:63]))
				OBJECT SET ENTERABLE:C238(*; "costs@"; False:C215)
				OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
				OBJECT SET RGB COLORS:C628(*; "@Field@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "@Field@"; <>Color_Not_Editable)
				
				OBJECT SET VISIBLE:C603(*; "costs@"; False:C215)
				OBJECT SET ENABLED:C1123(*; "@@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(*; "btnCancel@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENABLED:C1123(*; "btnPrint@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENABLED:C1123(*; "CRTG_PageTab@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENABLED:C1123(*; "DE @"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				
			: (User in group:C338($CurrUser_txt; "Conslt Rating - ReadOnly"))
				
				OBJECT SET ENTERABLE:C238(*; "costs@"; False:C215)
				
				InitChangeStack(1)
				If (Is new record:C668([Conslt Rating:63]))
					If (vbNewRtgRec=False:C215)
						vbNewRtgRec:=True:C214
						[Conslt Rating:63]BIN:1:=[Bridge MHD NBIS:1]BIN:3
						Inc_Sequence("ConsRtg"; ->[Conslt Rating:63]ConsltRatingID:42)
						CREATE RECORD:C68([Conslt Rating Cost:74])
						[Conslt Rating Cost:74]ConsltRatingID:1:=[Conslt Rating:63]ConsltRatingID:42
						SAVE RECORD:C53([Conslt Rating Cost:74])
					Else 
						vbNewRtgRec:=False:C215
						CANCEL:C270
					End if 
				Else 
					vbNewRtgRec:=False:C215
				End if 
				RELATE MANY:C262([Conslt Rating:63])
				FIRST RECORD:C50([Conslt Rating Cost:74])
				
				
			Else   //``` Case Else
				
				If (Is new record:C668([Conslt Rating:63]))
					CANCEL:C270
				Else 
					OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
					OBJECT SET VISIBLE:C603(*; "costs@"; False:C215)
					OBJECT SET ENABLED:C1123(*; "@@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
					OBJECT SET ENABLED:C1123(*; "btnCancel@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
					OBJECT SET ENABLED:C1123(*; "btnPrint@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
					OBJECT SET ENABLED:C1123(*; "DE @"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
					OBJECT SET ENABLED:C1123(*; "CRTG_PageTab@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
					//SET VISIBLE(*;"DE btnDelete@";False)
				End if 
		End case 
		C_LONGINT:C283($CurrL_L; $CurrT_L; $CurrR_L; $CurrB_L; $FormW_L; $FormH_L; $CurrW_L; $CurrH_L)
		GET WINDOW RECT:C443($CurrL_L; $CurrT_L; $CurrR_L; $CurrB_L)
		$CurrW_L:=$CurrR_L-$CurrL_L
		$CurrH_L:=$CurrB_L-$CurrT_L
		C_TEXT:C284($CurrForm_txt)
		$CurrForm_txt:=Current method name:C684
		$CurrForm_txt:=Replace string:C233($CurrForm_txt; Table name:C256(Current form table:C627); "")
		$CurrForm_txt:=Substring:C12($CurrForm_txt; 4)
		FORM GET PROPERTIES:C674(Current form table:C627->; $CurrForm_txt; $FormW_L; $FormH_L)
		C_BOOLEAN:C305($Resize_b)
		$Resize_b:=($CurrW_L<$FormW_L) | ($CurrH_L<$FormH_L)
		If ($Resize_b)
			If ($CurrW_L<$FormW_L)
				$CurrR_L:=$FormW_L-$CurrW_L
			Else 
				$CurrR_L:=0
			End if 
			If ($CurrH_L<$FormH_L)
				$CurrB_L:=$FormH_L-$CurrH_L
			Else 
				$CurrB_L:=0
			End if 
			RESIZE FORM WINDOW:C890($CurrR_L; $CurrB_L)
		End if 
		
		//start of Mods_2024_01
		
		C_OBJECT:C1216($contracts_o)
		$contracts_o:=ds:C1482.Contracts.query("ContractType =  :1 & ContractStatus = :2"; "@rating@"; "open").orderByFormula("num(this.ContractNo)"; dk ascending:K85:31)
		
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
		$loop_L:=Find in array:C230($stat_atxt; ([Conslt Rating:63]ContractNoRat:14+" @"))
		
		If ($loop_L>0)
			$contrdrpdwn_ptr->:=$loop_L
		End if 
		
		//get non-zero assigments for the contract
		ARRAY LONGINT:C221($assignments_aL; 0)
		
		If ([Conslt Rating:63]ContractNoRat:14#"")
			C_OBJECT:C1216($assignments_o)
			$assignments_o:=ds:C1482["Contract Assignments"].query("ContractNo = :1 & AssignNo > 0"; [Conslt Rating:63]ContractNoRat:14).orderBy("AssignNo DESC")
			
			If ($assignments_o.length>0)
				
				COLLECTION TO ARRAY:C1562($assignments_o.toCollection("AssignNo"); $assignments_aL; "AssignNo")
			End if 
			
		End if 
		COPY ARRAY:C226($assignments_aL; $assigndrpdwn_ptr->)
		$assigndrpdwn_ptr->:=0
		$loop_L:=Find in array:C230($assignments_aL; [Conslt Rating:63]AssignNoRat:12)
		
		If ($loop_L>0)
			$assigndrpdwn_ptr->:=$loop_L
		End if 
		
		If ((User in group:C338(Current user:C182; "Conslt Rating - ReadWrite")) | (Current user:C182="Designer"))
			
			//see if we need to update values from the contract/assignment if we have any
			C_OBJECT:C1216($contrassign_o)
			$contrassign_o:=ds:C1482[Table name:C256(->[Contract Assignments:83])].query("ContractNo = :1 & AssignNo = :2"; [Conslt Rating:63]ContractNoRat:14; [Conslt Rating:63]AssignNoRat:12)
			If ($contrassign_o.length=1)
				//update dates
				
				[Conslt Rating:63]ReqFeeProposal:30:=$contrassign_o[0].ReqFeeProposalDate
				[Conslt Rating:63]ProceedRat:10:=$contrassign_o[0].NTPdate_written
				[Conslt Rating:63]NTPdate_verbal:50:=$contrassign_o[0].NTPdate_verbal
				// also need to update costs in [Conslt Rating Cost]` 
				//  [Conslt Rating Cost] record is saved in the Save button object method
				If ((netFeeRate#0) & (overheadRate#0))
					[Conslt Rating Cost:74]Neg IndirectCost:4:=[Conslt Rating Cost:74]Neg Salary:3*overheadRate/100
					[Conslt Rating Cost:74]Neg NetFee:5:=([Conslt Rating Cost:74]Neg Salary:3+[Conslt Rating Cost:74]Neg IndirectCost:4)*netFeeRate/100
					[Conslt Rating Cost:74]Act IndirectCost:39:=[Conslt Rating Cost:74]Act Salary:21*overheadRate/100
					[Conslt Rating Cost:74]Act NetFee:22:=([Conslt Rating Cost:74]Act Salary:21+[Conslt Rating Cost:74]Act IndirectCost:39)*netFeeRate/100
				End if 
				
				[Conslt Rating Cost:74]Neg TotalLimitFee:6:=[Conslt Rating Cost:74]Neg Salary:3+[Conslt Rating Cost:74]Neg IndirectCost:4+[Conslt Rating Cost:74]Neg NetFee:5
				[Conslt Rating Cost:74]Neg TotalCost:18:=[Conslt Rating Cost:74]Neg TotalLimitFee:6+[Conslt Rating Cost:74]Neg TotalDirectCost:17
				
				[Conslt Rating Cost:74]Act TotalLimitFee:23:=[Conslt Rating Cost:74]Act Salary:21+[Conslt Rating Cost:74]Act IndirectCost:39+[Conslt Rating Cost:74]Neg NetFee:5
				[Conslt Rating Cost:74]Act TotalCost:35:=[Conslt Rating Cost:74]Act TotalLimitFee:23+[Conslt Rating Cost:74]Act TotalDirectCost:34
				//check one of the totals.
				// if there was a change in the rates , only need to check one of the totals
				If ([Conslt Rating Cost:74]Neg TotalCost:18#Old:C35([Conslt Rating Cost:74]Neg TotalCost:18))
					ALERT:C41("Costs have been updated due to changes in rates of the assignment. You must Save this record for the updates to be saved.")
				End if 
				
			End if 
			
		End if 
		// end of Mods_2024_01
		
	: (Form event code:C388=On Validate:K2:3)
		FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Conslt Rating:63]BIN:1; ->[Conslt Rating:63]ConsltRatingID:42; 1)
		If (Modified record:C314([Conslt Rating Cost:74]))
			SAVE RECORD:C53([Conslt Rating Cost:74])
		End if 
		
	: (Form event code:C388=On Unload:K2:2)
		OBJECT SET ENABLED:C1123(*; "@@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		UNLOAD RECORD:C212([Conslt Rating Cost:74])
		
	: (Form event code:C388=On Data Change:K2:15)
		
		If (Modified record:C314([Conslt Rating Cost:74]) & Not:C34(Modified record:C314([Conslt Rating:63])))
			//if the costs were modified, force the validate event.
			[Conslt Rating:63]ProjManager:27:=[Conslt Rating:63]ProjManager:27
		End if 
End case 