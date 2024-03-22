
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 01/12/17, 14:38:17
//----------------------------------------------------
//Method: Form Method: ImportServerProcess
//Description
// has a 30 second timer to quit
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2017_01  // Add code to auto save and load  [ServerProcesses] records
	//Modified by: administrator (1/12/17 14:38:21)
	
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		C_TEXT:C284($Name_txt)
		Case of 
			: (Structure file:C489="MHD BMS.4DC")
				$Name_txt:="Boston "
			: (Structure file:C489="MHD BMS External Server.4DC")
				$Name_txt:="External "
			Else 
				
		End case 
		
		BRING TO FRONT:C326(Current process:C322)
		
		SET TIMER:C645(30*60)  //set timer for 30 seconds
		
	: (Form event code:C388=On Timer:K2:25)
		// OK nothing happened cancel form
		CANCEL:C270
		
End case 


//End Form Method: ImportServerProcess