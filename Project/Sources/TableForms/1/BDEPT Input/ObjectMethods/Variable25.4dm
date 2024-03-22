// Updates the description field with a prefix of A 
//for state routes that have route number with an A
//Any other prefixes are removed when un-checking the prefix box

If (False:C215)
	C_TEXT:C284($code)  // Command Replaced was o_C_STRING length was 5
	C_TEXT:C284($BINR2v7Rte)  // Command Replaced was o_C_STRING length was 3
	
	Case of 
			
		: (Form event code:C388=On Load:K2:1)
			If (Substring:C12([Bridge MHD NBIS:1]Item7:65; 8; 1)="/")
				BINv7Suffix:=1
			End if 
			
		: (Form event code:C388=On Clicked:K2:4)
			$code:=Substring:C12(BINv7FDescr; 1; 2)
			
			If ($code="ST")
				If (BINv7Suffix=1)
					BINv7Descr:=Insert string:C231(BINv7Descr; "A/"; 1)
				End if 
				If (BINv7Suffix=0)
					If (Substring:C12(BINv7Descr; 2; 1)="/")
						BINv7Descr:=Delete string:C232(BINv7Descr; 1; 2)
					End if 
					If (Substring:C12(BINv7Descr; 2; 1)#"/")
						BINv7Descr:=Insert string:C231(BINv7Descr; ""; 1)
					End if 
				End if 
			Else 
				BINv7Suffix:=0
				If (Substring:C12(BINv7Descr; 2; 1)="/")
					BINv7Descr:=Delete string:C232(BINv7Descr; 1; 2)
				End if 
				If (Substring:C12(BINv7Descr; 2; 1)#"/")
					BINv7Descr:=Insert string:C231(BINv7Descr; ""; 1)
				End if 
			End if 
			
			If (($code="ST") | ($code="I ") | ($code="US"))
				$BINR2v7Rte:=Replace string:C233(Replace string:C233(BINv7RteNum; " "; ""); "_"; "")
				If (Length:C16($BINR2v7Rte)=1)
					[Bridge MHD NBIS:1]Item7:65:=$Code+"  "+$BINR2v7Rte+" "+BINv7Descr
				End if 
				If (Length:C16($BINR2v7Rte)=2)
					[Bridge MHD NBIS:1]Item7:65:=$Code+" "+$BINR2v7Rte+" "+BINv7Descr
				End if 
				If (Length:C16($BINR2v7Rte)=3)
					[Bridge MHD NBIS:1]Item7:65:=$Code+$BINR2v7Rte+" "+BINv7Descr
				End if 
				If (Length:C16($BINR2v7Rte)=0)
					[Bridge MHD NBIS:1]Item7:65:=$Code+"    "+BINv7Descr
				End if 
			Else 
				[Bridge MHD NBIS:1]Item7:65:=Substring:C12(BINv7FDescr; 1; 5)+" "+BINv7Descr
			End if 
			PushChange(1; ->[Bridge MHD NBIS:1]Item7:65)
	End case 
	
End if 
SIA_Suffix_OM(->[Bridge MHD NBIS:1]Item7:65; ->BINv7Suffix; ->BINv7FDescr; ->BINv7Descr; ->BINv7RteNum)