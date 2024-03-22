If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(12/11/18 10:02:39)
	Mods_2018_12_bug
	//  `added check to make sure other Personnel don't have the same 4D user ID
	
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		
		If ([Personnel:42]UserID_4D:12#0)
			C_LONGINT:C283($others_L; $curr4DUID_L; $currPID_L)
			$currPID_L:=[Personnel:42]Person ID:1
			$curr4DUID_L:=[Personnel:42]UserID_4D:12
			Begin SQL
				select count(*) from [Personnel]
				where [Personnel].[UserID_4D] = :$curr4DUID_L
				and [Personnel].[Person ID] <> :$currPID_L
				into :$others_L ;
				
			End SQL
			If ($others_L>0)
				ALERT:C41("There are other Personnel that have the same 4D User!")
				[Personnel:42]UserID_4D:12:=Old:C35([Personnel:42]UserID_4D:12)
			Else 
				PushChange(1; ->[Personnel:42]UserID_4D:12)
				
			End if 
		Else 
			PushChange(1; ->[Personnel:42]UserID_4D:12)
		End if 
		//update the hList
		SELECT LIST ITEMS BY REFERENCE:C630(PWUserHList; [Personnel:42]UserID_4D:12)
		C_TEXT:C284($ItemText)
		C_LONGINT:C283($ItemRef)
		GET LIST ITEM:C378(PWUserHList; Selected list items:C379(PWUserHList); $ItemRef; $ItemText)
		If ($ItemRef#[Personnel:42]UserID_4D:12)
			SELECT LIST ITEMS BY POSITION:C381(PWUserHList; 0)  //0 shows a blank list
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		
End case 