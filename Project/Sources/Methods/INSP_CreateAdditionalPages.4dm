//%attributes = {"invisible":true}
//Method: INSP_CreateAdditionalPages
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/07/22, 14:05:31
	// ----------------------------------------------------
	//Created : 
	Mods_2022_06
End if 
//
C_POINTER:C301($1; $2; $FilesToApend_ptr)
$FilesToApend_ptr:=$1
C_TEXT:C284($TempFolder_txt; $ErrorMethod_txt)
$TempFolder_txt:=$2->
//End INSP_CreateAdditionalPages
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="INSP_AttachmentSeq")
ARRAY TEXT:C222($Sequence_atxt; 0)
If (Records in selection:C76([Parameters:107])=1)
	$ErrorMethod_txt:=Method called on error:C704
	
	C_OBJECT:C1216($Seq_obj)
	C_BOOLEAN:C305(4DError_b)
	4DError_b:=False:C215
	ON ERR CALL:C155("4D_Errors")
	
	$Seq_obj:=JSON Parse:C1218([Parameters:107]Description:2; Is object:K8:27)
	If (4DError_b)
		ALERT:C41("Parameter INSP_AttachmentSeq is badly formed!")
		4DError_b:=False:C215
	Else 
		
		OB GET ARRAY:C1229($Seq_obj; "codes"; $Sequence_atxt)
	End if 
	ON ERR CALL:C155($ErrorMethod_txt)
	
Else 
	ARRAY TEXT:C222($Sequence_atxt; 4)
	$Sequence_atxt{1}:="5"
	$Sequence_atxt{2}:="6"
	$Sequence_atxt{3}:="8"
	$Sequence_atxt{4}:="7"
	
End if 

C_TEXT:C284($FileName_txt)
C_LONGINT:C283($Loop_l)
For ($Loop_l; 1; Size of array:C274($Sequence_atxt))
	QUERY:C277([Standard Photos:36]; [Standard Photos:36]InspID:1=[Inspections:27]InspID:2; *)
	QUERY:C277([Standard Photos:36];  & ; [Standard Photos:36]PictType:5=$Sequence_atxt{$Loop_l})
	$FileName_txt:="Attachment_"+$Sequence_atxt{$Loop_l}+".pdf"
	If (Records in selection:C76([Standard Photos:36])=1)
		WRITE PICTURE FILE:C680($TempFolder_txt+$FileName_txt; [Standard Photos:36]Std Photo:3; ".pdf")
		APPEND TO ARRAY:C911($FilesToApend_ptr->; $TempFolder_txt+$FileName_txt)
	End if 
End for 