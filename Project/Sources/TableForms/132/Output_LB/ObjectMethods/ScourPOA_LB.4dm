//Method: [ScourPOA].Output_LB.ScourPOA_LB
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck
	//User (4D) : Designer
	//Date and time: 06/23/20, 15:50:04
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06
End if 
//
Case of 
	: (Form event code:C388=On Header Click:K2:40)
		
		C_TEXT:C284($NameofObj_txt; $SortVariableName_txt)
		C_LONGINT:C283($dumTbl_L; $dumFld_L)
		C_POINTER:C301($SortVariable_ptr)
		
		RESOLVE POINTER:C394(Self:C308; $NameofObj_txt; $dumTbl_L; $dumFld_L)
		$SortVariableName_txt:=Replace string:C233($NameofObj_txt; "Header"; "SortDirection")
		$SortVariable_ptr:=Get pointer:C304($SortVariableName_txt)
		
		
		Case of 
			: ($NameofObj_txt="LB_Header1_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([ScourPOA:132]; [Bridge MHD NBIS:1]BDEPT:1; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([ScourPOA:132]; [Bridge MHD NBIS:1]BDEPT:1; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
			: ($NameofObj_txt="LB_Header2_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([ScourPOA:132]; [ScourPOA:132]BIN:2; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([ScourPOA:132]; [ScourPOA:132]BIN:2; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
			: ($NameofObj_txt="LB_Header3_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([ScourPOA:132]; [Bridge MHD NBIS:1]Item7:65; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([ScourPOA:132]; [Bridge MHD NBIS:1]Item7:65; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
			: ($NameofObj_txt="LB_Header4_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([ScourPOA:132]; [Bridge MHD NBIS:1]Item6A:63; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([ScourPOA:132]; [Bridge MHD NBIS:1]Item6A:63; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
			: ($NameofObj_txt="LB_Header6_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([ScourPOA:132]; [Bridge MHD NBIS:1]Item113:151; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([ScourPOA:132]; [Bridge MHD NBIS:1]Item113:151; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
			: ($NameofObj_txt="LB_Header7_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([ScourPOA:132]; [ScourPOA:132]Consultant:26; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([ScourPOA:132]; [ScourPOA:132]Consultant:26; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
			: ($NameofObj_txt="LB_Header8_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([ScourPOA:132]; [ScourPOA:132]Completed:21; >; [ScourPOA:132]DateCompleted:8; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([ScourPOA:132]; [ScourPOA:132]Completed:21; <; [ScourPOA:132]DateCompleted:8; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
			: ($NameofObj_txt="LB_Header9_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([ScourPOA:132]; [ScourPOA:132]PMReviewed:29; >; [ScourPOA:132]PMReviewDate:28; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([ScourPOA:132]; [ScourPOA:132]PMReviewed:29; <; [ScourPOA:132]PMReviewDate:28; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
			: ($NameofObj_txt="LB_Header10_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([ScourPOA:132]; [ScourPOA:132]Approved:23; >; [ScourPOA:132]DateApproved:5; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([ScourPOA:132]; [ScourPOA:132]Approved:23; <; [ScourPOA:132]DateApproved:5; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
			Else 
				ALERT:C41("Sorting not enabled for this column")
		End case 
	: (Form event code:C388=On Open Detail:K2:23)
		ut_SetWindowSize("create"; Current method name:C684)
	: (Form event code:C388=On Close Detail:K2:24)
		ut_SetWindowSize("Reset"; Current method name:C684)
End case 
//End [ScourPOA].Output_LB.ScourPOA_LB