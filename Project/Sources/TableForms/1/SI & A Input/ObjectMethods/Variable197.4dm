If (False:C215)
	//[Bridge MHD NBIS];"SI & A Input"
	//Popupmenu for Posting status
	
	// Modified by: costasmanousakis-(Designer)-(1/2/2007 15:44:41)
	Mods_2007_CM01
	// Modified by: Bridge Section-(Designer)-(10/26/18 11:24:17)
	Mods_2018_10
	//  `added field [Bridge MHD NBIS]PostingSingle and var vREcPostSingle
End if 

POPUPMENUC(->aPostStat_; ->aPostStatC_; ->[Bridge MHD NBIS:1]PostingStatus:8)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; ->[Bridge MHD NBIS:1]PostingStatus:8)
	Case of 
		: ([Bridge MHD NBIS:1]PostingStatus:8="DESIGN")
			//Design status means that there is no recommended posting.
			vRecPostingH:=0
			vRecPost3:=0
			vRecPost3S2:=0
			vREcPostSingle:=0
		: ([Bridge MHD NBIS:1]PostingStatus:8="CLOSED")
			//CLOSED status means that there is no recommended posting.
			vRecPostingH:=0
			vRecPost3:=0
			vRecPost3S2:=0
			vREcPostSingle:=0
			//also set item 64 and 66 to zero.
			[Bridge MHD NBIS:1]Item64:137:=0
			[Bridge MHD NBIS:1]Item66:139:=0
			PushChange(1; ->[Bridge MHD NBIS:1]Item64:137)
			PushChange(1; ->[Bridge MHD NBIS:1]Item66:139)
		: ([Bridge MHD NBIS:1]PostingStatus:8="UNKNWN")
			//UNKNOW (n) status means that there is Unknown data.
			vRecPostingH:=0
			vRecPost3:=0
			vRecPost3S2:=0
			vREcPostSingle:=0
			[Bridge MHD NBIS:1]Posting2Axle:9:=0
			[Bridge MHD NBIS:1]Posting3Axle:10:=0
			[Bridge MHD NBIS:1]Posting5Axle:11:=0
			[Bridge MHD NBIS:1]PostingSingle:231:=0
			[Bridge MHD NBIS:1]Opr3S2:17:=0
			[Bridge MHD NBIS:1]OprH20:15:=0
			[Bridge MHD NBIS:1]OprHS:18:=0
			[Bridge MHD NBIS:1]OprMS:204:=0
			[Bridge MHD NBIS:1]OprType3:16:=0
			[Bridge MHD NBIS:1]Inv3S2:21:=0
			[Bridge MHD NBIS:1]InvH20:19:=0
			[Bridge MHD NBIS:1]InvHS:22:=0
			[Bridge MHD NBIS:1]InvMS:203:=0
			[Bridge MHD NBIS:1]InvType3:20:=0
			[Bridge MHD NBIS:1]DateRatReport:205:=!00-00-00!
			
			[Bridge MHD NBIS:1]Item31:135:="0"
			[Bridge MHD NBIS:1]Item 63:199:="5"
			[Bridge MHD NBIS:1]Item 65:200:="5"
			[Bridge MHD NBIS:1]Item64:137:=44.1
			[Bridge MHD NBIS:1]Item66:139:=32.4
			//Set the popup for Item 31
			aItem31Des:=Find in array:C230(aItem31; [Bridge MHD NBIS:1]Item31:135)
			
			PushChange(1; ->[Bridge MHD NBIS:1]Posting2Axle:9)
			PushChange(1; ->[Bridge MHD NBIS:1]Posting3Axle:10)
			PushChange(1; ->[Bridge MHD NBIS:1]Posting5Axle:11)
			PushChange(1; ->[Bridge MHD NBIS:1]PostingSingle:231)
			PushChange(1; ->[Bridge MHD NBIS:1]Opr3S2:17)
			PushChange(1; ->[Bridge MHD NBIS:1]OprH20:15)
			PushChange(1; ->[Bridge MHD NBIS:1]OprHS:18)
			PushChange(1; ->[Bridge MHD NBIS:1]OprMS:204)
			PushChange(1; ->[Bridge MHD NBIS:1]OprType3:16)
			PushChange(1; ->[Bridge MHD NBIS:1]Inv3S2:21)
			PushChange(1; ->[Bridge MHD NBIS:1]InvH20:19)
			PushChange(1; ->[Bridge MHD NBIS:1]InvHS:22)
			PushChange(1; ->[Bridge MHD NBIS:1]InvMS:203)
			PushChange(1; ->[Bridge MHD NBIS:1]InvType3:20)
			PushChange(1; ->[Bridge MHD NBIS:1]DateRatReport:205)
			PushChange(1; ->[Bridge MHD NBIS:1]Item31:135)
			PushChange(1; ->[Bridge MHD NBIS:1]Item 63:199)
			PushChange(1; ->[Bridge MHD NBIS:1]Item 65:200)
			PushChange(1; ->[Bridge MHD NBIS:1]Item64:137)
			PushChange(1; ->[Bridge MHD NBIS:1]Item66:139)
			
	End case 
End if 