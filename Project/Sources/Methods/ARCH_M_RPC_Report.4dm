//%attributes = {"invisible":true}
// Method: ARCH_M_RPC_Report
// Description
// Run RPC reports from the [BridgeMHDNBISARCHIVE] table
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/18/11, 13:08:50
	// ----------------------------------------------------
	// First Release
	Mods_2011_10
	// Modified by: Costas Manousakis-(Designer)-(5/13/14 10:39:40)
	Mods_2014_05_bug
	//  `Adjusted  logic to allow running report if reason and date are not unique in the  selection
	// Modified by: Costas Manousakis-(Designer)-(10/25/17 12:12:14)
	Mods_2017_10
	//  `use new ProgressNew and UpdateProgressNew
End if 

//GP M_RPC_Report
//Copyright © 1998, Thomas D. Nee, All Rights Reserved.

//Use the current selection and print a report
//for the Regional Planning Commissions (RPCs).

//This version uses Print Layout to completely control printing.

C_LONGINT:C283($i; $j; $recs; $totalRecs; $totalj; $Interval; $NoRPCs; $pages; vCurrPage; vRptPages)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($PixPage; $PixH0; $PixH1; $PixD; $PixF; $PixCount; $PixPrint_L)  //Command Replaced was o_C_INTEGER
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
//values below must be verified from the print forms
$PixH0:=61
$PixH1:=10
$PixD:=8
$PixF:=3

//TRACE

$recs:=Records in selection:C76([BridgeMHDNBISArchive:139])
ARRAY TEXT:C222($archReasons_atxt; 0)
ARRAY DATE:C224($archDates_ad; 0)
DISTINCT VALUES:C339([BridgeMHDNBISArchive:139]ArchiveReason_s:223; $archReasons_atxt)
DISTINCT VALUES:C339([BridgeMHDNBISArchive:139]ArchiveDate_d:224; $archDates_ad)

If ($recs<=0)
	ALERT:C41("Please select some records and then try again.")
