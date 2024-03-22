If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(5/17/2007 10:40:50)
	Mods_2007_CM10
	// Modified by: costasmanousakis-(Designer)-(9/18/2007 16:54:50)
	Mods_2007_CM12_5301  //include searching for blanks
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (Self:C308->>0)
			C_TEXT:C284($FlagColor_s)  // Command Replaced was o_C_STRING length was 20
			C_LONGINT:C283($selected_L)
			$selected_L:=Self:C308->
			$FlagColor_s:=Self:C308->{$selected_L}
			SET QUERY DESTINATION:C396(Into set:K19:2; "CRTG_FlagSrchRecsSet")
			QUERY:C277([Conslt Rating:63]; [Conslt Rating:63]PriorityColorFlag:3=$FlagColor_s)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If (Records in set:C195("CRTG_FlagSrchRecsSet")>0)
				OBJECT SET RGB COLORS:C628(*; "@BackGroundRect@"; Col_paletteToRGB(Abs:C99(-(White:K11:1+(256*White:K11:1)))%256); Col_paletteToRGB(Abs:C99(-(White:K11:1+(256*White:K11:1)))\256))  // **Replaced o OBJECT SET COLOR(*; "@BackGroundRect@"; -(White+(256*White)))
				REDRAW WINDOW:C456
				USE SET:C118("CRTG_FlagSrchRecsSet")
				ORDER BY:C49([Conslt Rating:63]; [Bridge MHD NBIS:1]BDEPT:1; >)
				RegionTitle
			Else 
				ALERT:C41("No Records found with Color Flag :"+$FlagColor_s)
			End if 
			CLEAR SET:C117("CRTG_FlagSrchRecsSet")
			Self:C308->:=1
			
		End if 
		
	: (Form event code:C388=On Load:K2:1)
		If ((User in group:C338(Current user:C182; "Bridge Insp Engineer")) | (Current user:C182="Designer"))
			OBJECT SET VISIBLE:C603(*; "PrioFlagSrch_@"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "PrioFlagSrch_@"; False:C215)
		End if 
		
End case 
