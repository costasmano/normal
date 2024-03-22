//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/21/06, 16:30:11
	// ----------------------------------------------------
	// Method: P_ListSpecialReports
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(5/4/2006 11:49:21)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(9/14/2007 12:18:28)
	Mods_2007_CM12_5301
	Mods_2022_05  //Add List box and selection if designer
	//Modified by: Chuck Miller (5/10/22 12:30:30)
End if 
C_TEXT:C284($FormName_txt)
If (ut_UseListBox(Current method name:C684))
	$FormName_txt:="Output_LB"
Else 
	$FormName_txt:="Output"
	
End if 
G_DisplayTable_generic(->[zSpecialReports:106]; "Special Reports / Menus"; ""; $FormName_txt; 0; ->[zSpecialReports:106]Purpose:1; ->[zSpecialReports:106]SubCategory:5; ->[zSpecialReports:106]ReportName:2)