Else 
	C_BOOLEAN:C305($proceed_b)
	$proceed_b:=False:C215
	
	If ((Size of array:C274($archReasons_atxt)=1) & (Size of array:C274($archDates_ad)=1))
		$proceed_b:=True:C214
	Else 
		CONFIRM:C162("Multiple Archive Reasons ("+String:C10(Size of array:C274($archReasons_atxt))+")  and/or Archive Dates ("+String:C10(Size of array:C274($archDates_ad))+") found! Run the report anyway?"; "Run"; "Cancel")
		$proceed_b:=(OK=1)
	End if 
	
	If ($proceed_b)
		$totalRecs:=$recs
		CREATE SET:C116([BridgeMHDNBISArchive:139]; "Initial Bridge Set")
		ARRAY TEXT:C222($aRPC_Codes; 0)  //Command Replaced was o_ARRAY string length was 4
		DISTINCT VALUES:C339([BridgeMHDNBISArchive:139]RPC_Codes:180; $aRPC_Codes)
		SORT ARRAY:C229($aRPC_Codes)
		$NoRPCs:=Size of array:C274($aRPC_Codes)
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
		
		NewWindow(300; 370; 0; Plain window:K34:13; "RPC Reports"; "")
		DIALOG:C40([zDialogs:68]; "PrintReport")
		CLOSE WINDOW:C154
		
		If ((OK=1) & ((ckPrintRpt=1) | (ckWriteDocs=1)))
			CONFIRM:C162("Select which Report do Run : Regular or with Fed Aid Eligibility?"; "Regular"; "Fed Aid Eligib.")
			C_TEXT:C284($printForm_txt)
			C_BOOLEAN:C305($FedAidReport_b)
			If (OK=1)
				$FedAidReport_b:=False:C215
				$printForm_txt:="Rpt RPC Detail"
			Else 
				$FedAidReport_b:=True:C214
				$printForm_txt:="Rpt RPC FedAid"
			End if 
			
			If (ckPrintRpt=1)
				//_O_PAGE SETUP([BridgeMHDNBISArchive]; $printForm_txt)
				FORM SET OUTPUT:C54([BridgeMHDNBISArchive:139]; $printForm_txt)
				PRINT SETTINGS:C106
			End if 
			If (ckWriteDocs=1)
				$LocalFolder:=Select folder:C670("Select folder where reports will be placed."+<>sCR+"Cancel will place them in "+$DefaultFolder)
			End if 
			// start overall record counter      
			$totalj:=1
			
			C_OBJECT:C1216($progressobj_o)
			$progressobj_o:=ProgressNew("Printing/Exporting Reports for "+String:C10($NoRPCS)+" RPCs"; $Recs; True:C214; ""; 3)
			//Do 1st update of progress display 
			//UpdateProgress ($totalj;$totalRecs)
			$Interval:=MaxNum(MinNum(Int:C8($Recs/40); 20); 2)  // get an update interval between 2 and 20
			
			For ($i; 1; $NoRPCs)
				QUERY SELECTION:C341([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]RPC_Codes:180=$aRPC_Codes{$i})
				ORDER BY:C49([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]Town Name:174; [BridgeMHDNBISArchive:139]BDEPT:1; [BridgeMHDNBISArchive:139]Item8:203)
				$recs:=Records in selection:C76([BridgeMHDNBISArchive:139])
				
				If (ckPrintRpt=1)
					QUERY:C277([RPCs:72]; [RPCs:72]Code:1=Substring:C12([BridgeMHDNBISArchive:139]RPC_Codes:180; 1; 2))
					vRptHeader:=[RPCs:72]RPC Name:2
					If (Substring:C12([BridgeMHDNBISArchive:139]RPC_Codes:180; 3; 2)="00")
						vRptHeader:=<>sCR+vRptHeader
					Else 
						QUERY:C277([RPCs:72]; [RPCs:72]Code:1=Substring:C12([BridgeMHDNBISArchive:139]RPC_Codes:180; 3; 2))
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
					QUERY:C277([RPCs:72]; [RPCs:72]Code:1=Substring:C12([BridgeMHDNBISArchive:139]RPC_Codes:180; 1; 2))
					$DocName:=[RPCs:72]Short Name:3
					If (Substring:C12([BridgeMHDNBISArchive:139]RPC_Codes:180; 3; 2)#"00")
						QUERY:C277([RPCs:72]; [RPCs:72]Code:1=Substring:C12([BridgeMHDNBISArchive:139]RPC_Codes:180; 3; 2))
						$DocName:=$DocName+"-"+[RPCs:72]Short Name:3
					End if 
					$DocName:=$LocalFolder+$DocName+".TXT"
					C_TIME:C306($dTextData)
					$dTextData:=Create document:C266($DocName)
					$text:="Town"+<>sTab+"BDEPT"+<>sTab+"BIN"+<>sTab+"Item 8"+<>sTab+"Over"+<>sTab+"Under"
					$text:=$text+<>sTab+"Owner Code"+<>sTab+"Owner"+<>sTab+"Hist. Code"+<>sTab+"FC Code"+<>sTab+"Functional Class"
					$text:=$text+<>sTab+"Year Built"+<>sTab+"Year Rebuilt"+<>sTab+"AASHTO Rating"+<>sTab+"Deficiency"
					If ($FedAidReport_b)
						$text:=$text+<>sTab+"Fed. Aid. Eligib."
					End if 
					$text:=$text+<>sCR+<>sLF
					SEND PACKET:C103($dTextData; $text)
				End if 
				
				For ($j; 1; $recs)
					
					If (ckPrintRpt=1)
						C_BOOLEAN:C305(4DERROR_B)
						4DERROR_B:=False:C215
						ON ERR CALL:C155("4D_Errors")
						
						If (Not:C34($NewPage))
							If ([BridgeMHDNBISArchive:139]Town Name:174#$PreviousTwn)
								//The town has changed.
								//Check if the town name and one record will fit on this page.
								If (($PixCount+$PixH1+$PixD+$PixF)>$PixPage)
									//There is not enough room to print.              
									$PixPrint_L:=Print form:C5([BridgeMHDNBISArchive:139]; $printForm_txt; Form break0:K43:14)
									PAGE BREAK:C6(>)
									$NewPage:=True:C214
								Else 
									//There is enough room, print the town name.
									vTwnName:=[BridgeMHDNBISArchive:139]Town Name:174
									$PixPrint_L:=Print form:C5([BridgeMHDNBISArchive:139]; $printForm_txt; Form header2:K43:5)
									$PixCount:=$PixCount+$PixH1
								End if 
							End if 
						End if 
						
						If ($NewPage)
							//Print the headers and the record.
							vCurrPage:=vCurrPage+1
							$PixPrint_L:=Print form:C5([BridgeMHDNBISArchive:139]; $printForm_txt; Form header1:K43:4)
							If ([BridgeMHDNBISArchive:139]Town Name:174=$PreviousTwn)
								vTwnName:=[BridgeMHDNBISArchive:139]Town Name:174+" (Continued)"
							Else 
								vTwnName:=[BridgeMHDNBISArchive:139]Town Name:174
							End if 
							$PixPrint_L:=Print form:C5([BridgeMHDNBISArchive:139]; $printForm_txt; Form header2:K43:5)
							$PixPrint_L:=Print form:C5([BridgeMHDNBISArchive:139]; $printForm_txt)
							$PixCount:=$PixH0+$PixH1+$PixD
							$NewPage:=False:C215
						Else 
							//Print just the record.
							$PixPrint_L:=Print form:C5([BridgeMHDNBISArchive:139]; $printForm_txt)
							$PixCount:=$PixCount+$PixD
						End if 
						
						$PreviousTwn:=[BridgeMHDNBISArchive:139]Town Name:174
						If (($j=$recs) | (($PixCount+$PixD+$PixF)>$PixPage))
							//Either this is the last record or there is no more room, so finish this page.
							$PixPrint_L:=Print form:C5([BridgeMHDNBISArchive:139]; $printForm_txt; Form break0:K43:14)
							PAGE BREAK:C6(>)
							$NewPage:=True:C214
						End if 
						If (4DERROR_B)
							//Some error during printing - maybe user aborted
							// skip all - RPCs
							$j:=$recs+1
							$i:=$NoRPCs+1
							
						End if 
						ON ERR CALL:C155("")
						
					End if 
					
					If (ckWriteDocs=1)
						$text:=[BridgeMHDNBISArchive:139]Town Name:174+<>sTab+[BridgeMHDNBISArchive:139]BDEPT:1+<>sTab+[BridgeMHDNBISArchive:139]BIN:3+<>sTab+[BridgeMHDNBISArchive:139]Item8:203
						$text:=$text+<>sTab+[BridgeMHDNBISArchive:139]Item7:64+<>sTab+[BridgeMHDNBISArchive:139]Item6A:62
						$text:=$text+<>sTab+[BridgeMHDNBISArchive:139]Item22:127+<>sTab+GetOwnerTrans([BridgeMHDNBISArchive:139]Item22:127)+<>sTab+HistoricalTrans([BridgeMHDNBISArchive:139]Item37:128)
						$text:=$text+<>sTab+[BridgeMHDNBISArchive:139]Item26:119+<>sTab+GetFCTrans([BridgeMHDNBISArchive:139]Item26:119)
						$text:=$text+<>sTab+String:C10([BridgeMHDNBISArchive:139]Item27:82; "####;?;?")+<>sTab+String:C10([BridgeMHDNBISArchive:139]Item106:83; "####;;")
						$text:=$text+<>sTab+String:C10([BridgeMHDNBISArchive:139]AASHTO:5; "##0.0")+<>sTab+GetDeficTrans([BridgeMHDNBISArchive:139]StructDef:102; [BridgeMHDNBISArchive:139]FunctObs:105)
						If ($FedAidReport_b)
							$text:=$text+<>sTab+f_Boolean2String([BridgeMHDNBISArchive:139]FHWA Select:4; "Y")
						End if 
						$text:=$text+<>sCR+<>sLF
						SEND PACKET:C103($dTextData; $text)
					End if 
					
					NEXT RECORD:C51([BridgeMHDNBISArchive:139])
					// increment overall record counter
					$totalj:=$totalj+1
					//Update progress bar
					If ($totalj%$Interval=0)
						//UpdateProgress ($totalj;$totalRecs)
						UpdateProgressNew($progressobj_o; $totalj)
						
					End if 
					//Check to see if we got an abort from the progress bar
					//If (<>Abort)
					//  // skip all - RPCs
					//$j:=$recs+1
					//$i:=$NoRPCs+1
					//End if 
					If (Progress Stopped(OB Get:C1224($progressobj_o; "progress")))
						//abort loop
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
			//CALL PROCESS(<>ProgressPID)
			Progress QUIT(OB Get:C1224($progressobj_o; "progress"))
			
		End if 
		
	End if 
End if 