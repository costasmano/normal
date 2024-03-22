//%attributes = {"invisible":true}
//GP STORE_CS ($i)
//Copyright © 1996-97, Thomas D. Nee, All Rights Reserved.
//Store the value entered in vCS{$i} (referenced by pointer a_ptr_CS{$i})
//in aCS{$i}.

//Execute only when modified.  The variable vNoCSs is the number of Condition
//State records, which has already been set in GP SETUP_CSs.
//The array aCS{i} is the intermediary between the Condition State values stored
//in the [Cond State Insp] records and the pointer array a_ptr_CS{i}
//(points to the enterable objects vCSi).
//aCS{i} is always a metric quantity;  vCSi can be a metric quantity,
//an English quantity, or a percent.

C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER//Number of user modified Condition State; does not change in this GP.
C_LONGINT:C283($j)  //Command Replaced was o_C_INTEGER//Just a counter.
C_LONGINT:C283($k)  //Command Replaced was o_C_INTEGER//Condition State Index.
C_TEXT:C284($Text)  //Alert message text.
C_REAL:C285($CSi)  //User entered value.
C_REAL:C285($Diff)  //Difference between the Total Quantity and the sum of the CS's.
//vMaxCSs=5 in GP INIT_BMS.
ARRAY REAL:C219($aCS; 5)  //Saved starting values (in case of a cancel).

$i:=$1

$CSi:=a_ptr_CS{$i}->  //This is what the user entered.

//TRACE

Case of 
	: ([Cond Units:45]Percent:6)
		If ($CSi>100)
			$Text:="Your entry exceeded 100%.  Please try again."
			ALERT:C41($Text)
			GOTO OBJECT:C206(a_ptr_CS{$i}->)
			ABORT:C156
		End if 
		//Convert the Percent to a Quantity.  
		$CSi:=[Cond Units:45]Total Quantity:5*($CSi/100)
		
	: ([BMS Inspections:44]Metric:14=False:C215)
		$CSi:=MetricizeQ($CSi; [BMS Elements:47]Units:6)
		
End case 

If ([BMS Elements:47]Units:6="EA")
	//This element must be recorded in whole numbers.
	$CSi:=Round:C94($CSi; 0)
	//Else 
	//  $CSi:=Round($CSi;1)
End if 

//Can't use this because the user might enter decimal data.
//If ($CSi=aCS{$i})
//    `The user re-entered the existing value; do nothing.
//  ABORT
//End if 

If (([BMS Categories:49]Record as Each:6) | ([BMS Categories:49]Smart Flag:5))
	//The entire quantity must be in one condition state. 
	
	//$i is the entered Condition State (does not change in this procedure).
	//$k is the Condition State that will be modified in the loop.  
	If ($CSi=0)
		//The user entered zero; move 100% to next CS.
		$k:=CycleCS($i)
	Else 
		If ([Cond Units:45]Total Quantity:5=0)
			[Cond Units:45]Total Quantity:5:=$CSi
			PushChange(2; ->[Cond Units:45]Total Quantity:5)
			DISPLAY_Q
		End if 
		If (($CSi#[Cond Units:45]Total Quantity:5) & Not:C34([BMS Categories:49]Smart Flag:5))
			$Text:="All of this element's quantity must be in one Condition State."
			ALERT:C41($Text)
		End if 
		//Set the entered one to 100%.
		$k:=$i
	End if 
	
	aCS{$k}:=[Cond Units:45]Total Quantity:5
	
	//$j is just a counter.
	$j:=1
	While ($j<vNoCSs)
		//Cycle through the remaining Condition States; set them to zero.
		//Do this loop one fewer times than the number of CS's.
		$k:=CycleCS($k)
		aCS{$k}:=0
		$j:=$j+1
	End while 
	
Else 
	//The quantity can be in more than one condition state.
	
	//First, save the starting values (in case of a cancel).
	For ($j; 1; vNoCSs)
		$aCS{$j}:=aCS{$j}
	End for 
	
	//Make sure the CS quanities add up to the total quantity.  Assume that any
	//change to the CS quantity modifies the worse (higher number) Condition States.
	//If the worst Condition States can't be modified, then cycle through the first
	//Condition States.
	aCS{$i}:=$CSi
	$Diff:=[Cond Units:45]Total Quantity:5
	For ($j; 1; vNoCSs)
		$Diff:=$Diff-aCS{$j}
	End for 
	
	//$i is the entered Condition State (does not change in this procedure).
	//$k is the Condition State modified in the loop.
	$k:=$i
	//$j is just a counter.
	$j:=1
	While (($j<vNoCSs) & ($Diff#0))
		//Cycle through the Condition States.
		//Do this loop one fewer times than the number of CS's (i.e., don't come
		//around and modify the one entered by the user).
		$k:=CycleCS($k)
		aCS{$k}:=aCS{$k}+$Diff
		
		If (aCS{$k}<0)
			//Move it to the next (or first) Condition State.        
			$Diff:=aCS{$k}
			aCS{$k}:=0
		Else 
			//All done.        
			$Diff:=0
		End if 
		
		$j:=$j+1
	End while 
	
	If ($Diff<-0.00000001)  //$Diff sometimes ends up as a very small number instead of zero.
		//The user exceeded the Total Quantity.  Either the Total Quantity or the current
		//Condition State must be modified.
		OK:=1
		If ([Cond Units:45]Total Quantity:5>0)
			$Text:="You exceeded the Total Quantity.  Do you want to increase the Total Quantity?"
			CONFIRM:C162($Text)
		End if 
		If (OK=1)
			[Cond Units:45]Total Quantity:5:=[Cond Units:45]Total Quantity:5-$Diff
			PushChange(2; ->[Cond Units:45]Total Quantity:5)
			DISPLAY_Q
		Else 
			//Restore the starting values.
			For ($j; 1; vNoCSs)
				aCS{$j}:=$aCS{$j}
			End for 
			GOTO OBJECT:C206(a_ptr_CS{$i}->)
		End if 
	End if 
	
End if 

DISPLAY_CS