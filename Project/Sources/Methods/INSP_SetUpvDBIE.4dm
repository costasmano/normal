//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/24/13, 10:56:19
//----------------------------------------------------
//Method: insp_SetUpvDBIE
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_01  //r004 `  Make changes to printed inspection forms for differences in MBTA and non MBTA
	//Modified by: Charles Miller (1/24/13 10:56:20)
	// Modified by: Costas Manousakis-(Designer)-(2/5/15 10:29:08)
	Mods_2015_02
	//  `moved the vDBIE var declaration outside  the if statement. also force the object DOTEngineer to be visible even for MBTA
	//  ` the vDBIE is only in one object DOTEngineer
End if 

If ([Bridge MHD NBIS:1]InspResp:173="MBTA")
	OBJECT SET VISIBLE:C603(*; "MBTAEngineer@"; True:C214)
	OBJECT SET VISIBLE:C603(*; "DOTEngineer@"; False:C215)
	OBJECT SET VISIBLE:C603(*; "DOTEngineer"; True:C214)
Else 
	OBJECT SET VISIBLE:C603(*; "MBTAEngineer@"; False:C215)
	OBJECT SET VISIBLE:C603(*; "DOTEngineer@"; True:C214)
End if 
vDBIE:=fn_ReturnName(->[Inspections:27]DBrInspEngr:3)
//End insp_SetUpvDBIE