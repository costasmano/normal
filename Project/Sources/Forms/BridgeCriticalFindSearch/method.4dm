//Method: BridgeCriticalFindSearch
//Description
// Form to help with specifying conditions to search for critical findings
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: May 2, 2023, 17:13:53
	Mods_2023_05
	// ----------------------------------------------------
	
End if 
//
C_LONGINT:C283($FormEvent_L)
$FormEvent_L:=Form event code:C388
C_POINTER:C301($startdate_ptr; $endDate_ptr; $def_ptr; $prio_ptr)
$startdate_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "StartDate")
$endDate_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "endDate")
$def_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "deficiency")
$prio_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "priority")

C_LONGINT:C283($pick_L)

Case of 
	: ($FormEvent_L=On Load:K2:1)
		COPY ARRAY:C226(<>aDefCode; $def_ptr->)
		COPY ARRAY:C226(<>aUORCode; $prio_ptr->)
		$pick_L:=Find in array:C230($def_ptr->; "C-S")
		$def_ptr->:=$pick_L
		$pick_L:=Find in array:C230($prio_ptr->; "I")
		$prio_ptr->:=$pick_L
		$startdate_ptr->:=!00-00-00!
		$endDate_ptr->:=!00-00-00!
		DatePicker SET MAX DATE("EndDate"; Current date:C33)  //max date is current date 
		DatePicker SET MAX DATE("StartDate"; Current date:C33)  //max date is current date 
		OBJECT SET VISIBLE:C603(*; "EndDate"; False:C215)
		OBJECT SET ENABLED:C1123(*; "OKButton"; False:C215)
		
	: ($FormEvent_L=On Validate:K2:3)
		Form:C1466.returnobject.startDate:=$startdate_ptr->
		Form:C1466.returnobject.endDate:=$endDate_ptr->
		$pick_L:=$def_ptr->
		Form:C1466.returnobject.deficiency:=$def_ptr->{$pick_L}
		$pick_L:=$prio_ptr->
		Form:C1466.returnobject.priority:=$prio_ptr->{$pick_L}
		
End case 


//End BridgeCriticalFindSearch   