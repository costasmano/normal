//%attributes = {"invisible":true}
If (False:C215)
	//procedure: CalcItem91
	//Copyright © 1997, Albert Leung, All Rights Reserved.
	//created: 6/12/97
	//purpose: recalculate Item 91 when there is a change.
	
	// Modified 
	//     15-dec-1999 per memo from CSC dated 22-jun-1999
	// Modified by: costasmanousakis-(Designer)-(6/10/11 09:32:40)
	Mods_2011_06
	//  `execute a PushChange (1;->[Bridge MHD NBIS]Item91) in this method
	// Modified by: costasmanousakis-(Designer)-(11/30/11 16:27:51)
	Mods_2011_11
	//  `Added RRO to the bridges that this method does nothing
	// Modified by: Costas Manousakis-(Designer)-(12/7/12 15:15:17)
	Mods_2012_12
	//  `Do nothing for ALL non-NBI records
	// Modified by: Costas Manousakis-(Designer)-(4/11/18 13:43:39)
	Mods_2018_04
	//  `include BRIs 
End if 

C_LONGINT:C283($temp)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER

Case of 
	: (Not:C34([Bridge MHD NBIS:1]FHWARecord:174) & Not:C34([Bridge MHD NBIS:1]Item8 BridgeCat:207="BRI"))
		//do nothing
	Else 
		
		$temp:=24
		If (([Bridge MHD NBIS:1]Item92AA:163=True:C214) & ([Bridge MHD NBIS:1]Item92AB:164<$temp) & ([Bridge MHD NBIS:1]Item92AB:164#0))
			$temp:=[Bridge MHD NBIS:1]Item92AB:164
		End if 
		If (([Bridge MHD NBIS:1]Item92BA:165=True:C214) & ([Bridge MHD NBIS:1]Item92BB:166<$temp) & ([Bridge MHD NBIS:1]Item92BB:166#0))
			$temp:=[Bridge MHD NBIS:1]Item92BB:166
		End if 
		If (([Bridge MHD NBIS:1]Item92CA:167=True:C214) & ([Bridge MHD NBIS:1]Item92CB:168<$temp) & ([Bridge MHD NBIS:1]Item92CB:168#0))
			$temp:=[Bridge MHD NBIS:1]Item92CB:168
		End if 
		
		// *** Change #??  memo 6-22-1999  
		//If (([Bridge MHD NBIS]OtherInsp=True) & 
		//  ([Bridge MHD NBIS]OtherIFreq<$temp) & 
		//  ([Bridge MHD NBIS]OtherIFreq#0))
		//  $temp:=[Bridge MHD NBIS]OtherIFreq
		//End if 
		If (([Bridge MHD NBIS:1]ClosedInsp:45=True:C214) & ([Bridge MHD NBIS:1]ClosedIFreq:46<$temp) & ([Bridge MHD NBIS:1]ClosedIFreq:46#0))
			$temp:=[Bridge MHD NBIS:1]ClosedIFreq:46
		End if 
		[Bridge MHD NBIS:1]Item91:162:=$temp
		PushChange(1; ->[Bridge MHD NBIS:1]Item91:162)
End case 