If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(4/17/2007 15:15:55)
	Mods_2007_CM07
	// Modified by: Costas Manousakis-(Designer)-(5/15/18 10:12:45)
	Mods_2018_05
	//  `made fields not enterable
	// Modified by: Costas Manousakis-(Designer)-(2021-09-27T00:00:00 16:19:02)
	Mods_2021_09
	//  `renamed form to Output_LB to change it from output form to listbox; added a listbox
	// Modified by: Costas Manousakis-(Designer)-(2022-11-28 11:48:37)
	Mods_2022_11
	//  `Uncheck the 'Hide blank lines' property of the listbox under Background and Border
End if 

Case of 
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
	: (Form event code:C388=On Load:K2:1)
		ORDER BY:C49([Parameters:107]; [Parameters:107]ParamCode:1; >)
		If (Type:C295(ptr_Changes)#Array 2D:K8:24)
			ARRAY POINTER:C280(ptr_Changes; 0; 0)
		End if 
		
		
End case 
