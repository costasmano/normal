//%attributes = {"invisible":true}
//Method: PON_VERIFYUNIQELEM_b
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/19/15, 16:42:27
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 
//
C_BOOLEAN:C305($0)
C_LONGINT:C283($1; $2; $3; $4)
C_LONGINT:C283($key_L; $env_L; $parent_L; $Grandp_L)

$key_L:=$1
$env_L:=$2
$parent_L:=$3
$Grandp_L:=$4

C_BOOLEAN:C305($Unique_b)
C_LONGINT:C283($Count_L)

SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
QUERY:C277([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]BRKEY:1=[PON_ELEM_INSP:179]BRKEY:1; *)
QUERY:C277([PON_ELEM_INSP:179];  & ; [PON_ELEM_INSP:179]INSPID:21=[PON_ELEM_INSP:179]INSPID:21; *)
QUERY:C277([PON_ELEM_INSP:179];  & ; [PON_ELEM_INSP:179]STRUNITKEY:6=[PON_ELEM_INSP:179]STRUNITKEY:6; *)
QUERY:C277([PON_ELEM_INSP:179];  & ; [PON_ELEM_INSP:179]ELEMID:22#[PON_ELEM_INSP:179]ELEMID:22; *)
QUERY:C277([PON_ELEM_INSP:179];  & ; [PON_ELEM_INSP:179]ELEM_KEY:3=$key_L; *)
QUERY:C277([PON_ELEM_INSP:179];  & ; [PON_ELEM_INSP:179]ENVKEY:5=$env_L; *)
QUERY:C277([PON_ELEM_INSP:179];  & ; [PON_ELEM_INSP:179]ELEM_PARENT_KEY:4=$parent_L; *)
QUERY:C277([PON_ELEM_INSP:179];  & ; [PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19=$Grandp_L)

SET QUERY DESTINATION:C396(Into current selection:K19:1)

$0:=($Count_L=0)
//End PON_VERIFYUNIQELEM_b