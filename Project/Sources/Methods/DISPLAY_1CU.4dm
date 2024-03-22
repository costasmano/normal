//%attributes = {"invisible":true}
//GP DISPLAY_1CU.
//Copyright © 1996-97, Thomas D. Nee, All Rights Reserved.

//Called by layout procedure to show one Condition Unit with
//up to five Condition States.

C_LONGINT:C283($i; $NoCSs)  //Command Replaced was o_C_INTEGER//Counter
C_TEXT:C284(vUnits)  // Command Replaced was o_C_STRING length was 30
C_REAL:C285(vTotQ)
C_BOOLEAN:C305($Error)
//C_TEXT($Text)

$Error:=False:C215

vElemName:=LongName

If ([BMS Inspections:44]Metric:14)
	vUnits:=[BMS Elements:47]Units:6
	vTotQ:=Round:C94([Cond Units:45]Total Quantity:5; 1)
Else 
	vUnits:=AnglicizeUnit([BMS Elements:47]Units:6)
	vTotQ:=Round:C94(AnglicizeQ([Cond Units:45]Total Quantity:5; [BMS Elements:47]Units:6); 1)
End if 

$NoCSs:=5
If ([BMS Categories:49]Num of CSs:7>0)
	$NoCSs:=[BMS Categories:49]Num of CSs:7
End if 
//*** Obsolete.
//RELATE MANY([Cond Units]Cond Unit ID)
//SEARCH SELECTION([Cond State Insp];[Cond State Insp]New=False)
//SORT SELECTION([Cond State Insp];[Cond State Insp]Cond State No)
//If ($NoCSs#Records in selection([Cond State Insp]))
//  $Error:=True
//ALERT("Error:  The number of records does not match 
//the number of Condition States.")
//End if 

//TRACE

For ($i; 1; 5)
	//Negative value is displayed as blank.  
	a_ptr_NewCS{$i}->:=-1  //Pointer to vNewCSi
	
	If ($i<=$NoCSs)
		//*** Obsolete.
		//    If ($i#[Cond State Insp]Cond State No)
		//      $Error:=True
		//    End if 
		
		//a_ptr_CS{$i} is a pointer to vNewCSi
		//a_ptr_CSfld{$i} is a pointer to [Cond Units]CondStatei
		Case of 
			: (([Cond Units:45]Percent:6) & ([Cond Units:45]Total Quantity:5>0))
				//Convert to Percent of Total.
				a_ptr_CS{$i}->:=Round:C94(100*(a_ptr_CSfld{$i}->/[Cond Units:45]Total Quantity:5); 1)
				OBJECT SET FORMAT:C236(a_ptr_CS{$i}->; "##0.0 %;")
			: ([BMS Inspections:44]Metric:14)
				//Display metric quantity.
				a_ptr_CS{$i}->:=Round:C94(a_ptr_CSfld{$i}->; 1)
				OBJECT SET FORMAT:C236(a_ptr_CS{$i}->; "#,###,##0.0;")
			Else 
				//Display English quantity.
				a_ptr_CS{$i}->:=Round:C94(AnglicizeQ(a_ptr_CSfld{$i}->; [BMS Elements:47]Units:6); 1)
				OBJECT SET FORMAT:C236(a_ptr_CS{$i}->; "#,###,##0.0;")
		End case 
		//*** Obsolete.
		//    NEXT RECORD([Cond State Insp])
		//Default Colors.
		//Black on White -(15+(256*0))=-15.
		//SET COLOR(a_ptr_CS{$i}»;-15)
		OBJECT SET RGB COLORS:C628(a_ptr_NewCS{$i}->; Col_paletteToRGB(Abs:C99(-15)%256); Col_paletteToRGB(Abs:C99(-15)\256))  // **Replaced o OBJECT SET COLOR(a_ptr_NewCS{$i}->;-15)
	Else 
		//A value of -1 indicates non-displayable.
		a_ptr_CS{$i}->:=-1
		//Gray out unused Condition States.
		//Black on Light Gray -(15+(256*12)).
		// SET COLOR(a_ptr_CS{$i}»;-(15+(256*12)))
		
		OBJECT SET RGB COLORS:C628(a_ptr_NewCS{$i}->; Col_paletteToRGB(Abs:C99(-(15+(256*12)))%256); Col_paletteToRGB(Abs:C99(-(15+(256*12)))\256))  // **Replaced o OBJECT SET COLOR(a_ptr_NewCS{$i}->;-(15+(256*12)))
	End if 
	
End for 

//*** Obsolete.
//If ($Error)
//  $Text:="Error:  Condition State numbering is corrupted."+◊sCR+◊sCR
//  $Text:=$Text+"Please double-click on Element "+String([BMS Elements]Element No
//  $Text:=$Text+", Environment "+String([Cond Units]Environment)
//  $Text:=$Text+" to reset the condition states."+◊sCR+◊sCR
//  $Text:=$Text+"Afterwards, please verify the data."
//  ALERT($Text)
//End if 