//%attributes = {"invisible":true}
If (False:C215)
	//GP M_RPC_Report
	//Copyright © 1998, Thomas D. Nee, All Rights Reserved.
	
	//Use the current selection and print a report
	//for the Regional Planning Commissions (RPCs).
	
	//This version uses Print Layout to completely control printing.
	// Modified by: Costas Manousakis-(Designer)-(5/21/13 09:51:01)
	Mods_2013_05
	//  `Added sorting at the end
	// Modified by: Costas Manousakis-(Designer)-(5/6/20 12:44:59)
	Mods_2020_05
	//  `modified to use only the "Rpt RPC" form by printing sections of it.
End if 

C_LONGINT:C283($i; $j; $recs; $totalRecs; $totalj; $Interval; $NoRPCs; $pages; vCurrPage; vRptPages)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($PixPage; $PixH0; $PixH1; $PixD; $PixF; $PixCount)  //Command Replaced was o_C_INTEGER
//C_STRING(80;$Msg)
C_TEXT:C284($PreviousTwn)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284(vTwnName)  // Command Replaced was o_C_STRING length was 45
C_TEXT:C284($DocName)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284($LocalFolder; $DefaultFolder)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284(vRptHeader; vRptDescr; vFileDescr)
C_TEXT:C284($text)
C_DATE:C307(vRptDate)
C_TIME:C306(vRptTime)
C_LONGINT:C283(ckPrintRpt; ckWriteDocs)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($NewPage)

$PixPage:=551
$PixH0:=61
$PixH1:=10
$PixD:=8
$PixF:=3

$recs:=Records in selection:C76([Bridge MHD NBIS:1])
$totalRecs:=$recs
CREATE SET:C116([Bridge MHD NBIS:1]; "Initial Bridge Set")
ARRAY TEXT:C222($aRPC_Codes; 0)  //Command Replaced was o_ARRAY string length was 4
DISTINCT VALUES:C339([Bridge MHD NBIS:1]RPC_Codes:183; $aRPC_Codes)
SORT ARRAY:C229($aRPC_Codes)
$NoRPCs:=Size of array:C274($aRPC_Codes)
If ($recs<=0)
	ALERT:C41("Please select some records and then try again.")
