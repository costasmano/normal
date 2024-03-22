If (False:C215)
	//Script aTownName_ on layout [Bridge MHD NBIS];"BDEPT Input".
	//Copyright © 1997, Albert Leung, All Rights Reserved.
	
	//Scrollable area for Town Name.
	
	// Modified by: Costas Manousakis-(Designer)-(9/23/19 14:45:10)
	Mods_2019_09_bug
	//  `enabled on mouse enter event; skip assigning the inspection responsibility;
	//make changes to BDEPT only if it is blank or has only the townpart
End if 

C_LONGINT:C283($k)  // **replaced _ o _C_INTEGER()

If (Form event code:C388=On Load:K2:1)
	$k:=Find in array:C230(aTownName_; [Bridge MHD NBIS:1]Town Name:175)
	If ($k>0)
		aTownName_:=$k
	Else 
		aTownName_:=1
	End if 
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (Length:C16([Bridge MHD NBIS:1]BDEPT:1)<4)  //do this only if BDEPT is blank or has only the townpart
			[Bridge MHD NBIS:1]Town Name:175:=aTownName_{aTownName_}
			[Bridge MHD NBIS:1]BDEPT:1:=Substring:C12(Get_BDEPT([Bridge MHD NBIS:1]Town Name:175); 1; 3)  // get only the town part
			[Bridge MHD NBIS:1]Item2:60:=Get_District([Bridge MHD NBIS:1]BDEPT:1)
			[Bridge MHD NBIS:1]Item3:61:=Get_County([Bridge MHD NBIS:1]BDEPT:1)
			[Bridge MHD NBIS:1]Item4:62:=Get_Place([Bridge MHD NBIS:1]BDEPT:1)
			[Bridge MHD NBIS:1]RPC_Codes:183:=Get_RPCCode([Bridge MHD NBIS:1]BDEPT:1)
			[Bridge MHD NBIS:1]Bridge Key:2:=Change string:C234([Bridge MHD NBIS:1]Bridge Key:2; Get_Town_Code([Bridge MHD NBIS:1]BDEPT:1); 4)
			//[Bridge MHD NBIS]InspResp:=aInspRcod_{Num([Bridge MHD NBIS]Item2)}
			//aInspRdes_:=Find in array(aInspRcod_;[Bridge MHD NBIS]InspResp)
			PushChange(1; ->[Bridge MHD NBIS:1]BDEPT:1)
			PushChange(1; ->[Bridge MHD NBIS:1]Town Name:175)
			PushChange(1; ->[Bridge MHD NBIS:1]Item2:60)
			PushChange(1; ->[Bridge MHD NBIS:1]Item3:61)
			PushChange(1; ->[Bridge MHD NBIS:1]Item4:62)
			PushChange(1; ->[Bridge MHD NBIS:1]RPC_Codes:183)
			PushChange(1; ->[Bridge MHD NBIS:1]Bridge Key:2)
			//PushChange (1;->[Bridge MHD NBIS]InspResp)
			
			//Change added on 2/1/2001
			
			[Bridge MHD NBIS:1]Item8:206:=Change string:C234([Bridge MHD NBIS:1]Item8:206; [Bridge MHD NBIS:1]BDEPT:1; 1)
			
			[Bridge MHD NBIS:1]Item8:206:=Change string:C234([Bridge MHD NBIS:1]Item8:206; [Bridge MHD NBIS:1]BIN:3; 7)
			PushChange(1; ->[Bridge MHD NBIS:1]Item8:206)
			
			// End of change made on 2/1/2001
			vTown:=[Bridge MHD NBIS:1]Town Name:175+" (D-"+String:C10(Num:C11([Bridge MHD NBIS:1]Item2:60))+")"
			
		End if 
		
	: (Form event code:C388=On Mouse Enter:K2:33)
		TextToSpeach("Go Away! DO NOT TOUCH!")
		
End case 