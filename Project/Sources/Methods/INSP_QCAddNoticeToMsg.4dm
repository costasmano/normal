//%attributes = {"invisible":true}
//Method: INSP_QCAddNoticeToMsg
//Description
// Add the notification of current user, os user and machine to confirm compitetion message
// Parameters
// $ 0: $Newmessage
// $1 : $startmessage
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-10-25T00:00:00, 16:01:06
	// ----------------------------------------------------
	//Created : 
	Mods_2021_10
	
	C_TEXT:C284(INSP_QCAddNoticeToMsg; $0)
	C_TEXT:C284(INSP_QCAddNoticeToMsg; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(2021-10-28T00:00:00 18:03:57)
	Mods_2021_10
	//  `use <>Insp_ESignatureStart to determine when e-sigs are active compared to inspection date
End if 
//

C_TEXT:C284($0; $msg)
C_TEXT:C284($1)

$msg:=$1

C_BOOLEAN:C305($Esig_active_b)
$Esig_active_b:=False:C215
C_DATE:C307(<>Insp_ESignatureStart)
If (<>Insp_ESignatureStart#!00-00-00!)
	$Esig_active_b:=([Inspections:27]Insp Date:78>=<>Insp_ESignatureStart)
End if 

If ($Esig_active_b)
	$msg:="MADOT BMS user "+Current user:C182+\
		" connected from OS user "+Current system user:C484+\
		" on workstation "+Current machine:C483+Char:C90(13)+$msg
	
	ST SET ATTRIBUTES:C1093($msg; \
		Position:C15(Current user:C182; ST Get plain text:C1092($msg)); \
		Position:C15(Current user:C182; ST Get plain text:C1092($msg))+Length:C16(Current user:C182); \
		Attribute bold style:K65:1; 1; Attribute underline style:K65:4; 1; Attribute text color:K65:7; "red")
	
	ST SET ATTRIBUTES:C1093($msg; \
		Position:C15(Current system user:C484; ST Get plain text:C1092($msg)); \
		Position:C15(Current system user:C484; ST Get plain text:C1092($msg))+Length:C16(Current system user:C484); \
		Attribute bold style:K65:1; 1; Attribute underline style:K65:4; 1; Attribute text color:K65:7; "red")
	ST SET ATTRIBUTES:C1093($msg; \
		Position:C15(Current machine:C483; ST Get plain text:C1092($msg)); \
		Position:C15(Current machine:C483; ST Get plain text:C1092($msg))+Length:C16(Current machine:C483); \
		Attribute bold style:K65:1; 1; Attribute underline style:K65:4; 1; Attribute text color:K65:7; "Red")
	ST SET ATTRIBUTES:C1093($msg; ST Start text:K78:15; ST End text:K78:16; Attribute text size:K65:6; 14)
	
End if 

$0:=$msg
//End INSP_QCAddNoticeToMsg