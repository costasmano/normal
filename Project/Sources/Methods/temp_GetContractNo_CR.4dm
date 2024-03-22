//%attributes = {"invisible":true}
//* Contract No is linked to
//1. contract type
//2. consultant
//3. indirect cost/overhead rate
//4. net fee rate

ALL RECORDS:C47([Conslt Rating:63])
DISTINCT VALUES:C339([Conslt Rating:63]ContractNoRat:14; $asContractNo)

C_LONGINT:C283($j)  //Command Replaced was o_C_INTEGER
C_TIME:C306($vhDocRef)

$vhDocRef:=Create document:C266("")

SEND PACKET:C103($vhDocRef; "Contract No"+<>sTab)
SEND PACKET:C103($vhDocRef; "Conntract Type"+<>sTab)
SEND PACKET:C103($vhDocRef; "Consultant"+<>sTab)
SEND PACKET:C103($vhDocRef; "ID"+<>sTab)
SEND PACKET:C103($vhDocRef; "Overhead Rate"+<>sTab+<>sCR)

For ($j; 1; Size of array:C274($asContractNo))
	If ($asContractNo{$j}#"")
		QUERY:C277([Conslt Rating:63]; [Conslt Rating:63]ContractNoRat:14=$asContractNo{$j})
		SEND PACKET:C103($vhDocRef; $asContractNo{$j}+<>sTab)
		SEND PACKET:C103($vhDocRef; [Conslt Rating:63]ContractType:48+<>sTab)
		SEND PACKET:C103($vhDocRef; [Conslt Rating:63]AssignRatCons:5+<>sTab)
		SEND PACKET:C103($vhDocRef; String:C10([Conslt Rating:63]ConsltRatingID:42)+<>sTab)
		
		QUERY:C277([Conslt Rating Cost:74]; [Conslt Rating Cost:74]ConsltRatingID:1=[Conslt Rating:63]ConsltRatingID:42)
		SEND PACKET:C103($vhDocRef; String:C10([Conslt Rating Cost:74]OverheadRate:40)+<>sTab+<>sCR)
		
	End if 
End for 

CLOSE DOCUMENT:C267($vhDocRef)


