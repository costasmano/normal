//%attributes = {"invisible":true}
// Method: PRV_Addendum_FM
// Description
// 
// 
// Parameters
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 06/14/12, 14:07:40
	// ----------------------------------------------------
	// First Release
	Mods_2012_06
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Close Detail:K2:24)
		
	: ($FormEvent_L=On Load:K2:1)
		
		If (Is new record:C668([Addendum_Maintenance:102]))
			Inc_Sequence("AddendumMaint"; ->[Addendum_Maintenance:102]AddendumID:1)
			C_LONGINT:C283(PRV_LASTSEQNO_L; PRV_CURRASSIGNID_L)
			PRV_CURRASSIGNID_L:=[Contract_Assignment_Maintenance:101]AssignID:3
			Begin SQL
				select max(Addendum_Maintenance.AddendumNo)
				from Addendum_Maintenance
				where Addendum_Maintenance.AssignID = :PRV_CURRASSIGNID_L
				into :PRV_LASTSEQNO_L
			End SQL
			[Addendum_Maintenance:102]AddendumNo:2:=PRV_LASTSEQNO_L+1
			[Addendum_Maintenance:102]DateCreated:6:=Current date:C33(*)
			[Addendum_Maintenance:102]ContractNo:5:=[Contract_Assignment_Maintenance:101]ContractNo:1
			[Addendum_Maintenance:102]Overhead:18:=[Contract_Assignment_Maintenance:101]Overhead:5
			[Addendum_Maintenance:102]Fee:17:=[Contract_Assignment_Maintenance:101]Fee:6
			[Addendum_Maintenance:102]AssignNo:4:=[Contract_Assignment_Maintenance:101]AssignNo:2
			[Addendum_Maintenance:102]AssignID:3:=[Contract_Assignment_Maintenance:101]AssignID:3
			
		End if 
		
		If (PRV_LockedAssignment_b)
			OBJECT SET ENTERABLE:C238(*; "DE@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "DE@Btn"; False:C215)
		End if 
		
	: ($FormEvent_L=On Validate:K2:3)
		
	: ($FormEvent_L=On Unload:K2:2)
		
End case 
//End PRV_Addendum_FM