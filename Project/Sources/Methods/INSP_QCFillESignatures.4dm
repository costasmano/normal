//%attributes = {"invisible":true}
//Method: INSP_QCFillESignatures
//Description
// Fill the E-signature objects on inspection print forms.
// will use form objects TLESignature and DBIEESignature
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-10-25 17:18:54
	// ----------------------------------------------------
	//Created : 
	Mods_2021_10
	// Modified by: Costas Manousakis-(Designer)-(2021-10-28T00:00:00 18:03:57)
	Mods_2021_10
	//  `use <>Insp_ESignatureStart to determine when e-sigs are active compared to inspection date
End if 
//

//initialize the signature objects
OBJECT SET TITLE:C194(*; "TLESignature"; "")
OBJECT SET TITLE:C194(*; "DBIEESignature"; "")
C_BOOLEAN:C305($Esig_active_b)
$Esig_active_b:=False:C215
C_DATE:C307(<>Insp_ESignatureStart)
If (<>Insp_ESignatureStart#!00-00-00!)
	$Esig_active_b:=([Inspections:27]Insp Date:78>=<>Insp_ESignatureStart)
End if 
If ($Esig_active_b)
	
	//get the text and parse into object
	C_TEXT:C284($qc_txt; $Objname_txt)
	C_OBJECT:C1216($qc_o)
	$qc_txt:=EncryptDecryptString([Inspections:27]RatingFeedBack:203)
	$qc_o:=JSON Parse:C1218($qc_txt; Is object:K8:27)
	
	//scan the properties in the object
	ARRAY TEXT:C222($props_atxt; 0)
	OB GET PROPERTY NAMES:C1232($qc_o; $props_atxt)
	C_TEXT:C284($Esig_txt; $sig_date_txt; $initials_txt)
	C_LONGINT:C283($loop_L)
	C_OBJECT:C1216($Info)
	For ($loop_L; 1; Size of array:C274($props_atxt))
		$Objname_txt:=""
		Case of 
			: ($props_atxt{$loop_L}="tl")
				//fill only if inspection is complete
				If ([Inspections:27]InspComplete:168)
					$Info:=OB Get:C1224($qc_o; "tl"; Is object:K8:27)
					$Objname_txt:="TLESignature"
				End if 
			: ($props_atxt{$loop_L}="dbie")
				If ([Inspections:27]InspReviewed:12=BMS Approved)
					$Info:=OB Get:C1224($qc_o; "dbie"; Is object:K8:27)
					$Objname_txt:="DBIEESignature"
				End if 
				
		End case 
		If ($Objname_txt#"")
			$sig_date_txt:=Substring:C12(OB Get:C1224($Info; "date"; Is text:K8:3); 1; 10)
			$initials_txt:=OB Get:C1224($Info; "userinitial"; Is text:K8:3)
			If ($initials_txt#"")
				$initials_txt:=$initials_txt+" "
			End if 
			OBJECT SET TITLE:C194(*; $Objname_txt; "E-Signed "+$initials_txt+$sig_date_txt)
			
		End if 
	End for 
	
End if 

//End INSP_QCFillESignatures