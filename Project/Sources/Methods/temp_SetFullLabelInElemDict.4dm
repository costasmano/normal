//%attributes = {"invisible":true}
If (False:C215)
	Mods_2011_06  // CJ Miller`06/14/11, 10:33:13      ` Type all local variables for v11
End if 
If (False:C215)
	//4/16/2004
	C_LONGINT:C283($recCount)  //Command Replaced was o_C_INTEGER
	C_TEXT:C284($parentPrefix; $vsElmt)  // Command Replaced was o_C_STRING length was 10
	
	ALL RECORDS:C47([ElementDict:30])
	ORDER BY:C49([ElementDict:30]; [ElementDict:30]Category:3; >; [ElementDict:30]ElementNo:1; >)
	$recCount:=Records in table:C83([ElementDict:30])
	C_LONGINT:C283($i)
	For ($i; 1; $recCount)
		
		If ([ElementDict:30]Parent:4#0)
			Case of 
				: ([ElementDict:30]Parent:4=204)
					$parentPrefix:=" 5."
				: ([ElementDict:30]Parent:4=300)
					$parentPrefix:=" 1."
				: ([ElementDict:30]Parent:4=313)
					$parentPrefix:=" 2."
				: ([ElementDict:30]Parent:4=325)
					$parentPrefix:=" 3."
				: ([ElementDict:30]Parent:4=407)
					$parentPrefix:=" 8."
			End case 
			
			[ElementDict:30]FullLabel:13:=$parentPrefix+[ElementDict:30]Prefix:11
			[ElementDict:30]FullLabelArch:14:=$parentPrefix+[ElementDict:30]Prefix:11
			
		Else   //no parent    
			$vsElmt:=[ElementDict:30]Prefix:11
			If (Length:C16($vsElmt)=2)  //so that 10 is sorted correctly
				$vsElmt:=" "+$vsElmt
			End if 
			
			[ElementDict:30]FullLabel:13:=$vsElmt
			If ([ElementDict:30]Part:12#"")
				If (Length:C16([ElementDict:30]Part:12)=2)
					[ElementDict:30]FullLabelArch:14:=" "+[ElementDict:30]Part:12
				Else 
					[ElementDict:30]FullLabelArch:14:=[ElementDict:30]Part:12
				End if 
				
			Else 
				[ElementDict:30]FullLabelArch:14:=$vsElmt
			End if 
		End if 
		SAVE RECORD:C53([ElementDict:30])
		NEXT RECORD:C51([ElementDict:30])
	End for 
	
	REDUCE SELECTION:C351([ElementDict:30]; 0)
	UNLOAD RECORD:C212([ElementDict:30])
End if 
