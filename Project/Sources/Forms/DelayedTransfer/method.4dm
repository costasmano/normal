//Method: Form Method: DelayedTransfer
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/29/16, 16:53:46
	// ----------------------------------------------------
	//Created : 
	Mods_2016_03_bug
	// Modified by: Costas Manousakis-(Designer)-(5/26/20 19:08:11)
	Mods_2020_05
	//  `Added Interval in minutes to allow transfers at an interval (default = 120 min)
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_DATE:C307(vDate)
		vDate:=Current date:C33
		
		C_TIME:C306(v_1_195_tm)  //use TimeModified from bridge table
		C_LONGINT:C283(v_1_006_L)  //use rank from bridge table
		
		v_1_006_L:=120  // default to 120 min
		
		v_1_195_tm:=Current time:C178+(10*60)  //add 10 minutes by default
		v_1_195_tm:=v_1_195_tm/60  //and get rid of seconds
		v_1_195_tm:=v_1_195_tm*60
End case 

//End Form Method: DelayedTransfer