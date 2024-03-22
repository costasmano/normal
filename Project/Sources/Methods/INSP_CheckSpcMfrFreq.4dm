//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/18/07, 13:23:02
	// ----------------------------------------------------
	// Method: INSP_CheckSpcMfrFreq
	// Description
	// Check the requirements for Spec memb inspection.
	// If 58,69,60 or 62 <=4 Spec memb required
	//  `=4 12 mo freq
	//  `<= 3 6 mo freq
	// 
	// Parameters
	// $1 : SpMemCheckOption_txt (Optional) ("ABOVE" | "UW")
	// ----------------------------------------------------
	
	Mods_2007_CM_5401
	Mods_2009_03  //CJM  r001   `03/06/09, 15:12:46`Upgrade from open form window to open window
	//Mods_2011_11 `Change to include call to CalcItem91 is spec mem freq changed
	//Modified by: Charles Miller (11/21/11 14:37:38)
	
End if 
C_POINTER:C301($Item58fld_ptr; $Item59fld_ptr; $Item60fld_ptr; $Item62fld_ptr; $Item61fld_ptr)
C_POINTER:C301($Item92CAfld_ptr; $Item92CBfld_ptr)
C_BOOLEAN:C305($0; $Changed_b)
C_TEXT:C284(SpMemCheckOption_txt)
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	SpMemCheckOption_txt:=$1
Else 
	SpMemCheckOption_txt:="ABOVE"
End if 
Case of 
	: ((SpMemCheckOption_txt#"ABOVE") & (SpMemCheckOption_txt#"UW"))
		ALERT:C41("Method INSP_CheckSpcMfrFreq: Incorrect argument <"+SpMemCheckOption_txt+">")
	Else 
		C_TEXT:C284(vItem58; vItem59; vItem60; vItem62; vItem61)  // Command Replaced was o_C_STRING length was 1
		C_BOOLEAN:C305(vItem92CA_new_b; vItem92CA_b; $SpcMemb6Mo_b)
		C_LONGINT:C283(vItem92CB_new_L; vItem92CB_L; vItem92CA_L; vItem92CA_new_L)
		
		Case of 
			: (SpMemCheckOption_txt="ABOVE")
				$Item58fld_ptr:=->[Bridge MHD NBIS:1]Item58:130
				$Item59fld_ptr:=->[Bridge MHD NBIS:1]Item59:131
				$Item60fld_ptr:=->[Bridge MHD NBIS:1]Item60:132
				$Item61fld_ptr:=->[Bridge MHD NBIS:1]Item61:133
				$Item62fld_ptr:=->[Bridge MHD NBIS:1]Item62:134
				$Item92CAfld_ptr:=->[Bridge MHD NBIS:1]Item92CA:167
				$Item92CBfld_ptr:=->[Bridge MHD NBIS:1]Item92CB:168
			: (SpMemCheckOption_txt="UW")
				$Item58fld_ptr:=->[Bridge MHD NBIS:1]Item58:130  //This is not used in the checks anyway
				$Item59fld_ptr:=->[Bridge MHD NBIS:1]Item59:131  //This is not used in the checks anyway...
				$Item60fld_ptr:=->[Inspections:27]Item 60 UW:66
				$Item61fld_ptr:=->[Inspections:27]Item 61 UW:72
				$Item62fld_ptr:=->[Inspections:27]Item 62 UW:165
				$Item92CAfld_ptr:=->[Bridge MHD NBIS:1]UWSpInsp:212
				$Item92CBfld_ptr:=->[Bridge MHD NBIS:1]UWSpInspFreq:213
		End case 
		
		vItem58:=$Item58fld_ptr->
		vItem59:=$Item59fld_ptr->
		vItem60:=$Item60fld_ptr->
		vItem62:=$Item62fld_ptr->
		vItem61:=$Item61fld_ptr->
		vItem92CA_b:=$Item92CAfld_ptr->
		vItem92CB_L:=$Item92CBfld_ptr->
		
		C_TEXT:C284($SpecReqd_txt; $Spec12Mo_txt; $Spec6Mo_txt)
		$SpecReqd_txt:=";0;1;2;3;4;"
		$Spec12Mo_txt:=";4;"
		$Spec6Mo_txt:=";0;1;2;3;"
		
		$Changed_b:=False:C215
		$SpcMemb6Mo_b:=False:C215
		vItem92CA_new_b:=False:C215
		vItem92CB_new_L:=0
		
		vItem92CA_new_b:=vItem92CA_new_b | (Position:C15(vItem60; $SpecReqd_txt)>0)
		vItem92CA_new_b:=vItem92CA_new_b | (Position:C15(vItem62; $SpecReqd_txt)>0)
		vItem92CA_new_b:=vItem92CA_new_b | (Position:C15(vItem61; $SpecReqd_txt)>0)
		If (SpMemCheckOption_txt="ABOVE")
			vItem92CA_new_b:=vItem92CA_new_b | (Position:C15(vItem58; $SpecReqd_txt)>0)
			vItem92CA_new_b:=vItem92CA_new_b | (Position:C15(vItem59; $SpecReqd_txt)>0)
		End if 
		
		If (vItem92CA_new_b)
			vItem92CB_new_L:=12
			$SpcMemb6Mo_b:=$SpcMemb6Mo_b | (Position:C15(vItem60; $Spec6Mo_txt)>0)
			$SpcMemb6Mo_b:=$SpcMemb6Mo_b | (Position:C15(vItem62; $Spec6Mo_txt)>0)
			$SpcMemb6Mo_b:=$SpcMemb6Mo_b | (Position:C15(vItem61; $Spec6Mo_txt)>0)
			If (SpMemCheckOption_txt="ABOVE")
				$SpcMemb6Mo_b:=$SpcMemb6Mo_b | (Position:C15(vItem58; $Spec6Mo_txt)>0)
				$SpcMemb6Mo_b:=$SpcMemb6Mo_b | (Position:C15(vItem59; $Spec6Mo_txt)>0)
			End if 
			If ($SpcMemb6Mo_b)
				vItem92CB_new_L:=6
			End if 
		End if 
		
		If ((vItem92CA_b=vItem92CA_new_b) & (vItem92CB_new_L=vItem92CB_L))
			// no difference - nothing
		Else 
			
			C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
			C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
			C_TEXT:C284($Title_txt)
			FORM GET PROPERTIES:C674([Dialogs:21]; "SpecFreqUpdate"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
			$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
			//$winID_L:=Open form window([Dialogs];"SpecFreqUpdate")
			DIALOG:C40([Dialogs:21]; "SpecFreqUpdate")
			CLOSE WINDOW:C154
			If (vAccept=1)
				$Item92CAfld_ptr->:=(vItem92CA_new_L=1)
				$Item92CBfld_ptr->:=vItem92CB_new_L
				CalcItem91
				$Changed_b:=True:C214
			End if 
		End if 
		$0:=$Changed_b
End case 