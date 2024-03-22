//%attributes = {"invisible":true}
//* Contract No is linked to
//1. contract type
//2. consultant
//3. indirect cost/overhead rate
//4. net fee rate

ALL RECORDS:C47([Cons Inspection:64])
DISTINCT VALUES:C339([Cons Inspection:64]ConContractNo:7; $asContractNo)

C_LONGINT:C283($i; $j; $k)  //Command Replaced was o_C_INTEGER
C_TIME:C306($vhDocRef)
C_TEXT:C284($contractType; $consltName)  // Command Replaced was o_C_STRING length was 100
C_REAL:C285($overheadRate)

$vhDocRef:=Create document:C266("")

SEND PACKET:C103($vhDocRef; "Contract No"+<>sTab)
SEND PACKET:C103($vhDocRef; "Conntract Type"+<>sTab)
SEND PACKET:C103($vhDocRef; "Consultant"+<>sTab)
SEND PACKET:C103($vhDocRef; "Overhead Rate"+<>sCR)

For ($j; 1; Size of array:C274($asContractNo))
	If ($asContractNo{$j}#"")
		QUERY:C277([Cons Inspection:64]; [Cons Inspection:64]ConContractNo:7=$asContractNo{$j})
		
		For ($k; 1; Records in selection:C76([Cons Inspection:64]))
			If (Not:C34([Cons Inspection:64]ContractType:36=""))
				$contractType:=[Cons Inspection:64]ContractType:36
			End if 
			
			If (Not:C34([Cons Inspection:64]AssignConName:5=""))
				$consltName:=[Cons Inspection:64]AssignConName:5
			End if 
			
			QUERY:C277([Conslt Rating Cost:74]; [Conslt Rating Cost:74]ConsltRatingID:1=[Cons Inspection:64]ConsInspectionID:32)
			If (Not:C34([Conslt Rating Cost:74]OverheadRate:40=0))
				$overheadRate:=[Conslt Rating Cost:74]OverheadRate:40
			End if 
		End for 
		
		SEND PACKET:C103($vhDocRef; $asContractNo{$j}+<>sTab)
		SEND PACKET:C103($vhDocRef; $contractType+<>sTab)
		SEND PACKET:C103($vhDocRef; $consltName+<>sTab)
		SEND PACKET:C103($vhDocRef; String:C10($overheadRate)+<>sCR)
		$contractType:=""
		$consltName:=""
		$overheadRate:=0
	End if 
End for 

CLOSE DOCUMENT:C267($vhDocRef)


