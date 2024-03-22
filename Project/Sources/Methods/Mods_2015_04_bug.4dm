//%attributes = {"invisible":true}
//Method: Mods_2015_04_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/09/15, 12:03:39
	// ----------------------------------------------------
	//Created : 
	Mods_2015_04_bug
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(4/3/15)
// Modified Forms : 
//[Inspections]TunnelReprtTemplate
//  `added missing horiz line

//**********`Modified by: Costas Manousakis-(Designer)-(4/6/15)
// Modified Method(s) : 
//InitPers
//  `for the apeople array, if the name is all spaces - change it to blank  string ("")


//**********`Modified by: Costas Manousakis-(Designer)-(4/9/15)
// Modified Forms : 
//[ScourPOA];"Print2-A"
//  `fixed wrong variables for 2.a recommend and implemented check boxes

//[Inspections]RailRoutine Culvert
//  `fixed wrong variable name in place of  vDN62_13


//**********`Modified by: Costas Manousakis-(Designer)-(4/10/15)
// Modified Forms : 
//[ScourPOA];"Input-A"
//  `In Secion 6B (page 3) placed 'hidden' buttons above Monitorin and  Fixed Mon dev checkboxes
//  `made text plain to disitnghuish from editable
//  `uncover Install Crit WSE marker checkbox

// Modified Method(s) : 
//SCPOA_MonitorChecks
//  `changed dependecies of variables for SCPOA_Inst_Monit_L
//  `removed dependency for SCPOA_Inst_WaterSurf_L


//```
//```   **** End of Release 6.3.3.e 04/13/2015
//```


//**********`Modified by: Costas Manousakis-(Designer)-(4/23/15)


// Modified Forms : 
//[Inspections];"RailRoutine Culvert"
//  `fixed label for BDEPT

//**********`Modified by: Costas Manousakis-(Designer)-(4/24/15)
// Modified Method(s) : 
//INSP_AddElmtCat2HL
//  `for Dive inspections select only elements below 2000 always

//**********`Modified by: Costas Manousakis-(Designer)-(4/29/15)
// Modified Method(s) : 
//PRJ_DisplayProjects
//  `do initial search of project details based on belonging to a personell groups
//  `added one more table of lists "PRJ_BrgSectPersGroup" which matches the [pers_groups] groups 
//  `to the list "PRJ_BridgeSection_atxt"

//End Mods_2015_04_bug