//Method: Form Method: CountDownTimer
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/29/16, 16:45:30
	// ----------------------------------------------------
	//Created : 
	Mods_2016_03_bug
	// Modified by: Costas Manousakis-(Designer)-(5/26/20 19:07:30)
	Mods_2020_05
	//  `added button with option to Run Now
End if 

C_TIME:C306(vTimec; vTimeM)  //use same as other dlogs
C_LONGINT:C283($DayDiff_L; $SecondsDiff_L; $Timer_L)
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		$DayDiff_L:=vDate-Current date:C33
		vTimec:=($DayDiff_L*24*60*60)+vTimeM-Current time:C178
		$SecondsDiff_L:=vTimec+0
		$Timer_L:=$SecondsDiff_L\20
		
		Case of 
			: ($Timer_L>30)
				$Timer_L:=30
			: ($Timer_L>10)
				$Timer_L:=30
			Else 
				$Timer_L:=2
		End case 
		
		SET TIMER:C645(60*$Timer_L)  //30 seconds max
	: (Form event code:C388=On Outside Call:K2:11)
		CANCEL:C270
	: (Form event code:C388=On Timer:K2:25)
		$DayDiff_L:=vDate-Current date:C33
		vTimec:=($DayDiff_L*24*60*60)+vTimeM-Current time:C178
		POST OUTSIDE CALL:C329(-1)  //update all variables
		
		If (vTimec>0)
			//re check the timer settings
			$SecondsDiff_L:=vTimec+0
			$Timer_L:=$SecondsDiff_L\20
			
			Case of 
				: ($Timer_L>30)
					$Timer_L:=30
				: ($Timer_L>10)
					$Timer_L:=10
				Else 
					$Timer_L:=2
			End case 
			
			SET TIMER:C645(60*$Timer_L)  //30 seconds max ; 2 sec min
			
		Else 
			ACCEPT:C269  //reached end succesfully
		End if 
End case 

//End Form Method: CountDownTimer