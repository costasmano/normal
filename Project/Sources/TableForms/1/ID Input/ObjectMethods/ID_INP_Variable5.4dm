//SC aFeatDescr_ on layout [Bridge MHD NBIS];"ID Input".

//Pop up menu for Item6a 
// Added on 11\16\2000

//TRACE

C_TEXT:C284(IDv7FDescr)  // Command Replaced was o_C_STRING length was 30
If (False:C215)
	C_TEXT:C284($Prefix)  // Command Replaced was o_C_STRING length was 5
	C_TEXT:C284($code; $IDR2v7Rte)  // Command Replaced was o_C_STRING length was 5
	
	REDRAW:C174(IDa7FDescr_)
	If ((Form event code:C388=On Clicked:K2:4) & (IDa7FDescr_>0))
		IDv7FDescr:=IDa7FDescr_{IDa7FDescr_}
	End if 
	Case of 
		: ((Form event code:C388=On Load:K2:1) | (IDa7FDescr_=0))
			IDa7FDescr_:=Find in array:C230(IDa7FCodes_; Substring:C12([Bridge MHD NBIS:1]Item7:65; 1; 5))
			If (IDa7FDescr_<=0)  //Just in case nothing was found in array
				IDa7FDescr_:=0
				IDv7FDescr:="Select Code..."
				If ((Substring:C12([Bridge MHD NBIS:1]Item7:65; 1; 2)="I ") | (Substring:C12([Bridge MHD NBIS:1]Item7:65; 1; 2)="ST") | (Substring:C12([Bridge MHD NBIS:1]Item7:65; 1; 2)="US"))
					IDa7FDescr_:=Find in array:C230(IDa7FCodes_; (Substring:C12([Bridge MHD NBIS:1]Item7:65; 1; 2)+"   "))
					IDv7FDescr:=Substring:C12([Bridge MHD NBIS:1]Item7:65; 1; 2)
				End if 
			Else 
				IDv7FDescr:=IDa7FDescr_{IDa7FDescr_}
			End if 
			$Prefix:=Substring:C12([Bridge MHD NBIS:1]Item7:65; 1; 2)
			If (($Prefix="I ") | ($Prefix="US") | ($Prefix="ST"))
				OBJECT SET ENTERABLE:C238(IDv7RteNum; True:C214)
			Else 
				OBJECT SET ENTERABLE:C238(IDv7RteNum; False:C215)
			End if 
			
		: (Form event code:C388=On Clicked:K2:4)
			[Bridge MHD NBIS:1]Item7:65:=Change string:C234([Bridge MHD NBIS:1]Item7:65; IDa7FCodes_{IDa7FDescr_}; 1)
			
			$Prefix:=Substring:C12([Bridge MHD NBIS:1]Item7:65; 1; 5)
			// Added 10-16-00    
			If ($Prefix#"ST   ")
				IDv7Suffix:=0
				If (Substring:C12(IDv7Descr; 2; 1)="/")
					IDv7Descr:=Delete string:C232(IDv7Descr; 1; 2)
				End if 
				If (Substring:C12(IDv7Descr; 2; 1)#"/")
					IDv7Descr:=Insert string:C231(IDv7Descr; ""; 1)
				End if 
			End if 
			// End of addition on 10-16-00   
			If (($Prefix="I    ") | ($Prefix="US   ") | ($Prefix="ST   "))
				OBJECT SET ENTERABLE:C238(IDv7RteNum; True:C214)
				If ($Prefix="ST   ")
					OBJECT SET ENTERABLE:C238(IDv7suffix; True:C214)
				Else 
					OBJECT SET ENTERABLE:C238(IDv7suffix; False:C215)
				End if 
				
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
			Else 
				IDv7RteNum:="   "
				OBJECT SET ENTERABLE:C238(IDv7RteNum; False:C215)
				OBJECT SET ENTERABLE:C238(IDv7Suffix; False:C215)
				[Bridge MHD NBIS:1]Item7:65:=Substring:C12(IDv7FDescr; 1; 5)+" "+IDv7Descr
			End if 
			PushChange(1; ->[Bridge MHD NBIS:1]Item7:65)
	End case 
	
End if 
SIA_Feature_OM(->[Bridge MHD NBIS:1]Item7:65; ->IDa7FDescr_; ->IDv7FDescr; ->IDa7FCodes_; ->IDv7RteNum; ->IDv7suffix; ->IDv7Descr)