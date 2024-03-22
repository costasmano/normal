If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/08/05, 12:17:12
	// ----------------------------------------------------
	// Method: Form Method: Input
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(11/30/2005 10:36:49)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(12/1/2005 16:47:30)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(12/2/2005 19:15:27)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(12/28/2005 22:19:59)
	Mods_2005_CM21
	// Modified by: costasmanousakis-(Designer)-(2/26/2007 14:43:23)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(8/20/2007 16:57:58)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(12/3/07 11:01:35)
	Mods_2007_CM_5401  //added role variables
	// Modified by: costasmanousakis-(Designer)-06/19/08, 08:37:55
	Mods_2008_CM_5403  // ("WKHRS")
	// Modified by: costasmanousakis-(Designer)-(1/3/09 22:06:30)
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 13:06:45  ` ("WKHRMODS")
	// Modified by: costasmanousakis-(Designer)-(3/20/09 08:49:27)
	Mods_2009_CM_5404  // ("WKHRMODS")
	//  `Fixed Typical percentages on page 4 to match the standard excel sheet
	// Modified by: costasmanousakis-(Designer)-(7/21/09 15:15:46)
	Mods_2009_07
	//  `Adjusted the spacing and size of the salary fields on page 1.
	// Modified by: costasmanousakis-(Designer)-(6/8/11 09:53:06)
	Mods_2011_06
	//  ` set the format of the work hour arrays to ###,##0.#;-##0.#;0 This is to facilitate when
	//  `the reviewer "zeroes" an item by entering a small hour item like 0.001
	//  `increased the ht of the hour and dollar variables in the Totals page
	Mods_2020_07  //Make sure that the input form opens with correct size
	//Modified by: CJ (7/7/20 16:23:23)
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283($WNPosLeft_L; $WNPosTop_L; $WNPosRight_L; $WNPosBottom_L; $Width_L; $Height_L)
		FORM GET PROPERTIES:C674([Work_Estimate:103]; "Input"; $Width_L; $Height_L)
		GET WINDOW RECT:C443($WNPosLeft_L; $WNPosTop_L; $WNPosRight_L; $WNPosBottom_L)
		
		
		SET WINDOW RECT:C444($WNPosLeft_L; $WNPosTop_L; $WNPosLeft_L+$Width_L; $WNPosTop_L+$Height_L)
		
		utl_SetSpellandContextMenu
		C_LONGINT:C283(WKHR_InputStatus)  //Command Replaced was o_C_INTEGER
		C_BOOLEAN:C305(WKHR_SaveRelated_B; WKHR_LockEstimate)
		C_BOOLEAN:C305(WKHR_RoleApprove_b; WKHR_RoleReview_b; WKHR_RoleDesigner_b; WKHR_OfficeEstEdit_b; WKHR_OfficeEstView_b; WKHR_OrigEstView_b)
		WKHR_SaveRelated_B:=False:C215
		InitChangeStack(1)
		If (Is new record:C668([Work_Estimate:103]))
			Inc_Sequence("WorkHrEstimate"; ->[Work_Estimate:103]WKID:1)
		End if 
		//SubSectionGrid:=1
		FORM GOTO PAGE:C247(1)
		OBJECT SET VISIBLE:C603(*; "Matrix@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "ButtonGrid@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Text @"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Title_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "GridBtnTxt_@"; False:C215)
		WKHR_InitVars
		WKHR_ZeroAll
		WKHR_CalcRates
		WKHR_LoadVariables_2
		WKHR_CalcTotals
		C_TEXT:C284($curruser_txt)
		$curruser_txt:=Current user:C182
		WKHR_RoleApprove_b:=User in group:C338($curruser_txt; "BridgeMaintAppr")
		WKHR_RoleReview_b:=User in group:C338($curruser_txt; "BridgeMaintCtrl")
		WKHR_RoleDesigner_b:=User in group:C338($curruser_txt; "ExternalDesigners")
		WKHR_OfficeEstEdit_b:=False:C215
		WKHR_OfficeEstView_b:=False:C215
		WKHR_OrigEstView_b:=False:C215
		//WKHR_InputStatus = 2:From List ; =1:From Contract Module
		//WKHR_LockEstimate = Whether Data related to the estimate are locked
		//such as 
		WKHR_LockEstimate:=(WKHR_InputStatus=1)
		C_TEXT:C284(WKHR_AssignAddenDesc_txt)
		If ([Work_Estimate:103]AddendumNo:29=0)
			WKHR_AssignAddenDesc_txt:="Assignment"
		Else 
			WKHR_AssignAddenDesc_txt:="Assignment / Addendum"
		End if 
		C_BOOLEAN:C305($ViewAver_b; $ViewOrigEst_b)
		$ViewAver_b:=False:C215
		$ViewOrigEst_b:=False:C215
		Case of 
			: ((WKHR_InputStatus=2) | (WKHR_InputStatus=1))
				Case of 
					: (WKHR_RoleDesigner_b)
						//DISABLE BUTTON(*;"bDelete@")  `disable Delete button
						OBJECT SET VISIBLE:C603(*; "bDelete@"; False:C215)
						OBJECT SET VISIBLE:C603(*; "UpdateAssignment@"; False:C215)  //Mods_2007_CM07
						WKHR_Input_LockRevBtns("Both")  //Disable approve/rev btns
						OBJECT SET VISIBLE:C603(*; "@Avr@"; $ViewAver_b)  //cannot see average values
						OBJECT SET VISIBLE:C603(*; "ReadWriteBtn"; False:C215)
						If (([Work_Estimate:103]WkHrEstReviewed:33=BMS Approved) | ([Work_Estimate:103]WkHrEstApproved:18=BMS Approved))
							//Lock it if it has been reviewed or approved
							OBJECT SET ENABLED:C1123(*; "ToolSetButton"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
							OBJECT SET ENTERABLE:C238(*; "Cons_@"; False:C215)
							WKHR_LockEstimate:=True:C214
							OBJECT SET ENABLED:C1123(*; "ClearWKHRAllBtn@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
							OBJECT SET ENABLED:C1123(*; "DeleteRowBtn"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
							OBJECT SET ENABLED:C1123(*; "AddToList"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
						End if 
						
					: (WKHR_RoleReview_b & WKHR_RoleApprove_b)
						WKHR_OfficeEstView_b:=True:C214
						WKHR_OrigEstView_b:=True:C214 & ([Work_Estimate:103]Version_L:47>0)
						$ViewAver_b:=True:C214
						$ViewOrigEst_b:=True:C214 & ([Work_Estimate:103]Version_L:47>0)
						
						If ([Work_Estimate:103]WkHrEstComplete:17)
							WKHR_AllowRevieCmts_b:=True:C214  //Mods_2007_CM12_5301
							//WKHR_Input_LockRevBtns ("")  `Mods_2011_06
						Else 
							WKHR_Input_LockRevBtns("Both")
						End if 
						WKHR_Input_SetReviewRW
						
					: (WKHR_RoleReview_b)
						WKHR_OrigEstView_b:=True:C214 & ([Work_Estimate:103]Version_L:47>0)
						WKHR_OfficeEstView_b:=True:C214
						$ViewAver_b:=True:C214
						$ViewOrigEst_b:=True:C214 & ([Work_Estimate:103]Version_L:47>0)
						
						If (([Work_Estimate:103]WkHrEstComplete:17) & Not:C34([Work_Estimate:103]WkHrEstApproved:18=BMS Approved))
							WKHR_Input_LockRevBtns("Approve")
							WKHR_AllowRevieCmts_b:=True:C214  //Mods_2007_CM12_5301
						Else 
							WKHR_Input_LockRevBtns("Both")
						End if 
						
						WKHR_Input_SetReviewRW
						
					: (WKHR_RoleApprove_b)
						WKHR_OrigEstView_b:=True:C214 & ([Work_Estimate:103]Version_L:47>0)
						WKHR_OfficeEstView_b:=True:C214
						$ViewAver_b:=True:C214
						$ViewOrigEst_b:=True:C214 & ([Work_Estimate:103]Version_L:47>0)
						If ([Work_Estimate:103]WkHrEstReviewed:33=BMS Approved)
							WKHR_Input_LockRevBtns("Review")
							WKHR_AllowRevieCmts_b:=True:C214  //Mods_2007_CM12_5301
						Else 
							WKHR_Input_LockRevBtns("Both")
						End if 
						WKHR_Input_SetReviewRW
						
					: (Current user:C182="Designer")
						//nothing here
						WKHR_OrigEstView_b:=True:C214
						WKHR_OfficeEstEdit_b:=True:C214
						WKHR_OfficeEstView_b:=True:C214
						$ViewAver_b:=True:C214
						$ViewOrigEst_b:=True:C214
					Else 
						//lock everything
						WKHR_LockEstimate:=True:C214
						OBJECT SET VISIBLE:C603(*; "bDelete@"; False:C215)
						OBJECT SET ENABLED:C1123(*; "Approve_@"; False:C215)  // Command Replaced was o_DISABLE BUTTON //disable review buttons
						OBJECT SET ENABLED:C1123(*; "Review_@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
						OBJECT SET ENTERABLE:C238(*; "Review_@"; False:C215)
						OBJECT SET ENTERABLE:C238(*; "Approve_@"; False:C215)
						OBJECT SET VISIBLE:C603(*; "@Avr@"; $ViewAver_b)  //cannot see average values
						OBJECT SET VISIBLE:C603(*; "UpdateAssignment@"; False:C215)  //Mods_2007_CM07
						OBJECT SET VISIBLE:C603(*; "ReadWriteBtn"; False:C215)
						OBJECT SET ENABLED:C1123(*; "ToolSetButton"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
						OBJECT SET ENTERABLE:C238(*; "Cons_@"; False:C215)
						OBJECT SET ENABLED:C1123(*; "ClearWKHRAllBtn@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
						OBJECT SET ENABLED:C1123(*; "DeleteRowBtn"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
						OBJECT SET ENABLED:C1123(*; "AddToList"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				End case 
				OBJECT SET VISIBLE:C603(*; "@wkhr_OffEstPgTotal@"; WKHR_OfficeEstView_b)  //view or not office est
				WKHR_OffEstEditChk_OM
		End case 
		OBJECT SET VISIBLE:C603(*; "@OrigEst@"; $ViewOrigEst_b)  //adjust view of orig est values
		WKHR_StoreOrigEngEst("INIT")
		If (WKHR_OrigEstView_b)
			WKHR_StoreOrigEngEst("LOAD")
		End if 
		If ([Work_Estimate:103]Version_L:47>0)
			OBJECT SET VISIBLE:C603(*; "PIC_@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "PIC_@Avr@"; $ViewAver_b)
			OBJECT SET VISIBLE:C603(*; "PIC_@wkhr_OffEstPgTotal@"; WKHR_OfficeEstView_b)
			OBJECT SET VISIBLE:C603(*; "PIC_@OrigEst@"; $ViewOrigEst_b)
			OBJECT SET VISIBLE:C603(*; "PIC_@Constr@"; False:C215)
			
		Else 
			OBJECT SET VISIBLE:C603(*; "PIC_@"; False:C215)
		End if 
		
	: (Form event code:C388=On Data Change:K2:15)
		Case of 
			: (FORM Get current page:C276=1)
				WKHR_CalcRates
				WKHR_CalcTotals
				
			: (FORM Get current page:C276>1)
				[Work_Estimate:103]Consultant:6:=[Work_Estimate:103]Consultant:6  //force a validate event
		End case 
		
	: (Form event code:C388=On Validate:K2:3)
		If (Is new record:C668([Work_Estimate:103]))
			LogNewRecord(->[Work_Estimate:103]WKID:1; ->[Work_Estimate:103]WKID:1; ->[Work_Estimate:103]WKID:1; 0; "WorkHrEstimate")
		End if 
		WKHR_StoreVariables_2
		PushChange(1; ->[Work_Estimate:103]WkEstValues:5)  //always save values
		FlushGrpChgs(1; ->[Work_Estimate:103]WKID:1; ->[Work_Estimate:103]WKID:1; ->[Work_Estimate:103]WKID:1; 0)
		If (WKHR_SaveRelated_B)
			//Save related assignment/addendum records
			If ([Work_Estimate:103]AddendumNo:29>0)
				SAVE RECORD:C53([Addendum_Maintenance:102])
				If (WKHR_InputStatus=2)
					//From review screen
					UNLOAD RECORD:C212([Addendum_Maintenance:102])
					READ ONLY:C145([Addendum_Maintenance:102])
				End if 
			Else 
				SAVE RECORD:C53([Contract_Assignment_Maintenance:101])
				If (WKHR_InputStatus=2)
					UNLOAD RECORD:C212([Contract_Assignment_Maintenance:101])
					READ ONLY:C145([Contract_Assignment_Maintenance:101])
				End if 
			End if 
		End if 
	: (Form event code:C388=On Unload:K2:2)
		SET CURSOR:C469(0)
End case 