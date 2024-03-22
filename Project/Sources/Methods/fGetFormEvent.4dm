//%attributes = {"invisible":true}
If (False:C215)
	//fGetFormEvent
	//For debugging purposes -
	//   to return a string with the name of the $FormEvent_L
	
	// Modified by: costasmanousakis-(Designer)-(8/15/08 14:39:03)
	Mods_2008_CM_5404
	//  `Added optional parameter
	//  ` $1 : $FormEvent_L
	// Modified by: costasmanousakis-(Designer)-(1/1/10 19:39:21)
	Mods_2010_02
	//  `added some new form events
	// Modified by: Costas Manousakis-(Designer)-(2/12/12 20:36:26)
	Mods_2012_02
	//  `added some new form events
	// Modified by: Costas Manousakis-(Designer)-(8/17/17 14:17:47)
	Mods_2017_08
	//  `added all new form events
	// Modified by: Costas Manousakis-(Designer)-(6/8/20 11:26:32)
	Mods_2020_06
	//  `added the event code when form event is unknown
End if 
C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Load:K2:1)
		$0:="On Load"
	: ($FormEvent_L=On Validate:K2:3)
		$0:="On Validate"
	: ($FormEvent_L=On Clicked:K2:4)
		$0:="On Clicked"
	: ($FormEvent_L=On Header:K2:17)
		$0:="On Header"
	: ($FormEvent_L=On Printing Break:K2:19)
		$0:="On Printing Break"
	: ($FormEvent_L=On Printing Footer:K2:20)
		$0:="On Printing Footer"
	: ($FormEvent_L=On Display Detail:K2:22)
		$0:="On Display Detail"
	: ($FormEvent_L=On Outside Call:K2:11)
		$0:="On Outside Call"
	: ($FormEvent_L=On Activate:K2:9)
		$0:="On Activate"
	: ($FormEvent_L=On Deactivate:K2:10)
		$0:="On Deactivate"
	: ($FormEvent_L=On Double Clicked:K2:5)
		$0:="On Double Clicked"
	: ($FormEvent_L=On Losing Focus:K2:8)
		$0:="On Losing Focus"
	: ($FormEvent_L=On Getting Focus:K2:7)
		$0:="On Getting Focus"
	: ($FormEvent_L=On Drop:K2:12)
		$0:="On Drop"
	: ($FormEvent_L=On Before Keystroke:K2:6)
		$0:="On Before Keystroke"
	: ($FormEvent_L=On Menu Selected:K2:14)
		$0:="On Menu Selected"
	: ($FormEvent_L=On Plug in Area:K2:16)
		$0:="On Plug in Area"
	: ($FormEvent_L=On Data Change:K2:15)
		$0:="On Data Change"
	: ($FormEvent_L=On Drag Over:K2:13)
		$0:="On Drag Over"
	: ($FormEvent_L=On Close Box:K2:21)
		$0:="On Close Box"
	: ($FormEvent_L=On Printing Detail:K2:18)
		$0:="On Printing Detail"
	: ($FormEvent_L=On Unload:K2:2)
		$0:="On Unload"
	: ($FormEvent_L=On Open Detail:K2:23)
		$0:="On Open Detail"
	: ($FormEvent_L=On Close Detail:K2:24)
		$0:="On Close Detail"
	: ($FormEvent_L=On Timer:K2:25)
		$0:="On Timer"
	: ($FormEvent_L=On After Keystroke:K2:26)
		$0:="On After Keystroke"
	: ($FormEvent_L=On Resize:K2:27)
		$0:="On Resize"
	: ($FormEvent_L=On After Sort:K2:28)
		$0:="On After Sort"
	: ($FormEvent_L=On Selection Change:K2:29)
		$0:="On Selection Change"
	: ($FormEvent_L=On Column Moved:K2:30)
		$0:="On Column Moved"
	: ($FormEvent_L=On Column Resize:K2:31)
		$0:="On Column Resize"
	: ($FormEvent_L=On Row Moved:K2:32)
		$0:="On Row Moved"
	: ($FormEvent_L=On Mouse Enter:K2:33)
		$0:="On Mouse Enter"
	: ($FormEvent_L=On Mouse Leave:K2:34)
		$0:="On Mouse Leave"
	: ($FormEvent_L=On Mouse Move:K2:35)
		$0:="On Mouse Move"
	: ($FormEvent_L=On Alternative Click:K2:36)
		$0:="On Alternative Click"
	: ($FormEvent_L=On Long Click:K2:37)
		$0:="On Long Click"
	: ($FormEvent_L=On Load Record:K2:38)
		$0:="On Load Record"
	: ($FormEvent_L=On Before Data Entry:K2:39)
		$0:="On Before Data Entry"
	: ($FormEvent_L=On Header Click:K2:40)
		$0:="On Header Click"
	: ($FormEvent_L=On Expand:K2:41)
		$0:="On Expand"
	: ($FormEvent_L=On Collapse:K2:42)
		$0:="On Collapse"
	: ($FormEvent_L=On After Edit:K2:43)
		$0:="On After Edit"
	: ($FormEvent_L=On Begin Drag Over:K2:44)
		$0:="On Begin Drag Over"
	: ($FormEvent_L=On Begin URL Loading:K2:45)
		$0:="On Begin URL Loading"
	: ($FormEvent_L=On URL Resource Loading:K2:46)
		$0:="On URL Resource Loading"
	: ($FormEvent_L=On End URL Loading:K2:47)
		$0:="On End URL Loading"
	: ($FormEvent_L=On URL Loading Error:K2:48)
		$0:="On URL Loading Error"
	: ($FormEvent_L=On URL Filtering:K2:49)
		$0:="On URL Filtering"
	: ($FormEvent_L=On Open External Link:K2:50)
		$0:="On Open External Link"
	: ($FormEvent_L=On Window Opening Denied:K2:51)
		$0:="On Window Opening Denied"
	: ($FormEvent_L=On Bound Variable Change:K2:52)
		$0:="On bound variable change"
		//: ($FormEvent_L=_o_On Mac Toolbar Button)
		//$0:="_o_On Mac toolbar button"
	: ($FormEvent_L=On Page Change:K2:54)
		$0:="On Page Change"
	: ($FormEvent_L=On Footer Click:K2:55)
		$0:="On Footer Click"
	: ($FormEvent_L=On Delete Action:K2:56)
		$0:="On Delete Action"
	: ($FormEvent_L=On Scroll:K2:57)
		$0:="On Scroll"
		
	Else 
		$0:="What? "+String:C10($FormEvent_L)
End case 

$0:=Uppercase:C13($0)