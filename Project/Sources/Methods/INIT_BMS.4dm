//%attributes = {"invisible":true}
If (False:C215)
	//GP INIT_BMS
	//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
	//Initialize BMS global variables and arrays.
	
	Mods_2006_CM03
End if 

C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER

C_TEXT:C284(vName)  // Command Replaced was o_C_STRING length was 88//Person Name concatenated from [Personnel] file.
C_TEXT:C284(vElemName)  // Command Replaced was o_C_STRING length was 100//Element Name concatenated from element and category fields.
C_TEXT:C284(vInspDate)  // Command Replaced was o_C_STRING length was 8//Enterable Object: Inspection Date MMDDYYYY.

C_LONGINT:C283(vMinCSs)  //Fewest allowable Condition States for an Element.
vMinCSs:=3
C_LONGINT:C283(vMaxCSs)  //Maximum number of Condition States for an Element.
vMaxCSs:=5

//Objects on layout [Cond Units];"Cond Units In" and "Cond Units Inc".
C_LONGINT:C283(vElemNo)  //Command Replaced was o_C_INTEGER//Enterable Object: Element Number.
C_TEXT:C284(vOldComment)  //Non-Enterable Object: Previous Comment.
C_TEXT:C284(vElemText)  //Non-Enterable Object: Element Description.
C_TEXT:C284(vCSText)  //Non-Enterable Object: Condition State Descriptions.
C_REAL:C285(vOldQ)  //Non-Enterable Object: Previous Total Quantity.
C_REAL:C285(vCS1; vCS2; vCS3; vCS4; vCS5)  //Enterable Objects: Condition State Values (% or Q).
C_REAL:C285(vOldCS1; vOldCS2; vOldCS3; vOldCS4; vOldCS5)  //Non-Enterable Objects: Previous Condition State Values (% or Q).
C_REAL:C285(vNewCS1; vNewCS2; vNewCS3; vNewCS4; vNewCS5)  //Non-Enterable Objects, but printable.
ARRAY POINTER:C280(a_ptr_CS; 5)  //Pointer to vCSi.
ARRAY POINTER:C280(a_ptr_OldCS; 5)  //Pointer to vOldCSi.
ARRAY POINTER:C280(a_ptr_NewCS; 5)  //Pointer to vNewCSi.
For ($i; 1; vMaxCSs)  //Set up the arrays of pointers to the displayable Condition State objects.
	a_ptr_CS{$i}:=Get pointer:C304("vCS"+String:C10($i))
	a_ptr_OldCS{$i}:=Get pointer:C304("vOldCS"+String:C10($i))
	a_ptr_NewCS{$i}:=Get pointer:C304("vNewCS"+String:C10($i))
End for 
ARRAY POINTER:C280(a_ptr_CSfld; 5)  //Pointer to [Cond Units]CondStatei.
a_ptr_CSfld{1}:=->[Cond Units:45]CondState1:10
a_ptr_CSfld{2}:=->[Cond Units:45]CondState2:11
a_ptr_CSfld{3}:=->[Cond Units:45]CondState3:12
a_ptr_CSfld{4}:=->[Cond Units:45]CondState4:13
a_ptr_CSfld{5}:=->[Cond Units:45]CondState5:14

//Condition State (CS) arrays and variables (see GP SETUP_CSs).
ARRAY REAL:C219(aCS; 5)  //Storage for Condition State Values; always Quantities.
ARRAY REAL:C219(aOldCS; 5)  //Storage for Previous Condition State Values; always Quantities.
C_LONGINT:C283(vNoCSs)  //Command Replaced was o_C_INTEGER//The valid number of Condition States for the current element.
C_LONGINT:C283(vNoOldCSs)  //Command Replaced was o_C_INTEGER//The number of Condition States for the original element.

//Colors used on layout [Cond Units];"Cond Units In".
C_LONGINT:C283(vEntryColor)  //Entry Color.
vEntryColor:=-(6+(((15*16)+5)*256))  //Blue (6) on Light Grey  (15*16+5; 16th row 6th from left).  
C_LONGINT:C283(vDispColor)  //Non-enterable Display Color.
vDispColor:=-(15+(((11*16)+2)*256))  //Black (15) on Light Green (11*16+2; 12th row 3rd from left).

ut_RetrieveBMSArraysDoc

//This is also initialized in InitProcessVar, but I wanted to be able to
//open BMS Inspection records from the User environment without getting an error,
//so I duplicated it here.  TDN.
//Array for changes.
ARRAY POINTER:C280(ptr_Changes; 0; 0)