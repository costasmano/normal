//%attributes = {"invisible":true}
//Method: SIA_ControlDoubleClick
//Description
// Handles double-click events on the listboxes on various pages in the Bridge Input form
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//----------------------------------------------------
	//User name (OS): Charles Miller
	//Date and time: 02/23/12, 13:37:29
	//----------------------------------------------------
	Mods_2012_02  //r003
	//Modified by: Charles Miller (2/23/12 13:37:30)
	Mods_2012_03  //r003 `Add code to use list box for Inventory button on 
	//Modified by: Charles Miller (3/29/12 14:14:36)
	// Modified by: Costas Manousakis-(Designer)-(5/3/12 09:15:54)
	Mods_2012_05
	//  `Moved SIA_ReleaseBridgeRec at the end to apply to all cases;
	//  `Changed sort order of Bridge design to descending (<)
	//  `Added vApproveLvl - Cannot approve inspections from this point of entry.
	//  `Use INSP_UpdateInspList to re load the list of inspections
	// Modified by: Costas Manousakis-(Designer)-(5/18/12 10:06:37)
	Mods_2012_05
	//  `Added var $SortOrder_txt; fixed bug in the [RatingReports]
	// Modified by: Costas Manousakis-(Designer)-(6/8/12 15:00:47)
	Mods_2012_06
	//  `Had to hard code the Sort Order; $SortOrder_txt was not an acceptable argument type 
	// Modified by: Costas Manousakis-(Designer)-(1/2/13 12:58:34)
	Mods_2013_01
	//  `Added call to ut_Read_Write_Tables ("WRITE";.. to set tables to RW before opening
	// Modified by: Costas Manousakis-(Designer)-(4/16/13 11:44:39)
	Mods_2013_04
	//Tunnels Page 11
	// Modified by: Costas Manousakis-(Designer)-(5/22/13 16:36:57)
	Mods_2013_05
	//  `replaced ut_Read_Write_Tables with  INSP_Read_Write_Tables
	Mods_2013_05  //``` *** BUG FIX *****
	//  `Set name of listbox changed to LBSetBrgInsp for bridge inspections, LBSetTunnelInsp for Tunnel inspections
	// Modified by: Costas Manousakis-(Designer)-(2/26/14 12:57:56)
	Mods_2014_02
	//  `Added page 12 - Rating requests
	// Modified by: Costas Manousakis-(Designer)-(5/23/14 15:42:31)
	Mods_2014_05
	//  `set Read Write / Read Only for Secondary records according to privileges
	// Modified by: Costas Manousakis-(Designer)-(6/6/14 14:33:41)
	Mods_2014_06_bug
	//  `Load the TunnelInfo record  as RO after closing a Tunnel inspection
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
	// Modified by: Costas Manousakis-(Designer)-(10/22/19 16:23:20)
	Mods_2019_10_bug
	//  `Sort rating reports by report date, NBIS letter date and Report ID  CallReference #662
