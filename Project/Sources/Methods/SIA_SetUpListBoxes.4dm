//%attributes = {"invisible":true}
//----------------------------------------------------
//Method: SIA_SetUpListBoxes
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//User name (OS): Charles Miller
	//Date and time: 02/23/12, 13:41:11
	//----------------------------------------------------
	Mods_2012_02  //r003
	//Modified by: Charles Miller (2/23/12 13:41:15)
	Mods_2012_03  //r003 `Add code to use list box for Inventory button on 
	//Modified by: Charles Miller (3/29/12 14:16:04)
	Mods_2012_04  // Add code to resize the listbox to better fit the screen when not Designer or Admin
	//Modified by: Charles Miller (4/17/12 )
	// Modified by: Costas Manousakis-(Designer)-(4/17/12 14:44:43)
	Mods_2012_04
	//  `Made format of all dates to Char(Internal date short +Blank if null date ) - seems to work  in mac and windows the same
	// Modified by: Costas Manousakis-(Designer)-(5/3/12 10:37:02)
	Mods_2012_05
	//  `Removed the query for [Bridge Design] from this method - now done in SIA_BridgeInpNavCTRL
	// Modified by: Costas Manousakis-(Designer)-(4/11/13 16:30:38)
	Mods_2013_04
	// Modified by: Costas Manousakis-(Designer)-(10/17/16 12:12:28)
	Mods_2016_10
	//  `made columns 2 and 4 for Inspections -page 7 (item 41 and item 59) to variables - so the can be blank for Freeze thaw reports
	// Modified by: Costas Manousakis-(Designer)-(5/9/18 12:41:25)
	Mods_2018_05
	//  `changes in the Ratings listbox
	// Modified by: Costas Manousakis-(Designer)-(11/26/19 16:36:12)
	Mods_2019_11
	//  `additions in Rating reports
End if 
C_LONGINT:C283($1; $Page_l; $StartHeight_l)
$Page_l:=$1
Compiler_LB
C_TEXT:C284($ListBoxArea_txt)
LISTBOX DELETE COLUMN:C830(*; "ConsutantInspections"; 1; 99)
LISTBOX DELETE COLUMN:C830(*; "ConsutantRatings"; 1; 99)
LISTBOX DELETE COLUMN:C830(*; "RatingReports"; 1; 99)
LISTBOX DELETE COLUMN:C830(*; "Secondary"; 1; 99)
LISTBOX DELETE COLUMN:C830(*; "BridgeDesign"; 1; 99)
LISTBOX DELETE COLUMN:C830(*; "Inspections"; 1; 99)
LISTBOX DELETE COLUMN:C830(*; "InventoryPhotos"; 1; 99)
LISTBOX DELETE COLUMN:C830(*; "TunnelInspections"; 1; 99)

C_LONGINT:C283($BottomCompare_l)
C_BOOLEAN:C305($ShowDesignerStuff_b)

$ShowDesignerStuff_b:=False:C215
If ((<>CurrentUser_Name="Designer") | (<>CurrentUser_Name="Administrator")) & (Shift down:C543)
	$ShowDesignerStuff_b:=True:C214
	
End if 
C_BOOLEAN:C305($SetUp_b)
$SetUp_b:=True:C214
ARRAY TEXT:C222(SIA_ListBoxWidths_atxt; 0)
If (Not:C34(Is compiled mode:C492))
	OBJECT SET VISIBLE:C603(*; "ForDesigner@"; True:C214)
	If ($ShowDesignerStuff_b)  //((◊CurrentUser_Name="Designer") | (◊CurrentUser_Name="Administrator")) & (Shift down)
		OBJECT SET VISIBLE:C603(*; "ForDesigner@"; True:C214)
	Else 
		
		ARRAY TEXT:C222(SIA_ListBoxWidths_atxt; 7)
		SIA_ListBoxWidths_atxt{1}:="72, 65, 66, 244, 64, 67, 91"  //Con Insp
		SIA_ListBoxWidths_atxt{2}:="67, 257, 64, 64, 64, 64, 100"  //Con rating
		SIA_ListBoxWidths_atxt{3}:="123, 70, 70,70,70,70,70,70,70"  //Ratings
		SIA_ListBoxWidths_atxt{4}:="172, 97, 192, 237"  //Seondary
		SIA_ListBoxWidths_atxt{5}:="63, 126, 81, 413"  //Design
		SIA_ListBoxWidths_atxt{6}:="153, 35, 27, 37, 28, 29, 26, 107, 40, 40, 40"  //Inspection
		SIA_ListBoxWidths_atxt{7}:="100, 20, 20"  //inventoryphotos
		OBJECT SET VISIBLE:C603(*; "ForDesigner@"; False:C215)
	End if 
	
