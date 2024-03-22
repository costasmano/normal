//%attributes = {"invisible":true}
// Method: QRT_LaunchMethodError
// Description
// Trap error when trying to execute a method from the 
// ReportTemplates env
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/01/06, 16:32:36
	// ----------------------------------------------------
	// 
	// Parameters
	// ----------------------------------------------------
	
	
	// Modified by: Costas Manousakis-(Designer)-(1/20/12 18:02:45)
	Mods_2012_01
	//  `Added  info from the error  stack in the  Alert message;
	//  `Fixed the index of array atQRT_MethodNames to get the correct method name
End if 
C_LONGINT:C283($gERROR)
$gERROR:=Error
Case of 
	: ($gERROR=37)
		ALERT:C41("Cannot Find Stored Method Called <"+atQRT_MethodNames{TMPL_HLSelectedItem_L}+"> !!!")
	Else 
		ARRAY LONGINT:C221(SQLErrorNumbers_al; 0)
		ARRAY TEXT:C222(SQL_InternalCodes_atxt; 0)
		ARRAY TEXT:C222(SQL_InternalDescriptions_atxt; 0)
		GET LAST ERROR STACK:C1015(SQLErrorNumbers_al; SQL_InternalCodes_atxt; SQL_InternalDescriptions_atxt)
		ALERT:C41("Error "+String:C10(SQLErrorNumbers_al{1})+": ["+SQL_InternalDescriptions_atxt{1}+"] while executing Method <"+atQRT_MethodNames{TMPL_HLSelectedItem_L}+"> !!!")
End case 
