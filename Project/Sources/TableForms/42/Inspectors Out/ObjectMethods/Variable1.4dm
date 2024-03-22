If (False:C215)
	//Script: bzAdd
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Kent Wilbur
	//Date:  10/1/95
	
	//Purpose: 
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	Mods_2005_CM16
	
	//GP M_AddRecords hen disabled;
	
	// Modified by: costasmanousakis-(Designer)-(12/23/09 13:40:28)
	Mods_2009_12
	//Made this button visible only on 4D Client from the MHD BMS database
	//Unless the user has  Designer privileges
	// Modified by: Costas Manousakis-(Designer)-(5/17/13 09:11:09)
	Mods_2013_05
	//  `Use wildCard for structure file extension
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		If (User in group:C338(Current user:C182; "Design Access Group"))
		Else 
			If ((Application type:C494=4D Remote mode:K5:5) & (Structure file:C489="MHD BMS.@"))
			Else 
				OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
			End if 
			
		End if 
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		ADD RECORD:C56(pFile->)
		//Until (OK=0)  `Until the user clicks a Cancel button
		M_ShowAllRecs
		ORDER BY:C49([Personnel:42]; [Personnel:42]Last Name:5; >; [Personnel:42]First Name:3; >; [Personnel:42]Middle Name:4; >; [Personnel:42]Employer:9; >)
		
		WindowTitle
		//End of script
		
End case 

