//%attributes = {"invisible":true}
//Method: UpdateProgressNew
//Description
// Update the 4D progress bar
// Parameters
// $1 : $ProgressObj_o
// $2 : $Curr_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/24/17, 17:01:59
	// ----------------------------------------------------
	//Created : 
	Mods_2017_10
	
	C_OBJECT:C1216(UpdateProgressNew; $1)
	C_LONGINT:C283(UpdateProgressNew; $2)
	
	// Modified by: Costas Manousakis-(Designer)-(4/20/21 17:56:56)
	Mods_2021_WP
	//  `shortened the message
End if 
//
C_OBJECT:C1216($1)
C_LONGINT:C283($2)

C_LONGINT:C283($Curr_L; $Total_L; $StartMS_L; $progress_L; $currMill_L; $TimeOpt_L)
C_TEXT:C284($MsgTemplate_txt; $NumFormat_txt; $msg_txt)

$Curr_L:=$2
$Total_L:=OB Get:C1224($1; "total"; Is longint:K8:6)
$progress_L:=OB Get:C1224($1; "progress"; Is longint:K8:6)
$MsgTemplate_txt:=OB Get:C1224($1; "msgtempl"; Is text:K8:3)
$StartMS_L:=OB Get:C1224($1; "StartMS"; Is longint:K8:6)
$TimeOpt_L:=OB Get:C1224($1; "timeOpt"; Is longint:K8:6)

If ($progress_L>0)
	
	Progress SET PROGRESS($progress_L; ($Curr_L/$Total_L))
	
	$NumFormat_txt:="###,###,###,###,###,###"
	
	If ($MsgTemplate_txt="")
		$MsgTemplate_txt:=" records"
	End if 
	$msg_txt:=String:C10($Curr_L; $NumFormat_txt)+" of "+String:C10($Total_L; $NumFormat_txt)+$MsgTemplate_txt
	$currMill_L:=Milliseconds:C459
	
	If (($StartMS_L>0) & ($Curr_L/$Total_L>0.005))
		C_LONGINT:C283($DT_L; $RRR_L)
		C_REAL:C285($RRR_r)
		$DT_L:=$currMill_L-$StartMS_L
		$RRR_r:=($dt_L/$Curr_L)*($Total_L-$Curr_L)
		$RRR_L:=$RRR_r
		If ($TimeOpt_L ?? 0)
			//show time elapsed
			$msg_txt:=$msg_txt+" Used: "+FN_MilliSec2TimeStr($DT_L)
		End if 
		If ($TimeOpt_L ?? 1)
			//Show est remaining
			$msg_txt:=$msg_txt+" Left: "+FN_MilliSec2TimeStr($RRR_L)
		End if 
	End if 
	
	Progress SET MESSAGE($progress_L; $msg_txt)
	
End if 

//End UpdateProgressNew