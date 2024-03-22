//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/19/05, 16:20:22
	// ----------------------------------------------------
	// Method: SIA_MountModule
	// Description
	// Switch to different input screen from main Bridge Input form.
	//
	// Parameters
	// 1 : Text : Name of form
	// 2 : Boolean : Do relate many or not (optional)
	// ` Default = false
	// 3 : Int : Menu bar to mount (optional)
	//  ` Default = 3
	// ----------------------------------------------------
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(4/16/08 10:33:25)
	Mods_2008_CM_5403
	//Special for MDC users- if not a MDC bridge lock buttons except sia,insp, inv
	// Modified by: costasmanousakis-(Designer)-(5/1/08 09:22:28)
	Mods_2008_CM_5403
	//  `After the next input form loaded by the Modify record, unload and reload the 
	//  `bridge record because any changes made and then canceled from the next input form
	//  `still appear. Saved changes will still hold true.
	// Modified by: costasmanousakis-(Designer)-(2/16/10 10:34:04)
	Mods_2010_02
	// Use new Method SIA_BridgeInput_FM
	// Modified by: Costas Manousakis-(Designer)-(10/23/13 14:16:12)
	Mods_2013_10
	//  `if the Bridge  table is in Read only state - set it to RW to avoid error messages
	// Modified by: Costas Manousakis-(Designer)-(2/28/14 11:53:45)
	Mods_2014_02
	//  `Removed   `ControlMenuBar (2) at the end. Left at BlankMenu
	// Modified by: Costas Manousakis-(Designer)-(9/14/18 16:28:41)
	Mods_2018_09
	//  `Adjust window sizes when opening and closing forms
End if 
C_TEXT:C284($1; $FormName_txt)
C_BOOLEAN:C305($2; $RelateMany_b)
C_LONGINT:C283($3; $MenubarNo_I)  //Command Replaced was o_C_INTEGER
$FormName_txt:=$1
If (Count parameters:C259>1)
	$RelateMany_b:=$2
Else 
	$RelateMany_b:=False:C215
End if 
If (Count parameters:C259>2)
	$MenubarNo_I:=$3
Else 
	$MenubarNo_I:=3
End if 

C_LONGINT:C283($W)

ControlMenuBar($MenubarNo_I)
FORM SET INPUT:C55([Bridge MHD NBIS:1]; $FormName_txt)
If ($RelateMany_b)
	RELATE MANY:C262([Bridge MHD NBIS:1])
End if 
C_BOOLEAN:C305($BrTableRO_b)
$BrTableRO_b:=Read only state:C362([Bridge MHD NBIS:1])
If ($BrTableRO_b)
	READ WRITE:C146([Bridge MHD NBIS:1])
End if 
C_LONGINT:C283($wL; $wT; $wr; $wb)
GET WINDOW RECT:C443($wL; $wT; $wr; $wb)
C_LONGINT:C283($wf; $hf)
FORM GET PROPERTIES:C674([Bridge MHD NBIS:1]; $FormName_txt; $wf; $hf)
If ($wf>($wr-$wL))
	$wr:=$wl+$wf
End if 
If ($hf>($wb-$wt))
	$wb:=$wt+$hf
End if 
SET WINDOW RECT:C444($wL; $wT; $wr; $wb)
MODIFY RECORD:C57([Bridge MHD NBIS:1])
C_LONGINT:C283($w1L; $w1T; $w1r; $w1b)
GET WINDOW RECT:C443($w1L; $w1T; $w1r; $w1b)
If (($w1r-$w1L)<($wr-$wL))
	$w1r:=$w1L+($wr-$wL)
End if 

If (($w1b-$w1T)<($wb-$wt))
	$w1b:=$w1T+($wb-$wt)
End if 

SET WINDOW RECT:C444($w1L; $w1T; $w1r; $w1b)

SIA_BridgeInput_FM(On Load:K2:1)

If ($BrTableRO_b)
	READ ONLY:C145([Bridge MHD NBIS:1])
End if 

FORM SET INPUT:C55([Bridge MHD NBIS:1]; "Bridge Input")

//ControlMenuBar (2)