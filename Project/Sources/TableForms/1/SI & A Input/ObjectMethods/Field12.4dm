If (False:C215)
	//[Bridge MHD NBIS];"SI & A Input".Field12
	//[Bridge MHD NBIS]Item5
	
	
	//Modified 3/20/01 : moved Item 5 length check at the start of error checks
	
	
	// Modified by: costasmanousakis-(Designer)-(9/2/09 09:55:26)
	Mods_2009_08
	//  `Changed before and During events to Form events on load / data change
	// Modified by: Costas Manousakis-(Designer)-(9/11/18 13:53:52)
	Mods_2018_09_bug
	//  `added goto object when error; added additional checks for the route number Item 5D
End if 
C_TEXT:C284(saveItm5)  // old C_STRING length 9
C_TEXT:C284($cr)  // old C_STRING length 1
C_BOOLEAN:C305($ItmOk)
C_TEXT:C284($a)  // old C_STRING length 1
C_TEXT:C284($b)  // old C_STRING length 1
C_TEXT:C284($c)  // old C_STRING length 1
C_TEXT:C284($d)  // old C_STRING length 5
C_TEXT:C284($e)  // old C_STRING length 1

$cr:=Char:C90(13)
$ItmOk:=True:C214
Case of 
	: (Form event code:C388=On Load:K2:1)
		saveItm5:=[Bridge MHD NBIS:1]Item5:59
	: (Form event code:C388=On Data Change:K2:15)
		//check for errors
		$a:=Substring:C12([Bridge MHD NBIS:1]Item5:59; 1; 1)
		$b:=Substring:C12([Bridge MHD NBIS:1]Item5:59; 2; 1)
		$c:=Substring:C12([Bridge MHD NBIS:1]Item5:59; 3; 1)
		$d:=Substring:C12([Bridge MHD NBIS:1]Item5:59; 4; 5)
		$e:=Substring:C12([Bridge MHD NBIS:1]Item5:59; 9; 1)
		Case of 
			: (Length:C16([Bridge MHD NBIS:1]Item5:59)#9)
				$ItmOk:=False:C215
				BEEP:C151
				ALERT:C41("There are some characters missing! Total length for this field is 9"+$cr+$cr+"Pleae re-enter!")
			: (Position:C15($a; "12ABCDEFGHIJKLMNOPQRSTUVWXYZ")=0)
				$ItmOk:=False:C215
				BEEP:C151
				ALERT:C41("Only characters 1,2,A thru Z are allowed in Item 5A!"+$cr+$cr+"Please re-enter!")
			: (Position:C15($b; "12345678")=0)
				$ItmOk:=False:C215
				BEEP:C151
				ALERT:C41("Only characters 1 thru 8 are allowed in Item 5B!"+$cr+$cr+"Please re-enter!")
			: (Position:C15($c; "01234678")=0)
				$ItmOk:=False:C215
				BEEP:C151
				ALERT:C41("Only characters 0,1,2,3,4,6,7,8 are allowed in Item 5C!"+$cr+$cr+"Please re-enter!")
			: ($b="5") & ($d#"00000")
				$ItmOk:=False:C215
				BEEP:C151
				ALERT:C41("You have entered a Route number in Item 5D while Item 5B = 5 (City Street)!"+$cr+$cr+"Please re-enter!")
			: (Substring:C12($d; 5; 1)="A") & (Substring:C12($d; 1; 4)="0000")
				$ItmOk:=False:C215
				BEEP:C151
				ALERT:C41("Entered Route suffix in Item 5D without a Route number!"+$cr+$cr+"Please re-enter!")
			: ($b>="1") & ($b<="3") & (($d="00000") | ($d="0000A"))
				$ItmOk:=False:C215
				BEEP:C151
				ALERT:C41("For Interstate, US, or State Route : Invalid or zero Route number entered in Item 5D!"+$cr+$cr+"Please re-enter!")
			: (Position:C15($e; "01234")=0)
				$ItmOk:=False:C215
				BEEP:C151
				ALERT:C41("Only characters 0 thru 4 are allowed in Item 5E!"+$cr+$cr+"Please re-enter!")
		End case 
		If ($ItmOk=False:C215)
			[Bridge MHD NBIS:1]Item5:59:=saveItm5
			GOTO OBJECT:C206([Bridge MHD NBIS:1]Item5:59)
		Else 
			PushChange(1; Self:C308)
		End if 
End case 