If (False:C215)
	//procedure: [ElementDict];"NewElement"
	//by: Albert Leung
	//created: 5/12/2001
	//modified:
	//purpose: populate drop down list
	//Copyright © 1995-2001,  Albert S. Leung, All Rights Reserved.
	//parameters:
	Mods_2016_09  //Change from FlushChanges to FlushGRPChanges
	//Modified by: Chuck Miller (9/1/16 12:59:42)
	
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		TimeStamp_ut(->[ElementDict:30]; ->[ElementDict:30]DateCreated:6; ->[ElementDict:30]TimeCreated:7; ->[ElementDict:30]DateModified:8; ->[ElementDict:30]TimeModified:9)
		InitChangeStack(1)
	: (Form event code:C388=On Unload:K2:2)
	: (Form event code:C388=On Validate:K2:3)
		LogNewRecord(->[ElementDict:30]ElementNo:1; ->[ElementDict:30]ElementNo:1; ->[ElementDict:30]ElementNo:1; 4; "ExtraElements")
		//Fix spacing of the description
		[ElementDict:30]Description:2:=" "+[ElementDict:30]Description:2
		LogChanges(->[ElementDict:30]Description:2; ->[ElementDict:30]ElementNo:1; ->[ElementDict:30]ElementNo:1; ->[ElementDict:30]ElementNo:1; 1)
		SAVE RECORD:C53([ElementDict:30])
		TimeStamp_ut(->[ElementDict:30]; ->[ElementDict:30]DateCreated:6; ->[ElementDict:30]TimeCreated:7; ->[ElementDict:30]DateModified:8; ->[ElementDict:30]TimeModified:9)
		[ElementDict:30]ModifiedBy:10:=Current user:C182
		//##Save changes made to file
		FlushGrpChgs(1; ->[ElementDict:30]ElementNo:1; ->[ElementDict:30]ElementNo:1; ->[ElementDict:30]ElementNo:1; 1)
		
		//Reconfigure the form
		//need to add this element to hList2....also
		AddElemtoHlist(->hList2; [ElementDict:30]ElementNo:1; [ElementDict:30]Description:2; New list:C375; True:C214)  // enter a new list as a blank sublist
		
		If (Is a list:C621(hList1))
			CLEAR LIST:C377(hList1; *)
		End if 
		Case of 
			: ([Inspections:27]Insp Type:6="RTN")
				hList1:=CreateElemDictHlist("N58"; "N59"; "N60"; "N61"; "APP"; "OVR"; "TRA")
			: ([Inspections:27]Insp Type:6="FCR")
				hList1:=CreateElemDictHlist("N58"; "N59"; "N60"; "N61"; "APP"; "OVR"; "TRA")
			: ([Inspections:27]Insp Type:6="CMI")
				hList1:=CreateElemDictHlist("N58"; "N59"; "N60"; "N61"; "APP"; "OVR"; "TRA")
			: ([Inspections:27]Insp Type:6="CUL")
				hList1:=CreateElemDictHlist("N61"; "N62"; "APP"; "OVR"; "TRA")
			: ([Inspections:27]Insp Type:6="CLD")
				hList1:=CreateElemDictHlist("APP"; "OVR"; "TRA")
			: ([Inspections:27]Insp Type:6="DAM")
				hList1:=CreateElemDictHlist("N58"; "N59"; "N60"; "N61"; "N62")
			: ([Inspections:27]Insp Type:6="DVE")
				hList1:=CreateElemDictHlist("N58"; "N59"; "N60"; "N61"; "N62")
		End case 
		
End case 