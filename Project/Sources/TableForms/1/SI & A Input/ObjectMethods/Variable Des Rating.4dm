If (False:C215)
	//Object Method vDesRating
	//Form "[Bridge MHD NBIS]SI & A Input"
	//Created Oct-2001
	// Set the NBI Rating values and the Mass Specific 
	// rating info to design values and posting loads to blank.
	//Access to this button is controlled by the Form method
	Mods_2009_03  //CJM  r001   `03/06/09, 12:15:05`Upgrade from open form window to open window
	// Modified by: Bridge Section-(Designer)-(10/26/18 11:23:03)
	Mods_2018_10
	//  `added field [Bridge MHD NBIS]PostingSingle
End if 

C_TEXT:C284($msg)
C_TEXT:C284($rDate)  // Command Replaced was o_C_STRING length was 132
C_LONGINT:C283($tempwin)
C_REAL:C285($hs20; vHS20percent)
C_DATE:C307(vPostDate)

$msg:="Set SIA rating items,  Mass Specific rating items to design values "
$msg:=$msg+"and Posting loads to blank?"
CONFIRM:C162($msg)
If (OK=1)
	If (Current user:C182="Designer")
		C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
		C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
		C_TEXT:C284($Title_txt)
		FORM GET PROPERTIES:C674([Dialogs:21]; "DesRating"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
		$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
		vPostDate:=Current date:C33(*)
		vHS20percent:=100
		DIALOG:C40([Dialogs:21]; "DesRating")
		CLOSE WINDOW:C154($Win_l)
		$rdate:=String:C10(vPostDate; Internal date short:K1:7)
		$hs20:=vHS20percent/100
	Else 
		$hs20:=1
		Repeat 
			$rDate:=Request:C163("Date to be used for Posting Date :"; String:C10(Current date:C33(*); Internal date short:K1:7))
			If (Date:C102($rDate)=Date:C102("BadDate"))
				ALERT:C41("Bad Date Value : "+$rDate+". Please Re-enter")
			End if 
		Until (Date:C102($rDate)#Date:C102("BadDate"))
	End if 
	// set HS20 values and update related pop-ups  
	[Bridge MHD NBIS:1]Posting2Axle:9:=0
	[Bridge MHD NBIS:1]Posting3Axle:10:=0
	[Bridge MHD NBIS:1]Posting5Axle:11:=0
	[Bridge MHD NBIS:1]PostingSingle:231:=0
	[Bridge MHD NBIS:1]PostingStatus:8:="DESIGN"
	aPostStat_:=Find in array:C230(aPostStatC_; [Bridge MHD NBIS:1]PostingStatus:8)
	vRecPostingH:=0
	vRecPost3:=0
	vRecPost3S2:=0
	vREcPostSingle:=0
	[Bridge MHD NBIS:1]PostingDate:7:=Date:C102($rDate)
	[Bridge MHD NBIS:1]DateRatReport:205:=Date:C102("0")
	[Bridge MHD NBIS:1]OprH20:15:=27*$hs20
	[Bridge MHD NBIS:1]OprType3:16:=34*$hs20
	[Bridge MHD NBIS:1]Opr3S2:17:=49*$hs20
	[Bridge MHD NBIS:1]OprHS:18:=49*$hs20
	[Bridge MHD NBIS:1]InvH20:19:=20*$hs20
	[Bridge MHD NBIS:1]InvType3:20:=25*$hs20
	[Bridge MHD NBIS:1]Inv3S2:21:=36*$hs20
	[Bridge MHD NBIS:1]InvHS:22:=36*$hs20
	[Bridge MHD NBIS:1]Item 63:199:="5"
	aORatMethD_:=Find in array:C230(aORatMeth_; [Bridge MHD NBIS:1]Item 63:199)
	[Bridge MHD NBIS:1]Item 65:200:="5"
	aIRatMethD_:=Find in array:C230(aIRatMeth_; [Bridge MHD NBIS:1]Item 65:200)
	[Bridge MHD NBIS:1]Item64:137:=44.1*$hs20
	[Bridge MHD NBIS:1]Item66:139:=32.4*$hs20
	[Bridge MHD NBIS:1]Item31:135:="5"
	aItem31Des:=Find in array:C230(aItem31; [Bridge MHD NBIS:1]Item31:135)
	//save the changes
	PushChange(1; ->[Bridge MHD NBIS:1]Posting2Axle:9)
	PushChange(1; ->[Bridge MHD NBIS:1]Posting3Axle:10)
	PushChange(1; ->[Bridge MHD NBIS:1]Posting5Axle:11)
	PushChange(1; ->[Bridge MHD NBIS:1]PostingSingle:231)
	PushChange(1; ->[Bridge MHD NBIS:1]PostingStatus:8)
	PushChange(1; ->[Bridge MHD NBIS:1]PostingDate:7)
	PushChange(1; ->[Bridge MHD NBIS:1]DateRatReport:205)
	PushChange(1; ->[Bridge MHD NBIS:1]OprH20:15)
	PushChange(1; ->[Bridge MHD NBIS:1]OprType3:16)
	PushChange(1; ->[Bridge MHD NBIS:1]Opr3S2:17)
	PushChange(1; ->[Bridge MHD NBIS:1]OprHS:18)
	PushChange(1; ->[Bridge MHD NBIS:1]InvH20:19)
	PushChange(1; ->[Bridge MHD NBIS:1]InvType3:20)
	PushChange(1; ->[Bridge MHD NBIS:1]Inv3S2:21)
	PushChange(1; ->[Bridge MHD NBIS:1]InvHS:22)
	PushChange(1; ->[Bridge MHD NBIS:1]Item 63:199)
	PushChange(1; ->[Bridge MHD NBIS:1]Item 65:200)
	PushChange(1; ->[Bridge MHD NBIS:1]Item64:137)
	PushChange(1; ->[Bridge MHD NBIS:1]Item66:139)
	PushChange(1; ->[Bridge MHD NBIS:1]Item31:135)
End if 