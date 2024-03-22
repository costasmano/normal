//%attributes = {"invisible":true}
//Method: INSP_QCSaveApprovalInfo
//Description
// Save /Update approval info into a field
// Parameters
// $1 : $ParamObj  $o."type" : "tl" | "dbie" | "ae"
//    $o."fieldptr" : pointer to field to save / update
//    $o."stack" : stacknumber to push the change
//    $o."name" : 4D Username (optional)
//    $o."osname" : OS Username (optional)
//    $o."wkst" : workstation (optional)
//    $o."date" : approve date (optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/14/21, 18:00:28
	// ----------------------------------------------------
	//Created : 
	Mods_2021_04
	
	C_OBJECT:C1216(INSP_QCSaveApprovalInfo; $1)
	// Modified by: Costas Manousakis-(Designer)-(4/21/21 13:02:51)
	Mods_2021_04
	//  `force Json parse to return Is object
	// Modified by: Costas Manousakis-(Designer)-(2021-10-25T00:00:00 18:42:27)
	Mods_2021_10
	//  `add Personnel ID and user initials in approve object
End if 
//

C_OBJECT:C1216($1)

C_TEXT:C284($type)
C_POINTER:C301($fld_ptr)
C_LONGINT:C283($stack_L)
$type:=OB Get:C1224($1; "type"; Is text:K8:3)
$fld_ptr:=OB Get:C1224($1; "fieldptr"; Is pointer:K8:14)
$stack_L:=OB Get:C1224($1; "stack"; Is longint:K8:6)

C_TEXT:C284($qc_txt)
C_OBJECT:C1216($QC_o; $approve_o)
If ($fld_ptr->#"")
	$qc_txt:=EncryptDecryptString($fld_ptr->)
	$QC_o:=JSON Parse:C1218($qc_txt; Is object:K8:27)
End if 

C_TEXT:C284($User4d_txt; $userOS_txt; $machine_txt; $userInit_txt; $first_txt; $last_txt)
C_LONGINT:C283($PID_L)
$User4d_txt:=Current user:C182
$userOS_txt:=Current system user:C484
$machine_txt:=Current machine:C483
$PID_L:=<>CURRENTUSER_PID
Begin SQL
	select [Personnel].[First Name], [Personnel].[Last Name]
	from [Personnel]
	where [Personnel].[Person ID] = :$PID_L
	into :$first_txt, :$last_txt ;
End SQL
$userInit_txt:=Substring:C12($first_txt; 1; 1)+"."+Substring:C12($last_txt; 1; 1)+"."

If (OB Get:C1224($1; "name"; Is text:K8:3)#"")
	$User4d_txt:=OB Get:C1224($1; "name"; Is text:K8:3)
End if 
If (OB Get:C1224($1; "osname"; Is text:K8:3)#"")
	$userOS_txt:=OB Get:C1224($1; "osname"; Is text:K8:3)
End if 
If (OB Get:C1224($1; "wkst"; Is text:K8:3)#"")
	$machine_txt:=OB Get:C1224($1; "wkst"; Is text:K8:3)
End if 
If (OB Get:C1224($1; "userinitial"; Is text:K8:3)#"")
	$userInit_txt:=OB Get:C1224($1; "userinitial"; Is text:K8:3)
End if 
If (OB Get:C1224($1; "personID"; Is text:K8:3)#"")
	$PID_L:=OB Get:C1224($1; "personID"; Is longint:K8:6)
End if 
C_DATE:C307($date_d)
$date_d:=Current date:C33(*)
If (OB Get:C1224($1; "date"; Is date:K8:7)#!00-00-00!)
	$date_d:=OB Get:C1224($1; "date"; Is date:K8:7)
End if 

OB SET:C1220($approve_o; "name"; $User4d_txt; \
"date"; String:C10($date_d; ISO date:K1:8; Current time:C178(*)); \
"userinitial"; $userInit_txt; \
"personID"; $PID_L; \
"osname"; $userOS_txt; \
"wkst"; $machine_txt)

OB SET:C1220($QC_o; $type; $approve_o)

$qc_txt:=EncryptDecryptString(JSON Stringify:C1217($qc_o))

$fld_ptr->:=$qc_txt

PushChange($stack_L; $fld_ptr)

//End INSP_QCSaveTLApprove