Else 
	If ($ShowDesignerStuff_b)  //((◊CurrentUser_Name="Designer") | (◊CurrentUser_Name="Administrator")) & (Shift down)
		OBJECT SET VISIBLE:C603(*; "ForDesigner@"; True:C214)
	Else 
		
		ARRAY TEXT:C222(SIA_ListBoxWidths_atxt; 7)
		SIA_ListBoxWidths_atxt{1}:="72, 65, 66, 244, 64, 67, 91"  //Con Insp
		SIA_ListBoxWidths_atxt{2}:="67, 257, 64, 64, 64, 64, 100"  //Con rating
		SIA_ListBoxWidths_atxt{3}:="123, 70, 70,70,70,70,70,70,70"  //Ratings
		SIA_ListBoxWidths_atxt{4}:="172, 97, 192, 237"  //Seondary
		SIA_ListBoxWidths_atxt{5}:="63, 126, 81, 413"  //Design
		SIA_ListBoxWidths_atxt{6}:="153, 35, 27, 37, 28, 29, 26, 107, 40, 40, 40"  //Inspection
		SIA_ListBoxWidths_atxt{7}:="100, 20, 20"  //inventoryphotos
		OBJECT SET VISIBLE:C603(*; "ForDesigner@"; False:C215)
	End if 
End if 

