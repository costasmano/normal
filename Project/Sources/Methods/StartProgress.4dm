//%attributes = {"invisible":true}
If (False:C215)
	// Procedure: StartProgress (Window title; Termination method; Prompt string)
	// $0  Longint ID of launched process
	// $1	String	Desired window title
	// $2  String  Desired termination method ["Button";"Key";"None"]
	// $3  String  User feedback string
	// $4  Optional Item Description
	//
	// This procedure "encrypts" the parameters for the
	// indicator process and then launches it, passing the 
	// parameters in the process name [ see TN #31 ]
	
	// Preconditions : None
	
	// Assumptions : None
	//
	// Created 4/30/94 —Forrest Swilling
	// Modified by: costasmanousakis-(Designer)-(5/10/11 11:24:51)
	Mods_2011_05
	//  `Changed size of $3 and $4 to 132
	// Modified by: Costas Manousakis-(Designer)-(3/27/14 13:59:54)
	Mods_2014_03
	//  `removed the alert for Administrator
End if 

C_TEXT:C284($1; $2)  // Command Replaced was o_C_STRING length was 32
C_TEXT:C284($3; $4)  // Command Replaced was o_C_STRING length was 132
C_LONGINT:C283($0)
C_TEXT:C284($Name)  // Command Replaced was o_C_STRING length was 32

$Name:=("$"+$1+";"+$2)
//Global variables are defined in INIT_UI_GV method
<>vTitle:=$3

If (Count parameters:C259=4)
	<>vItemDesc:=$4
Else 
	<>vItemDesc:="Records to be processed:"
End if 

<>Ready:=False:C215
C_LONGINT:C283($rcount)
$rcount:=0
C_LONGINT:C283($pID)
$pID:=New process:C317("ShowProgress"; <>LStackSize; $Name; *)  // designate as local process
Repeat 
	IDLE:C311
	$rcount:=$rcount+1
Until (<>Ready)

$0:=$pID