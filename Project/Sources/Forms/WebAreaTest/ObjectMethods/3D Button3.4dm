C_POINTER:C301($area)
$area:=OBJECT Get pointer:C1124(Object named:K67:5; "web area")

C_TEXT:C284($pdffile)
ARRAY TEXT:C222($pdffiles_atxt; 0)
$pdffile:=Select document:C905(""; ".pdf"; "Select a pdf file"; 0; $pdffiles_atxt)
If (OK=1)
	C_TEXT:C284($file_txt)
	CONFIRM:C162("convert to posix or keep system format?"; "posix"; "system")
	
	If (OK=1)
		
		$file_txt:=Convert path system to POSIX:C1106($pdffiles_atxt{1})
		Web Area_url:="file:///"+$file_txt
		WA REFRESH CURRENT URL:C1023(*; "Web area")
		
	Else 
		WA OPEN URL:C1020(*; "Web area"; $pdffiles_atxt{1})
		//Web Area_url:="file:///"+$pdffiles_atxt{1}
	End if 
	
End if 