End if 
C_TEXT:C284($FormName_txt; $LbName_txt)
C_POINTER:C301($Table_ptr; $BInFld_ptr; $SortFld_ptr)
C_LONGINT:C283($column_l; $row_l)
C_TEXT:C284($SortOrder_txt)  // **Replaced old C_STRING length 1
Case of 
	: (FORM Get current page:C276=2)  //[Cons Inspection]
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			$FormName_txt:="Cslt Insp In"
			$Table_ptr:=->[Cons Inspection:64]
			$BInFld_ptr:=->[Cons Inspection:64]BIN:1
			$SortFld_ptr:=->[Cons Inspection:64]InspMonth:34
			$SortOrder_txt:="<"
			$LbName_txt:="ConsutantInspections"
			FORM SET INPUT:C55($Table_ptr->; $FormName_txt)
			LISTBOX GET CELL POSITION:C971(*; $LbName_txt; $column_l; $row_l)
			If ($row_l<1) | ($row_l>Records in selection:C76($Table_ptr->))
				InDoubleClick_B:=False:C215
			Else 
				GOTO SELECTED RECORD:C245($Table_ptr->; $row_l)
				
				If (Read only state:C362($Table_ptr->))
					LOAD RECORD:C52($Table_ptr->)
					DIALOG:C40($Table_ptr->; $FormName_txt)
				Else 
					$row_l:=ut_LoadRecordInteractiveV2($Table_ptr)
					
					Case of 
						: ($row_l=1)
							MODIFY RECORD:C57($Table_ptr->)
						: ($row_l=2)
							READ ONLY:C145($Table_ptr->)
							DIALOG:C40($Table_ptr->; $FormName_txt)
					End case 
					
				End if 
				InDoubleClick_B:=False:C215
				QUERY:C277($Table_ptr->; $BInFld_ptr->=[Bridge MHD NBIS:1]BIN:3)
				ORDER BY:C49($Table_ptr->; $SortFld_ptr->; <)
				UNLOAD RECORD:C212($Table_ptr->)
			End if 
			
		End if 
		
	: (FORM Get current page:C276=3)  //[Conslt Rating]
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			$FormName_txt:="Cslt Rating In"
			$Table_ptr:=->[Conslt Rating:63]
			$BInFld_ptr:=->[Conslt Rating:63]BIN:1
			$SortFld_ptr:=->[Conslt Rating:63]ReportDate:64
			$SortOrder_txt:="<"
			$LbName_txt:="ConsutantRatings"
			
			FORM SET INPUT:C55($Table_ptr->; $FormName_txt)
			LISTBOX GET CELL POSITION:C971(*; $LbName_txt; $column_l; $row_l)
			If ($row_l<1) | ($row_l>Records in selection:C76($Table_ptr->))
				InDoubleClick_B:=False:C215
			Else 
				GOTO SELECTED RECORD:C245($Table_ptr->; $row_l)
				
				If (Read only state:C362($Table_ptr->))
					LOAD RECORD:C52($Table_ptr->)
					DIALOG:C40($Table_ptr->; $FormName_txt)
				Else 
					$row_l:=ut_LoadRecordInteractiveV2($Table_ptr)
					
					Case of 
						: ($row_l=1)
							MODIFY RECORD:C57($Table_ptr->)
						: ($row_l=2)
							READ ONLY:C145($Table_ptr->)
							DIALOG:C40($Table_ptr->; $FormName_txt)
					End case 
				End if 
				InDoubleClick_B:=False:C215
				QUERY:C277($Table_ptr->; $BInFld_ptr->=[Bridge MHD NBIS:1]BIN:3)
				ORDER BY:C49($Table_ptr->; $SortFld_ptr->; <)
				UNLOAD RECORD:C212($Table_ptr->)
				
			End if 
			
		End if 
		
	: (FORM Get current page:C276=4)  //[RatingReports]
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			$Table_ptr:=->[RatingReports:65]
			$FormName_txt:="RatReportsIn"
			$BInFld_ptr:=->[RatingReports:65]BIN:1
			$SortFld_ptr:=->[RatingReports:65]ReportDate:4
			$LbName_txt:="RatingReports"
			$SortOrder_txt:="<"
			
			FORM SET INPUT:C55($Table_ptr->; $FormName_txt)
			LISTBOX GET CELL POSITION:C971(*; $LbName_txt; $column_l; $row_l)
			If ($row_l<1) | ($row_l>Records in selection:C76($Table_ptr->))
				InDoubleClick_B:=False:C215
			Else 
				GOTO SELECTED RECORD:C245($Table_ptr->; $row_l)
				
				If (Read only state:C362($Table_ptr->))
					LOAD RECORD:C52($Table_ptr->)
					DIALOG:C40($Table_ptr->; $FormName_txt)
				Else 
					$row_l:=ut_LoadRecordInteractiveV2($Table_ptr)
					
					Case of 
						: ($row_l=1)
							MODIFY RECORD:C57($Table_ptr->)
						: ($row_l=2)
							READ ONLY:C145($Table_ptr->)
							DIALOG:C40($Table_ptr->; $FormName_txt)
					End case 
				End if 
				InDoubleClick_B:=False:C215
				QUERY:C277($Table_ptr->; $BInFld_ptr->=[Bridge MHD NBIS:1]BIN:3)
				ORDER BY:C49($Table_ptr->; $SortFld_ptr->; <; [RatingReports:65]NBIS_Letter_d:36; <; [RatingReports:65]RatingID:21; <)
				
				UNLOAD RECORD:C212($Table_ptr->)
				LB_Header1_l:=2
				
			End if 
		End if 
		
		
	: (FORM Get current page:C276=5)  //[NBIS Secondary]
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			$FormName_txt:="2nd In"
			$Table_ptr:=->[NBIS Secondary:3]
			$BInFld_ptr:=->[NBIS Secondary:3]BIN:1
			$SortFld_ptr:=->[NBIS Secondary:3]Item5:4
			$SortOrder_txt:=">"
			$LbName_txt:="Secondary"
			
			FORM SET INPUT:C55($Table_ptr->; $FormName_txt)
			LISTBOX GET CELL POSITION:C971(*; $LbName_txt; $column_l; $row_l)
			If ($row_l<1) | ($row_l>Records in selection:C76($Table_ptr->))
				InDoubleClick_B:=False:C215
			Else 
				If (Not:C34(User in group:C338(<>CurrentUser_Name; "SIA Access")) | Not:C34(BRG_RWAccess))
					READ ONLY:C145([NBIS Secondary:3])
				Else 
					READ WRITE:C146([NBIS Secondary:3])
				End if 
				
				GOTO SELECTED RECORD:C245($Table_ptr->; $row_l)
				
				If (Read only state:C362($Table_ptr->))
					LOAD RECORD:C52($Table_ptr->)
					DIALOG:C40($Table_ptr->; $FormName_txt)
				Else 
					$row_l:=ut_LoadRecordInteractiveV2($Table_ptr)
					
					Case of 
						: ($row_l=1)
							MODIFY RECORD:C57($Table_ptr->)
						: ($row_l=2)
							READ ONLY:C145($Table_ptr->)
							DIALOG:C40($Table_ptr->; $FormName_txt)
					End case 
				End if 
				InDoubleClick_B:=False:C215
				QUERY:C277($Table_ptr->; $BInFld_ptr->=[Bridge MHD NBIS:1]BIN:3)
				ORDER BY:C49($Table_ptr->; $SortFld_ptr->; >)
				UNLOAD RECORD:C212($Table_ptr->)
			End if 
			
			LB_Header2_l:=1
		End if 
		
		
	: (FORM Get current page:C276=6)  //[Bridge Design]
		
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			$FormName_txt:="Bridge Design In"
			$Table_ptr:=->[Bridge Design:75]
			$BInFld_ptr:=->[Bridge Design:75]BIN:1
			$SortFld_ptr:=->[Bridge Design:75]ADVDate:4
			$SortOrder_txt:="<"
			$LbName_txt:="BridgeDesign"
			
			FORM SET INPUT:C55($Table_ptr->; $FormName_txt)
			LISTBOX GET CELL POSITION:C971(*; $LbName_txt; $column_l; $row_l)
			If ($row_l<1) | ($row_l>Records in selection:C76($Table_ptr->))
				InDoubleClick_B:=False:C215
			Else 
				GOTO SELECTED RECORD:C245($Table_ptr->; $row_l)
				
				If (Read only state:C362($Table_ptr->))
					LOAD RECORD:C52($Table_ptr->)
					DIALOG:C40($Table_ptr->; $FormName_txt)
				Else 
					$row_l:=ut_LoadRecordInteractiveV2($Table_ptr)
					//$parenttbl_ptr:=->[Bridge MHD NBIS]
					//$rowParent_L:=ut_LoadRecordInteractiveV2 ($parenttbl_ptr)
					Case of 
						: ($row_l=1)
							//: (($row_l=1) & ($rowParent_L=1))
							MODIFY RECORD:C57($Table_ptr->)
						: ($row_l=2)
							//: (($row_l=2) | ($rowParent_L=2))
							READ ONLY:C145($Table_ptr->)
							DIALOG:C40($Table_ptr->; $FormName_txt)
					End case 
				End if 
				InDoubleClick_B:=False:C215
				QUERY:C277($Table_ptr->; $BInFld_ptr->=[Bridge MHD NBIS:1]BIN:3)
				ORDER BY:C49($Table_ptr->; $SortFld_ptr->; <)
				UNLOAD RECORD:C212($Table_ptr->)
			End if 
			
		End if 
		
	: (FORM Get current page:C276=7)  //[Combined Inspections]
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			INSP_Read_Write_Tables("WRITE")
			
			C_LONGINT:C283(vApproveLvl)  // **replaced _ o _C_INTEGER()
			vApproveLvl:=0  //Cannot approve inspections from this point of entry.
			
			LISTBOX GET CELL POSITION:C971(*; "Inspections"; $column_l; $row_l)
			If ($row_l<1) | ($row_l>Records in selection:C76([Combined Inspections:90]))
				InDoubleClick_B:=False:C215
			Else 
				GOTO SELECTED RECORD:C245([Combined Inspections:90]; $row_l)
				C_LONGINT:C283($SelectedRecord_l)
				$SelectedRecord_l:=$row_l
				$row_l:=ut_LoadRecordInteractiveV2(->[Combined Inspections:90])
				COPY SET:C600("LBSetBrgInsp"; "MySet")
				
				//LOAD RECORD([Conslt Rating])
				SET CURSOR:C469(4)
				RELATE ONE:C42([Combined Inspections:90]NBISInspID:2)
				RELATE ONE:C42([Combined Inspections:90]BMSInspID:3)
				C_LONGINT:C283(vCurrentPontisID_L; vCurrentCombID_L)
				C_BOOLEAN:C305(vAllRelationsOK_B)
				vCurrentPontisID_L:=[BMS Inspections:44]Inspection ID:1
				vCurrentCombID_L:=[Combined Inspections:90]ID:6
				vAllRelationsOK_B:=True:C214
				If ([Combined Inspections:90]BMSInspID:3>0)
					If (vCurrentPontisID_L#[Combined Inspections:90]BMSInspID:3)
						vAllRelationsOK_B:=False:C215
					End if 
					If ([BMS Inspections:44]BIN:2#[Combined Inspections:90]BIN:1)
						vAllRelationsOK_B:=False:C215
					End if 
				End if 
				If (vAllRelationsOK_B)
					Case of 
						: (Read only state:C362([Combined Inspections:90]))
							READ ONLY:C145([Combined Inspections:90])
							DIALOG:C40([Inspections:27]; "BlankCombinedStarter")
						: ($row_l=1)
							FORM SET INPUT:C55([Inspections:27]; "BlankCombinedStarter")
							MODIFY RECORD:C57([Inspections:27])
						: ($row_l=2)
							READ ONLY:C145([Combined Inspections:90])
							DIALOG:C40([Inspections:27]; "BlankCombinedStarter")
						Else 
							
					End case 
					InDoubleClick_B:=False:C215
					If (In transaction:C397)
						CANCEL TRANSACTION:C241
					End if 
					//added to clear locks on [activity log] table
					If (Is record loaded:C669([Activity Log:59]))
						UNLOAD RECORD:C212([Activity Log:59])
					End if 
					
					G_CloseAllTables(->[Bridge MHD NBIS:1])  //close all tables except the main one.
					
					INSP_UpdateInspList
					
					COPY SET:C600("MySet"; "LBSetBrgInsp")
					
					HIGHLIGHT RECORDS:C656([Combined Inspections:90]; "LBSetBrgInsp")
					CLEAR SET:C117("MySet")
					
				Else 
					ALERT:C41("There are database link problems with this inspection record!! Record cannot be l"+"oaded!!")
				End if 
				
			End if 
		End if 
		
		
	: (FORM Get current page:C276=8)  //[InventoryPhotoInsp]
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			LISTBOX GET CELL POSITION:C971(*; "InventoryPhotos"; $column_l; $row_l)
			If ($row_l<1) | ($row_l>Records in selection:C76([InventoryPhotoInsp:112]))
				InDoubleClick_B:=False:C215
			Else 
				FORM SET INPUT:C55([InventoryPhotoInsp:112]; "Input")
				START TRANSACTION:C239
				GOTO SELECTED RECORD:C245([InventoryPhotoInsp:112]; $row_l)
				If (ut_LoadRecordInteractive(->[InventoryPhotoInsp:112]))
					MODIFY RECORD:C57([InventoryPhotoInsp:112])
					UNLOAD RECORD:C212([InventoryPhotoInsp:112])
					UNLOAD RECORD:C212([InventoryPhotos:113])
					
					INV_GetBINInventoryPhotos([Bridge MHD NBIS:1]BIN:3)
					
				End if 
				InDoubleClick_B:=False:C215
			End if 
		End if 
		
		
	: (FORM Get current page:C276=11)  //Tunnel Inspections
		
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			INSP_Read_Write_Tables("WRITE")
			
			C_LONGINT:C283(vApproveLvl)  // **replaced _ o _C_INTEGER()
			vApproveLvl:=0  //Cannot approve inspections from this point of entry.
			
			LISTBOX GET CELL POSITION:C971(*; "TunnelInspections"; $column_l; $row_l)
			If ($row_l<1) | ($row_l>Records in selection:C76([Combined Inspections:90]))
				InDoubleClick_B:=False:C215
			Else 
				GOTO SELECTED RECORD:C245([Combined Inspections:90]; $row_l)
				C_LONGINT:C283($SelectedRecord_l)
				$SelectedRecord_l:=$row_l
				$row_l:=ut_LoadRecordInteractiveV2(->[Combined Inspections:90])
				COPY SET:C600("LBSetTunnelInsp"; "MySet")
				
				//LOAD RECORD([Conslt Rating])
				SET CURSOR:C469(4)
				RELATE ONE:C42([Combined Inspections:90]NBISInspID:2)
				RELATE ONE:C42([Combined Inspections:90]BMSInspID:3)
				C_LONGINT:C283(vCurrentPontisID_L; vCurrentCombID_L)
				C_BOOLEAN:C305(vAllRelationsOK_B)
				vCurrentPontisID_L:=[BMS Inspections:44]Inspection ID:1
				vCurrentCombID_L:=[Combined Inspections:90]ID:6
				vAllRelationsOK_B:=True:C214
				If ([Combined Inspections:90]BMSInspID:3>0)
					If (vCurrentPontisID_L#[Combined Inspections:90]BMSInspID:3)
						vAllRelationsOK_B:=False:C215
					End if 
					If ([BMS Inspections:44]BIN:2#[Combined Inspections:90]BIN:1)
						vAllRelationsOK_B:=False:C215
					End if 
				End if 
				If (vAllRelationsOK_B)
					Case of 
						: (Read only state:C362([Combined Inspections:90]))
							READ ONLY:C145([Combined Inspections:90])
							DIALOG:C40([Inspections:27]; "BlankCombinedStarter")
						: ($row_l=1)
							FORM SET INPUT:C55([Inspections:27]; "BlankCombinedStarter")
							MODIFY RECORD:C57([Inspections:27])
						: ($row_l=2)
							READ ONLY:C145([Combined Inspections:90])
							DIALOG:C40([Inspections:27]; "BlankCombinedStarter")
						Else 
							
					End case 
					InDoubleClick_B:=False:C215
					If (In transaction:C397)
						CANCEL TRANSACTION:C241
					End if 
					//added to clear locks on [activity log] table
					If (Is record loaded:C669([Activity Log:59]))
						UNLOAD RECORD:C212([Activity Log:59])
					End if 
					
					G_CloseAllTables(->[Bridge MHD NBIS:1])  //close all tables except the main one.
					
					READ ONLY:C145([TunnelInfo:151])
					QUERY:C277([TunnelInfo:151]; [TunnelInfo:151]BIN:1=[Bridge MHD NBIS:1]BIN:3)
					
					INSP_UpdateInspList
					
					COPY SET:C600("MySet"; "LBSetTunnelInsp")
					
					HIGHLIGHT RECORDS:C656([Combined Inspections:90]; "LBSetTunnelInsp")
					CLEAR SET:C117("MySet")
					
				Else 
					ALERT:C41("There are database link problems with this inspection record!! Record cannot be l"+"oaded!!")
				End if 
				
			End if 
		End if 
		
		
		
	: (FORM Get current page:C276=12)  //[RatingRequests]
		
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			C_LONGINT:C283($TaskRes_L)
			
			If (RtgReq_Edit_b)
				READ WRITE:C146([RatingRequests:154])
				READ WRITE:C146([AddtlRatingRequests:155])
			Else 
				READ ONLY:C145([RatingRequests:154])
				READ ONLY:C145([AddtlRatingRequests:155])
			End if 
			
			$TaskRes_L:=LB_Tasks("DOUBLECLICK"; "RtgReqIncl")
			InDoubleClick_B:=False:C215
			QUERY:C277([RatingRequests:154]; [RatingRequests:154]BIN:1=[Bridge MHD NBIS:1]BIN:3)
			ORDER BY:C49([RatingRequests:154]; [RatingRequests:154]DateOfRequest_d:3; <)
			UNLOAD RECORD:C212([RatingRequests:154])
			UNLOAD RECORD:C212([AddtlRatingRequests:155])
			InDoubleClick_B:=False:C215
		End if 
		
End case 
InDoubleClick_B:=False:C215
SIA_ReleaseBridgeRec

//End SIA_ControlDoubleClick