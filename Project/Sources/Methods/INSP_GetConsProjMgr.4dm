//%attributes = {"invisible":true}
//Method: INSP_GetConsProjMgr
//Description
// Retrieve the project manager for a company 
// Parameters 
// $1 : $param_obj
//   -> .agency  : agency name
//   -> .structure : type of structure inspected "BIN" or "TIN"
//   <- .mgrID  : ID of project manager found
//   <- .mgrEmail  : email of project manager found
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/24/21, 16:39:43
	// ----------------------------------------------------
	//Created : 
	Mods_2021_03
	
	C_OBJECT:C1216(INSP_GetConsProjMgr; $1)
	// Modified by: Costas Manousakis-(Designer)-(4/21/21 13:05:32)
	Mods_2021_04
	//  `force ob get to return Is text
	// Modified by: Costas Manousakis-(Designer)-(2023-05-04 11:19:46)
	Mods_2023_05_bug
	//  `added missing [Personnel].EmailAddress_s from the SQL select - array $Emails_atxt was not getting filled
End if 
//
C_OBJECT:C1216($1; $param_o)
$param_o:=$1
C_TEXT:C284($agency; $structype)
$agency:=OB Get:C1224($param_o; "agency"; Is text:K8:3)
$structype:=OB Get:C1224($param_o; "structure"; Is text:K8:3)

C_LONGINT:C283($mgrID)
C_TEXT:C284($email_txt)
$mgrID:=0

//first find if there is a person listed in the structure type proj manager group
C_TEXT:C284($persGroup)
$persGroup:=$structype+"_InspProjMgrs"
ARRAY LONGINT:C221($Ids_aL; 0)
ARRAY TEXT:C222($Emails_atxt; 0)
Begin SQL
	select 
	[Personnel].[Person ID] ,
	[Personnel].EmailAddress_s
	from [Personnel]
	where [Personnel].[Employer] = :$agency
	and [Personnel].[EmailAddress_s] <> ''
	and [Personnel].[Person ID] IN 
	( Select [PERS_GroupMembers].[PersonID_I] 
	from [PERS_GroupMembers], [PERS_Groups]
	where 
	[PERS_GroupMembers].[GroupID_I] = [PERS_Groups].PERS_GroupID_I and
	[PERS_Groups].[PERS_GroupName_s]= :$persGroup )
	into :$Ids_aL , :$Emails_atxt ;
	
End SQL

If (Size of array:C274($Ids_aL)>0)
	$mgrID:=$Ids_aL{1}
	$email_txt:=$Emails_atxt{1}
Else 
	//search in the general insp proj manager group
	Begin SQL
		select 
		[Personnel].[Person ID] ,
		[Personnel].[EmailAddress_s]
		from [Personnel]
		where [Personnel].[Employer] = :$agency
		and [Personnel].[EmailAddress_s] <> ''
		and [Personnel].[Person ID] IN 
		( Select [PERS_GroupMembers].[PersonID_I] 
		from [PERS_GroupMembers], [PERS_Groups]
		where 
		[PERS_GroupMembers].[GroupID_I] = [PERS_Groups].PERS_GroupID_I and
		[PERS_Groups].[PERS_GroupName_s]= 'ConsInspProjMgrs' )
		into :$Ids_aL , :$Emails_atxt ;
		
	End SQL
	
	If (Size of array:C274($Ids_aL)>0)
		$mgrID:=$Ids_aL{1}
		$email_txt:=$Emails_atxt{1}
	End if 
	
End if 

OB SET:C1220($1; "mgrID"; $mgrID; "mgrEmail"; $email_txt)

//End INSP_GetConsProjMgr