Case of 
	: ($Page_l=2)  //ConsutantInspections
		ut_ControlLBSetUp("Cslt Insps"; Table:C252(->[Cons Inspection:64]))
		$ListBoxArea_txt:="ConsutantInspections"
		
		OBJECT SET VISIBLE:C603(*; "ConsutantInspections"; True:C214)
		
		C_LONGINT:C283($ColumnNumber_l)
		C_TEXT:C284($ColumnName_txt; $HeaderVarName_txt)
		C_POINTER:C301($HeaderVar_ptr; $ColumnVar_ptr)
		LISTBOX SET TABLE SOURCE:C1013(*; "ConsutantInspections"; Table:C252(->[Cons Inspection:64]))
		
		$ColumnNumber_l:=1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "ConsutantInspections"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		//BUTTON TEXT(LB_Header1_l;"Inspection Month")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238($ColumnVar_ptr->; False:C215)
		
		//Column 2
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "ConsutantInspections"; $ColumnNumber_l; $ColumnName_txt; [Cons Inspection:64]ReqFeeProposal:25; $HeaderVarName_txt; $HeaderVar_ptr->)
		//BUTTON TEXT(LB_Header2_l;"Req Fee Proposal")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		
		//Column 3
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "ConsutantInspections"; $ColumnNumber_l; $ColumnName_txt; [Cons Inspection:64]ProceedConDate:8; $HeaderVarName_txt; $HeaderVar_ptr->)
		//BUTTON TEXT(LB_Header3_l;"NTP Issued")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		
		//Column 4
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "ConsutantInspections"; $ColumnNumber_l; $ColumnName_txt; [Cons Inspection:64]AssignConName:5; $HeaderVarName_txt; $HeaderVar_ptr->)
		//BUTTON TEXT(LB_Header4_l;"Consultant Assigned")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		
		//Column 5
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "ConsutantInspections"; $ColumnNumber_l; $ColumnName_txt; [Cons Inspection:64]InspectionRecvd:29; $HeaderVarName_txt; $HeaderVar_ptr->)
		//BUTTON TEXT(LB_Header5_l;"Insp Received")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		
		
		//Column 6
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "ConsutantInspections"; $ColumnNumber_l; $ColumnName_txt; [Cons Inspection:64]ReportToDBIE:31; $HeaderVarName_txt; $HeaderVar_ptr->)
		//BUTTON TEXT(LB_Header6_l;"Insp given to DBIE")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		
		
		//Column 7
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "ConsutantInspections"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		//BUTTON TEXT(LB_Header7_l;"Status")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238($ColumnVar_ptr->; False:C215)
		
		
	: ($Page_l=3)  //ConsutantRatings
		$ListBoxArea_txt:="ConsutantRatings"
		
		ut_ControlLBSetUp("Cslt Ratings"; Table:C252(->[Conslt Rating:63]))
		
		OBJECT SET VISIBLE:C603(*; "ConsutantRatings"; True:C214)
		
		C_LONGINT:C283($ColumnNumber_l)
		C_TEXT:C284($ColumnName_txt; $HeaderVarName_txt)
		C_POINTER:C301($HeaderVar_ptr; $ColumnVar_ptr)
		LISTBOX SET TABLE SOURCE:C1013(*; "ConsutantRatings"; Table:C252(->[Conslt Rating:63]))
		
		$ColumnNumber_l:=0
		
		//Column 1
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "ConsutantRatings"; $ColumnNumber_l; $ColumnName_txt; [Conslt Rating:63]ProjManager:27; $HeaderVarName_txt; $HeaderVar_ptr->)
		//BUTTON TEXT(LB_Header2_l;"Req Fee Proposal")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column 2
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "ConsutantRatings"; $ColumnNumber_l; $ColumnName_txt; [Conslt Rating:63]AssignRatCons:5; $HeaderVarName_txt; $HeaderVar_ptr->)
		//BUTTON TEXT(LB_Header3_l;"NTP Issued")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align left:K42:2)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column 3
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "ConsutantRatings"; $ColumnNumber_l; $ColumnName_txt; [Conslt Rating:63]ReqFeeProposal:30; $HeaderVarName_txt; $HeaderVar_ptr->)
		//BUTTON TEXT(LB_Header4_l;"Consultant Assigned")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		
		//Column 4
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "ConsutantRatings"; $ColumnNumber_l; $ColumnName_txt; [Conslt Rating:63]ProceedRat:10; $HeaderVarName_txt; $HeaderVar_ptr->)
		//BUTTON TEXT(LB_Header5_l;"Insp Received")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		
		//Column 5
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "ConsutantRatings"; $ColumnNumber_l; $ColumnName_txt; [Conslt Rating:63]MostRecentSub:49; $HeaderVarName_txt; $HeaderVar_ptr->)
		//BUTTON TEXT(LB_Header6_l;"Insp given to DBIE")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		
		//Column 6
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "ConsutantRatings"; $ColumnNumber_l; $ColumnName_txt; [Conslt Rating:63]NBISLetter:26; $HeaderVarName_txt; $HeaderVar_ptr->)
		//BUTTON TEXT(LB_Header6_l;"Insp given to DBIE")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		
		//Column 7
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "ConsutantRatings"; $ColumnNumber_l; $ColumnName_txt; [Conslt Rating:63]AssignStatus:43; $HeaderVarName_txt; $HeaderVar_ptr->)
		//BUTTON TEXT(LB_Header6_l;"Insp given to DBIE")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
	: ($Page_l=4)  //RatingReports
		$ListBoxArea_txt:="RatingReports"
		ut_ControlLBSetUp("Ratings"; Table:C252(->[RatingReports:65]))
		LB_Header1_l:=0
		LB_Header2_l:=0
		LB_Header3_l:=0
		LB_Header4_l:=0
		LB_Header5_l:=0
		LB_Header6_l:=0
		LB_Header7_l:=0
		LB_Header8_l:=0
		LB_Header9_l:=0
		LB_Header10_l:=0
		
		C_LONGINT:C283($ColumnNumber_l)
		C_TEXT:C284($ColumnName_txt; $HeaderVarName_txt)
		C_POINTER:C301($HeaderVar_ptr; $ColumnVar_ptr)
		LISTBOX SET TABLE SOURCE:C1013(*; "RatingReports"; Table:C252(->[RatingReports:65]))
		LISTBOX DELETE COLUMN:C830(*; "RatingReports"; 1; 99)
		$ColumnNumber_l:=0
		LISTBOX SET HEADERS HEIGHT:C1143(*; "RatingReports"; 3; 1)  //3 lines
		LISTBOX SET ROWS HEIGHT:C835(*; "RatingReports"; 2; 1)  //3 lines
		//Column 1
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "RatingReports"; $ColumnNumber_l; $ColumnName_txt; [RatingReports:65]ReportDate:4; $HeaderVarName_txt; $HeaderVar_ptr->)
		//OBJECT SET TITLE(LB_Header1_l;"Report\\Date")
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Report\\Date")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET VERTICAL ALIGNMENT:C1187(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "RatingReports"; $ColumnNumber_l; $ColumnName_txt; [RatingReports:65]NBIS_Letter_d:36; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "NBIS\\Letter\\Date")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET VERTICAL ALIGNMENT:C1187(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "RatingReports"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Status")
		OBJECT SET VERTICAL ALIGNMENT:C1187(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align left:K42:2)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "pct")
		LISTBOX INSERT COLUMN:C829(*; "RatingReports"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Scan")
		OBJECT SET VERTICAL ALIGNMENT:C1187(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Scaled to fit prop centered:K6:6))
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "RatingReports"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Inv\\Oper")
		OBJECT SET VERTICAL ALIGNMENT:C1187(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column H20
		$ColumnNumber_l:=$ColumnNumber_l+1
		//LB_SetUPFieldColumn ($ColumnNumber_l;->$HeaderVarName_txt;->$HeaderVar_ptr;->$ColumnName_txt)
		//LISTBOX INSERT COLUMN(*;"RatingReports";$ColumnNumber_l;$ColumnName_txt;[RatingReports]InvH20;$HeaderVarName_txt;$HeaderVar_ptr->)
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "RatingReports"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "H-20")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		//OBJECT SET FORMAT(*;$ColumnName_txt;"##,##0.0")
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column Type3
		$ColumnNumber_l:=$ColumnNumber_l+1
		//LB_SetUPFieldColumn ($ColumnNumber_l;->$HeaderVarName_txt;->$HeaderVar_ptr;->$ColumnName_txt)
		//LISTBOX INSERT COLUMN(*;"RatingReports";$ColumnNumber_l;$ColumnName_txt;[RatingReports]InvType3;$HeaderVarName_txt;$HeaderVar_ptr->)
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "RatingReports"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Type 3")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		//OBJECT SET FORMAT(*;$ColumnName_txt;"##,##0.0")
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column 3S2
		$ColumnNumber_l:=$ColumnNumber_l+1
		//LB_SetUPFieldColumn ($ColumnNumber_l;->$HeaderVarName_txt;->$HeaderVar_ptr;->$ColumnName_txt)
		//LISTBOX INSERT COLUMN(*;"RatingReports";$ColumnNumber_l;$ColumnName_txt;[RatingReports]Inv3S2;$HeaderVarName_txt;$HeaderVar_ptr->)
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "RatingReports"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "Type\\3S2")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		//OBJECT SET FORMAT(*;$ColumnName_txt;"##,##0.0")
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column HS2044
		$ColumnNumber_l:=$ColumnNumber_l+1
		//LB_SetUPFieldColumn ($ColumnNumber_l;->$HeaderVarName_txt;->$HeaderVar_ptr;->$ColumnName_txt)
		//LISTBOX INSERT COLUMN(*;"RatingReports";$ColumnNumber_l;$ColumnName_txt;[RatingReports]InvHS2044;$HeaderVarName_txt;$HeaderVar_ptr->)
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "RatingReports"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "HS20\\-44")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		//OBJECT SET FORMAT(*;$ColumnName_txt;"##,##0.0")
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column SU4
		$ColumnNumber_l:=$ColumnNumber_l+1
		//LB_SetUPFieldColumn ($ColumnNumber_l;->$HeaderVarName_txt;->$HeaderVar_ptr;->$ColumnName_txt)
		//LISTBOX INSERT COLUMN(*;"RatingReports";$ColumnNumber_l;$ColumnName_txt;[RatingReports]OprH20;$HeaderVarName_txt;$HeaderVar_ptr->)
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "RatingReports"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "SU4")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		//OBJECT SET FORMAT(*;$ColumnName_txt;"##,##0.0")
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column SU5
		$ColumnNumber_l:=$ColumnNumber_l+1
		//LB_SetUPFieldColumn ($ColumnNumber_l;->$HeaderVarName_txt;->$HeaderVar_ptr;->$ColumnName_txt)
		//LISTBOX INSERT COLUMN(*;"RatingReports";$ColumnNumber_l;$ColumnName_txt;[RatingReports]OprType3;$HeaderVarName_txt;$HeaderVar_ptr->)
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "RatingReports"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "SU5")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		//OBJECT SET FORMAT(*;$ColumnName_txt;"##,##0.0")
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column SU6
		$ColumnNumber_l:=$ColumnNumber_l+1
		//LB_SetUPFieldColumn ($ColumnNumber_l;->$HeaderVarName_txt;->$HeaderVar_ptr;->$ColumnName_txt)
		//LISTBOX INSERT COLUMN(*;"RatingReports";$ColumnNumber_l;$ColumnName_txt;[RatingReports]Opr3S2;$HeaderVarName_txt;$HeaderVar_ptr->)
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "RatingReports"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "SU6")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		//OBJECT SET FORMAT(*;$ColumnName_txt;"##,##0.0")
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column SU7
		$ColumnNumber_l:=$ColumnNumber_l+1
		//LB_SetUPFieldColumn ($ColumnNumber_l;->$HeaderVarName_txt;->$HeaderVar_ptr;->$ColumnName_txt)
		//LISTBOX INSERT COLUMN(*;"RatingReports";$ColumnNumber_l;$ColumnName_txt;[RatingReports]OprHS2044;$HeaderVarName_txt;$HeaderVar_ptr->)
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "RatingReports"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "SU7")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		//OBJECT SET FORMAT(*;$ColumnName_txt;"##,##0.0")
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column EV2
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "RatingReports"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "EV2")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		//OBJECT SET FORMAT(*;$ColumnName_txt;"##,##0.0")
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column EV3
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "RatingReports"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(*; $HeaderVarName_txt; "EV3")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		//OBJECT SET FORMAT(*;$ColumnName_txt;"##,##0.0")
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
	: ($Page_l=5)  //Secondary
		$ListBoxArea_txt:="Secondary"
		LB_Header1_l:=0
		LB_Header2_l:=1
		LB_Header3_l:=0
		LB_Header4_l:=0
		OBJECT SET VISIBLE:C603(*; "Secondary"; True:C214)
		ut_ControlLBSetUp("Secondary"; Table:C252(->[NBIS Secondary:3]))
		
		C_LONGINT:C283($ColumnNumber_l)
		C_TEXT:C284($ColumnName_txt; $HeaderVarName_txt)
		C_POINTER:C301($HeaderVar_ptr; $ColumnVar_ptr)
		LISTBOX SET TABLE SOURCE:C1013(*; "Secondary"; Table:C252(->[NBIS Secondary:3]))
		LISTBOX DELETE COLUMN:C830(*; "Secondary"; 1; 99)
		$ColumnNumber_l:=0
		
		//Column 1
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "Secondary"; $ColumnNumber_l; $ColumnName_txt; [NBIS Secondary:3]Item8:38; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header1_l; "Item 8")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align left:K42:2)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column 2
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "Secondary"; $ColumnNumber_l; $ColumnName_txt; [NBIS Secondary:3]Item5:4; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header2_l; "Item 5")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column 3
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "Secondary"; $ColumnNumber_l; $ColumnName_txt; [NBIS Secondary:3]Item7:7; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header3_l; "Item 7")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align left:K42:2)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column 4
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "Secondary"; $ColumnNumber_l; $ColumnName_txt; [NBIS Secondary:3]Item6A:5; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header4_l; "Item 6A")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align left:K42:2)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
	: ($Page_l=6)  //BridgeDesign
		$ListBoxArea_txt:="BridgeDesign"
		ut_ControlLBSetUp("BridgeDesign"; Table:C252(->[Bridge Design:75]))
		LB_Header3_l:=2
		LB_Header4_l:=0
		
		OBJECT SET VISIBLE:C603(*; "BridgeDesign"; True:C214)
		
		C_LONGINT:C283($ColumnNumber_l)
		C_TEXT:C284($ColumnName_txt; $HeaderVarName_txt)
		C_POINTER:C301($HeaderVar_ptr; $ColumnVar_ptr)
		LISTBOX SET TABLE SOURCE:C1013(*; "BridgeDesign"; Table:C252(->[Bridge Design:75]))
		LISTBOX DELETE COLUMN:C830(*; "BridgeDesign"; 1; 99)
		$ColumnNumber_l:=0
		
		//Column 1
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "BridgeDesign"; $ColumnNumber_l; $ColumnName_txt; [Bridge Design:75]PROJIS:2; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header1_l; "PROJIS")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column 2
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "BridgeDesign"; $ColumnNumber_l; $ColumnName_txt; [Bridge Design:75]FAPNumber:3; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header2_l; "FAP No.")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align left:K42:2)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column 3
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "BridgeDesign"; $ColumnNumber_l; $ColumnName_txt; [Bridge Design:75]ADVDate:4; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header3_l; "ADV Date")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		
		//Column 4
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "BridgeDesign"; $ColumnNumber_l; $ColumnName_txt; [Bridge Design:75]ProjectType:7; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header4_l; "Type of Project")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align left:K42:2)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
	: ($Page_l=7)  //Inspections
		ut_ControlLBSetUp("Bridge-Inspections"; Table:C252(->[Combined Inspections:90]))
		$ListBoxArea_txt:="Inspections"
		OBJECT SET VISIBLE:C603(*; "Inspections"; True:C214)
		
		C_LONGINT:C283($ColumnNumber_l)
		$ColumnNumber_l:=0
		C_TEXT:C284($ColumnName_txt; $HeaderVarName_txt)
		C_POINTER:C301($HeaderVar_ptr; $ColumnVar_ptr)
		LISTBOX SET TABLE SOURCE:C1013(*; "Inspections"; Table:C252(->[Combined Inspections:90]))
		//Column 1
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "Inspections"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header1_l; "Type")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align left:K42:2)
		OBJECT SET ENTERABLE:C238($ColumnVar_ptr->; False:C215)
		//FONT(*;$ColumnName_txt;"Tahoma")
		//FONT SIZE(*;$ColumnName_txt;12)
		
		//Column 2
		$ColumnNumber_l:=$ColumnNumber_l+1
		//LB_SetUPFieldColumn ($ColumnNumber_l;->$HeaderVarName_txt;->$HeaderVar_ptr;->$ColumnName_txt)
		//INSERT LISTBOX COLUMN(*;"Inspections";$ColumnNumber_l;$ColumnName_txt;[Inspections]Item 41;$HeaderVarName_txt;$HeaderVar_ptr->)
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "Inspections"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header2_l; "41")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		//FONT(*;$ColumnName_txt;"Tahoma")
		//FONT SIZE(*;$ColumnName_txt;12)
		
		//Column 3
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "Inspections"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header3_l; "58")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238($ColumnVar_ptr->; False:C215)
		//FONT(*;$ColumnName_txt;"Tahoma")
		//FONT SIZE(*;$ColumnName_txt;12)
		
		//Column 4
		$ColumnNumber_l:=$ColumnNumber_l+1
		//LB_SetUPFieldColumn ($ColumnNumber_l;->$HeaderVarName_txt;->$HeaderVar_ptr;->$ColumnName_txt)
		//INSERT LISTBOX COLUMN(*;"Inspections";$ColumnNumber_l;$ColumnName_txt;[Inspections]Item 59;$HeaderVarName_txt;$HeaderVar_ptr->)
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "Inspections"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194($HeaderVar_ptr->; "59")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		//FONT(*;$ColumnName_txt;"Tahoma")
		//FONT SIZE(*;$ColumnName_txt;12)
		
		//Column 5
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "Inspections"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194($HeaderVar_ptr->; "60")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238($ColumnVar_ptr->; False:C215)
		//FONT(*;$ColumnName_txt;"Tahoma")
		//FONT SIZE(*;$ColumnName_txt;12)
		
		//Column 6
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "Inspections"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194($HeaderVar_ptr->; "61")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238($ColumnVar_ptr->; False:C215)
		//FONT(*;$ColumnName_txt;"Tahoma")
		//FONT SIZE(*;$ColumnName_txt;12)
		
		//Column 7
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; "Inspections"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194($HeaderVar_ptr->; "62")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238($ColumnVar_ptr->; False:C215)
		//FONT(*;$ColumnName_txt;"Tahoma")
		//FONT SIZE(*;$ColumnName_txt;12)
		
		//Column 8
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "Inspections"; $ColumnNumber_l; $ColumnName_txt; [Combined Inspections:90]InspDate:4; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194($HeaderVar_ptr->; "Insp. Date")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		//SET FORMAT(*;$ColumnName_txt;String(Internal date short ))
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		//FONT(*;$ColumnName_txt;"Tahoma")
		//FONT SIZE(*;$ColumnName_txt;12)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		
		//Column 9
		$ColumnNumber_l:=$ColumnNumber_l+1
		If (False:C215)
			LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
			LISTBOX INSERT COLUMN:C829(*; "Inspections"; $ColumnNumber_l; $ColumnName_txt; [Inspections:27]InspComplete:168; $HeaderVarName_txt; $HeaderVar_ptr->)
			OBJECT SET TITLE:C194($HeaderVar_ptr->; "C")
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
			OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
			//FONT(*;$ColumnName_txt;"Tahoma")
			//FONT SIZE(*;$ColumnName_txt;12)
		End if 
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "pct")
		LISTBOX INSERT COLUMN:C829(*; "Inspections"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194($HeaderVar_ptr->; "C")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Scaled to fit prop centered:K6:6))
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		//Column 10
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "pct")
		LISTBOX INSERT COLUMN:C829(*; "Inspections"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		If ([Bridge MHD NBIS:1]InspResp:173="MBTA")
			OBJECT SET TITLE:C194($HeaderVar_ptr->; "QC")
		Else 
			OBJECT SET TITLE:C194($HeaderVar_ptr->; "D.A.")
		End if 
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Scaled to fit prop centered:K6:6))
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		//FONT(*;$ColumnName_txt;"Tahoma")
		//FONT SIZE(*;$ColumnName_txt;12)
		
		//Column 11
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "pct")
		LISTBOX INSERT COLUMN:C829(*; "Inspections"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		If ([Bridge MHD NBIS:1]InspResp:173="MBTA")
			OBJECT SET TITLE:C194($HeaderVar_ptr->; "QA")
		Else 
			OBJECT SET TITLE:C194($HeaderVar_ptr->; "F.A.")
		End if 
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align left:K42:2)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Scaled to fit prop centered:K6:6))
		OBJECT SET ENTERABLE:C238($ColumnVar_ptr->; False:C215)
		//FONT(*;$ColumnName_txt;"Tahoma")
		//FONT SIZE(*;$ColumnName_txt;10)
		
		LB_Header1_l:=0
		LB_Header2_l:=0
		LB_Header3_l:=0
		LB_Header4_l:=0
		LB_Header5_l:=0
		LB_Header6_l:=0
		LB_Header7_l:=0
		LB_Header8_l:=2
		LB_Header9_l:=0
		LB_Header10_l:=0
		LB_Header11_l:=0
		
		ORDER BY:C49([Combined Inspections:90]; [Combined Inspections:90]InspDate:4; <)
		
	: ($Page_l=8)  //InventoryPhotos
		ut_ControlLBSetUp("InventoryPhotos"; Table:C252(->[InventoryPhotoInsp:112]))
		$ListBoxArea_txt:="InventoryPhotos"
		
		OBJECT SET VISIBLE:C603(*; "InventoryPhotos"; True:C214)
		
		C_LONGINT:C283($ColumnNumber_l)
		C_TEXT:C284($ColumnName_txt; $HeaderVarName_txt)
		C_POINTER:C301($HeaderVar_ptr; $ColumnVar_ptr)
		LISTBOX SET TABLE SOURCE:C1013(*; "InventoryPhotos"; Table:C252(->[InventoryPhotoInsp:112]))
		LISTBOX DELETE COLUMN:C830(*; ""; 1; 99)
		$ColumnNumber_l:=0
		LISTBOX SET HEADERS HEIGHT:C1143(*; "InventoryPhotos"; 2; lk lines:K53:23)
		
		//Column 1
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; "InventoryPhotos"; $ColumnNumber_l; $ColumnName_txt; [InventoryPhotoInsp:112]InvPhotoDate_D:3; $HeaderVarName_txt; $HeaderVar_ptr->)
		//BUTTON TEXT($HeaderVar_ptr->;"?")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		//SET FORMAT(*;$ColumnName_txt;Char(Internal date short ))
		OBJECT SET TITLE:C194($HeaderVar_ptr->; "Inventory Photo\rDate")
		
		//Column 2
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "pct")
		LISTBOX INSERT COLUMN:C829(*; "InventoryPhotos"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		//BUTTON TEXT($HeaderVar_ptr->;"")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Scaled to fit prop centered:K6:6))
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		OBJECT SET TITLE:C194($HeaderVar_ptr->; "Compl.\r(TL)")
		
		//Column 3
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "pct")
		LISTBOX INSERT COLUMN:C829(*; "InventoryPhotos"; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		//BUTTON TEXT($HeaderVar_ptr->;"")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Scaled to fit prop centered:K6:6))
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		If ([Bridge MHD NBIS:1]InspResp:173="MBTA")
			OBJECT SET TITLE:C194($HeaderVar_ptr->; "Appr (MBTA\rQC)")
		Else 
			OBJECT SET TITLE:C194($HeaderVar_ptr->; "Appr.\r(DBIE)")
		End if 
		
		
	: ($Page_l=11)  //TunnelInspections
		ut_ControlLBSetUp("Tunnel-Inspections"; Table:C252(->[Combined Inspections:90]))
		$ListBoxArea_txt:="TunnelInspections"
		OBJECT SET VISIBLE:C603(*; $ListBoxArea_txt; True:C214)
		
		C_LONGINT:C283($ColumnNumber_l)
		$ColumnNumber_l:=0
		C_TEXT:C284($ColumnName_txt; $HeaderVarName_txt)
		C_POINTER:C301($HeaderVar_ptr; $ColumnVar_ptr)
		LISTBOX SET TABLE SOURCE:C1013(*; $ListBoxArea_txt; Table:C252(->[Combined Inspections:90]))
		//Column 1
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; $ListBoxArea_txt; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header1_l; "Type")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align left:K42:2)
		OBJECT SET ENTERABLE:C238($ColumnVar_ptr->; False:C215)
		//FONT(*;$ColumnName_txt;"Tahoma")
		//FONT SIZE(*;$ColumnName_txt;12)
		
		//Column 2
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; $ListBoxArea_txt; $ColumnNumber_l; $ColumnName_txt; [Inspections:27]Item 41:77; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header2_l; "41")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		//FONT(*;$ColumnName_txt;"Tahoma")
		//FONT SIZE(*;$ColumnName_txt;12)
		
		//Column 3
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; $ListBoxArea_txt; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194(LB_Header3_l; "62a")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238($ColumnVar_ptr->; False:C215)
		//FONT(*;$ColumnName_txt;"Tahoma")
		//FONT SIZE(*;$ColumnName_txt;12)
		
		//Column 4
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; $ListBoxArea_txt; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194($HeaderVar_ptr->; "62b")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		//FONT(*;$ColumnName_txt;"Tahoma")
		//FONT SIZE(*;$ColumnName_txt;12)
		
		//Column 5
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; $ListBoxArea_txt; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194($HeaderVar_ptr->; "62c")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238($ColumnVar_ptr->; False:C215)
		//FONT(*;$ColumnName_txt;"Tahoma")
		//FONT SIZE(*;$ColumnName_txt;12)
		
		//Column 6
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; $ListBoxArea_txt; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194($HeaderVar_ptr->; "62d")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238($ColumnVar_ptr->; False:C215)
		//FONT(*;$ColumnName_txt;"Tahoma")
		//FONT SIZE(*;$ColumnName_txt;12)
		
		//Column 7
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; $ListBoxArea_txt; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194($HeaderVar_ptr->; "62e")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238($ColumnVar_ptr->; False:C215)
		//FONT(*;$ColumnName_txt;"Tahoma")
		//FONT SIZE(*;$ColumnName_txt;12)
		
		//Column 7
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; $ListBoxArea_txt; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194($HeaderVar_ptr->; "62f")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238($ColumnVar_ptr->; False:C215)
		
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "txt")
		LISTBOX INSERT COLUMN:C829(*; $ListBoxArea_txt; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194($HeaderVar_ptr->; "62g")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238($ColumnVar_ptr->; False:C215)
		
		//$ColumnNumber_l:=$ColumnNumber_l+1
		//LB_SetUPVariableColumn ($ColumnNumber_l;->$HeaderVarName_txt;->$ColumnVar_ptr;->$HeaderVar_ptr;->$ColumnName_txt;"txt")
		//INSERT LISTBOX COLUMN(*;$ListBoxArea_txt;$ColumnNumber_l;$ColumnName_txt;$ColumnVar_ptr->;$HeaderVarName_txt;$HeaderVar_ptr->)
		//BUTTON TEXT($HeaderVar_ptr->;"62h")
		//SET ALIGNMENT(*;$ColumnName_txt;Center )
		//SET ENTERABLE($ColumnVar_ptr->;False)
		
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPFieldColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$HeaderVar_ptr; ->$ColumnName_txt)
		LISTBOX INSERT COLUMN:C829(*; $ListBoxArea_txt; $ColumnNumber_l; $ColumnName_txt; [Combined Inspections:90]InspDate:4; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194($HeaderVar_ptr->; "Insp. Date")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "pct")
		LISTBOX INSERT COLUMN:C829(*; $ListBoxArea_txt; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		OBJECT SET TITLE:C194($HeaderVar_ptr->; "C")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Scaled to fit prop centered:K6:6))
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "pct")
		LISTBOX INSERT COLUMN:C829(*; $ListBoxArea_txt; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		If ([Bridge MHD NBIS:1]InspResp:173="MBTA")
			OBJECT SET TITLE:C194($HeaderVar_ptr->; "QC")
		Else 
			OBJECT SET TITLE:C194($HeaderVar_ptr->; "D.A.")
		End if 
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align center:K42:3)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Scaled to fit prop centered:K6:6))
		OBJECT SET ENTERABLE:C238(*; $ColumnName_txt; False:C215)
		
		$ColumnNumber_l:=$ColumnNumber_l+1
		LB_SetUPVariableColumn($ColumnNumber_l; ->$HeaderVarName_txt; ->$ColumnVar_ptr; ->$HeaderVar_ptr; ->$ColumnName_txt; "pct")
		LISTBOX INSERT COLUMN:C829(*; $ListBoxArea_txt; $ColumnNumber_l; $ColumnName_txt; $ColumnVar_ptr->; $HeaderVarName_txt; $HeaderVar_ptr->)
		If ([Bridge MHD NBIS:1]InspResp:173="MBTA")
			OBJECT SET TITLE:C194($HeaderVar_ptr->; "QA")
		Else 
			OBJECT SET TITLE:C194($HeaderVar_ptr->; "F.A.")
		End if 
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColumnName_txt; Align left:K42:2)
		OBJECT SET FORMAT:C236(*; $ColumnName_txt; Char:C90(Scaled to fit prop centered:K6:6))
		OBJECT SET ENTERABLE:C238($ColumnVar_ptr->; False:C215)
		
		LB_Header1_l:=0
		LB_Header2_l:=0
		LB_Header3_l:=0
		LB_Header4_l:=0
		LB_Header5_l:=0
		LB_Header6_l:=0
		LB_Header7_l:=0
		LB_Header8_l:=0
		LB_Header9_l:=0
		LB_Header10_l:=0
		LB_Header11_l:=0
		LB_Header12_l:=0
		LB_Header13_l:=0
		
		ORDER BY:C49([Combined Inspections:90]; [Combined Inspections:90]InspDate:4; <)
		
	Else 
		$SetUp_b:=False:C215
End case 

If ($SetUp_b)
	SIA_ResetWidths($ListBoxArea_txt; $SetUp_b)
End if 

If ($ShowDesignerStuff_b)  // ((◊CurrentUser_Name="Designer") | (◊CurrentUser_Name="Administrator"))&(Shift down)
	C_LONGINT:C283($Left_l; $top_l; $Right_l; $Bottom_l)
	OBJECT GET COORDINATES:C663(*; $ListBoxArea_txt; $Left_l; $top_l; $Right_l; $Bottom_l)
	C_LONGINT:C283($Left1_l; $top1_l; $Right1_l; $Bottom1_l)
	OBJECT GET COORDINATES:C663(*; "ForDesigner3"; $Left1_l; $top1_l; $Right1_l; $Bottom1_l)
	If ($Bottom_l>=$top1_l)
		OBJECT MOVE:C664(*; $ListBoxArea_txt; 0; 0; 0; $top1_l-$Bottom_l-20)
	Else 
		
	End if 
End if 
//Case of 
//: ($Page_l=7)
//REDRAW(Inspections)
//End case 
//End SIA_SetUpListBoxes