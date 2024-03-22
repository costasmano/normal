If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/25/07, 12:09:52
	// ----------------------------------------------------
	// Method: Object Method: ChgInspTypeBtn
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(12/11/07 17:01:25)
	Mods_2007_CM_5401
	//More descriptive Confirm statement
	// Modified by: costasmanousakis-(Designer)-(12/17/07 09:00:16)
	Mods_2007_CM_5401
	//Don't allow inspections that are in the review process : after completion
	//Delete BMS inspections and CUS when switching from a routine type inspection
	// Modified by: costasmanousakis-(Designer)-(4/16/08 08:48:27)
	Mods_2008_CM_5403  //use method BRG_RWAccess
	// Modified by: costasmanousakis-(Designer)-(8/20/08 08:18:46)
	Mods_2008_CM_5404
	//  `Use Method INSP_UpdateInspList
	// Modified by: costasmanousakis-(Designer)-(4/10/09 11:15:11)
	Mods_2009_04
	//  `Adjusted code to use Selected record number before and after to keep the record highlighted.
	Mods_2011_06  // CJ Miller`06/20/11, 10:35:52      ` Type all local variables for v11
	// Modified by: costasmanousakis-(Designer)-(10/17/11 10:29:38)
	Mods_2011_10
	//  `Use Query({inspections]) instead of Relate Many([combined inspections]) to find the needed record
	// Modified by: costasmanousakis-(Designer)-(11/1/11 15:36:45)
	Mods_2011_11
	//  `USe global var ◊CurrentUser_Name
	// Modified by: Costas Manousakis-(Designer)-(6/20/12 14:47:50)
	Mods_2012_06
	//  `Befoire getting the cell position of the listbox, check if there is anything in the hilite set
	// Modified by: Costas Manousakis-(Designer)-(1/2/13 11:49:12)
	Mods_2013_01
	//  `Added call to ut_Read_Write_Tables ("WRITE";.. to set tables to RW before changing  type
	Mods_2013_05  //``` *** BUG FIX *****
	//  `Set name of listbox changed to LBSetBrgInsp
	// Modified by: Costas Manousakis-(Designer)-(2022-03-18 15:32:40)
	Mods_2022_03
	//Add call to Synch_ReturnForward to reset new style vsForward
	
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		Case of 
			: (Current user:C182="Designer")
				OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
			: (Not:C34(BRG_RWAccess))
				OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
			: (User in group:C338(<>CurrentUser_Name; "Inspection Leaders"))
				OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
			: (User in group:C338(<>CurrentUser_Name; "Inspection Engineers"))
				OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
			Else 
				OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End case 
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283(vbCombined; vbSpecial)  //Command Replaced was o_C_INTEGER
		C_TEXT:C284($msg1; $msg2; vTextMsg)
		C_TEXT:C284($FieldName)  // Command Replaced was o_C_STRING length was 40
		C_TEXT:C284($FieldName)  // Command Replaced was o_C_STRING length was 40
		C_TEXT:C284($vsInspType)  // Command Replaced was o_C_STRING length was 3
		C_LONGINT:C283($rec_L)
		C_LONGINT:C283($rec_L; $column_l)
		$rec_L:=Records in set:C195("LBSetBrgInsp")
		If ($rec_L>0)
			LISTBOX GET CELL POSITION:C971(*; "Inspections"; $column_l; $rec_L)
		End if 
		If ($rec_L<1) | ($rec_L>Records in selection:C76([Combined Inspections:90]))
			ALERT:C41("You must Select an Inspection first!")
		Else 
			ut_Read_Write_Tables("WRITE"; ->[Combined Inspections:90]; ->[Inspections:27]; ->[BMS Inspections:44])
			
			GOTO SELECTED RECORD:C245([Combined Inspections:90]; $rec_L)
			If (ut_LoadRecordInteractive(->[Combined Inspections:90]))
				//RELATE MANY([Combined Inspections])
				QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[Combined Inspections:90]NBISInspID:2)
				If (ut_LoadRecordInteractive(->[Inspections:27]))
					C_BOOLEAN:C305($MakeChange_b)
					$MakeChange_b:=False:C215
					Case of 
						: (<>CurrentUser_Name="Designer")
							$MakeChange_b:=True:C214
						: (([Inspections:27]InspApproved:167#0) | ([Inspections:27]InspReviewed:12#0) | [Inspections:27]InspComplete:168)
							ALERT:C41("Cannot Modify an Inspection in the review process!")
						: (User in group:C338(<>CurrentUser_Name; "Inspection Engineers"))
							$MakeChange_b:=True:C214
						: ([Inspections:27]TeamLeader:4#<>CurrentUser_PID)
							ALERT:C41("You are not the Team Leader of this inspection!")
						Else 
							$MakeChange_b:=True:C214
					End case 
					If ($MakeChange_b)
						$vsInspType:=GetInspType
						If ($vsInspType#"")
							If ($vsInspType#[Inspections:27]Insp Type:6)
								C_TEXT:C284($msg; $oldType; $newType)
								READ ONLY:C145([Inspection Type:31])
								QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=$vsInspType)
								$newType:=[Inspection Type:31]Description:2
								QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=[Inspections:27]Insp Type:6)
								$oldType:=[Inspection Type:31]Description:2
								$msg:="Change Inspection type from "+$oldType+" to "+$newType+" ?"
								If (($vsInspType="RT@") | ($vsInspType="CUL"))
									$msg:=$msg+<>sCR+"The list of safety elements and Pontis Elements will have to be "
									$msg:=$msg+"modified manually to correspond to the new inspection type!"
								End if 
								If (([Inspections:27]Insp Type:6="RT@") | ([Inspections:27]Insp Type:6="CUL"))
									If (($vsInspType#"RT@") & ($vsInspType#"CUL"))
										$msg:=$msg+<>sCR+"Any existing Pontis Elements will be deleted!"
									End if 
								End if 
								CONFIRM:C162($msg)
								If (OK=1)
									[Inspections:27]Insp Type:6:=$vsInspType
									vsForward:=Synch_ReturnForward([Bridge MHD NBIS:1]Item2:60; [Bridge MHD NBIS:1]InspResp:173; [Inspections:27]Insp Type:6; [Inspections:27]TeamLeader:4)
									
									LogChanges(->[Inspections:27]Insp Type:6; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
									SAVE RECORD:C53([Inspections:27])
									If (($vsInspType#"RT@") & ($vsInspType#"CUL"))
										If ([Combined Inspections:90]BMSInspID:3>0)
											SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
											QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
											If (Records in selection:C76([BMS Inspections:44])=1)
												QUERY:C277([Cond Units:45]; [Cond Units:45]Inspection ID:2=[BMS Inspections:44]Inspection ID:1)
												If (Records in selection:C76([Cond Units:45])>0)
													InitGrpDelete
													While (Not:C34(End selection:C36([Cond Units:45])))
														PushGrpDelete(->[Cond Units:45]Cond Unit ID:1)
														NEXT RECORD:C51([Cond Units:45])
													End while 
													FlushGrpDeletions(->[BMS Inspections:44]Inspection ID:1; ->[Cond Units:45]Inspection ID:2; ->[Cond Units:45]Cond Unit ID:1; 2)
													DELETE SELECTION:C66([Cond Units:45])
												End if 
												LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1)
												DELETE RECORD:C58([BMS Inspections:44])
											End if 
											//SET AUTOMATIC RELATIONS(True;True)
											[Combined Inspections:90]BMSInspID:3:=-1
											LogLink(->[Combined Inspections:90]BMSInspID:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1; ->[BMS Inspections:44]Inspection ID:1)
										End if 
									End if 
									[Combined Inspections:90]InspType:5:=$vsInspType
									LogChanges(->[Combined Inspections:90]InspType:5; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
									SAVE RECORD:C53([Combined Inspections:90])
								End if 
							Else 
								ALERT:C41("Inspection type chosen is same as original!")
							End if 
						End if 
					End if 
					
				Else 
					ALERT:C41("Did NOT get Write access to the Inspection record!")
				End if 
			Else 
				ALERT:C41("Did NOT get Write access to the [Combined Inspection] record!")
			End if 
			INSP_UpdateInspList
			GOTO SELECTED RECORD:C245([Combined Inspections:90]; $rec_L)
		End if 
End case 