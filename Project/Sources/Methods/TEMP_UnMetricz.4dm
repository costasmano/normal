//%attributes = {"invisible":true}
If (False:C215)
	//GP BMS MetricConv
	
	//This procedure was used once and should not be used again.
	//For March 1997, District 1 sent in the Claris spreadsheets already
	//converted to metric.  They had metric conversion factors applied which 
	//now must be undone.
	
	C_TEXT:C284($Units)  // Command Replaced was o_C_STRING length was 30
	C_REAL:C285($ConvFact)
	C_LONGINT:C283($i; $j)  //Command Replaced was o_C_INTEGER
	TRACE:C157
	
	//ALL RECORDS([Cond Units])
	QUERY:C277([Cond Units:45]; [Cond Units:45]Inspection ID:2>=2462; *)
	QUERY:C277([Cond Units:45]; [Cond Units:45]Inspection ID:2<=2484; *)
	QUERY:C277([Cond Units:45]; [Cond Units:45]Inspection ID:2#2469; *)
	QUERY:C277([Cond Units:45]; [Cond Units:45]Inspection ID:2#2474; *)
	QUERY:C277([Cond Units:45]; [Cond Units:45]Inspection ID:2#2475)
	
	For ($i; 1; Records in selection:C76([Cond Units:45]))
		START TRANSACTION:C239
		
		RELATE ONE:C42([Cond Units:45]Element ID:3)
		$Units:=[BMS Elements:47]Units:6
		Case of 
			: (Substring:C12($Units; 1; 2)="LM")
				$ConvFact:=0.3048
			: ($Units="EA/SM")
				$ConvFact:=0.3048*0.3048
			Else 
				$ConvFact:=1
		End case 
		
		//***Obsolete.  
		//  RELATE MANY([Cond Units]Cond Unit ID)
		//  For ($j;1;Records in selection([Cond State Insp]))
		//    [Cond State Insp]Amount:=[Cond State Insp]Amount/$ConvFact
		//    [Cond State Insp]future use:=True
		//    SAVE RECORD([Cond State Insp])
		//    NEXT RECORD([Cond State Insp])
		//  End for 
		
		For ($j; 1; 5)
			If (a_ptr_CSfld{$j}->>0)
				a_ptr_CSfld{$j}->:=a_ptr_CSfld{$j}->/$ConvFact
			End if 
		End for 
		
		[Cond Units:45]Total Quantity:5:=[Cond Units:45]Total Quantity:5/$ConvFact
		[Cond Units:45]Metric:9:=True:C214
		[Cond Units:45]Comment:7:="∆"+[Cond Units:45]Comment:7  //Mark this CU as done.
		SAVE RECORD:C53([Cond Units:45])
		NEXT RECORD:C51([Cond Units:45])
		
		VALIDATE TRANSACTION:C240
	End for 
End if 
