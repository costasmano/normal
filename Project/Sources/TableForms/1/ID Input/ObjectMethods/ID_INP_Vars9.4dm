//18 character description for item6a

C_TEXT:C284(IDv6Descr)  // Command Replaced was o_C_STRING length was 18
If (False:C215)
	C_TEXT:C284($code; $IDR2vRte)  // Command Replaced was o_C_STRING length was 5
	
	Case of 
		: (Form event code:C388=On Load:K2:1)
			IDv6Descr:=Substring:C12([Bridge MHD NBIS:1]Item6A:63; 7; 18)
		: (Form event code:C388=On Data Change:K2:15)
			$code:=Substring:C12(IDvFeatDescr; 1; 2)
			If (($code="I ") | ($code="ST") | ($code="US"))
				
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
SIA_Description_OM(->[Bridge MHD NBIS:1]Item6A:63; ->IDvRteNum; ->IDvFeatDescr; ->IDv6Descr)