Else 
	If ($recs=1)
		vRptDescr:="There is one bridge selected "
	Else 
		vRptDescr:="There are "+String:C10($recs)+" bridges selected "
	End if 
	If ($NoRPCs=1)
		vRptDescr:=vRptDescr+"in one Regional Planning Commission (RPC)."
	Else 
		vRptDescr:=vRptDescr+"in "+String:C10($NoRPCs)+" Regional Planning Commissions (RPC)."
	End if 
	vRptDescr:=vRptDescr+(3*<>sCR)+"Select this to print a report"
	If ($NoRPCs>1)
		vRptDescr:=vRptDescr+" for each RPC"
	End if 
	If ($recs=1)
		vRptDescr:=vRptDescr+"."
	Else 
		$pages:=Int:C8($recs/50)+1
		If ($NoRPCs>$pages)
			$pages:=$NoRPCs
		End if 
		If ($pages<=1)
			vRptDescr:=vRptDescr+" (about one page)."
		Else 
			vRptDescr:=vRptDescr+" (about "+String:C10($pages)+" pages)."
		End if 
	End if 
	vRptDescr:=vRptDescr+(2*<>sCR)+"If so, select landscape in the next dialog."
	
	If (Application type:C494=4D Remote mode:K5:5)
		// If we are running 4D Client,  default folder is where 4D client
		// application is
		$DefaultFolder:=Application file:C491
	Else 
		// Otherwise, the default folder is where the data file is located
		$DefaultFolder:=Data file:C490
	End if 
	$DefaultFolder:=GetPath($DefaultFolder)
	
	vFileDescr:="Select this to export the data to "
	If ($NoRPCs=1)
		vFileDescr:=vFileDescr+"a file"
	Else 
		vFileDescr:=vFileDescr+"files"
	End if 
	vFileDescr:=vFileDescr+" (placed in the "+$DefaultFolder+")."
	vFileDescr:=vFileDescr+(2*<>sCR)+"When importing one of these files, specify "+<>sQU+"text"+<>sQU
	vFileDescr:=vFileDescr+" for BIN and Item 8.  Otherwise some characters could be lost."
	
	NewWindow(300; 370; 0; 1; ""; "")
	DIALOG:C40([zDialogs:68]; "PrintReport")
	CLOSE WINDOW:C154
	
	If ((OK=1) & ((ckPrintRpt=1) | (ckWriteDocs=1)))
		
		If (ckPrintRpt=1)
			//_O_PAGE SETUP([Bridge MHD NBIS]; "Rpt RPC")
			FORM SET OUTPUT:C54([Bridge MHD NBIS:1]; "Rpt RPC")
			PRINT SETTINGS:C106
		End if 
		If (ckWriteDocs=1)
			$LocalFolder:=Select folder:C670("Select folder where reports will be placed."+<>sCR+"Cancel will place them in "+$DefaultFolder)
		End if 
		// start overall record counter      
		$totalj:=1
		<>ProgressPID:=StartProgress(""; "None"; "Printing/Exporting Reports for "+String:C10($NoRPCS)+" RPCs")
		//Do 1st update of progress display 
		UpdateProgress($totalj; $totalRecs)
		$Interval:=MaxNum(MinNum(Int:C8($Recs/40); 20); 2)  // get an update interval between 2 and 20
		
		For ($i; 1; $NoRPCs)
			QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]RPC_Codes:183=$aRPC_Codes{$i})
			ORDER BY:C49([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Town Name:175; [Bridge MHD NBIS:1]BDEPT:1; [Bridge MHD NBIS:1]Item8:206)
			$recs:=Records in selection:C76([Bridge MHD NBIS:1])
			
			If (ckPrintRpt=1)
				QUERY:C277([RPCs:72]; [RPCs:72]Code:1=Substring:C12([Bridge MHD NBIS:1]RPC_Codes:183; 1; 2))
				vRptHeader:=[RPCs:72]RPC Name:2
				If (Substring:C12([Bridge MHD NBIS:1]RPC_Codes:183; 3; 2)="00")
					vRptHeader:=<>sCR+vRptHeader
				Else 
					QUERY:C277([RPCs:72]; [RPCs:72]Code:1=Substring:C12([Bridge MHD NBIS:1]RPC_Codes:183; 3; 2))
					vRptHeader:=vRptHeader+<>sCR+[RPCs:72]RPC Name:2
				End if 
				vRptHeader:=vRptHeader+<>sCR+"Number of Bridges:  "+String:C10($recs)
				vRptDate:=Current date:C33(*)
				vRptTime:=Current time:C178(*)
				
				$NewPage:=True:C214
				$PixCount:=0
				vCurrPage:=0
				$PreviousTwn:=""
			End if 
			
			If (ckWriteDocs=1)
				QUERY:C277([RPCs:72]; [RPCs:72]Code:1=Substring:C12([Bridge MHD NBIS:1]RPC_Codes:183; 1; 2))
				$DocName:=[RPCs:72]Short Name:3
				If (Substring:C12([Bridge MHD NBIS:1]RPC_Codes:183; 3; 2)#"00")
					QUERY:C277([RPCs:72]; [RPCs:72]Code:1=Substring:C12([Bridge MHD NBIS:1]RPC_Codes:183; 3; 2))
					$DocName:=$DocName+"-"+[RPCs:72]Short Name:3
				End if 
				$DocName:=$LocalFolder+$DocName+".TXT"
				C_TIME:C306($dTextData)
				$dTextData:=Create document:C266($DocName)
				$text:="Town"+<>sTab+"BDEPT"+<>sTab+"BIN"+<>sTab+"Item 8"+<>sTab+"Over"+<>sTab+"Under"
				$text:=$text+<>sTab+"Owner Code"+<>sTab+"Owner"+<>sTab+"Hist. Code"+<>sTab+"FC Code"+<>sTab+"Functional Class"
				$text:=$text+<>sTab+"Year Built"+<>sTab+"Year Rebuilt"+<>sTab+"AASHTO Rating"+<>sTab+"Deficiency"+<>sCR
				$text:=$text+<>sLF
				SEND PACKET:C103($dTextData; $text)
			End if 
			
			For ($j; 1; $recs)
				
				If (ckPrintRpt=1)
					If (Not:C34($NewPage))
						If ([Bridge MHD NBIS:1]Town Name:175#$PreviousTwn)
							//The town has changed.
							//Check if the town name and one record will fit on this page.
							If (($PixCount+$PixH1+$PixD+$PixF)>$PixPage)
								//There is not enough room to print.              
								Print form:C5([Bridge MHD NBIS:1]; "Rpt RPC"; Form footer:K43:2)
								PAGE BREAK:C6(>)
								$NewPage:=True:C214
							Else 
								//There is enough room, print the town name.
								vTwnName:=[Bridge MHD NBIS:1]Town Name:175
								Print form:C5([Bridge MHD NBIS:1]; "Rpt RPC"; Form header1:K43:4)
								$PixCount:=$PixCount+$PixH1
							End if 
						End if 
					End if 
					
					If ($NewPage)
						//Print the headers and the record.
						vCurrPage:=vCurrPage+1
						Print form:C5([Bridge MHD NBIS:1]; "Rpt RPC"; Form header:K43:3)
						If ([Bridge MHD NBIS:1]Town Name:175=$PreviousTwn)
							vTwnName:=[Bridge MHD NBIS:1]Town Name:175+" (Continued)"
						Else 
							vTwnName:=[Bridge MHD NBIS:1]Town Name:175
						End if 
						Print form:C5([Bridge MHD NBIS:1]; "Rpt RPC"; Form header1:K43:4)
						Print form:C5([Bridge MHD NBIS:1]; "Rpt RPC"; Form detail:K43:1)
						$PixCount:=$PixH0+$PixH1+$PixD
						$NewPage:=False:C215
					Else 
						//Print just the record.
						Print form:C5([Bridge MHD NBIS:1]; "Rpt RPC"; Form detail:K43:1)
						$PixCount:=$PixCount+$PixD
					End if 
					
					$PreviousTwn:=[Bridge MHD NBIS:1]Town Name:175
					If (($j=$recs) | (($PixCount+$PixD+$PixF)>$PixPage))
						//Either this is the last record or there is no more room, so finish this page.
						Print form:C5([Bridge MHD NBIS:1]; "Rpt RPC"; Form footer:K43:2)
						PAGE BREAK:C6(>)
						$NewPage:=True:C214
					End if 
				End if 
				
				If (ckWriteDocs=1)
					$text:=[Bridge MHD NBIS:1]Town Name:175+<>sTab+[Bridge MHD NBIS:1]BDEPT:1+<>sTab+[Bridge MHD NBIS:1]BIN:3+<>sTab+[Bridge MHD NBIS:1]Item8:206
					$text:=$text+<>sTab+[Bridge MHD NBIS:1]Item7:65+<>sTab+[Bridge MHD NBIS:1]Item6A:63
					$text:=$text+<>sTab+[Bridge MHD NBIS:1]Item22:128+<>sTab+GetOwnerTrans+<>sTab+HistoricalTrans
					$text:=$text+<>sTab+[Bridge MHD NBIS:1]Item26:120+<>sTab+GetFCTrans
					$text:=$text+<>sTab+String:C10([Bridge MHD NBIS:1]Item27:83; "####;?;?")+<>sTab+String:C10([Bridge MHD NBIS:1]Item106:84; "####;;")
					$text:=$text+<>sTab+String:C10([Bridge MHD NBIS:1]AASHTO:5; "##0.0")+<>sTab+GetDeficTrans+<>sCR
					$text:=$text+<>sLF
					SEND PACKET:C103($dTextData; $text)
				End if 
				
				NEXT RECORD:C51([Bridge MHD NBIS:1])
				// increment overall record counter
				$totalj:=$totalj+1
				//Update progress bar
				If ($totalj%$Interval=0)
					UpdateProgress($totalj; $totalRecs)
				End if 
				//Check to see if we got an abort from the progress bar
				If (<>Abort)
					// skip all - RPCs
					$j:=$recs+1
					$i:=$NoRPCs+1
				End if 
				
				// end of RPC record loop          
			End for 
			
			If (ckWriteDocs=1)
				CLOSE DOCUMENT:C267($dTextData)
			End if 
			USE SET:C118("Initial Bridge Set")
			//end of RPC loop
		End for 
		
		CLEAR SET:C117("Initial Bridge Set")
		POST OUTSIDE CALL:C329(<>ProgressPID)
		
		C_TEXT:C284(GEN_SORTLISTCMD_txt)
		
		If (GEN_SORTLISTCMD_txt#"")
			EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
		End if 
		
	End if 
End if 