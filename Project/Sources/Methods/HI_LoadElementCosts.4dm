//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/19/05, 16:28:57
	// ----------------------------------------------------
	// Method: HI_LoadElementCosts
	// Description
	//Detemine Element Costs to be used for HI calculations.  
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM18
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
ALL RECORDS:C47([BMS Elements:47])
ARRAY INTEGER:C220($arr_ElemID_i; 0)
ARRAY INTEGER:C220($arr_ElNo_i; 0)
ARRAY INTEGER:C220($arr_NCS_i; 0)

SELECTION TO ARRAY:C260([BMS Elements:47]Element ID:1; $arr_ElemID_i; [BMS Elements:47]Element No:2; $arr_ElNo_i; [BMS Categories:49]Num of CSs:7; $arr_NCS_i)
C_LONGINT:C283($NumElements; $El_i; $Env_i)  //Command Replaced was o_C_INTEGER
$NumElements:=Size of array:C274($arr_ElemID_i)
SHORT_MESSAGE("Loading/Updating..")
For ($El_i; 1; $NumElements)
	MESSAGE:C88(String:C10($El_i)+"..")
	For ($Env_i; 1; 4)  //4 enviroments
		QUERY:C277([ACTMODLS:91]; [ACTMODLS:91]ELEMKEY:2=$arr_ElNo_i{$El_i}; *)
		QUERY:C277([ACTMODLS:91];  & ; [ACTMODLS:91]SKEY:3=$arr_NCS_i{$El_i}; *)
		QUERY:C277([ACTMODLS:91];  & ; [ACTMODLS:91]ENVKEY:5=$Env_i; *)
		QUERY:C277([ACTMODLS:91];  & ; [ACTMODLS:91]MOKEY:1="00")
		ORDER BY:C49([ACTMODLS:91]; [ACTMODLS:91]VARUNITCO:13; <)
		REDUCE SELECTION:C351([ACTMODLS:91]; 1)
		GOTO SELECTED RECORD:C245([ACTMODLS:91]; 1)
		C_REAL:C285($UnitCost)
		QUERY:C277([ELEMDEFS:92]; [ELEMDEFS:92]ELEMKEY:1=[ACTMODLS:91]ELEMKEY:2)
		$UnitCost:=[ACTMODLS:91]VARUNITCO:13*[ELEMDEFS:92]ELEMWEIGHT:18
		QUERY:C277([Element Costs:50]; [Element Costs:50]Element ID:1=$arr_ElemID_i{$El_i}; *)
		QUERY:C277([Element Costs:50];  & ; [Element Costs:50]Environment:5=$Env_i; *)
		QUERY:C277([Element Costs:50];  & ; [Element Costs:50]Action No:3="HI")  //for the HI
		Case of 
			: (Records in selection:C76([Element Costs:50])=0)
				//new rec
				CREATE RECORD:C68([Element Costs:50])
				[Element Costs:50]Element ID:1:=$arr_ElemID_i{$El_i}
				[Element Costs:50]Action No:3:="HI"
				[Element Costs:50]Environment:5:=$Env_i
				[Element Costs:50]Cost:4:=$UnitCost
				SAVE RECORD:C53([Element Costs:50])
			: (Records in selection:C76([Element Costs:50])=1)
				//update
				LOAD RECORD:C52([Element Costs:50])
				[Element Costs:50]Cost:4:=$UnitCost
				SAVE RECORD:C53([Element Costs:50])
				
			Else 
				//error
		End case 
		
	End for 
	
End for 

CLOSE WINDOW:C154