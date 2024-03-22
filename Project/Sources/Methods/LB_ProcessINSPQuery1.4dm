//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 12/29/11, 15:27:14
//----------------------------------------------------
//Method: LB_ProcessINSPQuery1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_12  //r004
	//Modified by: Charles Miller (12/29/11 15:27:15)
	
End if 
C_LONGINT:C283($0)
$0:=0
Case of 
	: (Form event code:C388=On Load:K2:1)
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		LISTBOX SET TABLE SOURCE:C1013(*; "SelectListBox"; [LB_QueryTable:147]TableNumber_l:3)
		C_POINTER:C301($Table_ptr)
		
		
		TeamLeaderName_txt:="QR_PersonName([Inspections]TeamLeader)"
		LBRowNumber_txt:="Selected record number([Inspections])"
		
		C_LONGINT:C283($NumCol_L)
		$NumCol_L:=0
		
		$NumCol_L:=$NumCol_L+1
		LISTBOX INSERT COLUMN FORMULA:C970(*; "SelectListBox"; $NumCol_L; "RecNoCol"; LBRowNumber_txt; Is longint:K8:6; "RecNoHdr"; RowNoHeaderVar_L)
		OBJECT SET TITLE:C194(RowNoHeaderVar_L; "#")
		$NumCol_L:=$NumCol_L+1
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $NumCol_L; "RecIDCol"; [Inspections:27]InspID:2; "RecIDHeader"; RecIDHeaderVar_L)
		OBJECT SET TITLE:C194(RecIDHeaderVar_L; "Rec ID")
		$NumCol_L:=$NumCol_L+1
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $NumCol_L; "DateCol"; [Inspections:27]Insp Date:78; "DateHeader"; dateHeaderVar_L)
		OBJECT SET TITLE:C194(dateHeaderVar_L; "Date")
		$NumCol_L:=$NumCol_L+1
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $NumCol_L; "TypeCol"; [Inspections:27]Insp Type:6; "TypeHeader"; TypeHeaderVar_L)
		OBJECT SET TITLE:C194(TypeHeaderVar_L; "Type")
		$NumCol_L:=$NumCol_L+1
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $NumCol_L; "DescCol"; [Inspection Type:31]Description:2; "DescHeader"; descHeaderVar_L)
		OBJECT SET TITLE:C194(descHeaderVar_L; "Inspection Type")
		$NumCol_L:=$NumCol_L+1
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $NumCol_L; "BINCol"; [Bridge MHD NBIS:1]BIN:3; "BINHeader"; BINHeaderVar_L)
		OBJECT SET TITLE:C194(BINHeaderVar_L; "BIN")
		$NumCol_L:=$NumCol_L+1
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $NumCol_L; "BDEPTCol"; [Bridge MHD NBIS:1]BDEPT:1; "bdeptHeader"; bdeptHeaderVar_L)
		OBJECT SET TITLE:C194(bdeptHeaderVar_L; "BDEPT")
		$NumCol_L:=$NumCol_L+1
		LISTBOX INSERT COLUMN FORMULA:C970(*; "SelectListBox"; $NumCol_L; "TeamLdrCol"; TeamLeaderName_txt; Is text:K8:3; "TeamLdrHeader"; TeamLdrHeaderVar_L)
		OBJECT SET TITLE:C194(TeamLdrHeaderVar_L; "Team Leader")
		$NumCol_L:=$NumCol_L+1
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $NumCol_L; "CompCol"; [Inspections:27]InspComplete:168; "ComplHeader"; ComplHeaderVar_L)
		OBJECT SET TITLE:C194(ComplHeaderVar_L; "Compl.")
		$NumCol_L:=$NumCol_L+1
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $NumCol_L; "ReviewCol"; [Inspections:27]InspReviewed:12; "ReviewlHeader"; RevHeaderVar_L)
		OBJECT SET TITLE:C194(RevHeaderVar_L; "DBIE Rev.")
		$NumCol_L:=$NumCol_L+1
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $NumCol_L; "ReviewPicCol"; INSPLB_pict_Rev_p; "ReviewPicHeader"; RevPicHeaderVar_L)
		OBJECT SET TITLE:C194(RevPicHeaderVar_L; "DBIE Rev.")
		$NumCol_L:=$NumCol_L+1
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $NumCol_L; "ApprCol"; [Inspections:27]InspApproved:167; "ApprlHeader"; ApprHeaderVar_L)
		OBJECT SET TITLE:C194(ApprHeaderVar_L; "AE Rev.")
		$NumCol_L:=$NumCol_L+1
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $NumCol_L; "ApprPicCol"; INSPLB_pict_app_p; "ApprPicHeader"; ApprPicHeaderVar_L)
		OBJECT SET TITLE:C194(ApprPicHeaderVar_L; "AE Rev.")
		$NumCol_L:=$NumCol_L+1
		LISTBOX INSERT COLUMN:C829(*; "SelectListBox"; $NumCol_L; "SecondTmLdrCol"; SecondTeamLdrName_txt; "SecondTmLdrlHeader"; TeamLdr2HeaderVar_L)
		
		//INSERT LISTBOX COLUMN(*;"SelectListBox";$NumCol_L;"SecondTmLdrCol";[Personnel]Last Name+", "+[Personnel]First Name;"SecondTmLdrlHeader";TeamLdr2HeaderVar_L)
		
		OBJECT SET TITLE:C194(TeamLdr2HeaderVar_L; "2nd Tm Ldr.")
		OBJECT SET VISIBLE:C603(*; "TypeCol"; False:C215)
		OBJECT SET VISIBLE:C603(*; "RecIDCol"; False:C215)
		OBJECT SET VISIBLE:C603(*; "ReviewCol"; False:C215)
		OBJECT SET VISIBLE:C603(*; "ApprCol"; False:C215)
		
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "DateCol"; Align center:K42:3)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "BINCol"; Align center:K42:3)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "CompCol"; Align center:K42:3)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "ReviewCol"; Align center:K42:3)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "ApprCol"; Align center:K42:3)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "RecNoCol"; Align center:K42:3)
		OBJECT SET FORMAT:C236(*; "ApprPicCol"; Char:C90(Scaled to fit prop centered:K6:6))
		OBJECT SET FORMAT:C236(*; "ReviewPicCol"; Char:C90(Scaled to fit prop centered:K6:6))
		C_LONGINT:C283($0)
		C_TEXT:C284($nameofObj_txt; $LBColVarName_txt)
		C_LONGINT:C283($dumTbl_L; $dumFld_L)
		RESOLVE POINTER:C394(Self:C308; $nameofObj_txt; $dumTbl_L; $dumFld_L)
		C_LONGINT:C283($lbCol_L; $LBRow_L)
		C_POINTER:C301($LBColVar_ptr)
		LISTBOX GET CELL POSITION:C971(*; $nameofObj_txt; $lbCol_L; $LBRow_L; $LBColVar_ptr)
		RESOLVE POINTER:C394($LBColVar_ptr; $LBColVarName_txt; $dumTbl_L; $dumFld_L)
		$nameofObj_txt:=$nameofObj_txt+" Col="+String:C10($lbCol_L)+" Row:"+String:C10($LBRow_L)+"  varname:"+$LBColVarName_txt
		
	: (Form event code:C388=On Display Detail:K2:22)
		C_TEXT:C284(SecondTeamLdrName_txt)
		SecondTeamLdrName_txt:=QR_PersonName([Inspections:27]TeamLeader:4)
		C_PICTURE:C286(INSPLB_pict_Rev_p; INSPLB_pict_app_p)
		
		Case of 
			: ([Inspections:27]InspApproved:167=0)
				INSPLB_pict_app_p:=INSPLB_pict_app_p*0
			: ([Inspections:27]InspApproved:167=1)
				GET PICTURE FROM LIBRARY:C565("BMS RejectIcon"; INSPLB_pict_app_p)
			: ([Inspections:27]InspApproved:167=2)
				GET PICTURE FROM LIBRARY:C565("BMS ApproveIcon"; INSPLB_pict_app_p)
				
		End case 
		Case of 
			: ([Inspections:27]InspReviewed:12=0)
				INSPLB_pict_Rev_p:=INSPLB_pict_Rev_p*0
			: ([Inspections:27]InspReviewed:12=1)
				GET PICTURE FROM LIBRARY:C565("BMS RejectIcon"; INSPLB_pict_Rev_p)
			: ([Inspections:27]InspReviewed:12=2)
				GET PICTURE FROM LIBRARY:C565("BMS ApproveIcon"; INSPLB_pict_Rev_p)
				
		End case 
		
	: (Form event code:C388=On Header Click:K2:40)
		//ALERT("Header Click on "+$nameofObj_txt)
		RESOLVE POINTER:C394(Self:C308; $nameofObj_txt; $dumTbl_L; $dumFld_L)
		
		Case of 
			: ($nameofObj_txt="TeamLdrHeaderVar_L")
				If (LB_SortDirection_l=0)
					ORDER BY FORMULA:C300([Inspections:27]; QR_PersonName([Inspections:27]TeamLeader:4); >)
					Self:C308->:=1
					LB_SortDirection_l:=1
				Else 
					ORDER BY FORMULA:C300([Inspections:27]; QR_PersonName([Inspections:27]TeamLeader:4); <)
					Self:C308->:=2
					LB_SortDirection_l:=0
				End if 
				$0:=-1
				
			: ($nameofObj_txt="TeamLdr2HeaderVar_L")
				SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
				
				If (LB_SortDirection_l=0)
					ORDER BY:C49([Inspections:27]; [Personnel:42]Last Name:5; >)
					Self:C308->:=1
					LB_SortDirection_l:=1
				Else 
					ORDER BY:C49([Inspections:27]; [Personnel:42]Last Name:5; <)
					Self:C308->:=2
					LB_SortDirection_l:=0
				End if 
				$0:=-1
				
			: ($nameofObj_txt="ApprPicHeaderVar_L@")
				
				If ((Self:C308->=0) | (Self:C308->=2))
					ORDER BY:C49([Inspections:27]; [Inspections:27]InspApproved:167; >)
					Self:C308->:=1
					
				Else 
					ORDER BY:C49([Inspections:27]; [Inspections:27]InspApproved:167; <)
					Self:C308->:=2
					
				End if 
				
			: ($nameofObj_txt="RevPicHeaderVar_L@")
				
				If (Self:C308->=0) | (Self:C308->=2)
					ORDER BY:C49([Inspections:27]; [Inspections:27]InspReviewed:12; >)
					Self:C308->:=1
					
				Else 
					ORDER BY:C49([Inspections:27]; [Inspections:27]InspReviewed:12; <)
					Self:C308->:=2
					
				End if 
			Else 
				LB_SortDirection_L:=0
				
		End case 
		
		//$0:=0
	: (Form event code:C388=On After Sort:K2:28)
		//ALERT("After Sort on "+$nameofObj_txt)
		
	: (Form event code:C388=On Clicked:K2:4)
		//ALERT("Click on "+$nameofObj_txt)
	: (Form event code:C388=On Double Clicked:K2:5)
		//ALERT("double Click on "+$nameofObj_txt)
		
		
		
End case 

//End LB_ProcessINSPQuery1

