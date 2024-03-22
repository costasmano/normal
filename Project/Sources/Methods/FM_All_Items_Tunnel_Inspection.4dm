//%attributes = {"invisible":true}
//Method: FM_All_Items_Tunnel_Inspection
//Description
// method used in the print forms for tunnel inspections
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 01/02/18, 12:00:37
	// ----------------------------------------------------
	//Created : 
	Mods_2018_01
	// Modified by: Costas Manousakis-(Designer)-(1/12/18 13:08:22)
	Mods_2018_01
	//  `for elements with unit=percent hide the rect and text
	// Modified by: Costas Manousakis-(Designer)-(3/22/18 16:36:11)
	Mods_2018_03
	//  `additions for protective systems
	// Modified by: Costas Manousakis-(Designer)-(4/26/18 17:15:54)
	Mods_2018_04_bug
	//  `added missing seting of team_leader title and checks for missing person IDs
	// Modified by: Costas Manousakis-(Designer)-(5/2/18 16:40:59)
	Mods_2018_05_bug
	//  `fit to print NTI_Contracts and NTI_Segment
	// Modified by: Costas Manousakis-(Designer)-(3/19/19 14:16:37)
	Mods_2019_03_bug
	//  ` if [TIN_Inspections]WeightPostingNA_B is true set format of posting values so that Zeros show as blank
