C_TIME:C306($inpFile_T)
$inpFile_T:=Open document:C264(""; "TEXT"; Read mode:K24:5)
If (OK=1)
	SourceFile_txt:=Document
	CLOSE DOCUMENT:C267($inpFile_T)
Else 
	SourceFile_txt:=""
End if 