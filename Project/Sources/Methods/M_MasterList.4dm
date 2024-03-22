//%attributes = {"invisible":true}
If (False:C215)
	//GP M_MasterList
	//1998 Thomas D. Nee
	
	//Use the current selection and print a Master List report.
	
	//This version uses Print Layout to completely control printing.
	
	Mods_2004_CM12
	Mods_2005_CM14
	// Modified by: costasmanousakis-(Designer)-(9/11/08 14:52:16)
	Mods_2008_CM_5404
	//Use Set Print Option commands instead of PageSetup
	// Modified by: Costas Manousakis-(Designer)-(5/21/13 09:49:47)
	Mods_2013_05
	//  `Added sorting at the end
	// Modified by: Costas Manousakis-(Designer)-(5/10/16 16:36:16)
	Mods_2016_05_bug
	//  `use only form [Bridge MHD NBIS];"Rpt Mstr" for printing all parts of the report
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

$recs:=Records in selection:C76([Bridge MHD NBIS:1])
If ($recs<=0)
	ALERT:C41("Please select some records before running this report.")
Else 
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
	
	If (OK=1)
		//  testing page setup
		SET PRINT OPTION:C733(Orientation option:K47:2; 2)  //Landscape
		SET PRINT OPTION:C733(Paper option:K47:1; "Letter")
		SET PRINT OPTION:C733(Scale option:K47:3; 100)
		PRINT SETTINGS:C106
		If (OK=1)
			$recs:=Records in selection:C76([Bridge MHD NBIS:1])
			vRptHeader:=<>sCR+vRptHeader+<>sCR+"Number of Bridges:  "+String:C10($recs)
			vRptDate:=Current date:C33(*)
			vRptTime:=Current time:C178(*)
			ORDER BY:C49([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Town Name:175; [Bridge MHD NBIS:1]BDEPT:1; [Bridge MHD NBIS:1]Item8:206)
			
			$NewPage:=True:C214
			$PixCount:=0
			vCurrPage:=0
			$PreviousTwn:=""
			For ($j; 1; $recs)
				
				vTwnName:=[Bridge MHD NBIS:1]Town Name:175+" - District "+String:C10(Num:C11([Bridge MHD NBIS:1]Item2:60))
				
				If (Not:C34($NewPage))
					If ([Bridge MHD NBIS:1]Town Name:175#$PreviousTwn)
						//The town has changed.
						//Check if the town name and one record will fit on this page.
						If (($PixCount+$PixH1+$PixD+$PixF)>$PixPage)
							//There is not enough room to print.              
							Print form:C5([Bridge MHD NBIS:1]; "Rpt Mstr"; Form footer:K43:2)
							PAGE BREAK:C6(>)
							$NewPage:=True:C214
						Else 
							//There is enough room, print the town name.
							Print form:C5([Bridge MHD NBIS:1]; "Rpt Mstr"; Form header1:K43:4)
							//Print form([Bridge MHD NBIS];"Rpt RPC Header1")
							$PixCount:=$PixCount+$PixH1
						End if 
					End if 
				End if 
				
				If ($NewPage)
					//Print the headers and the record.
					vCurrPage:=vCurrPage+1
					//Print form([Bridge MHD NBIS];"Rpt Mstr Hdr0")
					Print form:C5([Bridge MHD NBIS:1]; "Rpt Mstr"; Form header:K43:3)
					If ([Bridge MHD NBIS:1]Town Name:175=$PreviousTwn)
						vTwnName:=vTwnName+" (Continued)"
					End if 
					Print form:C5([Bridge MHD NBIS:1]; "Rpt Mstr"; Form header1:K43:4)
					//Print form([Bridge MHD NBIS];"Rpt RPC Header1")
					//Print form([Bridge MHD NBIS];"Rpt Mstr Detail")
					Print form:C5([Bridge MHD NBIS:1]; "Rpt Mstr"; Form detail:K43:1)
					$PixCount:=$PixH0+$PixH1+$PixD
					$NewPage:=False:C215
				Else 
					//Print just the record.
					//Print form([Bridge MHD NBIS];"Rpt Mstr Detail")
					Print form:C5([Bridge MHD NBIS:1]; "Rpt Mstr"; Form detail:K43:1)
					$PixCount:=$PixCount+$PixD
				End if 
				
				$PreviousTwn:=[Bridge MHD NBIS:1]Town Name:175
				If (($j=$recs) | (($PixCount+$PixD+$PixF)>$PixPage))
					//Either this is the last record or there is no more room, so finish this page.
					Print form:C5([Bridge MHD NBIS:1]; "Rpt Mstr"; Form footer:K43:2)
					If ($j=$recs)
						PAGE BREAK:C6  //if last record - end
					Else 
						PAGE BREAK:C6(>)  //else keep print job as one.
					End if 
					
					$NewPage:=True:C214
				End if 
				
				NEXT RECORD:C51([Bridge MHD NBIS:1])
			End for 
			//PAGE BREAK
			
			C_TEXT:C284(GEN_SORTLISTCMD_txt)
			
			If (GEN_SORTLISTCMD_txt#"")
				EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
			End if 
			
		End if 
	End if 
End if 