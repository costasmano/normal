//%attributes = {"invisible":true}
//Method: ut_UseListBox
//Description
//This method will allow swich between new list box and original pout for for designer
// Parameters
// $0 : UseListbox_b : true use listbox dialog ; False : use output form
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 06/30/20, 16:12:12
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06
	
	C_BOOLEAN:C305(ut_UseListBox; $0)
	C_TEXT:C284(ut_UseListBox; $1)  //current method name calling it
	Mods_2020_12  //Added code to allow for auto change to use List box. 
	//Modified by: CJ (12/22/20 12:50:29)
	// Modified by: Costas Manousakis-(Designer)-(2021-10-01T00:00:00 15:42:36)
	Mods_2021_10
	//  `Use SQL to avoid locking Parameters record
End if 
//
C_BOOLEAN:C305($0; $useLB_B)
$0:=False:C215
$useLB_B:=False:C215
If (Count parameters:C259=1)
	C_TEXT:C284($1; $UseListboxmethods)
	Begin SQL
		select [Parameters].Description
		from [Parameters]
		where [Parameters].ParamCode = 'USENewListBox'
		into :$UseListboxmethods ;
	End SQL
	//QUERY([Parameters];[Parameters]ParamCode="USENewListBox")
	ARRAY TEXT:C222($parts_atxt; 0)
	ut_NewTextToArray($UseListboxmethods; ->$parts_atxt; ",")
	$useLB_B:=(Find in array:C230($parts_atxt; $1)>0)
	
End if 
Case of 
	: ($useLB_B)
		
	: (Current user:C182="Designer")
		CONFIRM:C162("Use Original Output form or List Box"; "List Box"; "Original Form")
		$useLB_B:=OK=1
	Else 
		$useLB_B:=False:C215
End case 
$0:=$useLB_B

//End ut_UseListBox
