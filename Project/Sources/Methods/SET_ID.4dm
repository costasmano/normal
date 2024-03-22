//%attributes = {"invisible":true}
//GP SET_ID($SeqName;$ptr_id)
//© October 1995, Thomas D. Nee, All Rights Reserved.
//Accesses the [Sequences] file to set the next ID number.
//$1 - $SeqName:  name in sequence record.
//$2 - $ptr_id:  pointer to id field.

//A problem crops up if [Sequences] is not open for writing.

C_TEXT:C284($SeqName)  // Command Replaced was o_C_STRING length was 20
C_POINTER:C301($ptr_id)

$SeqName:=$1
$ptr_id:=$2
QUERY:C277([Sequences:28]; [Sequences:28]Name:1=$SeqName)

Case of 
	: ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Display Detail:K2:22))
		If ($ptr_id->=0)  //This is a new record, so increment sequence.
			If (Records in selection:C76([Sequences:28])=0)
				CREATE RECORD:C68([Sequences:28])  //This is the first time for this sequence.
				[Sequences:28]Name:1:=$SeqName
				[Sequences:28]Value:2:=0  //Starting number.
			End if 
			[Sequences:28]Increment:3:=True:C214  //but the increment won't be written until After.
			$ptr_id->:=[Sequences:28]Value:2+1
		Else   //This is an existing record; there will be no need to increment the sequence.
			[Sequences:28]Increment:3:=False:C215
		End if 
		SAVE RECORD:C53([Sequences:28])
		
	: (After:C31)
		//   If (Records in selection([Sequences])=0)
		//Error; it should have been created Before!      
		//    End if 
		If ([Sequences:28]Increment:3)
			[Sequences:28]Value:2:=$ptr_id->
			[Sequences:28]Increment:3:=False:C215  //Reset it for the next time.
			SAVE RECORD:C53([Sequences:28])
		End if 
End case 