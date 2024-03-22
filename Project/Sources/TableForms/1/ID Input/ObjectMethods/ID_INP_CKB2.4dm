// Updates the description field with a prefix of A 
//for state routes that have route number with an A
If (False:C215)
	C_TEXT:C284($code; $IDR2vRte)  // Command Replaced was o_C_STRING length was 5
	
	Case of 
			
		: (Form event code:C388=On Load:K2:1)
			If (Substring:C12([Bridge MHD NBIS:1]Item6A:63; 8; 1)="/")
				IDvSuffix:=1
			End if 
			
		: (Form event code:C388=On Clicked:K2:4)
			$code:=Substring:C12(IDvFeatDescr; 1; 2)
			
			If ($code="ST")
				If (IDvSuffix=1)
					IDv6Descr:=Insert string:C231(IDv6Descr; "A/"; 1)
				End if 
				If (IDvSuffix=0)
					If (Substring:C12(IDv6Descr; 2; 1)="/")
						IDv6Descr:=Delete string:C232(IDv6Descr; 1; 2)
					End if 
					If (Substring:C12(IDv6Descr; 2; 1)#"/")
						IDv6Descr:=Insert string:C231(IDv6Descr; ""; 1)
					End if 
				End if 
			Else 
				IDvSuffix:=0
				If (Substring:C12(IDv6Descr; 2; 1)="/")
					IDv6Descr:=Delete string:C232(IDv6Descr; 1; 2)
				End if 
				If (Substring:C12(IDv6Descr; 2; 1)#"/")
					IDv6Descr:=Insert string:C231(IDv6Descr; ""; 1)
				End if 
			End if 
			
			If (($code="ST") | ($code="I ") | ($code="US"))
				$IDR2vRte:=Replace string:C233(Replace string:C233(IDvRteNum; " "; ""); "_"; "")
				If (Length:C16($IDR2vRte)=1)
					[Bridge MHD NBIS:1]Item6A:63:=$Code+"  "+$IDR2vRte+" "+IDv6Descr
				End if 
				If (Length:C16($IDR2vRte)=2)
					[Bridge MHD NBIS:1]Item6A:63:=$Code+" "+$IDR2vRte+" "+IDv6Descr
				End if 
				If (Length:C16($IDR2vRte)=3)
					[Bridge MHD NBIS:1]Item6A:63:=$Code+$IDR2vRte+" "+IDv6Descr
				End if 
				If (Length:C16($IDR2vRte)=0)
					[Bridge MHD NBIS:1]Item6A:63:=$Code+"    "+IDv6Descr
				End if 
			Else 
				[Bridge MHD NBIS:1]Item6A:63:=Substring:C12(IDvFeatDescr; 1; 5)+" "+IDv6Descr
			End if 
			PushChange(1; ->[Bridge MHD NBIS:1]Item6A:63)
	End case 
	
End if 
SIA_Suffix_OM(->[Bridge MHD NBIS:1]Item6A:63; ->IDvSuffix; ->IDvFeatDescr; ->IDv6Descr; ->IDvRteNum)