//%attributes = {"invisible":true}
// Method: PRV_ReviewInput_FM
// Description
// 
// 
// Parameters
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 06/06/12, 09:59:45
	// ----------------------------------------------------
	// First Release
	Mods_2012_06
	// Modified by: Costas Manousakis-(Designer)-(9/24/13 11:33:14)
	Mods_2013_09
	//  `
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 
C_TEXT:C284(PRV_REVIEWTYPEDESC_TXT; PRV_NEWREVIEWTYPE_s; PRV_ApproveLabel_txt; PRV_SENDSUBMTO_txt)
C_LONGINT:C283(PRV_DOTHEFLOW_L; PRV_GETBRIDGEBININFO_L)
PRV_DOTHEFLOW_L:=15001
PRV_GETBRIDGEBININFO_L:=15002
Case of 
	: ($FormEvent_L=On Close Detail:K2:24)
		
	: ($FormEvent_L=On Load:K2:1)
		PRV_REVIEWTYPEDESC_TXT:="UNKNOWN PRESERVATION REVIEW"
		PRV_ReviewSCR_DateCheck_B:=False:C215
		If (Is new record:C668(Current form table:C627->))
			[Preservation_Reviews:145]AssignID:2:=[Contract_Assignment_Maintenance:101]AssignID:3
			[Preservation_Reviews:145]ReviewTYpe_s:3:=PRV_NEWREVIEWTYPE_s
			Inc_Sequence("PreservReview"; ->[Preservation_Reviews:145]Review_ID:1)
		End if 
		C_TEXT:C284($elmt_txt; $CertYN_txt; $CertTypeYN_txt; $SendTo_txt; $SubmRecdYN_txt)
		C_BOOLEAN:C305(PRV_FIRSTSTEP_Recd_b)
		PRV_FIRSTSTEP_Recd_b:=True:C214
		C_BOOLEAN:C305($CertYN_b; $CertTypeYN_b)
		$CertYN_b:=False:C215
		$CertTypeYN_b:=False:C215
		$elmt_txt:=DOM Find XML element:C864(PRV_REVIEWTYPESTREE_txt; "PRV_ReviewTypes/"+PRV_NEWREVIEWTYPE_s)
		If (OK=1)
			DOM GET XML ELEMENT VALUE:C731($elmt_txt; PRV_REVIEWTYPEDESC_TXT)
			ON ERR CALL:C155("Error Handler")
			DOM GET XML ATTRIBUTE BY NAME:C728($elmt_txt; "CERT"; $CertYN_b)
			DOM GET XML ATTRIBUTE BY NAME:C728($elmt_txt; "CERTTYPE"; $CertTypeYN_b)
			DOM GET XML ATTRIBUTE BY NAME:C728($elmt_txt; "SENDTO"; PRV_SENDSUBMTO_txt)
			DOM GET XML ATTRIBUTE BY NAME:C728($elmt_txt; "SUBMRCD"; PRV_FIRSTSTEP_Recd_b)
			ON ERR CALL:C155("")
		End if 
		
		//PRV_ReviewInput_FM (PRV_DOTHEFLOW_L)
		
		If (Not:C34(PRV_FIRSTSTEP_Recd_b))
			FORM GOTO PAGE:C247(2)
			ARRAY TEXT:C222(PRV_Actions_atxt; 3)
			
			If ($CertYN_b)
				PRV_Actions_atxt{1}:="Certificate Issued"
			Else 
				PRV_Actions_atxt{1}:="Approved"
			End if 
			PRV_Actions_atxt{2}:="Returned with comments No Re-Submission Required"  //Mods_2013_09
			PRV_Actions_atxt{3}:="Returned with comments Re-Submission Required"  //Mods_2013_09
			
			If ($CertTypeYN_b)
				OBJECT SET VISIBLE:C603(*; "@Certificate@"; True:C214)
			End if 
			
		Else 
			C_TEXT:C284(PRV_Designer_txt)
			Case of 
				: ([Contract_Assignment_Maintenance:101]DesignerDesignation_s:76="Boston@")
					PRV_Designer_txt:=[Contract_Assignment_Maintenance:101]DesignerDesignation_s:76
					FORM GOTO PAGE:C247(3)
				: ([Contract_Assignment_Maintenance:101]DesignerDesignation_s:76="District@")
					PRV_Designer_txt:=[Contract_Assignment_Maintenance:101]DesignerDesignation_s:76
					FORM GOTO PAGE:C247(3)
				Else 
					
			End case 
			
			ARRAY TEXT:C222(PRV_Actions_atxt; 4)
			PRV_Actions_atxt{1}:="Sent back to Distr for revisions"
			PRV_Actions_atxt{2}:="Sent back to P.M. for Consultant revisions"
			PRV_Actions_atxt{3}:="Accepted, Send back to P.M."
			PRV_Actions_atxt{4}:="Other :"
		End if 
		OBJECT SET ENABLED:C1123(*; "DE PRV_Actions_atxt@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		If (PRV_LockedAssignment_b)
			OBJECT SET ENTERABLE:C238(*; "DE@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET VISIBLE:C603(*; "DE@btn"; False:C215)
		End if 
		
	: ($FormEvent_L=On Data Change:K2:15)
		//PRV_ReviewInput_FM (PRV_DOTHEFLOW_L)
		C_POINTER:C301($lastobj_ptr)
		$lastobj_ptr:=Focus object:C278
		C_TEXT:C284($VarName_txt; $FldName_txt)
		C_LONGINT:C283($tblNum_L; $FldNum_L; $FldType_L)
		RESOLVE POINTER:C394($lastobj_ptr; $VarName_txt; $tblNum_L; $FldNum_L)
		If ($FldNum_L>0)
			ARRAY TEXT:C222($fldnames_atxt; 0)
			ARRAY LONGINT:C221($FldNums_aL; 0)
			GET FIELD TITLES:C804(Table:C252($tblNum_L)->; $fldnames_atxt; $FldNums_aL)
			
			$FldName_txt:=Field name:C257($tblNum_L; $FldNum_L)
			$FldType_L:=Type:C295(Field:C253($tblNum_L; $FldNum_L)->)
			If ($FldType_L=Is date:K8:7)
				ARRAY POINTER:C280($FldSeq_aptr; 0)
				Case of 
					: (FORM Get current page:C276=1)
						APPEND TO ARRAY:C911($FldSeq_aptr; ->[Preservation_Reviews:145]Received_d:4)
						APPEND TO ARRAY:C911($FldSeq_aptr; ->[Preservation_Reviews:145]SentToDistr_d:13)
						APPEND TO ARRAY:C911($FldSeq_aptr; ->[Preservation_Reviews:145]Deadline_d:12)
						APPEND TO ARRAY:C911($FldSeq_aptr; ->[Preservation_Reviews:145]CommentsRecd_d:7)
						APPEND TO ARRAY:C911($FldSeq_aptr; ->[Preservation_Reviews:145]SentToREviewer_d:5)
						APPEND TO ARRAY:C911($FldSeq_aptr; ->[Preservation_Reviews:145]ReviewerDeadline_d:14)
						APPEND TO ARRAY:C911($FldSeq_aptr; ->[Preservation_Reviews:145]DistrCmtsReviewed_d:15)
						APPEND TO ARRAY:C911($FldSeq_aptr; ->[Preservation_Reviews:145]SentBackToPM_d:9)
						
					: (FORM Get current page:C276=2)
						APPEND TO ARRAY:C911($FldSeq_aptr; ->[Preservation_Reviews:145]SentToREviewer_d:5)
						APPEND TO ARRAY:C911($FldSeq_aptr; ->[Preservation_Reviews:145]CommentsRecd_d:7)
						APPEND TO ARRAY:C911($FldSeq_aptr; ->[Preservation_Reviews:145]SentBackToPM_d:9)
					: (FORM Get current page:C276=3)
						APPEND TO ARRAY:C911($FldSeq_aptr; ->[Preservation_Reviews:145]Received_d:4)
						APPEND TO ARRAY:C911($FldSeq_aptr; ->[Preservation_Reviews:145]SentToREviewer_d:5)
						APPEND TO ARRAY:C911($FldSeq_aptr; ->[Preservation_Reviews:145]ReviewerDeadline_d:14)
						APPEND TO ARRAY:C911($FldSeq_aptr; ->[Preservation_Reviews:145]DistrCmtsReviewed_d:15)
						APPEND TO ARRAY:C911($FldSeq_aptr; ->[Preservation_Reviews:145]SentBackToPM_d:9)
						
				End case 
				C_LONGINT:C283($loop_L; $loop2_L)
				C_TEXT:C284($msg_txt)
				$msg_txt:=""
				C_BOOLEAN:C305(PRV_ReviewSCR_DateCheck_B)
				PRV_ReviewSCR_DateCheck_B:=False:C215
				For ($loop_L; Size of array:C274($FldSeq_aptr); 1; -1)
					
					If ($FldSeq_aptr{$loop_L}->#!00-00-00!)
						For ($loop2_L; ($loop_L-1); 1; -1)
							If ($FldSeq_aptr{$loop2_L}->#!00-00-00!)
								If ($FldSeq_aptr{$loop_L}-><$FldSeq_aptr{$loop2_L}->)
									$msg_txt:=$msg_txt+"Date entered "+String:C10($FldSeq_aptr{$loop_L}->)+" for field ["+$fldnames_atxt{Find in array:C230($FldNums_aL; Field:C253($FldSeq_aptr{$loop_L}))}+"] is less than the date "+String:C10($FldSeq_aptr{$loop2_L}->)+" for ["+$fldnames_atxt{Find in array:C230($FldNums_aL; Field:C253($FldSeq_aptr{$loop2_L}))}+"]"+Char:C90(Carriage return:K15:38)
									$loop2_L:=0
								End if 
							End if 
						End for 
					End if 
				End for 
				
				If ($msg_txt#"")
					PRV_ReviewSCR_DateCheck_B:=True:C214
					$msg_txt:="Date entry errors:"+Char:C90(Carriage return:K15:38)+$msg_txt
					ALERT:C41($msg_txt)
				End if 
				
			End if 
		End if 
		
	: ($FormEvent_L=On Unload:K2:2)
	: ($FormEvent_L=On Validate:K2:3)
		
		
	: ($FormEvent_L=PRV_DOTHEFLOW_L)
		If (False:C215)
			OBJECT SET ENTERABLE:C238([Preservation_Reviews:145]SentToDistr_d:13; False:C215)
			OBJECT SET ENTERABLE:C238([Preservation_Reviews:145]Deadline_d:12; False:C215)
			OBJECT SET ENTERABLE:C238([Preservation_Reviews:145]SentToREviewer_d:5; False:C215)
			OBJECT SET ENTERABLE:C238([Preservation_Reviews:145]CommentsRecd_d:7; False:C215)
			OBJECT SET ENTERABLE:C238([Preservation_Reviews:145]SentToREviewer_d:5; False:C215)
			OBJECT SET ENTERABLE:C238([Preservation_Reviews:145]ReviewerDeadline_d:14; False:C215)
			OBJECT SET ENTERABLE:C238([Preservation_Reviews:145]DistrCmtsReviewed_d:15; False:C215)
			//SET ENTERABLE([Preservation_Reviews]Reviewer_s;False)
			OBJECT SET ENABLED:C1123(PRV_Actions_atxt; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENTERABLE:C238([Preservation_Reviews:145]SentBackToPM_d:9; False:C215)
			OBJECT SET ENTERABLE:C238([Preservation_Reviews:145]; False:C215)
			
			If (PRV_FIRSTSTEP_Recd_b)
				
				If (([Contract_Assignment_Maintenance:101]DesignerDesignation_s:76="Boston@") | ([Contract_Assignment_Maintenance:101]DesignerDesignation_s:76="District@"))
					If ([Preservation_Reviews:145]Received_d:4#!00-00-00!)
						OBJECT SET ENTERABLE:C238([Preservation_Reviews:145]SentToREviewer_d:5; True:C214)
						OBJECT SET ENTERABLE:C238([Preservation_Reviews:145]ReviewerDeadline_d:14; True:C214)
					End if 
				Else 
					If ([Preservation_Reviews:145]Received_d:4#!00-00-00!)
						OBJECT SET ENTERABLE:C238([Preservation_Reviews:145]SentToDistr_d:13; True:C214)
					End if 
					If ([Preservation_Reviews:145]SentToDistr_d:13#!00-00-00!)
						OBJECT SET ENTERABLE:C238([Preservation_Reviews:145]Deadline_d:12; True:C214)
						OBJECT SET ENTERABLE:C238([Preservation_Reviews:145]CommentsRecd_d:7; True:C214)
					End if 
					If ([Preservation_Reviews:145]CommentsRecd_d:7#!00-00-00!)
						OBJECT SET ENTERABLE:C238([Preservation_Reviews:145]SentToREviewer_d:5; True:C214)
						OBJECT SET ENTERABLE:C238([Preservation_Reviews:145]ReviewerDeadline_d:14; True:C214)
					End if 
				End if 
				
				If ([Preservation_Reviews:145]SentToREviewer_d:5#!00-00-00!)
					OBJECT SET ENTERABLE:C238([Preservation_Reviews:145]DistrCmtsReviewed_d:15; True:C214)
				End if 
				If ([Preservation_Reviews:145]DistrCmtsReviewed_d:15#!00-00-00!)
					OBJECT SET ENABLED:C1123(PRV_Actions_atxt; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				End if 
				
				If ([Preservation_Reviews:145]Action_s:8#"")
					OBJECT SET ENTERABLE:C238([Preservation_Reviews:145]SentBackToPM_d:9; True:C214)
				End if 
			Else 
				OBJECT SET ENTERABLE:C238([Preservation_Reviews:145]SentToREviewer_d:5; True:C214)
				If ([Preservation_Reviews:145]SentToREviewer_d:5#!00-00-00!)
					OBJECT SET ENTERABLE:C238([Preservation_Reviews:145]CommentsRecd_d:7; True:C214)
				End if 
				If ([Preservation_Reviews:145]CommentsRecd_d:7#!00-00-00!)
					OBJECT SET ENABLED:C1123(PRV_Actions_atxt; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				End if 
				
				If ([Preservation_Reviews:145]Action_s:8#"")
					OBJECT SET ENTERABLE:C238([Preservation_Reviews:145]SentBackToPM_d:9; True:C214)
					OBJECT SET ENTERABLE:C238([Preservation_Reviews:145]CertificateType_s:10; True:C214)
				End if 
				
			End if 
			
		End if 
		
End case 