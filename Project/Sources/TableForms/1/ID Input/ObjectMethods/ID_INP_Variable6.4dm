//SC IDaFeatDescr_ on layout [Bridge MHD NBIS];"ID Input".

//Pop up menu for Item6a 

C_TEXT:C284(IDvFeatDescr)  // Command Replaced was o_C_STRING length was 30
If (False:C215)
	C_TEXT:C284($Prefix)  // Command Replaced was o_C_STRING length was 5
	C_TEXT:C284($code; $IDR2vRte)  // Command Replaced was o_C_STRING length was 5
	
	REDRAW:C174(IDaFeatDescr_)
	If ((Form event code:C388=On Clicked:K2:4) & (IDaFeatDescr_>0))
		IDvFeatDescr:=IDaFeatDescr_{IDaFeatDescr_}
	End if 
	Case of 
		: ((Form event code:C388=On Load:K2:1) | (IDaFeatDescr_=0))
			IDaFeatDescr_:=Find in array:C230(IDaFeatCodes_; Substring:C12([Bridge MHD NBIS:1]Item6A:63; 1; 5))
			If (IDaFeatDescr_<=0)  //Just in case nothing was found in array
				IDaFeatDescr_:=0
				IDvFeatDescr:="Select Code..."
				If ((Substring:C12([Bridge MHD NBIS:1]Item6A:63; 1; 2)="I ") | (Substring:C12([Bridge MHD NBIS:1]Item6A:63; 1; 2)="ST") | (Substring:C12([Bridge MHD NBIS:1]Item6A:63; 1; 2)="US"))
					IDaFeatDescr_:=Find in array:C230(IDaFeatCodes_; (Substring:C12([Bridge MHD NBIS:1]Item6A:63; 1; 2)+"   "))
					IDvFeatDescr:=Substring:C12([Bridge MHD NBIS:1]Item6A:63; 1; 2)
				End if 
			Else 
				IDvFeatDescr:=IDaFeatDescr_{IDaFeatDescr_}
			End if 
			$Prefix:=Substring:C12([Bridge MHD NBIS:1]Item6A:63; 1; 2)
			If (($Prefix="I ") | ($Prefix="US") | ($Prefix="ST"))
				OBJECT SET ENTERABLE:C238(IDvRteNum; True:C214)
			Else 
				OBJECT SET ENTERABLE:C238(IDvRteNum; False:C215)
			End if 
			
		: (Form event code:C388=On Clicked:K2:4)
			[Bridge MHD NBIS:1]Item6A:63:=Change string:C234([Bridge MHD NBIS:1]Item6A:63; IDaFeatCodes_{IDaFeatDescr_}; 1)
			
			$Prefix:=Substring:C12([Bridge MHD NBIS:1]Item6A:63; 1; 5)
			// Added 10/16/00
			If ($Prefix#"ST   ")
				IDvsuffix:=0
				If (Substring:C12(IDv6Descr; 2; 1)="/")
					IDv6Descr:=Delete string:C232(IDv6Descr; 1; 2)
				End if 
				If (Substring:C12(IDv6Descr; 2; 1)#"/")
					IDv6Descr:=Insert string:C231(IDv6Descr; ""; 1)
				End if 
			End if 
			// End of addition on 10/16/00
			If (($Prefix="I    ") | ($Prefix="US   ") | ($Prefix="ST   "))
				OBJECT SET ENTERABLE:C238(IDvRteNum; True:C214)
				If ($Prefix="ST   ")
					OBJECT SET ENTERABLE:C238(IDvSuffix; True:C214)
				Else 
					OBJECT SET ENTERABLE:C238(IDvSuffix; False:C215)
				End if 
				
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
			Else 
				IDvRteNum:="   "
				OBJECT SET ENTERABLE:C238(IDvRteNum; False:C215)
				OBJECT SET ENTERABLE:C238(IDvSuffix; False:C215)
				[Bridge MHD NBIS:1]Item6A:63:=Substring:C12(IDvFeatDescr; 1; 5)+" "+IDv6Descr
			End if 
			PushChange(1; ->[Bridge MHD NBIS:1]Item6A:63)
	End case 
End if 
SIA_Feature_OM(->[Bridge MHD NBIS:1]Item6A:63; ->IDaFeatDescr_; ->IDvFeatDescr; ->IDaFeatCodes_; ->IDvRteNum; ->IDvSuffix; ->IDv6Descr)