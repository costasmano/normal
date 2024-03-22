//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/30/08, 22:13:13
	// ----------------------------------------------------
	// Method: QR_RPCNames
	// Description
	// Return the RPC names for the current Bridge record.
	// 
	// Parameters
	// $0 : $RPCs_txt
	// $1 : $BIN_txt (Optional)
	// $2 : $BDEPT_s (Required if $1 is passed)
	// ----------------------------------------------------
	
	Mods_2008_CM_5404  //Copied to Server on : 10/31/08, 10:12:13
	// Modified by: costasmanousakis-(Designer)-(10/18/11 16:13:42)
	Mods_2011_10
	//  `Added optional parameters
End if 
C_TEXT:C284($0; $RPCs_txt)
C_TEXT:C284($BDept_s)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284($BIN_txt)
If (Count parameters:C259>0)
	C_TEXT:C284($1; $2)
	$BIN_txt:=$1
	$BDept_s:=$2  //must have a current [bridge mhd nbis] record
Else 
	$BDept_s:=[Bridge MHD NBIS:1]BDEPT:1  //must have a current [bridge mhd nbis] record
	$BIN_txt:=[Bridge MHD NBIS:1]BIN:3
End if 

C_TEXT:C284($BDept_3_s)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($RPC_s)  // Command Replaced was o_C_STRING length was 2
$BDept_3_s:=Substring:C12($BDept_s; 1; 3)
$RPCs_txt:=""
If ($BDept_3_s#"")
	ARRAY TEXT:C222($RPCList_atxt; 0)
	C_LONGINT:C283($I; $K; $J)
	$K:=Find in array:C230(<>aBDEPT; $BDept_3_s)
	If ($K>0)
		$RPC_s:=<>aRPC_1{$K}
		$J:=Find in array:C230(<>aRPCCode; $RPC_s)
		If ($J>0)
			If (Find in array:C230($RPCList_atxt; <>aRPCName{$J})>0)
			Else 
				INSERT IN ARRAY:C227($RPCList_atxt; (Size of array:C274($RPCList_atxt)+1); 1)
				$RPCList_atxt{Size of array:C274($RPCList_atxt)}:=<>aRPCName{$J}
			End if 
		End if 
		
		$RPC_s:=<>aRPC_2{$K}
		$J:=Find in array:C230(<>aRPCCode; $RPC_s)
		If ($J>0)
			If (Find in array:C230($RPCList_atxt; <>aRPCName{$J})>0)
			Else 
				INSERT IN ARRAY:C227($RPCList_atxt; (Size of array:C274($RPCList_atxt)+1); 1)
				$RPCList_atxt{Size of array:C274($RPCList_atxt)}:=<>aRPCName{$J}
			End if 
		End if 
		QUERY:C277([TownLineInfo:73]; [TownLineInfo:73]BIN:1=$BIN_txt)
		ARRAY TEXT:C222($TLINEBDEPTS_as; 0)  //Command Replaced was o_ARRAY string length was 6
		SELECTION TO ARRAY:C260([TownLineInfo:73]BDEPT:2; $TLINEBDEPTS_as)
		For ($i; 1; Size of array:C274($TLINEBDEPTS_as))
			$BDept_3_s:=Substring:C12($TLINEBDEPTS_as{$i}; 1; 3)
			$K:=Find in array:C230(<>aBDEPT; $BDept_3_s)
			If ($K>0)
				$RPC_s:=<>aRPC_1{$K}
				$J:=Find in array:C230(<>aRPCCode; $RPC_s)
				If ($J>0)
					If (Find in array:C230($RPCList_atxt; <>aRPCName{$J})>0)
					Else 
						INSERT IN ARRAY:C227($RPCList_atxt; (Size of array:C274($RPCList_atxt)+1); 1)
						$RPCList_atxt{Size of array:C274($RPCList_atxt)}:=<>aRPCName{$J}
					End if 
				End if 
				
				$RPC_s:=<>aRPC_2{$K}
				$J:=Find in array:C230(<>aRPCCode; $RPC_s)
				If ($J>0)
					If (Find in array:C230($RPCList_atxt; <>aRPCName{$J})>0)
					Else 
						INSERT IN ARRAY:C227($RPCList_atxt; (Size of array:C274($RPCList_atxt)+1); 1)
						$RPCList_atxt{Size of array:C274($RPCList_atxt)}:=<>aRPCName{$J}
					End if 
				End if 
			End if 
			
		End for 
		
		If (Size of array:C274($RPCList_atxt)>0)
			SORT ARRAY:C229($RPCList_atxt)
			$RPCs_txt:=$RPCList_atxt{1}
			For ($I; 2; Size of array:C274($RPCList_atxt))
				$RPCs_txt:=$RPCs_txt+","+$RPCList_atxt{$i}
			End for 
		End if 
	End if 
	
End if 

$0:=$RPCs_txt