End if 
//
C_LONGINT:C283($FormEvent_L)
$FormEvent_L:=Form event code:C388
If (Count parameters:C259=1)
	
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
End if 
C_LONGINT:C283($FormHeader_L; $formBreak_L; $FormDetail_L; $formFooter_L; $break_footer_L; $printed_L; $totalHt; $totalW)
Case of 
	: ($FormEvent_L=On Header:K2:17)
		vpageno:=vpageno+1
		C_TEXT:C284($Name_txt)
		$Name_txt:=""
		$Name_txt:=FM_ReturnInspectionTitle
		
		OBJECT SET TITLE:C194(*; "Insptitle"; $Name_txt)
		$Name_txt:=""
		OBJECT SET TITLE:C194(*; "Start_End_Date"; String:C10([TIN_Inspections:184]InspDate:3)+" - "+String:C10([TIN_Inspections:184]InspCompleteDate:15))
		vDist:=String:C10(Num:C11([NTI_TunnelInfo:181]NTI_i6_s:11))
		
		OBJECT SET TITLE:C194(*; "Owner"; Substring:C12([TIN_Inspections:184]NTI_i1_S:1; 10; 3))
		OBJECT SET TITLE:C194(*; "maintainer"; Substring:C12([TIN_Inspections:184]NTI_i1_S:1; 10; 3))
		OBJECT SET TITLE:C194(*; "VentZone"; Substring:C12([TIN_Inspections:184]NTI_i1_S:1; Length:C16([TIN_Inspections:184]NTI_i1_S:1)-2; 3))
		OBJECT SET TITLE:C194(*; "TINtext"; Substring:C12([TIN_Inspections:184]NTI_i1_S:1; 4; 3))
		
		$Name_txt:=Get_Description(->aPeople; ->aPeople_ID; ->[TIN_Inspections:184]ProjManager:14)
		If (($Name_txt="") & ([TIN_Inspections:184]ProjManager:14>0))
			OBJECT SET TITLE:C194(*; "projmgr"; "Invalid Person ID")
		Else 
			OBJECT SET TITLE:C194(*; "projmgr"; $Name_txt)
		End if 
		
		$Name_txt:=Get_Description(->aPeople; ->aPeople_ID; ->[TIN_Inspections:184]DistrTnlInspEng:22)
		If (($Name_txt="") & ([TIN_Inspections:184]DistrTnlInspEng:22>0))
			OBJECT SET TITLE:C194(*; "dist_tunnel_Inspengineer"; "Invalid Person ID")
		Else 
			OBJECT SET TITLE:C194(*; "dist_tunnel_Inspengineer"; $Name_txt)
		End if 
		
		$Name_txt:=Get_Description(->aPeople; ->aPeople_ID; ->[TIN_Inspections:184]DistrInspEng:12)
		If (($Name_txt="") & ([TIN_Inspections:184]DistrInspEng:12>0))
			OBJECT SET TITLE:C194(*; "dist_engineer"; "Invalid Person ID")
		Else 
			OBJECT SET TITLE:C194(*; "dist_engineer"; $Name_txt)
		End if 
		
		$Name_txt:=Get_Description(->aPeople; ->aPeople_ID; ->[TIN_Inspections:184]TeamLeader:11)
		If (($Name_txt="") & ([TIN_Inspections:184]TeamLeader:11>0))
			OBJECT SET TITLE:C194(*; "team_leader"; "Invalid Person ID")
		Else 
			OBJECT SET TITLE:C194(*; "team_leader"; $Name_txt)
		End if 
		
		
		If ([TIN_Inspections:184]RatingReportYN_B:30)
			OBJECT SET TITLE:C194(*; "RatingReportYorN"; "Y")
		Else 
			OBJECT SET TITLE:C194(*; "RatingReportYorN"; "N")
		End if 
		If ([TIN_Inspections:184]WeightPostingNA_B:36)
			OBJECT SET TITLE:C194(*; "NotApplicable"; "X")
			OBJECT SET FORMAT:C236(*; "WeightPosting_@"; "###,###;;")
		Else 
			OBJECT SET TITLE:C194(*; "NotApplicable"; "")
			OBJECT SET FORMAT:C236(*; "WeightPosting_@"; "")
		End if 
		
		C_LONGINT:C283($InspID_L)
		$InspID_L:=[TIN_Inspections:184]InspectionID:2
		ARRAY LONGINT:C221($PersonID_aL; 0)
		Begin SQL
			select 
			[TIN_Insp_TmMembers].[PersonID]
			from
			[TIN_Insp_TmMembers]
			where
			[TIN_Insp_TmMembers].[InspectionID] =:$InspID_L
			into
			:$PersonID_aL;
		End SQL
		$Name_txt:=""
		C_LONGINT:C283($Pos_L; $Loop_l)
		vTmMembers:=""
		For ($Loop_l; 1; Size of array:C274($PersonID_aL))
			$Pos_L:=Find in array:C230(aPeople_ID; $PersonID_aL{$Loop_l})
			If ($Pos_L>0)
				$Name_txt:=aPeople{$Pos_L}
			Else 
				$Name_txt:="Invalid Person ID"
			End if 
			If (vTmMembers="")
				vTmMembers:=$Name_txt
			Else 
				vTmMembers:=vTmMembers+", "+$Name_txt
			End if 
		End for 
		Feet_L:=Trunc:C95(([TIN_Inspections:184]ActualFieldMeasure_L:26/12); 0)
		Inches_L:=[TIN_Inspections:184]ActualFieldMeasure_L:26-(Feet_L*12)
		Feet1_L:=Trunc:C95(([TIN_Inspections:184]PostedClearance_L:27/12); 0)
		Inches1_L:=[TIN_Inspections:184]PostedClearance_L:27-(Feet1_L*12)
		
		ut_FitPrintFormObjectbyName("NTI_Contracts"; 10; 6)
		ut_FitPrintFormObjectbyName("NTI_Segment"; 10; 6)
		
	: ($FormEvent_L=On Printing Detail:K2:18)
		
		$FormHeader_L:=Get print marker:C708(Form header:K43:3)
		
		$FormDetail_L:=Get print marker:C708(Form detail:K43:1)
		$formBreak_L:=Get print marker:C708(Form break0:K43:14)
		$formFooter_L:=Get print marker:C708(Form footer:K43:2)
		$break_footer_L:=$formFooter_L-$FormDetail_L
		$printed_L:=Get printed height:C702
		GET PRINTABLE AREA:C703($totalHt; $totalW)
		
		Case of 
			: (NTI_PrintSection_txt="Detail")
				NTI_LoadLB_elemInfo(->PON_NBE_LB_ELEMDESC_TXT; ->PON_NBE_LB_ELEMU_TXT; ->PON_NBE_LB_QP_TXT; ->[NTI_ELEM_TIN_INSP:185])
				C_TEXT:C284($QFormat_txt)
				If (PON_NBE_LB_ELEMU_TXT="each")
					$QFormat_txt:="###,###,###,###,##0;;"
					OBJECT SET FORMAT:C236(vTotQ; $QFormat_txt)
				Else 
					$QFormat_txt:="###,###,###,###,##0.000;;"
					OBJECT SET FORMAT:C236(vTotQ; "###,###,###,###,##0.000;;")
				End if 
				
				If ([NTI_ELEM_TIN_INSP:185]ELEM_QorP:16)
					PON_NBE_LB_CS1_r:=[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17
					PON_NBE_LB_CS2_r:=[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18
					PON_NBE_LB_CS3_r:=[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19
					PON_NBE_LB_CS4_r:=[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20
					
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS1_r; $QFormat_txt)
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS2_r; $QFormat_txt)
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS3_r; $QFormat_txt)
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS4_r; $QFormat_txt)
					
				Else 
					PON_NBE_LB_CS1_r:=Round:C94([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE1:12; 2)
					PON_NBE_LB_CS2_r:=Round:C94([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13; 2)
					PON_NBE_LB_CS3_r:=Round:C94([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14; 2)
					PON_NBE_LB_CS4_r:=Round:C94([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15; 2)
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS1_r; "###,###,###,###,##0.00;;")
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS2_r; "###,###,###,###,##0.00;;")
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS3_r; "###,###,###,###,##0.00;;")
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS4_r; "###,###,###,###,##0.00;;")
				End if 
				Pon_ElemKey_txt:=NTI_ElemKeyTxt([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3; [NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7; [NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_KEY:25)
				QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
				C_LONGINT:C283($style_L; $background_L)
				Case of 
					: ([NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y")
						$style_L:=Italic:K14:3
						$background_L:=-(Black:K11:16+(256*White:K11:1))
					: ([NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21="Y")
						$style_L:=Plain:K14:1
						$background_L:=-(Black:K11:16+(256*White:K11:1))
						
					Else 
						$style_L:=Bold:K14:2
						$background_L:=-(Black:K11:16+(256*(15*16+1)))  //light grey - 2nd block on the last row of the 4D color 'chart'
				End case 
				OBJECT SET FONT STYLE:C166(Pon_ElemKey_txt; $style_L)
				OBJECT SET FONT STYLE:C166(PON_NBE_LB_ELEMDESC_TXT; $style_L)
				OBJECT SET RGB COLORS:C628(*; "PON_BackgroundLine"; Col_paletteToRGB(Abs:C99($background_L)%256); Col_paletteToRGB(Abs:C99($background_L)\256))  // **Replaced o OBJECT SET COLOR(*; "PON_BackgroundLine"; $background_L)
				
				vTotQ:=[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21
				
				OBJECT SET VISIBLE:C603(*; "CHKLINE@"; Not:C34([NTI_ELEM_TIN_INSP:185]ELEM_QorP:16))
				
				If (PON_NBE_LB_ELEMU_TXT="percent")
					OBJECT SET VISIBLE:C603(*; "QorP@"; False:C215)
				Else 
					OBJECT SET VISIBLE:C603(*; "QorP@"; True:C214)
				End if 
				
				$printed_L:=Get printed height:C702
				//check space left
				//space needed = formFooter-FormHeader
				If (($printed_L+($formFooter_L-$FormHeader_L))>$totalHt)
					CANCEL:C270
				End if 
			: (NTI_PrintSection_txt="Header")
				
				FM_All_Items_Tunnel_Inspection(On Header:K2:17)
				$printed_L:=Get printed height:C702
				
			: (NTI_PrintSection_txt="Break0")
				SET PRINT MARKER:C709(Form break0:K43:14; $formBreak_L+($totalHt-($printed_L+$break_footer_L)); *)
				
		End case 
		
End case 

//End FM_All_Items_Tunnel_Inspection