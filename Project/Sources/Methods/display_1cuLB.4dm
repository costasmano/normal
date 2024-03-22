//%attributes = {"invisible":true}
//Method: display_1cuLB
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/07/19, 15:39:52
	// ----------------------------------------------------
	//Created : 
	Mods_2019_05
End if 
//
//GP DISPLAY_1CU.
//Copyright © 1996-97, Thomas D. Nee, All Rights Reserved.

//Called by layout procedure to show one Condition Unit with
//up to five Condition States.
//LISTBOX SET ROWS HEIGHT(*;"LBCondUnits_SUB";35;0)
C_LONGINT:C283($i; $NoCSs)  //Command Replaced was o_C_INTEGER//Counter
C_TEXT:C284(vUnits)  // Command Replaced was o_C_STRING length was 30
C_REAL:C285(vTotQ)
C_BOOLEAN:C305($Error)
//C_TEXT($Text)
DISPLAY_1CU
$Error:=False:C215

vElemName:=LongName

If ([BMS Inspections:44]Metric:14)
	vUnits:=[BMS Elements:47]Units:6
	vTotQ:=Round:C94([Cond Units:45]Total Quantity:5; 1)
Else 
	vUnits:=AnglicizeUnit([BMS Elements:47]Units:6)
	vTotQ:=Round:C94(AnglicizeQ([Cond Units:45]Total Quantity:5; [BMS Elements:47]Units:6); 1)
End if 

$NoCSs:=5
If ([BMS Categories:49]Num of CSs:7>0)
	$NoCSs:=[BMS Categories:49]Num of CSs:7
End if 
CU_SetRowStyle($NoCSs)
//For ($i;1;5)
//  //Negative value is displayed as blank.  
//a_ptr_NewCS{$i}->:=-1  //Pointer to vNewCSi

//If ($i<=$NoCSs)

//Case of 
//: (([Cond Units]Percent) & ([Cond Units]Total Quantity>0))
//  //Convert to Percent of Total.
//a_ptr_CS{$i}->:=Round(100*(a_ptr_CSfld{$i}->/[Cond Units]Total Quantity);1)
//OBJECT SET FORMAT(a_ptr_CS{$i}->;"##0.0 %;")
//: ([BMS Inspections]Metric)
//  //Display metric quantity.
//a_ptr_CS{$i}->:=Round(a_ptr_CSfld{$i}->;1)
//OBJECT SET FORMAT(a_ptr_CS{$i}->;"#,###,##0.0;")
//Else 
//  //Display English quantity.
//a_ptr_CS{$i}->:=Round(AnglicizeQ (a_ptr_CSfld{$i}->;[BMS Elements]Units);1)
//OBJECT SET FORMAT(a_ptr_CS{$i}->;"#,###,##0.0;")
//End case 

//Else 
//OBJECT SET FORMAT(a_ptr_CS{$i}->;"#,###,##0.0;")
//  //A value of -1 indicates non-displayable.
//a_ptr_CS{$i}->:=-1
//  //Gray out unused Condition States.
//  //Black on Light Gray -(15+(256*12)).
//  // SET COLOR(a_ptr_CS{$i}»;-(15+(256*12)))

//End if 

//End for 

//*** Obsolete.
//If ($Error)
//  $Text:="Error:  Condition State numbering is corrupted."+◊sCR+◊sCR
//  $Text:=$Text+"Please double-click on Element "+String([BMS Elements]Element No
//  $Text:=$Text+", Environment "+String([Cond Units]Environment)
//  $Text:=$Text+" to reset the condition states."+◊sCR+◊sCR
//  $Text:=$Text+"Afterwards, please verify the data."
//  ALERT($Text)
//End if 
//End display_1cuLB