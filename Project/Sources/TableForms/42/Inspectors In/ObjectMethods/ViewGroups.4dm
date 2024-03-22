//Method: [Personnel];"Inspectors In".ViewGroups
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 04/10/18, 15:37:57
	// ----------------------------------------------------
	//Created : 
	Mods_2018_04  //Add user groups to page 2 for designers AND ADMINS
	// Modified by: Costas Manousakis-(Designer)-(8/28/18 10:47:14)
	Mods_2018_08
	//  `added label on page 2 with the person id , name and employer
End if 
//
Case of 
	: (OBJECT Get title:C1068(*; "ViewGroups")="View Groups")
		OBJECT SET TITLE:C194(*; "ViewGroups"; "View Person")
		FORM GOTO PAGE:C247(2)
		OBJECT SET VISIBLE:C603(*; "Variable50"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Variable49"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Variable48"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Variable47"; False:C215)
		OBJECT SET TITLE:C194(*; "NameEmployer"; String:C10([Personnel:42]Person ID:1)+":"+[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5+" - "+[Personnel:42]Employer:9)
		PERS_ShowMemberships
	Else 
		ARRAY TEXT:C222(4DGroups_atxt; 0)
		ARRAY TEXT:C222(4DPersonnelGroups_atxt; 0)
		OBJECT SET VISIBLE:C603(*; "Variable50"; True:C214)
		OBJECT SET VISIBLE:C603(*; "Variable49"; True:C214)
		OBJECT SET VISIBLE:C603(*; "Variable48"; True:C214)
		OBJECT SET VISIBLE:C603(*; "Variable47"; True:C214)
		
		OBJECT SET TITLE:C194(*; "ViewGroups"; "View Groups")
		FORM GOTO PAGE:C247(1)
End case 

//End [Personnel].Inspectors In.ViewGroups