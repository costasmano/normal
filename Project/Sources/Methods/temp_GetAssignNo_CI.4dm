//%attributes = {"invisible":true}
//* Assignment no is linked to
//1. req for fee proposal date
//2. NTP date - verbal and written

ALL RECORDS:C47([Cons Inspection:64])
DISTINCT VALUES:C339([Cons Inspection:64]ConContractNo:7; $asContractNo)

ARRAY TEXT:C222($asContractType; Size of array:C274($asContractNo))  //Command Replaced was o_ARRAY string length was 50
ARRAY TEXT:C222($asConsultant; Size of array:C274($asContractNo))  //Command Replaced was o_ARRAY string length was 100
ARRAY INTEGER:C220($asAssignNo; 50)

C_LONGINT:C283($i; $j; $k)  //Command Replaced was o_C_INTEGER
C_TIME:C306($vhDocRef)
C_DATE:C307($reqFee; $NTP; $NTPverbal)

$vhDocRef:=Create document:C266("")

SEND PACKET:C103($vhDocRef; "Contract No"+<>sTab)
SEND PACKET:C103($vhDocRef; "Assign No"+<>sTab)
SEND PACKET:C103($vhDocRef; "ReqFeeProposal Date"+<>sTab)
SEND PACKET:C103($vhDocRef; "NTP Verbal"+<>sTab)
SEND PACKET:C103($vhDocRef; "NTP Written Rate"+<>sTab+<>sCR)

For ($j; 1; Size of array:C274($asContractNo))
	If ($asContractNo{$j}#"")
		QUERY:C277([Cons Inspection:64]; [Cons Inspection:64]ConContractNo:7=$asContractNo{$j})
		DISTINCT VALUES:C339([Cons Inspection:64]AssignConNumber:6; $asAssignNo)
		
		For ($i; 1; Size of array:C274($asAssignNo))
			QUERY:C277([Cons Inspection:64]; [Cons Inspection:64]ConContractNo:7=$asContractNo{$j}; *)
			QUERY:C277([Cons Inspection:64];  & ; [Cons Inspection:64]AssignConNumber:6=$asAssignNo{$i})
			For ($k; 1; Records in selection:C76([Cons Inspection:64]))
				If (Not:C34([Cons Inspection:64]ReqFeeProposal:25=!00-00-00!))
					$reqFee:=[Cons Inspection:64]ReqFeeProposal:25
				End if 
				If (Not:C34([Cons Inspection:64]ProceedConDate:8=!00-00-00!))
					$NTP:=[Cons Inspection:64]ProceedConDate:8
				End if 
				If (Not:C34([Cons Inspection:64]NTPdate_verbal:35=!00-00-00!))
					$NTPverbal:=[Cons Inspection:64]NTPdate_verbal:35
				End if 
			End for 
			
			SEND PACKET:C103($vhDocRef; $asContractNo{$j}+<>sTab)
			SEND PACKET:C103($vhDocRef; String:C10($asAssignNo{$i})+<>sTab)
			SEND PACKET:C103($vhDocRef; String:C10($reqFee)+<>sTab)
			SEND PACKET:C103($vhDocRef; String:C10($NTP)+<>sTab)
			SEND PACKET:C103($vhDocRef; String:C10($NTPverbal)+<>sTab+<>sCR)
			$reqFee:=Date:C102("00/00/00")
			$NTP:=Date:C102("00/00/00")
			$NTPverbal:=Date:C102("00/00/00")
		End for 
		
	End if 
End for 

CLOSE DOCUMENT:C267($vhDocRef)