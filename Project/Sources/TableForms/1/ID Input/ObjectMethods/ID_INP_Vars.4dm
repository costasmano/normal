
//Route number for item7

C_TEXT:C284(IDv7RteNum)  // Command Replaced was o_C_STRING length was 3
If (False:C215)
	C_TEXT:C284($prefix)  // Command Replaced was o_C_STRING length was 5
	C_TEXT:C284($code; $IDR2v7Rte)  // Command Replaced was o_C_STRING length was 5
	
	Case of 
		: (Form event code:C388=On Load:K2:1)
			$prefix:=Substring:C12([Bridge MHD NBIS:1]Item7:65; 1; 5)
			
			If (($prefix="WATER") | ($prefix="OTHER") | ($prefix="MBTA ") | ($prefix="COMB ") | ($prefix="HWY  ") | ($prefix="RR   "))
				IDv7RteNum:=""
			Else 
				IDv7RteNum:=Substring:C12([Bridge MHD NBIS:1]Item7:65; 3; 3)
			End if 
		: (Form event code:C388=On Data Change:K2:15)
			$code:=Substring:C12(IDv7FDescr; 1; 2)
			
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
			PushChange(1; ->[Bridge MHD NBIS:1]Item7:65)
	End case 
End if 
SIA_RteNum_OM(->[Bridge MHD NBIS:1]Item7:65; ->IDv7RteNum; ->IDv7FDescr; ->IDv7Descr)
