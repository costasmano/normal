//%attributes = {"invisible":true}
// Method: ARCH_M_MasterList
// Description
// Run Master List report from [BridgeMHDNBISArchive] table
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/18/11, 12:47:28
	// ----------------------------------------------------
	// First Release
	Mods_2011_10
	// Modified by: Costas Manousakis-(Designer)-(5/13/14 10:39:40)
	Mods_2014_05_bug
	//  `Adjusted  logic to allow running report if reason and date are not unique in the selection
	// Modified by: Costas Manousakis-(Designer)-(5/10/16 16:46:06)
	Mods_2016_05_bug
	//  `use only form [BridgeMHDNBISArchive];"Rpt Mstr" for all parts of the report
	// Modified by: Costas Manousakis-(Designer)-(2024-01-02 19:08:22)
	Mods_2024_01
	//  `added optional object parameter. when it is passed, indicates that a combined master list is being produced
	//  ` attributes .title : title for the report (input).
	//  ` attributes .pagecount : number of pages printed (output).
	
	C_OBJECT:C1216(ARCH_M_MasterList; $1)
	
End if 

C_LONGINT:C283($j; $recs; $pages; vCurrPage; vRptPages)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($PixPage; $PixH0; $PixH1; $PixD; $PixF; $PixCount)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($text)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($PreviousTwn)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284(vTwnName)  // Command Replaced was o_C_STRING length was 45
C_TEXT:C284(vRptHeader)
C_DATE:C307(vRptDate)
C_TIME:C306(vRptTime)
C_BOOLEAN:C305($NewPage)

$PixPage:=551
$PixH0:=61
$PixH1:=10
$PixD:=8
$PixF:=3

C_BOOLEAN:C305($combined_)

If (Count parameters:C259>0)
	C_OBJECT:C1216($1)
	vRptHeader:=$1.title
	$combined_:=True:C214
End if 

//TRACE
//ALERT("This report is not fully operational.  Hit cancel at the next dialog.")

$recs:=Records in selection:C76([BridgeMHDNBISArchive:139])
ARRAY TEXT:C222($archReasons_atxt; 0)
ARRAY DATE:C224($archDates_ad; 0)
DISTINCT VALUES:C339([BridgeMHDNBISArchive:139]ArchiveReason_s:223; $archReasons_atxt)
DISTINCT VALUES:C339([BridgeMHDNBISArchive:139]ArchiveDate_d:224; $archDates_ad)

If ($recs<=0)
	ALERT:C41("Please select some records before running this report.")
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
		
		If (Not:C34($combined_))
			vRptHeader:=Request:C163("Please enter a title for this report:"; "Master List")
			$pages:=Int:C8($recs/55)+1
			If ($recs=1)
				$text:="Print a Master List for one bridge?"
			Else 
				$text:="Print a Master List of "+String:C10($recs)+" bridges"
				If ($pages<=1)
					$text:=$text+" (about one page)?"
				Else 
					$text:=$text+" (about "+String:C10($pages)+" pages)?"
				End if 
			End if 
			$text:=$text+<>sCR+"If OK, select landscape."
			CONFIRM:C162($text)
			
		End if 
		
		If (OK=1)
			//  testing page setup
			If (Not:C34($combined_))
				
				SET PRINT OPTION:C733(Orientation option:K47:2; 2)  //Landscape
				SET PRINT OPTION:C733(Paper option:K47:1; "Letter")
				SET PRINT OPTION:C733(Scale option:K47:3; 100)
				PRINT SETTINGS:C106
				
			End if 
			If (OK=1)
				$recs:=Records in selection:C76([BridgeMHDNBISArchive:139])
				vRptHeader:=<>sCR+vRptHeader+<>sCR+"Number of Bridges:  "+String:C10($recs)
				vRptDate:=Current date:C33(*)
				vRptTime:=Current time:C178(*)
				ORDER BY:C49([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]Town Name:174; [BridgeMHDNBISArchive:139]BDEPT:1; [BridgeMHDNBISArchive:139]Item8:203)
				
				$NewPage:=True:C214
				$PixCount:=0
				vCurrPage:=0
				$PreviousTwn:=""
				For ($j; 1; $recs)
					
					vTwnName:=[BridgeMHDNBISArchive:139]Town Name:174+" - District "+String:C10(Num:C11([BridgeMHDNBISArchive:139]Item2:59))
					
					If (Not:C34($NewPage))
						If ([BridgeMHDNBISArchive:139]Town Name:174#$PreviousTwn)
							//The town has changed.
							//Check if the town name and one record will fit on this page.
							If (($PixCount+$PixH1+$PixD+$PixF)>$PixPage)
								//There is not enough room to print.              
								Print form:C5([BridgeMHDNBISArchive:139]; "Rpt Mstr"; Form footer:K43:2)
								PAGE BREAK:C6(>)
								$NewPage:=True:C214
							Else 
								//There is enough room, print the town name.
								Print form:C5([BridgeMHDNBISArchive:139]; "Rpt Mstr"; Form header1:K43:4)
								//Print form([Bridge MHD NBIS];"Rpt RPC Header1")
								$PixCount:=$PixCount+$PixH1
							End if 
						End if 
					End if 
					
					If ($NewPage)
						//Print the headers and the record.
						vCurrPage:=vCurrPage+1
						Print form:C5([BridgeMHDNBISArchive:139]; "Rpt Mstr"; Form header:K43:3)
						If ([BridgeMHDNBISArchive:139]Town Name:174=$PreviousTwn)
							vTwnName:=vTwnName+" (Continued)"
						End if 
						Print form:C5([BridgeMHDNBISArchive:139]; "Rpt Mstr"; Form header1:K43:4)
						//Print form([Bridge MHD NBIS];"Rpt RPC Header1")
						Print form:C5([BridgeMHDNBISArchive:139]; "Rpt Mstr"; Form detail:K43:1)
						$PixCount:=$PixH0+$PixH1+$PixD
						$NewPage:=False:C215
					Else 
						//Print just the record.
						Print form:C5([BridgeMHDNBISArchive:139]; "Rpt Mstr"; Form detail:K43:1)
						$PixCount:=$PixCount+$PixD
					End if 
					
					$PreviousTwn:=[BridgeMHDNBISArchive:139]Town Name:174
					If (($j=$recs) | (($PixCount+$PixD+$PixF)>$PixPage))
						//Either this is the last record or there is no more room, so finish this page.
						Print form:C5([BridgeMHDNBISArchive:139]; "Rpt Mstr"; Form footer:K43:2)
						If ($j=$recs)
							If (Not:C34($combined_))
								PAGE BREAK:C6  //if last record - end
							End if 
						Else 
							PAGE BREAK:C6(>)  //else keep print job as one.
						End if 
						
						$NewPage:=True:C214
					End if 
					
					NEXT RECORD:C51([BridgeMHDNBISArchive:139])
				End for 
				//PAGE BREAK
				$1.pagecount:=vCurrPage
			End if 
		End if 
	End if 
End if 