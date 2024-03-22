//%attributes = {"invisible":true}
// Method: PRV_CTRLListBoxes
// Description
// 
// Parameters
// $1 : $Task_txt ("LOAD" | "SAVE" | "INIT"; "MAKEALLVARS" "SETCOLVARS" "DELALLCOLUMNS")
// ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 06/04/12, 11:41:57
	// ----------------------------------------------------
	// First Release
	Mods_2012_06
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
End if 
C_TEXT:C284($1; $Task_txt)

If (Count parameters:C259>0)
	$Task_txt:=$1
Else 
	$Task_txt:="MAKEALLVARS"
End if 

C_TEXT:C284($LBName_txt; $ColName_txt; $HdrVarName_txt)
C_POINTER:C301($HdrVar_ptr; $ColumnVar_ptr)
C_LONGINT:C283($colNum_L)
Case of 
	: ($Task_txt="SETCOLVARS")
		C_TEXT:C284($2; $LBCODE_txt)
		$LBCODE_txt:=$2
		C_LONGINT:C283($3)
		C_POINTER:C301($4; $HdrName_ptr; $5; $HdrVarPtr_ptr; $6; $ColName_ptr)
		$HdrName_ptr:=$4
		$HdrVarPtr_ptr:=$5
		$ColName_ptr:=$6
		$HdrName_ptr->:="LB_"+$LBCODE_txt+"_HDR"+String:C10($3; "00")
		$ColName_ptr->:="LB_"+$LBCODE_txt+"_COL"+String:C10($3; "00")
		$HdrVarPtr_ptr->:=Get pointer:C304(($HdrName_ptr->)+"_L")
		If (Count parameters:C259>6)
			C_POINTER:C301($7)
			C_TEXT:C284($8)
			$7->:=Get pointer:C304("LB_"+$LBCODE_txt+"_Det"+String:C10($3; "00")+"_"+$8)
		End if 
		
	: ($Task_txt="DELALLCOLUMNS")
		C_TEXT:C284($2; $LBName_txt)
		$LBName_txt:=$2
		C_LONGINT:C283($NumColumns_L; $loop_L)
		$NumColumns_L:=LISTBOX Get number of columns:C831(*; $LBName_txt)
		LISTBOX DELETE COLUMN:C830(*; $LBName_txt; 1; $NumColumns_L)
		
	: ($Task_txt="SETWIDTHLB")
		C_TEXT:C284($2; $LBName_txt)
		$LBName_txt:=$2
		C_LONGINT:C283($NumColumns_L; $loop_L; $TotalWitdh_L; $L_L; $T_L; $R_L; $B_L; $ColW_L)
		OBJECT GET COORDINATES:C663(*; $LBName_txt; $L_L; $T_L; $R_L; $B_L)
		$NumColumns_L:=LISTBOX Get number of columns:C831(*; $LBName_txt)
		ARRAY TEXT:C222($Col_atxt; 0)
		ARRAY TEXT:C222($hdr_atxt; 0)
		ARRAY POINTER:C280($col_aptr; 0)
		ARRAY POINTER:C280($hdr_aptr; 0)
		ARRAY BOOLEAN:C223($colvis_ab; 0)
		ARRAY POINTER:C280($styles_aptr; 0)
		LISTBOX GET ARRAYS:C832(*; $LBName_txt; $Col_atxt; $hdr_atxt; $col_aptr; $hdr_aptr; $colvis_ab; $styles_aptr)
		$TotalWitdh_L:=20
		
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($hdr_atxt))
			$ColW_L:=LISTBOX Get column width:C834(*; $hdr_atxt{$loop_L})
			$TotalWitdh_L:=$TotalWitdh_L+$ColW_L
		End for 
		
		If (Not:C34(PRV_FORM_LOADED_b))
			OBJECT MOVE:C664(*; $LBName_txt; 0; 0; ($TotalWitdh_L-($R_L-$L_L)); 0)
		End if 
		
	: ($Task_txt="ALIGNTXTHDRS")
		C_TEXT:C284($2; $LBRootName_txt; $LBName_txt; $HDRName_txt)
		$LBRootName_txt:=$2
		$LBName_txt:="PRV_"+$LBRootName_txt+"_LB"
		C_LONGINT:C283($NumColumns_L; $loop_L; $TotalWitdh_L; $L_L; $T_L; $R_L; $B_L; $ColW_L; $HDRL_L; $HDRT_L; $HDRR_L; $HDRB_L)
		OBJECT GET COORDINATES:C663(*; $LBName_txt; $L_L; $T_L; $R_L; $B_L)
		ARRAY TEXT:C222($Col_atxt; 0)
		ARRAY TEXT:C222($hdr_atxt; 0)
		ARRAY POINTER:C280($col_aptr; 0)
		ARRAY POINTER:C280($hdr_aptr; 0)
		ARRAY BOOLEAN:C223($colvis_ab; 0)
		ARRAY POINTER:C280($styles_aptr; 0)
		LISTBOX GET ARRAYS:C832(*; $LBName_txt; $Col_atxt; $hdr_atxt; $col_aptr; $hdr_aptr; $colvis_ab; $styles_aptr)
		
		C_LONGINT:C283($loop_L; $loop_2_L)
		For ($loop_L; 1; Size of array:C274($hdr_atxt))
			$ColW_L:=LISTBOX Get column width:C834(*; $hdr_atxt{$loop_L})
			$R_L:=$L_L+$ColW_L
			$HDRName_txt:="LBL_"+$LBRootName_txt+"_"+String:C10($loop_L)+"_@"
			OBJECT GET COORDINATES:C663(*; $HDRName_txt; $HDRL_L; $HDRT_L; $HDRR_L; $HDRB_L)
			If (($HDRR_L-$HDRL_L)>0)
				OBJECT MOVE:C664(*; $HDRName_txt; ($L_L-$HDRL_L); 0; ($ColW_L-$HDRR_L+$HDRL_L); 0)
			End if 
			$HDRName_txt:="SPANLBL_"+$LBRootName_txt+"_"+String:C10($loop_L)+"_@"
			OBJECT GET COORDINATES:C663(*; $HDRName_txt; $HDRL_L; $HDRT_L; $HDRR_L; $HDRB_L)
			If (($HDRR_L-$HDRL_L)>0)
				OBJECT MOVE:C664(*; $HDRName_txt; ($L_L-$HDRL_L); 0; 0; 0)
			End if 
			
			For ($loop_2_L; 1; $loop_L)
				$HDRName_txt:="SPANLBL_"+$LBRootName_txt+"_"+String:C10($loop_2_L)+"_"+String:C10($loop_L)+"_@"
				OBJECT GET COORDINATES:C663(*; $HDRName_txt; $HDRL_L; $HDRT_L; $HDRR_L; $HDRB_L)
				If (($HDRR_L-$HDRL_L)>0)
					OBJECT MOVE:C664(*; $HDRName_txt; 0; 0; ($R_L-$HDRR_L); 0)
				End if 
				
			End for 
			
			$L_L:=$R_L
		End for 
		
	: ($Task_txt="SETLBTYPAPPROVAL")
		
		C_TEXT:C284($2; $LBName_txt; $LBNameRoot_txt)
		$LBNameRoot_txt:=$2
		$LBName_txt:="PRV_"+$2+"_LB"
		PRV_CTRLListBoxes("DELALLCOLUMNS"; $LBName_txt)
		$colNum_L:=0
		
		C_TEXT:C284($elmt_txt; $CertYN_txt; $CertTypeYN_txt; $SendTo_txt; $SubmRecdYN_txt; $SENDSUBMTO_txt)
		C_BOOLEAN:C305($FIRSTSTEP_Recd_b)
		C_BOOLEAN:C305($CertYN_b; $CertTypeYN_b)
		$CertYN_b:=False:C215
		$CertTypeYN_b:=False:C215
		$elmt_txt:=DOM Find XML element:C864(PRV_REVIEWTYPESTREE_txt; "PRV_ReviewTypes/"+$LBNameRoot_txt)
		If (OK=1)
			ON ERR CALL:C155("Error Handler")
			DOM GET XML ATTRIBUTE BY NAME:C728($elmt_txt; "CERT"; $CertYN_b)
			DOM GET XML ATTRIBUTE BY NAME:C728($elmt_txt; "CERTTYPE"; $CertTypeYN_b)
			DOM GET XML ATTRIBUTE BY NAME:C728($elmt_txt; "SENDTO"; $SENDSUBMTO_txt)
			DOM GET XML ATTRIBUTE BY NAME:C728($elmt_txt; "SUBMRCD"; $FIRSTSTEP_Recd_b)
			ON ERR CALL:C155("")
		End if 
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $LBNameRoot_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Preservation_Reviews:145]SentToREviewer_d:5; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Date Subm.")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 95)
		
		//$colNum_L:=$colNum_L+1
		//PRV_CTRLListBoxes ("SETCOLVARS";$Task_txt;$colNum_L;->$HdrVarName_txt;->$HdrVar_ptr;->$ColName_txt)
		//INSERT LISTBOX COLUMN(*;$LBName_txt;$colNum_L;$ColName_txt;[Preservation_Reviews]Reviewer_s;$HdrVarName_txt;$HdrVar_ptr->)
		//SET ALIGNMENT(*;$ColName_txt;Center )
		//SET ENTERABLE(*;$ColName_txt;False)
		//SET FORMAT(*;$ColName_txt;Char(Internal date short +Blank if null date ))
		//SET LISTBOX COLUMN WIDTH(*;$ColName_txt;180)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $LBNameRoot_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Preservation_Reviews:145]CommentsRecd_d:7; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Response Date")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 115)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $LBNameRoot_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Preservation_Reviews:145]Action_s:8; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		If ($CertYN_b)
			OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Certificate Issued")
		Else 
			OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Approval")
		End if 
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 180)
		
		If ($CertTypeYN_b)
			$colNum_L:=$colNum_L+1
			PRV_CTRLListBoxes("SETCOLVARS"; $LBNameRoot_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
			LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Preservation_Reviews:145]CertificateType_s:10; $HdrVarName_txt; $HdrVar_ptr->)
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
			OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
			//SET FORMAT(*;$ColName_txt;Char(Internal date short +Blank if null date ))
			OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Certificate Type")
			LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 130)
		End if 
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $LBNameRoot_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Preservation_Reviews:145]SentBackToPM_d:9; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Sent To Conslt./P.M.")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 145)
		
		PRV_CTRLListBoxes("SETWIDTHLB"; $LBName_txt)
		
	: ($Task_txt="SETLBTYPREVIEW")
		
		C_TEXT:C284($2; $LBName_txt; $LBNameRoot_txt)
		$LBNameRoot_txt:=$2
		$LBName_txt:="PRV_"+$2+"_LB"
		PRV_CTRLListBoxes("DELALLCOLUMNS"; $LBName_txt)
		$colNum_L:=0
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $LBNameRoot_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Preservation_Reviews:145]Received_d:4; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 75)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $LBNameRoot_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Preservation_Reviews:145]SentToDistr_d:13; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 75)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $LBNameRoot_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Preservation_Reviews:145]Deadline_d:12; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 75)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $LBNameRoot_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Preservation_Reviews:145]Reviewer_s:6; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align left:K42:2)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 220)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $LBNameRoot_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Preservation_Reviews:145]CommentsRecd_d:7; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 80)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $LBNameRoot_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Preservation_Reviews:145]SentToREviewer_d:5; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 80)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $LBNameRoot_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Preservation_Reviews:145]ReviewerDeadline_d:14; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 80)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $LBNameRoot_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Preservation_Reviews:145]DistrCmtsReviewed_d:15; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 85)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $LBNameRoot_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Preservation_Reviews:145]Action_s:8; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align left:K42:2)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 220)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $LBNameRoot_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Preservation_Reviews:145]SentBackToPM_d:9; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 75)
		PRV_CTRLListBoxes("SETWIDTHLB"; $LBName_txt)
		
	: ($Task_txt="SETUPALL")
		
		PRV_CTRLListBoxes("STR25")
		PRV_CTRLListBoxes("HWY25")
		PRV_CTRLListBoxes("STR90")
		PRV_CTRLListBoxes("HWY75")
		PRV_CTRLListBoxes("FINALPSE")
		PRV_CTRLListBoxes("FINALPSEASST")
		PRV_CTRLListBoxes("ROW")
		PRV_CTRLListBoxes("ENV")
		PRV_CTRLListBoxes("TRA")
		PRV_CTRLListBoxes("CONSTR")
		PRV_CTRLListBoxes("OTHER")
		PRV_CTRLListBoxes("FHWA")
		PRV_CTRLListBoxes("BRIDGES")
		PRV_CTRLListBoxes("BRIDGESDEC")
		PRV_CTRLListBoxes("ADDENDUMS")
		PRV_CTRLListBoxes("INVOICES")
		PRV_CTRLListBoxes("PUBMTGS")
		PRV_CTRLListBoxes("CSLTMTGS")
		
	: ($Task_txt="STR25")
		PRV_CTRLListBoxes("SETLBTYPREVIEW"; $Task_txt)
		PRV_CTRLListBoxes("ALIGNTXTHDRS"; $Task_txt)
		
	: ($Task_txt="HWY25")
		PRV_CTRLListBoxes("SETLBTYPREVIEW"; $Task_txt)
		
	: ($Task_txt="STR90")
		PRV_CTRLListBoxes("SETLBTYPREVIEW"; $Task_txt)
		
	: ($Task_txt="HWY75")
		PRV_CTRLListBoxes("SETLBTYPREVIEW"; $Task_txt)
		
	: ($Task_txt="FINALPSE")
		PRV_CTRLListBoxes("SETLBTYPREVIEW"; $Task_txt)
		
	: ($Task_txt="FINALPSEASST")
		PRV_CTRLListBoxes("SETLBTYPREVIEW"; $Task_txt)
		
	: ($Task_txt="ROW")
		PRV_CTRLListBoxes("SETLBTYPAPPROVAL"; $Task_txt)
		
	: ($Task_txt="ENV")
		PRV_CTRLListBoxes("SETLBTYPAPPROVAL"; $Task_txt)
		
	: ($Task_txt="TRA")
		PRV_CTRLListBoxes("SETLBTYPAPPROVAL"; $Task_txt)
		
	: ($Task_txt="CONSTR")
		PRV_CTRLListBoxes("SETLBTYPAPPROVAL"; $Task_txt)
		
	: ($Task_txt="OTHER")
		PRV_CTRLListBoxes("SETLBTYPAPPROVAL"; $Task_txt)
		
	: ($Task_txt="FHWA")
		PRV_CTRLListBoxes("SETLBTYPAPPROVAL"; $Task_txt)
		
	: ($Task_txt="ADDENDUMS")
		
		$LBName_txt:="PRV_"+$Task_txt+"_LB"
		
		PRV_CTRLListBoxes("DELALLCOLUMNS"; $LBName_txt)
		
		$colNum_L:=0
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Addendum_Maintenance:102]AddendumNo:2; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 35)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "No.")
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Addendum_Maintenance:102]Est_HRS_r:20; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; "###,###.0;;0")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 85)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Work Hrs")
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Addendum_Maintenance:102]Est_TotalLimitFee:16; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; "$###,###,###.00;;$0")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 140)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align right:K42:4)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Total Limiting Fee")
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Addendum_Maintenance:102]Est_DirectExpense:11; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; "$###,###,###.00;;$0")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 140)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align right:K42:4)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Total Direct Expenses")
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Addendum_Maintenance:102]Appr_HRS_r:21; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; "###,###.0;;0")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 85)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Work HRS")
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Addendum_Maintenance:102]Appr_TotalLimmitFee_r:22; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; "$###,###,###.00;;$0")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align right:K42:4)
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 140)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Total Limiting Fee")
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Addendum_Maintenance:102]Appr_DirectExpense_r:23; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; "$###,###,###.00;;$0")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align right:K42:4)
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 140)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Total Direct Expenses")
		
		PRV_CTRLListBoxes("ALIGNTXTHDRS"; $Task_txt)
		PRV_CTRLListBoxes("SETWIDTHLB"; $LBName_txt)
		
	: ($Task_txt="INVOICES")
		
		$LBName_txt:="PRV_"+$Task_txt+"_LB"
		PRV_CTRLListBoxes("DELALLCOLUMNS"; $LBName_txt)
		
		$colNum_L:=0
		//1
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Invoice_Maintenance:95]InvoiceNo:2; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 35)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "No.")
		//2
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Invoice_Maintenance:95]InvoiceDate_d:19; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 95)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Invoice Date")
		//3
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Invoice_Maintenance:95]DateReceived:4; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 95)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Date Rec'd")
		//4
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Invoice_Maintenance:95]TotalHRS_r:18; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; "###,###.0;;0")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 70)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "HRS")
		//5
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt; ->$ColumnVar_ptr; "r")
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; $ColumnVar_ptr->; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; "$###,###,###.00;;$0")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align right:K42:4)
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 140)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Limiting Fee")
		//6
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Invoice_Maintenance:95]DirectExpenses:15; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; "$###,###,###.00;;$0")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 140)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align right:K42:4)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Direct Expenses")
		//7
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt; ->$ColumnVar_ptr; "r")
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; $ColumnVar_ptr->; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; "$###,###,###.00;;$0")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 140)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align right:K42:4)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Total")
		//8
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Invoice_Maintenance:95]DateProcessFoward:9; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET FORMAT:C236(*; $ColName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 110)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Date Processed")
		
		PRV_CTRLListBoxes("ALIGNTXTHDRS"; $Task_txt)
		PRV_CTRLListBoxes("SETWIDTHLB"; $LBName_txt)
		
	: ($Task_txt="BRIDGESDEC")
		$LBName_txt:="PRV_"+$Task_txt+"_LB"
		PRV_CTRLListBoxes("DELALLCOLUMNS"; $LBName_txt)
		
		$colNum_L:=0
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Contract_Project_Maintenance:100]BIN:5; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "BIN")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 40)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Bridge MHD NBIS:1]Item27:83; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "I-27")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 40)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Bridge MHD NBIS:1]Item106:84; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "I-106")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 40)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Bridge MHD NBIS:1]Item58:130; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "I-58")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 40)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Bridge MHD NBIS:1]Item59:131; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "I-59")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 40)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Bridge MHD NBIS:1]Item60:132; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "I-60")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 40)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Bridge MHD NBIS:1]Item62:134; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "I-62")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 40)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Bridge MHD NBIS:1]Item67:142; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "I-67")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 40)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Bridge MHD NBIS:1]Item71:145; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "I-71")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 40)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Bridge MHD NBIS:1]Item113:151; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "I-113")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 40)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt; ->$ColumnVar_ptr; "txt")
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; $ColumnVar_ptr->; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Paint")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 40)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt; ->$ColumnVar_ptr; "txt")
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; $ColumnVar_ptr->; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "I-36")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 40)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt; ->$ColumnVar_ptr; "txt")
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; $ColumnVar_ptr->; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Area")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 80)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt; ->$ColumnVar_ptr; "txt")
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; $ColumnVar_ptr->; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "VertCL")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 55)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt; ->$ColumnVar_ptr; "txt")
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; $ColumnVar_ptr->; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "HI")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 55)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt; ->$ColumnVar_ptr; "txt")
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; $ColumnVar_ptr->; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "ADT")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 80)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt; ->$ColumnVar_ptr; "txt")
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; $ColumnVar_ptr->; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Detour")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 55)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt; ->$ColumnVar_ptr; "txt")
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; $ColumnVar_ptr->; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align left:K42:2)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Func.Class")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 180)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt; ->$ColumnVar_ptr; "txt")
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; $ColumnVar_ptr->; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Rank")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 50)
		
	: ($Task_txt="INSPECT")
		$LBName_txt:="PRV_"+$Task_txt+"_LB"
		PRV_CTRLListBoxes("DELALLCOLUMNS"; $LBName_txt)
		C_TEXT:C284($ColumnWidths_txt; PRV_LBCOLWIDTH_txt)
		$ColumnWidths_txt:="153, 35, 27, 37, 28, 29, 26, 107, 40, 40, 40"  //Inspection
		Begin SQL
			select [LB_QueryTable].[ColumnWidths_txt]
			from [LB_QueryTable]
			where [LB_QueryTable].[QueryName_s] = 'Bridge-Inspections'
			and [LB_QueryTable].[ColumnWidths_txt] is not null
			into :PRV_LBCOLWIDTH_txt ;
		End SQL
		
		If (PRV_LBCOLWIDTH_txt#"")
			$ColumnWidths_txt:=PRV_LBCOLWIDTH_txt
		End if 
		ARRAY TEXT:C222($Widths_atxt; 0)
		ut_TextToArray($ColumnWidths_txt; ->$Widths_atxt; ",")
		
		$colNum_L:=0
		
		//Column 1
		$colNum_L:=$colNum_L+1
		
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt; ->$ColumnVar_ptr; "txt")
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; $ColumnVar_ptr->; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Type")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align left:K42:2)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		//FONT(*;$ColName_txt;"Tahoma")
		//FONT SIZE(*;$ColName_txt;12)
		If ($colNum_L>Size of array:C274($Widths_atxt))
			LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 50)
		Else 
			LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; Num:C11($Widths_atxt{$colNum_L}))
		End if 
		
		//Column 2
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Inspections:27]Item 41:77; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "41")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		//FONT(*;$ColName_txt;"Tahoma")
		//FONT SIZE(*;$ColName_txt;12)
		If ($colNum_L>Size of array:C274($Widths_atxt))
			LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 50)
		Else 
			LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; Num:C11($Widths_atxt{$colNum_L}))
		End if 
		
		//Column 3
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt; ->$ColumnVar_ptr; "txt")
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; $ColumnVar_ptr->; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "58")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		//FONT(*;$ColName_txt;"Tahoma")
		//FONT SIZE(*;$ColName_txt;12)
		If ($colNum_L>Size of array:C274($Widths_atxt))
			LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 50)
		Else 
			LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; Num:C11($Widths_atxt{$colNum_L}))
		End if 
		
		//Column 4
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Inspections:27]Item 59:80; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "59")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		//FONT(*;$ColName_txt;"Tahoma")
		//FONT SIZE(*;$ColName_txt;12)
		If ($colNum_L>Size of array:C274($Widths_atxt))
			LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 50)
		Else 
			LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; Num:C11($Widths_atxt{$colNum_L}))
		End if 
		
		//Column 5
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt; ->$ColumnVar_ptr; "txt")
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; $ColumnVar_ptr->; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "60")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		//FONT(*;$ColName_txt;"Tahoma")
		//FONT SIZE(*;$ColName_txt;12)
		If ($colNum_L>Size of array:C274($Widths_atxt))
			LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 50)
		Else 
			LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; Num:C11($Widths_atxt{$colNum_L}))
		End if 
		
		//Column 6
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt; ->$ColumnVar_ptr; "txt")
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; $ColumnVar_ptr->; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "61")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		//FONT(*;$ColName_txt;"Tahoma")
		If ($colNum_L>Size of array:C274($Widths_atxt))
			LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 50)
		Else 
			LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; Num:C11($Widths_atxt{$colNum_L}))
		End if 
		//FONT SIZE(*;$ColName_txt;12)
		
		//Column 7
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt; ->$ColumnVar_ptr; "txt")
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; $ColumnVar_ptr->; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "62")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		//FONT(*;$ColName_txt;"Tahoma")
		//FONT SIZE(*;$ColName_txt;12)
		If ($colNum_L>Size of array:C274($Widths_atxt))
			LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 50)
		Else 
			LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; Num:C11($Widths_atxt{$colNum_L}))
		End if 
		
		//Column 8
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Combined Inspections:90]InspDate:4; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Insp. Date")
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		//SET FORMAT(*;$ColName_txt;String(Internal date short ))
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		//FONT(*;$ColName_txt;"Tahoma")
		//FONT SIZE(*;$ColName_txt;12)
		OBJECT SET FORMAT:C236(*; $ColName_txt; Char:C90(Internal date short:K1:7+Blank if null date:K1:9))
		If ($colNum_L>Size of array:C274($Widths_atxt))
			LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 50)
		Else 
			LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; Num:C11($Widths_atxt{$colNum_L}))
		End if 
		
		//Column 9
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt; ->$ColumnVar_ptr; "pct")
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; $ColumnVar_ptr->; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "C")
		//SET ALIGNMENT(*;$ColName_txt;Center )
		OBJECT SET FORMAT:C236(*; $ColName_txt; Char:C90(Scaled to fit prop centered:K6:6))
		//SET ENTERABLE(*;$ColName_txt;False)
		If ($colNum_L>Size of array:C274($Widths_atxt))
			LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 50)
		Else 
			LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; Num:C11($Widths_atxt{$colNum_L}))
		End if 
		
		//Column 10
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt; ->$ColumnVar_ptr; "pct")
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; $ColumnVar_ptr->; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "D.A.")
		//SET ALIGNMENT(*;$ColName_txt;Center )
		OBJECT SET FORMAT:C236(*; $ColName_txt; Char:C90(Scaled to fit prop centered:K6:6))
		//`SET ENTERABLE(*;$ColName_txt;False)
		//FONT(*;$ColName_txt;"Tahoma")
		If ($colNum_L>Size of array:C274($Widths_atxt))
			LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 50)
		Else 
			LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; Num:C11($Widths_atxt{$colNum_L}))
		End if 
		//FONT SIZE(*;$ColName_txt;12)
		
		//Column 11
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt; ->$ColumnVar_ptr; "pct")
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; $ColumnVar_ptr->; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "F.A.")
		//SET ALIGNMENT(*;$ColName_txt;Center )
		OBJECT SET FORMAT:C236(*; $ColName_txt; Char:C90(Scaled to fit prop centered:K6:6))
		//SET ENTERABLE(*;$ColName_txt;False)
		//FONT(*;$ColName_txt;"Tahoma")
		If ($colNum_L>Size of array:C274($Widths_atxt))
			LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 50)
		Else 
			LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; Num:C11($Widths_atxt{$colNum_L}))
		End if 
		
		
	: ($Task_txt="BRIDGES")
		
		$LBName_txt:="PRV_"+$Task_txt+"_LB"
		PRV_CTRLListBoxes("DELALLCOLUMNS"; $LBName_txt)
		
		$colNum_L:=0
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Contract_Project_Maintenance:100]BridgeNo:4; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 85)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Bridge No")
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Contract_Project_Maintenance:100]BIN:5; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "BIN")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 50)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Contract_Project_Maintenance:100]Location:6; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Location")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 300)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Contract_Project_Maintenance:100]District:8; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Dist.")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 40)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Contract_Project_Maintenance:100]Town:7; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Town")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 130)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt; ->$ColumnVar_ptr; "txt")
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; $ColumnVar_ptr->; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "SDFO")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 50)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt; ->$ColumnVar_ptr; "txt")
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; $ColumnVar_ptr->; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Item26")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 50)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Bridge MHD NBIS:1]Item8:206; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Item8")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 140)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Bridge MHD NBIS:1]AASHTO:5; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "AASHTO")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 50)
		
		PRV_CTRLListBoxes("SETWIDTHLB"; $LBName_txt)
		
	: ($Task_txt="PUBMTGS")
		$LBName_txt:="PRV_"+$Task_txt+"_LB"
		PRV_CTRLListBoxes("DELALLCOLUMNS"; $LBName_txt)
		
		$colNum_L:=0
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Preservation_Meetings:148]MeetingDate_d:4; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Date")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 85)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Preservation_Meetings:148]Summary_txt:7; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align left:K42:2)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Summary")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 700)
		
	: ($Task_txt="CSLTMTGS")
		$LBName_txt:="PRV_"+$Task_txt+"_LB"
		PRV_CTRLListBoxes("DELALLCOLUMNS"; $LBName_txt)
		
		$colNum_L:=0
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Preservation_Meetings:148]MeetingDate_d:4; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Date")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 85)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Preservation_Meetings:148]Purpose_txt:6; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align left:K42:2)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Purpose")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 350)
		
		$colNum_L:=$colNum_L+1
		PRV_CTRLListBoxes("SETCOLVARS"; $Task_txt; $colNum_L; ->$HdrVarName_txt; ->$HdrVar_ptr; ->$ColName_txt)
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; $colNum_L; $ColName_txt; [Preservation_Meetings:148]Summary_txt:7; $HdrVarName_txt; $HdrVar_ptr->)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $ColName_txt; Align left:K42:2)
		OBJECT SET ENTERABLE:C238(*; $ColName_txt; False:C215)
		OBJECT SET TITLE:C194(*; $HdrVarName_txt; "Summary")
		LISTBOX SET COLUMN WIDTH:C833(*; $ColName_txt; 400)
		
	: ($Task_txt="MAKEALLVARS")
		C_TIME:C306(PRV_CompVariablesFile_t)
		C_TEXT:C284($CompVarsFile_txt)
		$CompVarsFile_txt:=Select folder:C670("Select Folder where Compiler Vars file will be generated")
		
		If (OK=1)
			$CompVarsFile_txt:=$CompVarsFile_txt+"PRVCompilerVars_"+ut_CreateTimeStamp+".txt"
			PRV_CompVariablesFile_t:=Create document:C266($CompVarsFile_txt)
			C_TEXT:C284($Compilers_txt)
			PRV_CTRLListBoxes("MAKEVARS"; "STR25"; 12; ->$Compilers_txt)
			PRV_CTRLListBoxes("MAKEVARS"; "HWY25"; 12; ->$Compilers_txt)
			PRV_CTRLListBoxes("MAKEVARS"; "STR90"; 12; ->$Compilers_txt)
			PRV_CTRLListBoxes("MAKEVARS"; "HWY75"; 12; ->$Compilers_txt)
			PRV_CTRLListBoxes("MAKEVARS"; "FINALPSE"; 12; ->$Compilers_txt)
			PRV_CTRLListBoxes("MAKEVARS"; "FINALPSEASST"; 12; ->$Compilers_txt)
			PRV_CTRLListBoxes("MAKEVARS"; "ROW"; 12; ->$Compilers_txt)
			PRV_CTRLListBoxes("MAKEVARS"; "ENV"; 12; ->$Compilers_txt)
			PRV_CTRLListBoxes("MAKEVARS"; "TRA"; 12; ->$Compilers_txt)
			PRV_CTRLListBoxes("MAKEVARS"; "CONSTR"; 12; ->$Compilers_txt)
			PRV_CTRLListBoxes("MAKEVARS"; "OTHER"; 12; ->$Compilers_txt)
			PRV_CTRLListBoxes("MAKEVARS"; "FHWA"; 12; ->$Compilers_txt)
			PRV_CTRLListBoxes("MAKEVARS"; "BRIDGES"; 12; ->$Compilers_txt)
			PRV_CTRLListBoxes("MAKEVARS"; "ADDENDUMS"; 12; ->$Compilers_txt)
			PRV_CTRLListBoxes("MAKEVARS"; "PUBMTGS"; 12; ->$Compilers_txt)
			PRV_CTRLListBoxes("MAKEVARS"; "CSLTMTGS"; 12; ->$Compilers_txt)
			PRV_CTRLListBoxes("MAKEVARS"; "INVOICES"; 12; ->$Compilers_txt)
			PRV_CTRLListBoxes("MAKEVARS"; "BRIDGESDEC"; 20; ->$Compilers_txt)
			PRV_CTRLListBoxes("MAKEVARS"; "INSPECT"; 12; ->$Compilers_txt)
			CLOSE DOCUMENT:C267(PRV_CompVariablesFile_t)
			ut_OpenDocument($CompVarsFile_txt)
			
		End if 
		
	: ($Task_txt="MAKEVARS")
		C_TEXT:C284($2; $LBRootName_txt; $LBName_txt; $HDRVarNames_txt)
		C_LONGINT:C283($3; $maxCount_L)
		$maxCount_L:=$3
		C_POINTER:C301($4; $compDirs_ptr)
		$compDirs_ptr:=$4
		C_LONGINT:C283($loop_L)
		$LBRootName_txt:=$2
		$HDRVarNames_txt:="C_longint(LB_"+$LBRootName_txt+"_HDR"+String:C10(1; "00")+"_L"
		For ($loop_L; 1; $maxCount_L)
			$HDRVarNames_txt:=$HDRVarNames_txt+";LB_"+$LBRootName_txt+"_HDR"+String:C10($loop_L; "00")+"_L"
		End for 
		$HDRVarNames_txt:=$HDRVarNames_txt+")"
		$compDirs_ptr->:=$compDirs_ptr->+Char:C90(13)+$HDRVarNames_txt
		$HDRVarNames_txt:="C_text(LB_"+$LBRootName_txt+"_Det"+String:C10(1; "00")+"_txt"
		For ($loop_L; 1; $maxCount_L)
			$HDRVarNames_txt:=$HDRVarNames_txt+";LB_"+$LBRootName_txt+"_Det"+String:C10($loop_L; "00")+"_txt"
		End for 
		$HDRVarNames_txt:=$HDRVarNames_txt+")"
		$compDirs_ptr->:=$compDirs_ptr->+Char:C90(13)+$HDRVarNames_txt
		
		$HDRVarNames_txt:="C_Longint(LB_"+$LBRootName_txt+"_Det"+String:C10(1; "00")+"_L"
		For ($loop_L; 1; $maxCount_L)
			$HDRVarNames_txt:=$HDRVarNames_txt+";LB_"+$LBRootName_txt+"_Det"+String:C10($loop_L; "00")+"_L"
		End for 
		$HDRVarNames_txt:=$HDRVarNames_txt+")"
		$compDirs_ptr->:=$compDirs_ptr->+Char:C90(13)+$HDRVarNames_txt
		
		$HDRVarNames_txt:="C_real(LB_"+$LBRootName_txt+"_Det"+String:C10(1; "00")+"_r"
		For ($loop_L; 1; $maxCount_L)
			$HDRVarNames_txt:=$HDRVarNames_txt+";LB_"+$LBRootName_txt+"_Det"+String:C10($loop_L; "00")+"_r"
		End for 
		$HDRVarNames_txt:=$HDRVarNames_txt+")"
		$compDirs_ptr->:=$compDirs_ptr->+Char:C90(13)+$HDRVarNames_txt
		
		$HDRVarNames_txt:="C_boolean(LB_"+$LBRootName_txt+"_Det"+String:C10(1; "00")+"_b"
		For ($loop_L; 1; $maxCount_L)
			$HDRVarNames_txt:=$HDRVarNames_txt+";LB_"+$LBRootName_txt+"_Det"+String:C10($loop_L; "00")+"_b"
		End for 
		$HDRVarNames_txt:=$HDRVarNames_txt+")"
		$compDirs_ptr->:=$compDirs_ptr->+Char:C90(13)+$HDRVarNames_txt
		
		$HDRVarNames_txt:="C_date(LB_"+$LBRootName_txt+"_Det"+String:C10(1; "00")+"_d"
		For ($loop_L; 1; $maxCount_L)
			$HDRVarNames_txt:=$HDRVarNames_txt+";LB_"+$LBRootName_txt+"_Det"+String:C10($loop_L; "00")+"_d"
		End for 
		$HDRVarNames_txt:=$HDRVarNames_txt+")"
		$compDirs_ptr->:=$compDirs_ptr->+Char:C90(13)+$HDRVarNames_txt
		
		$HDRVarNames_txt:="C_picture(LB_"+$LBRootName_txt+"_Det"+String:C10(1; "00")+"_pct"
		For ($loop_L; 1; $maxCount_L)
			$HDRVarNames_txt:=$HDRVarNames_txt+";LB_"+$LBRootName_txt+"_Det"+String:C10($loop_L; "00")+"_pct"
		End for 
		$HDRVarNames_txt:=$HDRVarNames_txt+")"
		$compDirs_ptr->:=$compDirs_ptr->+Char:C90(13)+$HDRVarNames_txt
		
		$HDRVarNames_txt:="C_time(LB_"+$LBRootName_txt+"_Det"+String:C10(1; "00")+"_t"
		For ($loop_L; 1; $maxCount_L)
			$HDRVarNames_txt:=$HDRVarNames_txt+";LB_"+$LBRootName_txt+"_Det"+String:C10($loop_L; "00")+"_t"
		End for 
		$HDRVarNames_txt:=$HDRVarNames_txt+")"
		$compDirs_ptr->:=$compDirs_ptr->+Char:C90(13)+$HDRVarNames_txt+Char:C90(13)
		SEND PACKET:C103(PRV_CompVariablesFile_t; $compDirs_ptr->)
		$compDirs_ptr->:=""
End case 