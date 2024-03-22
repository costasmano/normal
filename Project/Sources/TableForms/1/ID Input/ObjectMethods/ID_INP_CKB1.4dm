// Updates the description field with a prefix of A 
//for state routes that have route number with an A
//Any other prefixes are removed when un-checking the prefix box

If (False:C215)
	C_TEXT:C284($code; $IDR2v7Rte)  // Command Replaced was o_C_STRING length was 5
	
	Case of 
			
		: (Form event code:C388=On Load:K2:1)
			If (Substring:C12([Bridge MHD NBIS:1]Item7:65; 8; 1)="/")
				IDv7Suffix:=1
			End if 
			
		: (Form event code:C388=On Clicked:K2:4)
			$code:=Substring:C12(IDv7FDescr; 1; 2)
			
			If ($code="ST")
				If (IDv7Suffix=1)
					IDv7Descr:=Insert string:C231(IDv7Descr; "A/"; 1)
				End if 
				If (IDv7Suffix=0)
					If (Substring:C12(IDv7Descr; 2; 1)="/")
						IDv7Descr:=Delete string:C232(IDv7Descr; 1; 2)
					End if 
					If (Substring:C12(IDv7Descr; 2; 1)#"/")
						IDv7Descr:=Insert string:C231(IDv7Descr; ""; 1)
					End if 
				End if 
			Else 
				IDv7Suffix:=0
				If (Substring:C12(IDv7Descr; 2; 1)="/")
					IDv7Descr:=Delete string:C232(IDv7Descr; 1; 2)
				End if 
				If (Substring:C12(IDv7Descr; 2; 1)#"/")
					IDv7Descr:=Insert string:C231(IDv7Descr; ""; 1)
				End if 
			End if 
			
			If (($code="ST") | ($code="I ") | ($code="US"))
				$IDR2v7Rte:=Replace string:C233(Replace string:C233(IDv7RteNum; " "; ""); "_"; "")
				If (Length:C16($IDR2v7Rte)=1)
					[Bridge MHD NBIS:1]Item7:65:=$Code+"  "+$IDR2v7Rte+" "+IDv7Descr
				End if 
				If (Length:C16($IDR2v7Rte)=2)
					[Bridge MHD NBIS:1]Item7:65:=$Code+" "+$IDR2v7Rte+" "+IDv7Descr
				End if 
				If (Length:C16($IDR2v7Rte)=3)
					[Bridge MHD NBIS:1]Item7:65:=$Code+$IDR2v7Rte+" "+IDv7Descr
				End if 
				If (Length:C16($IDR2v7Rte)=0)
					[Bridge MHD NBIS:1]Item7:65:=$Code+"    "+IDv7Descr
				End if 
			Else 
				[Bridge MHD NBIS:1]Item7:65:=Substring:C12(IDv7FDescr; 1; 5)+" "+IDv7Descr
			End if 
			PushChange(1; ->[Bridge MHD NBIS:1]Item7:65)
	End case 
End if 
SIA_Suffix_OM(->[Bridge MHD NBIS:1]Item7:65; ->IDv7Suffix; ->IDv7FDescr; ->IDv7Descr; ->IDv7RteNum)