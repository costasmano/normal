//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_ConvertToDOTBridges
// User name (OS): charlesmiller
// Date and time: 10/15/09, 13:55:44
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_10  //r002 CJ Miller`10/15/09, 13:55:45   `Write code to convert to DOT bridges
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
READ ONLY:C145(*)
C_LONGINT:C283($Loop_l)
C_TIME:C306($Doc)
READ WRITE:C146([Bridge MHD NBIS:1])
READ WRITE:C146([Activity Log:59])
ARRAY TEXT:C222($Report_atxt; 0)
ARRAY TEXT:C222($Report_atxt; 20)
C_LONGINT:C283($ReportSize_l)
$ReportSize_l:=1
//Part 1 convert  [Bridge MHD NBIS]Item8 Owner = MHD or [Bridge MHD NBIS]Item8 Owner =MTA to 
// [Bridge MHD NBIS]Item8 Owner = DOT
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Item8 Owner:208="MHD"; *)
QUERY:C277([Bridge MHD NBIS:1];  | ; [Bridge MHD NBIS:1]Item8 Owner:208="MTA"; *)
QUERY:C277([Bridge MHD NBIS:1];  | ; [Bridge MHD NBIS:1]Item8 Owner:208="MHS"; *)
QUERY:C277([Bridge MHD NBIS:1];  | ; [Bridge MHD NBIS:1]Item8 Owner:208="CAN")
QUERY SELECTION:C341([Bridge MHD NBIS:1])
FIRST RECORD:C50([Bridge MHD NBIS:1])
ARRAY POINTER:C280(ptr_Changes; 0; 0)
InitChangeStack(1)
ALERT:C41("Converting "+String:C10(Records in selection:C76([Bridge MHD NBIS:1]))+" records!")
For ($Loop_l; 1; Records in selection:C76([Bridge MHD NBIS:1]))
	//START TRANSACTION
	
	If (ut_LoadRecord(->[Bridge MHD NBIS:1]))
		
		[Bridge MHD NBIS:1]LegacyOwner:226:=[Bridge MHD NBIS:1]Item8 Owner:208
		
		Case of 
			: ([Bridge MHD NBIS:1]Item8 Owner:208="MHD")
				
			: (([Bridge MHD NBIS:1]Item8 Owner:208="MTA") | ([Bridge MHD NBIS:1]Item8 Owner:208="MHS") | ([Bridge MHD NBIS:1]Item8 Owner:208="CAN"))
				[Bridge MHD NBIS:1]Item21:127:="01"
				[Bridge MHD NBIS:1]Item22:128:="01"
				If (Not:C34(In transaction:C397))
					PushChange(1; ->[Bridge MHD NBIS:1]Item21:127)
					PushChange(1; ->[Bridge MHD NBIS:1]Item22:128)
				End if 
		End case 
		[Bridge MHD NBIS:1]Item8 Owner:208:="DOT"
		[Bridge MHD NBIS:1]Item8:206:=[Bridge MHD NBIS:1]BDEPT:1+[Bridge MHD NBIS:1]BIN:3+[Bridge MHD NBIS:1]Item8 Owner:208+[Bridge MHD NBIS:1]Item8 BridgeCat:207
		If (Not:C34(In transaction:C397))
			PushChange(1; ->[Bridge MHD NBIS:1]Item8 Owner:208)
			PushChange(1; ->[Bridge MHD NBIS:1]Item8:206)
			PushChange(1; ->[Bridge MHD NBIS:1]LegacyOwner:226)
			FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
		End if 
		If (Length:C16($Report_atxt{$ReportSize_l})>25000)
			$ReportSize_l:=$ReportSize_l+1
			If ($ReportSize_l>Size of array:C274($Report_atxt))
				APPEND TO ARRAY:C911($Report_atxt; "")
			End if 
		End if 
		$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+[Bridge MHD NBIS:1]BIN:3+Char:C90(Tab:K15:37)
		$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+Old:C35([Bridge MHD NBIS:1]Item8 Owner:208)+Char:C90(Tab:K15:37)
		$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+[Bridge MHD NBIS:1]Item8 Owner:208+Char:C90(Tab:K15:37)
		$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+Old:C35([Bridge MHD NBIS:1]Item8:206)+Char:C90(Tab:K15:37)
		$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+[Bridge MHD NBIS:1]Item8:206+Char:C90(Tab:K15:37)
		$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+Old:C35([Bridge MHD NBIS:1]Item21:127)+Char:C90(Tab:K15:37)
		$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+[Bridge MHD NBIS:1]Item21:127+Char:C90(Tab:K15:37)
		$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+Old:C35([Bridge MHD NBIS:1]Item22:128)+Char:C90(Tab:K15:37)
		$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+[Bridge MHD NBIS:1]Item22:128+Char:C90(Tab:K15:37)
		$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+Old:C35([Bridge MHD NBIS:1]LegacyOwner:226)+Char:C90(Tab:K15:37)
		$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+[Bridge MHD NBIS:1]LegacyOwner:226+Char:C90(Carriage return:K15:38)
		
		SAVE RECORD:C53([Bridge MHD NBIS:1])
		
		NEXT RECORD:C51([Bridge MHD NBIS:1])
	End if 
	//CANCEL TRANSACTION
