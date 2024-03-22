//%attributes = {"invisible":true}
//Method: CSLTINSP_ProceedWithLetter
//Description
// verify if it is ok to proceed with creating a letter for Consultant inspections
// Parameters
// $0: $Results_o  : object containing results of check
//  // {records : numrecords}
//  // {createLtr : true/false}
//  // {NBIRecs : true/false } : records are all NBI or notNBI
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/08/20, 12:29:51
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06
	
	C_OBJECT:C1216(CSLTINSP_ProceedWithLetter; $0)
	// Modified by: Costas Manousakis-(Designer)-(2023-06-07 11:00:24)
	Mods_2023_06_bug
	//  `when there are both NBI and Non-NBI bridges on list , ask for confirmation!
End if 
//

C_OBJECT:C1216($0; $Results_o)

//there must be records listed 
//Contract and assignment must be the same
//BIN records must be all either NBI or Non-NBI
//contract number must exist in the [contracts] table
C_LONGINT:C283($Recs)
$Recs:=Records in selection:C76([Cons Inspection:64])

ARRAY TEXT:C222($contrNos_atxt; 0)
ARRAY INTEGER:C220($AssignNos_aL; 0)
ARRAY LONGINT:C221($recs_aL; 0)
ARRAY BOOLEAN:C223($NBIRec_ab; 0)
C_LONGINT:C283($contrCount_L)
C_BOOLEAN:C305($NBIRecs_b; $AllSame_b; $bCreateLetter)
C_LONGINT:C283($loop_L)

If ($Recs>0)
	DISTINCT VALUES:C339([Cons Inspection:64]ConContractNo:7; $contrNos_atxt)
	DISTINCT VALUES:C339([Cons Inspection:64]AssignConNumber:6; $AssignNos_aL)
	SELECTION TO ARRAY:C260([Cons Inspection:64]; $recs_aL; [Bridge MHD NBIS:1]FHWARecord:174; $NBIRec_ab)
	$NBIRecs_b:=$NBIRec_ab{1}
	$AllSame_b:=True:C214
	For ($loop_L; 2; Size of array:C274($NBIRec_ab))
		If ($NBIRec_ab{$loop_L}#$NBIRec_ab{$loop_L-1})
			$AllSame_b:=False:C215
			$loop_L:=Size of array:C274($NBIRec_ab)+1  //exit loop
		End if 
	End for 
	
	//Contract should exist
	C_TEXT:C284($contrNo_txt)
	$contrNo_txt:=$contrNos_atxt{1}
	Begin SQL
		select count(*)
		from [Contracts]
		where [Contracts].[ContractNo] = :$contrNo_txt
		into :$contrCount_L ;
	End SQL
	
End if 

$bCreateLetter:=False:C215

Case of 
	: ($Recs=0)
		ALERT:C41("You must have at least one Bridge Inspection in the list!")
		
	: (Size of array:C274($contrNos_atxt)>1) | (Size of array:C274($AssignNos_aL)>1)
		ALERT:C41("Cannot create this letter for multiple contracts and/or multiple assignments!")
		
	: (Not:C34($AllSame_b))
		CONFIRM:C162("There are both NBI and Non-NBI bridge records in the list! Do you want to continue?"; "Yes"; "No")
		$bCreateLetter:=(Ok=1)
		
	: ($contrCount_L=0)
		ALERT:C41("Contract number ["+$contrNo_txt+"] was not found in the system!")
		
	: ($Recs>20)
		CONFIRM:C162("Are you sure you want to include all "+String:C10($Recs)+" selected bridges in the letter?"; "Yes"; "No")
		$bCreateLetter:=(Ok=1)
		
	Else 
		$bCreateLetter:=True:C214
End case 

OB SET:C1220($Results_o; "records"; $Recs; "createLtr"; $bCreateLetter; "NBIRecs"; $NBIRecs_b)

$0:=$Results_o
//End CSLTINSP_ProceedWithLetter