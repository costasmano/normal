//%attributes = {"invisible":true}
If (False:C215)
	//G_FracCrit2BMS
	//Transfer FC Inspection data from [Inspections] table to [Bridge MHD NBIS]
	Mods_2018_10  //Add code and fields to allow for entry and reporting of single posting
	//Modified by: Chuck Miller (10/18/18 14:59:31)
End if 

[Bridge MHD NBIS:1]Item93A:169:=[Inspections:27]Insp Date:78
InitChangeStack(1)
PushChange(1; ->[Bridge MHD NBIS:1]Item93A:169)
If ([Bridge MHD NBIS:1]Item58:130#[Inspections:27]Item 58:79)
	[Bridge MHD NBIS:1]Item58:130:=[Inspections:27]Item 58:79
	PushChange(1; ->[Bridge MHD NBIS:1]Item58:130)
End if 
If ([Bridge MHD NBIS:1]Item59:131#[Inspections:27]Item 59:80)
	[Bridge MHD NBIS:1]Item59:131:=[Inspections:27]Item 59:80
	PushChange(1; ->[Bridge MHD NBIS:1]Item59:131)
End if 
If ([Bridge MHD NBIS:1]Item60:132#[Inspections:27]Item 60:81)
	[Bridge MHD NBIS:1]Item60:132:=[Inspections:27]Item 60:81
	PushChange(1; ->[Bridge MHD NBIS:1]Item60:132)
End if 

If ([Bridge MHD NBIS:1]Posting2Axle:9#[Inspections:27]ActualPostH:26)
	[Bridge MHD NBIS:1]Posting2Axle:9:=[Inspections:27]ActualPostH:26
	PushChange(1; ->[Bridge MHD NBIS:1]Posting2Axle:9)
End if 
If ([Bridge MHD NBIS:1]Posting3Axle:10#[Inspections:27]ActualPost3:27)
	[Bridge MHD NBIS:1]Posting3Axle:10:=[Inspections:27]ActualPost3:27
	PushChange(1; ->[Bridge MHD NBIS:1]Posting3Axle:10)
End if 
If ([Bridge MHD NBIS:1]Posting5Axle:11#[Inspections:27]ActualPost3S2:28)
	[Bridge MHD NBIS:1]Posting5Axle:11:=[Inspections:27]ActualPost3S2:28
	PushChange(1; ->[Bridge MHD NBIS:1]Posting5Axle:11)
End if 
If ([Bridge MHD NBIS:1]PostingSingle:231#[Inspections:27]ActualPostSgl:29)
	[Bridge MHD NBIS:1]PostingSingle:231:=[Inspections:27]ActualPostSgl:29
	PushChange(1; ->[Bridge MHD NBIS:1]PostingSingle:231)
End if 
