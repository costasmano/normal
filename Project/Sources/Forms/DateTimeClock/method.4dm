//Method: "DateTimeClock"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/14/17, 15:51:20
	// ----------------------------------------------------
	//Created : 
	Mods_2017_03
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		WA OPEN URL:C1020(*; "Web Area"; "about:blank")
		C_TEXT:C284($html_txt)
		$html_txt:=""
		$html_txt:=$html_txt+"<html>"
		$html_txt:=$html_txt+"<body>"
		$html_txt:=$html_txt+"<span style=\"font-family:Arial; font-size:14px\">Time in Boston MA : </span>"
		$html_txt:=$html_txt+"<iframe src=\"http://free.timeanddate.com/clock/i625yglm/n43/tt0/tw0/tm3/td2/th1/tb2\" frameborder=\"0\" width=\"254\" height=\"15\"></iframe>"
		$html_txt:=$html_txt+"</body>"
		$html_txt:=$html_txt+"</html>"
		OBJECT SET TITLE:C194(*; "Text"; "Your Computer Date and time : "+String:C10(Current date:C33(*); Internal date short:K1:7)+" "+String:C10(Current time:C178(*)))
		WA SET PAGE CONTENT:C1037(*; "Web Area"; $html_txt; "about:blank")
		WA REFRESH CURRENT URL:C1023(*; "Web Area")
		SET TIMER:C645(1*60)
	: (Form event code:C388=On Validate:K2:3)
		
	: (Form event code:C388=On Timer:K2:25)
		OBJECT SET TITLE:C194(*; "Text"; "Your Computer Date and time : "+String:C10(Current date:C33(*); Internal date short:K1:7)+" "+String:C10(Current time:C178(*)))
		
		
End case 

//End DateTimeClock