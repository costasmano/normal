
// ----------------------------------------------------
// Form Method: TableOfLists.i
// User name (OS): cjmiller
// Date and time: 01/10/06, 14:47:01
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_09  // CJ Miller`09/16/11, 12:54:01      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(6/20/14 17:40:38)
	Mods_2014_06_bug
	//  `assigned ENTER key as shortcut to validate button - change action of valicdate to No action
End if 

If (Form event code:C388=On Load:K2:1)
	
	If (Not:C34(In transaction:C397))
		START TRANSACTION:C239
	End if 
	If (Record number:C243([TableOfLists:125])=New record:K29:1)
		[TableOfLists:125]ListName_s:1:=SelectedListName_s
		Inc_Sequence("TableOfLists"; ->[TableOfLists:125]ListKeyID_L:4)
	End if 
	
End if 
//End Form Method: TableOfLists.i