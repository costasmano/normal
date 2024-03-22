//Method: [TIN_Inspections].Input.WeightPosting
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/28/17, 11:45:56
	// ----------------------------------------------------
	//Created : 
	Mods_2017_12
	Mods_2018_02  //Add code to confirm change if data already exists
	//Modified by: Chuck Miller (2/15/18 15:20:31)
	
End if 
//
If (Form event code:C388=On Clicked:K2:4)
	If ([TIN_Inspections:184]WeightPostingNA_B:36)
		C_BOOLEAN:C305($DoConfirm_B)
		$DoConfirm_B:=(([TIN_Inspections:184]WeightPostingActual3_r:38#0) | \
			([TIN_Inspections:184]WeightPostingActual3S2_r:39#0) | \
			([TIN_Inspections:184]WeightPostingActualH_r:37#0) | \
			([TIN_Inspections:184]WeightPostingActualSingle_r:40#0) | \
			([TIN_Inspections:184]WeightPostingRec3_r:42#0) | \
			([TIN_Inspections:184]WeightPostingRec3S2_r:43#0) | \
			([TIN_Inspections:184]WeightPostingRecH_r:41#0) | \
			([TIN_Inspections:184]WeightPostingRecSingle_r:44#0) | \
			([TIN_Inspections:184]WeightPostingSignAdvance_s:46#"") | \
			([TIN_Inspections:184]WeightPostingSignAtTunnel_s:45#""))
		If ($DoConfirm_B)
			CONFIRM:C162("Are you sure you want to remove all weight posting data?"; "Yes"; "No")
			[TIN_Inspections:184]WeightPostingNA_B:36:=(OK=1)
		End if 
	End if 
	OBJECT SET VISIBLE:C603(*; "WeightPostingFalse@"; Not:C34([TIN_Inspections:184]WeightPostingNA_B:36))
	OBJECT SET VISIBLE:C603(*; "DE WeightPostingFalse@"; Not:C34([TIN_Inspections:184]WeightPostingNA_B:36))
	
	
	
	
	
	If ([TIN_Inspections:184]WeightPostingNA_B:36)
		[TIN_Inspections:184]WeightPostingActual3_r:38:=0
		[TIN_Inspections:184]WeightPostingActual3S2_r:39:=0
		[TIN_Inspections:184]WeightPostingActualH_r:37:=0
		[TIN_Inspections:184]WeightPostingActualSingle_r:40:=0
		[TIN_Inspections:184]WeightPostingRec3_r:42:=0
		[TIN_Inspections:184]WeightPostingRec3S2_r:43:=0
		[TIN_Inspections:184]WeightPostingRecH_r:41:=0
		[TIN_Inspections:184]WeightPostingRecSingle_r:44:=0
		[TIN_Inspections:184]WeightPostingSignAdvance_s:46:=""
		[TIN_Inspections:184]WeightPostingSignAtTunnel_s:45:=""
	End if 
	
End if 
//End [TIN_Inspections].Input.WeightPosting