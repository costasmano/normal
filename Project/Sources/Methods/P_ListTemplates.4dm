//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/21/06, 15:40:39
	// ----------------------------------------------------
	// Method: P_ListTemplates
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(5/4/2006 11:48:20)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(2/23/2007 15:59:07)
	Mods_2007_CM07
	Mods_2022_05  //Add List box and selection if designer
	//Modified by: Chuck Miller (5/10/22 12:30:30)
	
End if 
C_TEXT:C284($FormName_txt)
If (ut_UseListBox(Current method name:C684))
	$FormName_txt:="Output_LB"
Else 
	$FormName_txt:="Output"
	
End if 
G_DisplayTable_generic(->[Templates:86]; "Custom Templates"; ""; $FormName_txt; 0; ->[Templates:86]TemplateName:2)