//%attributes = {"invisible":true}
// MakeKey method
C_TEXT:C284($1)  // Command Replaced was o_C_STRING length was 80//Address
C_TEXT:C284($2; $3)  // Command Replaced was o_C_STRING length was 31//User and password
C_TEXT:C284($4)  // Command Replaced was o_C_STRING length was 3//Destination platform ('Mac' or 'PC')
C_LONGINT:C283($5)  //Command Replaced was o_C_INTEGER// Network component ID
C_BLOB:C604($BlobPath; $0)  // Blob that contains the result
C_LONGINT:C283($offset)  //Command Replaced was o_C_INTEGER
SET BLOB SIZE:C606($BlobPath; 148)
$offset:=0
TEXT TO BLOB:C554($1; $BlobPath; Mac Pascal string:K22:8; $offset)
$offset:=82
TEXT TO BLOB:C554($2; $BlobPath; Mac Pascal string:K22:8; $offset)
$offset:=114
TEXT TO BLOB:C554($3; $BlobPath; Mac Pascal string:K22:8; $offset)
$offset:=146
If ($4="Mac")
	INTEGER TO BLOB:C548($5; $BlobPath; Macintosh byte ordering:K22:2; $offset)
Else 
	INTEGER TO BLOB:C548($5; $BlobPath; PC byte ordering:K22:3; $offset)
End if 
$0:=$BlobPath