End for 
UNLOAD RECORD:C212([Bridge MHD NBIS:1])

//OK lets get import of bridges
ALERT:C41("Select document to be used as a basis to update to DOT")

$Doc:=Open document:C264("")
If (OK=1)
	ARRAY TEXT:C222($Query_as; 0)  //Command Replaced was o_ARRAY string length was 3
	C_TEXT:C284($Input_txt)
	
	Repeat 
		RECEIVE PACKET:C104($Doc; $Input_txt; 32000)
		ut_TextToArray($Input_txt; ->$Query_as; Char:C90(Carriage return:K15:38))
	Until (OK=0)
	CLOSE DOCUMENT:C267($doc)
	QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BIN:3; $Query_as)
	C_BOOLEAN:C305($Proceed_b)
	$Proceed_b:=True:C214
	If (Records in selection:C76([Bridge MHD NBIS:1])=Size of array:C274($Query_as))
	Else 
		
		CONFIRM:C162("There are "+String:C10(Records in selection:C76([Bridge MHD NBIS:1]))+" records found for an array sized "+String:C10(Size of array:C274($Query_as)); "Proceed"; "Skip")
		If (OK=1)
		Else 
			$Proceed_b:=False:C215
			
		End if 
		
	End if 
	C_LONGINT:C283($Loc_l)
	If ($Proceed_b)
		FIRST RECORD:C50([Bridge MHD NBIS:1])
		For ($Loop_l; 1; Records in selection:C76([Bridge MHD NBIS:1]))
			//START TRANSACTION
			
			If (ut_LoadRecord(->[Bridge MHD NBIS:1]))
				$Loc_l:=Find in array:C230($Query_as; [Bridge MHD NBIS:1]BIN:3)
				DELETE FROM ARRAY:C228($Query_as; $Loc_l; 1)
				
				[Bridge MHD NBIS:1]LegacyOwner:226:=[Bridge MHD NBIS:1]Item8 Owner:208
				[Bridge MHD NBIS:1]Item8 Owner:208:="DOT"
				[Bridge MHD NBIS:1]Item8:206:=[Bridge MHD NBIS:1]BDEPT:1+[Bridge MHD NBIS:1]BIN:3+[Bridge MHD NBIS:1]Item8 Owner:208+[Bridge MHD NBIS:1]Item8 BridgeCat:207
				[Bridge MHD NBIS:1]Item21:127:="01"
				[Bridge MHD NBIS:1]Item22:128:="01"
				If (Not:C34(In transaction:C397))
					PushChange(1; ->[Bridge MHD NBIS:1]Item8 Owner:208)
					PushChange(1; ->[Bridge MHD NBIS:1]Item8:206)
					PushChange(1; ->[Bridge MHD NBIS:1]Item21:127)
					PushChange(1; ->[Bridge MHD NBIS:1]Item22:128)
					PushChange(1; ->[Bridge MHD NBIS:1]LegacyOwner:226)
					FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
				End if 
				If (Length:C16($Report_atxt{$ReportSize_l})>25000)
					$ReportSize_l:=$ReportSize_l+1
					If ($ReportSize_l>Size of array:C274($Report_atxt))
						APPEND TO ARRAY:C911($Report_atxt; "")
					End if 
				End if 
				$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+[Bridge MHD NBIS:1]BIN:3+Char:C90(Tab:K15:37)
				$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+Old:C35([Bridge MHD NBIS:1]Item8 Owner:208)+Char:C90(Tab:K15:37)
				$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+[Bridge MHD NBIS:1]Item8 Owner:208+Char:C90(Tab:K15:37)
				$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+Old:C35([Bridge MHD NBIS:1]Item8:206)+Char:C90(Tab:K15:37)
				$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+[Bridge MHD NBIS:1]Item8:206+Char:C90(Tab:K15:37)
				$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+Old:C35([Bridge MHD NBIS:1]Item21:127)+Char:C90(Tab:K15:37)
				$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+[Bridge MHD NBIS:1]Item21:127+Char:C90(Tab:K15:37)
				$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+Old:C35([Bridge MHD NBIS:1]Item22:128)+Char:C90(Tab:K15:37)
				$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+[Bridge MHD NBIS:1]Item22:128+Char:C90(Tab:K15:37)
				$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+Old:C35([Bridge MHD NBIS:1]LegacyOwner:226)+Char:C90(Tab:K15:37)
				$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+[Bridge MHD NBIS:1]LegacyOwner:226+Char:C90(Carriage return:K15:38)
				SAVE RECORD:C53([Bridge MHD NBIS:1])
				NEXT RECORD:C51([Bridge MHD NBIS:1])
			End if 
			//CANCEL TRANSACTION
		End for 
		If (Size of array:C274($Query_as)>0)
			$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)+"Begin report of  MIssing BINS"+Char:C90(Carriage return:K15:38)
			C_TEXT:C284($MissingBins_txt)
			$MissingBins_txt:=""
			For ($Loop_l; 1; Size of array:C274($Query_as))
				Case of 
					: ($Loop_l>1)
						$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+$Query_as{$Loop_l}
					Else 
						$Report_atxt{$ReportSize_l}:=$Report_atxt{$ReportSize_l}+Char:C90(Carriage return:K15:38)+$Query_as{$Loop_l}
				End case 
				If (Length:C16($Report_atxt{$ReportSize_l})>25000)
					$ReportSize_l:=$ReportSize_l+1
					If ($ReportSize_l>Size of array:C274($Report_atxt))
						APPEND TO ARRAY:C911($Report_atxt; "")
					End if 
				End if 
				
			End for 
		End if 
	End if 
	
End if 

READ ONLY:C145(*)
//CANCEL TRANSACTION
$Doc:=Create document:C266("")
If (OK=1)
	
	SEND PACKET:C103($Doc; "BIN"+Char:C90(Tab:K15:37)+"OLD Item8 Owner"+Char:C90(Tab:K15:37)+"Item8 Owner"+Char:C90(Tab:K15:37)+"OLD Item8"+Char:C90(Tab:K15:37)+"Item8"+Char:C90(Tab:K15:37)+"OLD Item21"+Char:C90(Tab:K15:37)+"Item21"+Char:C90(Tab:K15:37)+"OLD Item22"+Char:C90(Tab:K15:37)+"Item22"+Char:C90(Tab:K15:37)+"OLD Legacy"+Char:C90(Tab:K15:37)+"Legacy"+Char:C90(Carriage return:K15:38))
	For ($Loop_l; 1; Size of array:C274($Report_atxt))
		SEND PACKET:C103($Doc; $Report_atxt{$Loop_l})
		
		
	End for 
	CLOSE DOCUMENT:C267($Doc)
	
End if 

//End ut_ConvertToDOTBridges