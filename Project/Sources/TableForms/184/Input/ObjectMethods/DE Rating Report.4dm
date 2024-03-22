//Method: [TIN_Inspections].Input.Rating Report
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/28/17, 11:13:46
	// ----------------------------------------------------
	//Created : 
	Mods_2017_12
	Mods_2018_02  //Add code to confirm change if data already exists
	//Modified by: Chuck Miller (2/15/18 15:20:31)
	
End if 
//
If (Form event code:C388=On Clicked:K2:4)
	
	If (Not:C34([TIN_Inspections:184]RatingReportYN_B:30))
		C_BOOLEAN:C305($DoConfirm_B)
		$DoConfirm_B:=(([TIN_Inspections:184]RatingReport_d:31#!00-00-00!) | \
			([TIN_Inspections:184]RatingReportDateofInsp_d:32#!00-00-00!) | \
			([TIN_Inspections:184]RatingReportInvertGirder_s:35#"") | \
			([TIN_Inspections:184]RatingReportInvertSlab_s:34#"") | \
			([TIN_Inspections:184]RatingReportRoofGirder_s:33#""))
		
		If ($DoConfirm_B)
			CONFIRM:C162("Are you sure you want to remove all Rating Report data?"; "Yes"; "No")
			[TIN_Inspections:184]RatingReportYN_B:30:=(OK=0)
		End if 
	End if 
	
	
	OBJECT SET VISIBLE:C603(*; "RatingIfTrue@"; [TIN_Inspections:184]RatingReportYN_B:30)
	OBJECT SET VISIBLE:C603(*; "DE RatingIfTrue@"; [TIN_Inspections:184]RatingReportYN_B:30)
	If (Not:C34([TIN_Inspections:184]RatingReportYN_B:30))
		[TIN_Inspections:184]RatingReport_d:31:=!00-00-00!
		[TIN_Inspections:184]RatingReportDateofInsp_d:32:=[TIN_Inspections:184]RatingReport_d:31
		[TIN_Inspections:184]RatingReportInvertGirder_s:35:=""
		[TIN_Inspections:184]RatingReportInvertSlab_s:34:=""
		[TIN_Inspections:184]RatingReportRoofGirder_s:33:=""
	End if 
End if 
//End [TIN_Inspections].Input.Rating Report