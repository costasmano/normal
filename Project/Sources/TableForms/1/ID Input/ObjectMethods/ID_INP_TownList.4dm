If (False:C215)
	//Script aTownName_ on layout [Bridge MHD NBIS];"BDEPT Input".
	//Copyright © 1997, Albert Leung, All Rights Reserved.
	
	//Scrollable area for Town Name.
	Mods_2005_CM01
	
End if 

C_LONGINT:C283($k)  //Command Replaced was o_C_INTEGER

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		$k:=Find in array:C230(aTownName_; [Bridge MHD NBIS:1]Town Name:175)
		If ($k>0)
			aTownName_:=$k
		Else 
			aTownName_:=1
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		[Bridge MHD NBIS:1]Town Name:175:=aTownName_{aTownName_}
		[Bridge MHD NBIS:1]BDEPT:1:=Get_BDEPT([Bridge MHD NBIS:1]Town Name:175)
		[Bridge MHD NBIS:1]Item8:206:=Change string:C234([Bridge MHD NBIS:1]Item8:206; [Bridge MHD NBIS:1]BDEPT:1; 1)
		PushChange(1; ->[Bridge MHD NBIS:1]Item8:206)
		[Bridge MHD NBIS:1]Item2:60:=Get_District([Bridge MHD NBIS:1]BDEPT:1)
		[Bridge MHD NBIS:1]Item3:61:=Get_County([Bridge MHD NBIS:1]BDEPT:1)
		[Bridge MHD NBIS:1]Item4:62:=Get_Place([Bridge MHD NBIS:1]BDEPT:1)
		[Bridge MHD NBIS:1]RPC_Codes:183:=Get_RPCCode([Bridge MHD NBIS:1]BDEPT:1)
		[Bridge MHD NBIS:1]Bridge Key:2:=Change string:C234([Bridge MHD NBIS:1]Bridge Key:2; Get_Town_Code([Bridge MHD NBIS:1]BDEPT:1); 4)
		PushChange(1; ->[Bridge MHD NBIS:1]BDEPT:1)
		PushChange(1; ->[Bridge MHD NBIS:1]Town Name:175)
		PushChange(1; ->[Bridge MHD NBIS:1]Item2:60)
		PushChange(1; ->[Bridge MHD NBIS:1]Item3:61)
		PushChange(1; ->[Bridge MHD NBIS:1]Item4:62)
		PushChange(1; ->[Bridge MHD NBIS:1]RPC_Codes:183)
		PushChange(1; ->[Bridge MHD NBIS:1]Bridge Key:2)
		vTown:=[Bridge MHD NBIS:1]Town Name:175+" (D-"+String:C10(Num:C11([Bridge MHD NBIS:1]Item2:60))+")"
End case 