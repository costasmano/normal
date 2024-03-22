If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(1/11/2006 11:52:26)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(5/31/11 11:33:45)
	Mods_2011_05
	//  `Append a Char(0) at the end of the blob for the V11 bug
End if 

ARRAY TEXT:C222($arr_Bins_S; 0)  //Command Replaced was o_ARRAY string length was 3
If (Records in set:C195("UserSet")>0)
	COPY NAMED SELECTION:C331(Current form table:C627->; "ListPreCmdCopy")
	USE SET:C118("UserSet")
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $arr_Bins_S)
	USE NAMED SELECTION:C332("ListPreCmdCopy")
	CLEAR NAMED SELECTION:C333("ListPreCmdCopy")
	HIGHLIGHT RECORDS:C656("UserSet")
End if 
C_LONGINT:C283($numbins; $i)
$numbins:=Size of array:C274($arr_Bins_S)

If ($numbins>0)
	//ALERT("Copying BINS")
	CLEAR PASTEBOARD:C402
	C_BLOB:C604($ClipBlob)
	TEXT TO BLOB:C554($arr_Bins_S{1}; $ClipBlob; Mac text without length:K22:10; *)
	For ($i; 2; $numbins)
		TEXT TO BLOB:C554((","+$arr_Bins_S{$i}); $ClipBlob; Mac text without length:K22:10; *)
	End for 
	TEXT TO BLOB:C554(Char:C90(0); $ClipBlob; Mac text without length:K22:10; *)
	APPEND DATA TO PASTEBOARD:C403("TEXT"; $ClipBlob)
	If (OK=0)
		ALERT:C41("Unable to copy List of BINs to ClipBoard")
	End if 
	
	ARRAY TEXT:C222($arr_Bins_S; 0)  //Command Replaced was o_ARRAY string length was 3
	SET BLOB SIZE:C606($ClipBlob; 0)
End if 