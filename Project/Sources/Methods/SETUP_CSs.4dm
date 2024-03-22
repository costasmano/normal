//%attributes = {"invisible":true}
If (False:C215)
	//GP SETUP_CSs
	//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
	//Setup the Condition State Inspection records.
	
	// Modified by: costasmanousakis-(Designer)-(3/2/2006 16:20:00)
	Mods_2006_CM03
	// Modified by: Chuck Miller-(Designer)-(8/24/17 14:54:52)
	Mods_2017_08_bug  //replace _ o _during
	
	
End if 
C_REAL:C285(vOldQm; vOldQ; vTotQ)
//C_REAL($Amt)  `Initial value for a Condition State.
C_BOOLEAN:C305(vNewCURecord_b)
SHORT_MESSAGE("One moment please ...")

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Display Detail:K2:22))
	//Need to save the old Quantity as a real in case the user switches P <-> Q
	//or metric <-> English.
	vOldQm:=[Cond Units:45]Total Quantity:5
	vOldComment:=[Cond Units:45]Comment:7
End if 

Case of 
	: (((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Display Detail:K2:22)) | (Form event code:C388=On Clicked:K2:4))
		//All relations must be set up procedurally.
		RELATE ONE:C42([Cond Units:45]Element ID:3)
		RELATE ONE:C42([BMS Elements:47])
		//Relate Many([BMS Categories]Category ID) can't be used because that might
		//change the current record for [BMS Elements]; use Search.
		QUERY:C277([Cond States:51]; [Cond States:51]Category ID:2=[BMS Categories:49]Category ID:1)
		QUERY:C277([Cat CS Notes:55]; [Cat CS Notes:55]Category ID:1=[BMS Categories:49]Category ID:1)
		//Find all the one records in [CS Notes].
		RELATE ONE SELECTION:C349([Cat CS Notes:55]; [CS Notes:53])
		
		OBJECT SET TITLE:C194(sbMetric; "Metric ("+[BMS Elements:47]Units:6+")")
		OBJECT SET TITLE:C194(sbEnglish; "English ("+AnglicizeUnit([BMS Elements:47]Units:6)+")")
		If ([BMS Elements:47]Units:6="EA")
			//      [Cond Units]Metric:=True
			//      sbMetric:=1
			//      sbEnglish:=0
			OBJECT SET ENABLED:C1123(sbMetric; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(sbEnglish; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			//This element must be recorded in whole numbers.
			vTotQ:=Round:C94([Cond Units:45]Total Quantity:5; 0)
			If (vTotQ#[Cond Units:45]Total Quantity:5)
				[Cond Units:45]Total Quantity:5:=vTotQ
				PushChange(2; ->[Cond Units:45]Total Quantity:5)
			End if 
			OBJECT SET FORMAT:C236(vTotQ; "#,###,##0")
			OBJECT SET FILTER:C235(vTotQ; "&9")
		Else 
			OBJECT SET ENABLED:C1123(sbMetric; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(sbEnglish; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET FORMAT:C236(vTotQ; "#,###,##0.0")
			OBJECT SET FILTER:C235(vTotQ; "|PosReals")
		End if 
		BMS_QtyButtnTxt
		DISPLAY_Q
		
		vElemNo:=[BMS Elements:47]Element No:2  //"No" is an abbreviation for Number.
		vElemText:=LongDescr
		vCSText:=CS_Descr
		vNoCSs:=[BMS Categories:49]Num of CSs:7
		C_LONGINT:C283($i)
		For ($i; 1; vMaxCSs)
			If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Display Detail:K2:22))
				If ($i<=vNoCSs)
					//Take the value from the Cond State field.          
					aOldCS{$i}:=a_ptr_CSfld{$i}->  //Value from the Cond State field.
					aCS{$i}:=a_ptr_CSfld{$i}->
				Else 
					//A value of -1 indicates non-enterable, non-displayable.        
					aOldCS{$i}:=-1
					aCS{$i}:=-1
				End if 
				
			Else 
				
				If ($i<=vNoCSs)
					If ($i>vNoOldCSs)
						//The Element has been changed to one with more CS's than the previous element.
						//Set this additional Condition State to zero.          
						aCS{$i}:=0
					End if 
				Else 
					//A value of -1 indicates non-enterable, non-displayable.        
					aCS{$i}:=-1
				End if 
				
			End if 
			
		End for 
		
		//Store the number of Condition States to check if the user changes to an 
		//element with a different number of Condition States. 
		vNoOldCSs:=vNoCSs
		
		If ([BMS Categories:49]Smart Flag:5)
			If ([Cond Units:45]Total Quantity:5#1)
				If (Not:C34(vNewCURecord_b))  //mods_2006_cm03a
					ALERT:C41("The Total Quantity has been set to 1.  This is mandatory for Smart Flags.")
				End if 
				[Cond Units:45]Total Quantity:5:=1
				PushChange(2; ->[Cond Units:45]Total Quantity:5)
			End if 
			vTotQ:=1
			OBJECT SET ENTERABLE:C238(vTotQ; False:C215)
			OBJECT SET RGB COLORS:C628(vTotQ; Col_paletteToRGB(Abs:C99(vDispColor)%256); Col_paletteToRGB(Abs:C99(vDispColor)\256))  // **Replaced o OBJECT SET COLOR(vTotQ; vDispColor)
			If ([Cond Units:45]Environment:4#2)
				[Cond Units:45]Environment:4:=2
				PushChange(2; ->[Cond Units:45]Environment:4)
			End if 
			OBJECT SET ENTERABLE:C238([Cond Units:45]Environment:4; False:C215)
			OBJECT SET ENABLED:C1123(*; "DE EnvNo"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET RGB COLORS:C628([Cond Units:45]Environment:4; Col_paletteToRGB(Abs:C99(vDispColor)%256); Col_paletteToRGB(Abs:C99(vDispColor)\256))  // **Replaced o OBJECT SET COLOR([Cond Units]Environment; vDispColor)
		Else 
			OBJECT SET ENTERABLE:C238(vTotQ; True:C214)
			OBJECT SET RGB COLORS:C628(vTotQ; Col_paletteToRGB(Abs:C99(vEntryColor)%256); Col_paletteToRGB(Abs:C99(vEntryColor)\256))  // **Replaced o OBJECT SET COLOR(vTotQ; vEntryColor)
			OBJECT SET ENTERABLE:C238([Cond Units:45]Environment:4; True:C214)
			OBJECT SET ENABLED:C1123(*; "DE EnvNo"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET RGB COLORS:C628([Cond Units:45]Environment:4; Col_paletteToRGB(Abs:C99(vEntryColor)%256); Col_paletteToRGB(Abs:C99(vEntryColor)\256))  // **Replaced o OBJECT SET COLOR([Cond Units]Environment; vEntryColor)
		End if 
		
		If (([BMS Categories:49]Smart Flag:5) | ([BMS Categories:49]Record as Each:6))
			//The Total Quantity must be in one and only one Condition State. 
			AllInOneCS
		Else 
			If ([Cond Units:45]Total Quantity:5>0)
				//Make sure the CS amounts add up to the total quantity.  Assume the worst
				//(in case the element has changed and a CS was dropped, move that quantity
				//to the next higher CS).
				aCS{vNoCSs}:=[Cond Units:45]Total Quantity:5
				For ($i; 1; vNoCSs-1)
					If ([BMS Elements:47]Units:6="EA")
						aCS{$i}:=Round:C94(aCS{$i}; 0)
					End if 
					aCS{vNoCSs}:=MaxNum(0; aCS{vNoCSs}-aCS{$i})
				End for 
			End if 
		End if 
		
		DISPLAY_CS
		
End case 

CLOSE WINDOW:C154