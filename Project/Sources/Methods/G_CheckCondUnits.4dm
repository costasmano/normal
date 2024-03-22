//%attributes = {"invisible":true}
If (False:C215)
	//G_CheckCondUnits
	Mods_2005_CM06
	// Modified by: costasmanousakis-(Designer)-(10/12/2005 13:00:21)
	Mods_2005_CM17
End if 
C_TEXT:C284($0; $msgs)
$msgs:=""
//Check Cond units
C_LONGINT:C283($vNumCondU_i; $i)  //Command Replaced was o_C_INTEGER
$vNumCondU_i:=Records in selection:C76([Cond Units:45])
If ($vNumCondU_i>0)
	If (False:C215)
		ARRAY INTEGER:C220($aCUID; 0)
		ARRAY INTEGER:C220($aCUEnv; 0)
		ARRAY REAL:C219($aCUtotQ; 0)
		C_TEXT:C284($CUErrors)
		SELECTION TO ARRAY:C260([Cond Units:45]Element ID:3; $aCUID; [Cond Units:45]Environment:4; $aCUEnv; [Cond Units:45]Total Quantity:5; $aCUtotQ)
		For ($i; 1; $vNumCondU_i)
			$CUErrors:=""
			If ($aCUID{$i}=0)
				$CUErrors:="No ID for a Pontis Element!!"
			Else 
				QUERY:C277([BMS Elements:47]; [BMS Elements:47]Element ID:1=$aCUID{$i})
				If ($aCUEnv{$i}=0)
					$CUErrors:=$CUErrors+"- No Enviroment -"
				End if 
				If ($aCUtotQ{$i}=0)
					$CUErrors:=$CUErrors+"- Zero Quantity -"
				End if 
			End if 
			If ($CUErrors#"")
				$CUErrors:=Replace string:C233($CUErrors; "--"; "-")
				If ($aCUID{$i}#0)
					If ($aCUEnv{$i}>0)
						$CUErrors:="Pontis Element "+String:C10([BMS Elements:47]Element No:2)+" Env:"+String:C10($aCUEnv{$i})+" has following errors : "+$CUErrors
					Else 
						$CUErrors:="Pontis Element "+String:C10([BMS Elements:47]Element No:2)+" has following errors : "+$CUErrors
					End if 
				End if 
				$msgs:=$msgs+$CUErrors+<>sCR
			End if 
			
		End for 
		
	Else 
		C_TEXT:C284($CUErrors)
		C_LONGINT:C283(ElementNo_L)  //is updated by method Check_CUdata
		FIRST RECORD:C50([Cond Units:45])
		For ($i; 1; $vNumCondU_i)
			$CUErrors:=Check_CUdata
			If ($CUErrors#"")
				$CUErrors:="Pontis Elmt:"+String:C10(ElementNo_L)+" Env:"+String:C10([Cond Units:45]Environment:4)+" Errors: "+$CUErrors
				If ((Length:C16($msgs)+Length:C16($CUErrors))>31500)
					$msgs:=$msgs+" More Errors found...."+<>sCR
				Else 
					$msgs:=$msgs+$CUErrors+<>sCR
				End if 
			End if 
			NEXT RECORD:C51([Cond Units:45])
		End for 
	End if 
	
End if 
$0:=$msgs
$CUErrors:=""
$msgs:=""