//Route number for item6a

C_TEXT:C284(IDvRteNum)  // Command Replaced was o_C_STRING length was 3
If (False:C215)
	C_TEXT:C284($prefix)  // Command Replaced was o_C_STRING length was 5
	C_TEXT:C284($code; $IDR2vRte)  // Command Replaced was o_C_STRING length was 5
	
	Case of 
		: (Form event code:C388=On Load:K2:1)
			$prefix:=Substring:C12([Bridge MHD NBIS:1]Item6A:63; 1; 5)
			
			If (($prefix="WATER") | ($prefix="OTHER") | ($prefix="MBTA ") | ($prefix="COMB ") | ($prefix="HWY  ") | ($prefix="RR   "))
				IDvRtenum:=""
			Else 
				IDvRtenum:=Substring:C12([Bridge MHD NBIS:1]Item6A:63; 3; 3)
			End if 
		: (Form event code:C388=On Data Change:K2:15)
			$code:=Substring:C12(IDvFeatDescr; 1; 2)
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
			PushChange(1; ->[Bridge MHD NBIS:1]Item6A:63)
	End case 
	
End if 
SIA_RteNum_OM(->[Bridge MHD NBIS:1]Item6A:63; ->IDvRteNum; ->IDvFeatDescr; ->IDv6Descr)
