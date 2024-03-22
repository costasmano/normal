//%attributes = {"invisible":true}
//Method: NTI_InspectionInput_FM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/25/16, 12:30:56
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
	// Modified by: Costas Manousakis-(Designer)-(10/11/17 16:06:16)
	Mods_2017_10
	//  `use NTI_GroupSuffix method
	// Modified by: Costas Manousakis-(Designer)-(2/14/18 12:11:12)
	Mods_2018_02
	//  `New implementation
	Mods_2018_02  // Added code to enable or disable 4D write area depending upon whether in read write mode or not
	//Modified by: Chuck Miller (2/15/18 13:04:57)
	// Modified by: Costas Manousakis-(Designer)-(2/10/20 14:37:29)
	Mods_2020_02
	//  `Enabled on Resize event on form;  added form event in method to redraw listboxes
	//  `Deselect all rows in Photo_LB on load
	// Modified by: Costas Manousakis-(Designer)-(6/23/21 12:20:55)
	Mods_2021_WP
	//  `
	
End if 
//


Case of 
	: (Form event code:C388=On Load:K2:1)
		InDoubleClick_B:=False:C215
		NTI_INIT
		NTI_SETARRAYS
		InitChangeStack(1)  //inspection
		InitChangeStack(2)  //all others
		InitChangeStack(3)  //[TIN_Insp_Comments]
		PON_ChangeStackLvl_L:=2
		C_LONGINT:C283(Feet_L; Inches_L; Feet1_L; Inches1_L)
		OBJECT SET VISIBLE:C603(*; "WeightPostingFalse@"; Not:C34([TIN_Inspections:184]WeightPostingNA_B:36))
		OBJECT SET VISIBLE:C603(*; "DE WeightPostingFalse@"; Not:C34([TIN_Inspections:184]WeightPostingNA_B:36))
		
		Feet_L:=Trunc:C95(([TIN_Inspections:184]ActualFieldMeasure_L:26/12); 0)
		Inches_L:=[TIN_Inspections:184]ActualFieldMeasure_L:26-(Feet_L*12)
		Feet1_L:=Trunc:C95(([TIN_Inspections:184]PostedClearance_L:27/12); 0)
		Inches1_L:=[TIN_Inspections:184]PostedClearance_L:27-(Feet1_L*12)
		
		If (Not:C34(Read only state:C362([TIN_Inspections:184])))
			START TRANSACTION:C239
			//_ o _ENABLE BUTTON(*;"DE @")
			OBJECT SET ENABLED:C1123(*; "DE @"; True:C214)
			OBJECT SET VISIBLE:C603(*; "DE @btn"; True:C214)
			OBJECT SET ENTERABLE:C238(*; "DE @"; True:C214)
			
			//WR TEXT ACCESS (AreaGeneralRemarks;wr allowed access)
		Else 
			//hide save buttons
			OBJECT SET VISIBLE:C603(*; "DE @btn"; False:C215)
			//disable DE dropdowns
			//_ o _DISABLE BUTTON(*;"DE @")
			OBJECT SET ENABLED:C1123(*; "DE @"; False:C215)
			OBJECT SET ENTERABLE:C238(*; "DE @"; False:C215)
			//WR TEXT ACCESS (AreaGeneralRemarks;wr restricted access)
		End if 
		C_DATE:C307(NTI_DROPBININSPDATE)
		
		If (NTI_DROPBININSPDATE>!00-00-00!)
			If ([TIN_Inspections:184]InspDate:3>=NTI_DROPBININSPDATE)
				OBJECT SET VISIBLE:C603(*; "DE SummBINNTE Btn"; False:C215)
			End if 
		End if 
		
		If (Is new record:C668([TIN_Inspections:184]))
			//initialize 
			[TIN_Inspections:184]NTI_i1_S:1:=[NTI_TunnelInfo:181]NTI_i1_s:6
			Inc_Sequence("TIN_Inspections"; ->[TIN_Inspections:184]InspectionID:2)
			LogNewRecord(->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[TIN_Inspections:184]NTI_i1_S:1; ->[TIN_Inspections:184]InspectionID:2; 1; "TIN_Inspections")
			[TIN_Inspections:184]InspType:21:=NTI_NewTINInspType_txt
			[TIN_Inspections:184]InspDate:3:=Current date:C33(*)
			[TIN_Inspections:184]CreatedBy:8:=Current user:C182
			[TIN_Inspections:184]CreatedDateTimeStamp:7:=ISODateTime(Current date:C33(*); Current time:C178(*))
			If (<>CurrentUser_PID>0)
				READ ONLY:C145([Personnel:42])
				QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=<>CurrentUser_PID)
				If ([Personnel:42]Job Code:8=2)
					[TIN_Inspections:184]TeamLeader:11:=<>CurrentUser_PID
				End if 
			End if 
			C_TEXT:C284($tunnelGrpsuffix_txt)
			
			C_LONGINT:C283($DTIE_L)
			$tunnelGrpsuffix_txt:=NTI_GroupSuffix
			$DTIE_L:=GRP_GetGroupRepID("TunnelInspEng"+$tunnelGrpsuffix_txt)
			
			If ($DTIE_L>0)
				[TIN_Inspections:184]DistrTnlInspEng:22:=$DTIE_L
			End if 
			
			$DTIE_L:=GRP_GetGroupRepID("TunnelEngineer"+$tunnelGrpsuffix_txt)
			If ($DTIE_L>0)
				[TIN_Inspections:184]DistrInspEng:12:=$DTIE_L
			End if 
			[TIN_Inspections:184]Agency:13:=<>PERS_MyCompany_txt
		End if 
		
		TININSP_DTIE_OM
		TININSP_DIE_OM
		TININSP_aAgency_OM
		NTI_ListElements_TIN
		NTI_NTE_LB_OM_TIN
		QUERY:C277([TIN_Insp_TmMembers:187]; [TIN_Insp_TmMembers:187]InspectionID:1=[TIN_Inspections:184]InspectionID:2)
		INSP_BuildTmMbrArea(->[TIN_Insp_TmMembers:187]PersonID:2)
		
		NTI_ListInspImages
		NTI_ImageSortNeeded_b:=False:C215
		OBJECT SET VISIBLE:C603(*; "ImageSortWarning"; False:C215)
		LISTBOX SELECT ROW:C912(*; "PHotos_LB"; 0; lk remove from selection:K53:3)
		
		ARRAY TEXT:C222(TINInspCommentTypes_atxt; 0)
		Begin SQL
			select
			[TableOfLists].[ListValue_s],
			[TableOfLists].[ListSequence_l]
			from
			[TableOfLists]
			
			where
			[TableOfLists].[ListName_s]='TIN_CommentTypes'
			ORDER BY 2 ASC
			into
			:TINInspCommentTypes_atxt;
		End SQL
		If ([TIN_Inspections:184]InspType:21="ZDA")  //damage
		Else 
			C_LONGINT:C283($Pos_L)
			$Pos_L:=Find in array:C230(TINInspCommentTypes_atxt; "@DAM@")
			If ($Pos_L>0)
				DELETE FROM ARRAY:C228(TINInspCommentTypes_atxt; $Pos_L; 1)
			End if 
		End if 
		TINInspCommentTypes_atxt:=2
		TINInspCommentTypes_atxt{0}:=TINInspCommentTypes_atxt{TINInspCommentTypes_atxt}
		NTI_SaveAndUpdateComments_WP(True:C214)  // load the general remarks comments
		OBJECT SET VISIBLE:C603(*; "Damage@"; ([TIN_Inspections:184]InspType:21="ZDA"))
		OBJECT SET VISIBLE:C603(*; "DE Damage@"; ([TIN_Inspections:184]InspType:21="ZDA"))
		
		OBJECT SET TITLE:C194(*; "InspectionTitle"; FM_ReturnInspectionTitle)
		NTI_CheckDependencies
		OBJECT SET VISIBLE:C603(*; "RatingIfTrue@"; [TIN_Inspections:184]RatingReportYN_B:30)
		OBJECT SET VISIBLE:C603(*; "DE RatingIfTrue@"; [TIN_Inspections:184]RatingReportYN_B:30)
		
	: (Form event code:C388=On Resize:K2:27)
		REDRAW:C174(PHotos_LB)
		REDRAW:C174(PON_NBE_LB)
End case 

//End NTI_InspectionInput_FM