//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/14/13, 14:28:24
//----------------------------------------------------
//Method: INSP_SetWPHeadings
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_02  //r001 ` ` Allow for different headings on weight postings
	//Modified by: Charles Miller (2/14/13 14:28:31)
	//[ElementsSafety];"Safety ElmInput"
	//[Inspections];"RailRoutine Arch Pr Pg 2"
	//[Inspections];"RailCulvertCombined-RRC"
	//[Inspections];"MHD_Special_Member98"
	//[Inspections];"RailRoutine Culvert"
	//[Inspections];"Railfc_rr_p1"
	//[Inspections];"RoutinePrPg2_v2"
	//[Inspections];"FCPrPg1_v2"
	//[Inspections];"DamagePg1_v2"
	//[Inspections];"CulvertPrPg1_v2"
	//[Inspections];"Culvert Combined"
	//[Inspections];"Routine Combined"
	//[Inspections];"SpecialExtra"
	//[Inspections];"Damage Pg1"
	//[Inspections];"Damage Form"
	//[Inspections];"Culvert Pr Pg 1"
	//[Inspections];"FC Pr (Pg 1)"
	//[Inspections];"Routine Pr Pg 2"
	//[Inspections];"Critical Member"
End if 

WP_H_s:="H"
WP_H20_s:="H-20"
WP_3_s:="3"
WP_3S2_s:="3S2"
WP_Single_s:="Single"

If (False:C215)  // add code below to adjust headings for now only defaults
	Case of 
			
			
			
			
			
	End case 
End if 
//End INSP_SetWPHeadings

