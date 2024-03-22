//SC [Bridge MHD NBIS]BDEPT on layout [Bridge MHD NBIS];"BDEPT Input".
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.
If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/17/15 13:44:23)
	// Modified by: Costas Manousakis-(Designer)-(9/23/19 14:50:35)
	Mods_2019_09_bug
	//  `check for valid Town code; or if not enough characters entered; don't assign inspection responsibility
	//  `disable automatic drag and drop on object
End if 
If (Form event code:C388=On Data Change:K2:15)
	C_TEXT:C284($bin)  // **Replaced old C_STRING length 3
	C_TEXT:C284($bdept)  // **Replaced old C_STRING length 6
	C_LONGINT:C283($recs; $recs2)
	C_TEXT:C284($text)  // **Replaced old C_STRING length 255
	
	$bin:=[Bridge MHD NBIS:1]BIN:3
	[Bridge MHD NBIS:1]BDEPT:1:=Replace string:C233([Bridge MHD NBIS:1]BDEPT:1; "_"; "")
	$bdept:=[Bridge MHD NBIS:1]BDEPT:1
	
	Case of 
		: ($bdept="")
			//do nothing if it has been cleared
		: (Find in array:C230(<>aBDEPT; Substring:C12($bdept; 1; 3))<=0)
			ALERT:C41("Town code :"+Substring:C12($bdept; 1; 3)+" is not valid!")
			[Bridge MHD NBIS:1]BDEPT:1:=""
			REJECT:C38
			GOTO OBJECT:C206([Bridge MHD NBIS:1]BDEPT:1)
			
		: (Length:C16($bdept)<6)
			ALERT:C41("Not enough numbers entered for BDEPT : "+$bdept+" !")
			REJECT:C38
			GOTO OBJECT:C206([Bridge MHD NBIS:1]BDEPT:1)
			
		Else 
			
			SET QUERY DESTINATION:C396(Into variable:K19:4; $recs)
			//PUSH RECORD([Bridge MHD NBIS])
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1=$bdept; *)
			QUERY:C277([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]BIN:3#$bin)
			SET QUERY DESTINATION:C396(Into variable:K19:4; $recs2)
			QUERY:C277([TownLineInfo:73]; [TownLineInfo:73]BDEPT:2=$bdept; *)
			QUERY:C277([TownLineInfo:73];  & ; [TownLineInfo:73]BIN:1#$bin)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			$recs:=$recs+$recs2
			If ($recs>=1)
				$text:="Warning:"+<>sCR+<>sCR+"There already "
				Case of 
					: ($recs=1)
						$text:=$text+"is one record "
					: ($recs>1)
						$text:=$text+"are "+String:C10($recs)+" records "
				End case 
				$text:=$text+"with BDEPT='"+Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 1; 1)+"-"+Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 2; 2)
				$text:=$text+"-"+Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 4; 3)+"'."+<>sCR+<>sCR+"Please verify."
				ALERT:C41($text)
				GOTO OBJECT:C206([Bridge MHD NBIS:1]BDEPT:1)
			End if 
			
			PushChange(1; Self:C308)
			
			//Change added on 1/31/2001
			
			[Bridge MHD NBIS:1]Item8:206:=Change string:C234([Bridge MHD NBIS:1]Item8:206; [Bridge MHD NBIS:1]BDEPT:1; 1)
			
			[Bridge MHD NBIS:1]Item8:206:=Change string:C234([Bridge MHD NBIS:1]Item8:206; [Bridge MHD NBIS:1]BIN:3; 7)
			PushChange(1; ->[Bridge MHD NBIS:1]Item8:206)
			
			// End of change made on 1/31/2001
			
			[Bridge MHD NBIS:1]Town Name:175:=Get_Town_Name([Bridge MHD NBIS:1]BDEPT:1)
			[Bridge MHD NBIS:1]Item2:60:=Get_District([Bridge MHD NBIS:1]BDEPT:1)
			[Bridge MHD NBIS:1]Item3:61:=Get_County([Bridge MHD NBIS:1]BDEPT:1)
			[Bridge MHD NBIS:1]Item4:62:=Get_Place([Bridge MHD NBIS:1]BDEPT:1)
			[Bridge MHD NBIS:1]RPC_Codes:183:=Get_RPCCode([Bridge MHD NBIS:1]BDEPT:1)
			[Bridge MHD NBIS:1]Bridge Key:2:=Change string:C234([Bridge MHD NBIS:1]Bridge Key:2; Get_Town_Code([Bridge MHD NBIS:1]BDEPT:1); 4)
			//[Bridge MHD NBIS]InspResp:=aInspRcod_{Num([Bridge MHD NBIS]Item2)}
			//aInspRdes_:=Find in array(aInspRcod_;[Bridge MHD NBIS]InspResp)
			PushChange(1; ->[Bridge MHD NBIS:1]Town Name:175)
			PushChange(1; ->[Bridge MHD NBIS:1]Item2:60)
			PushChange(1; ->[Bridge MHD NBIS:1]Item3:61)
			PushChange(1; ->[Bridge MHD NBIS:1]Item4:62)
			PushChange(1; ->[Bridge MHD NBIS:1]RPC_Codes:183)
			PushChange(1; ->[Bridge MHD NBIS:1]Bridge Key:2)
			PushChange(1; ->[Bridge MHD NBIS:1]InspResp:173)
			
			vTown:=[Bridge MHD NBIS:1]Town Name:175+" (D-"+String:C10(Num:C11([Bridge MHD NBIS:1]Item2:60))+")"
	End case 
	
End if 