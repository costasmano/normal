//%attributes = {"invisible":true}
//procedure: M_HandlePrefs
//purpose: Handle preference settings
If (False:C215)
	//by: Albert Leung
	//date: 1/29/97
	//modified: 1/20/98
	// Modified by: Costas Manousakis-(Designer)-(4/13/12 11:02:50)
	Mods_2012_04
	//  `get the form size of the dialog,; window type and a window title
	// Modified by: Costas Manousakis-(Designer)-(5/14/12 16:11:24)
	Mods_2012_05
	//  `Preferences dialog now includes SMTP server. 
	//  `now the print and smtp prefs are not stored in the db - stored in xml file
	//  `dialog has three options now,: cancel , apply and save, apply - prefs written only if apply and save is clicked
	// Modified by: Costas Manousakis-(Designer)-(9/2/15 12:19:16)
	Mods_2015_09
	//  `added ◊pref_TruckPost_NOL
	//  `form "Preferences" is now a project form
	// Modified by: Costas Manousakis-(Designer)-(10/25/16 15:03:53)
	Mods_2016_10
	//  `added code for ◊pref_New4DWR
	// Modified by: Costas Manousakis-(Designer)-(1/8/20 17:42:40)
	Mods_2020_01_bug
	//  `added code for EmailMethod
End if 
C_LONGINT:C283(bApplyandSave; bRevertToSaved)
C_TEXT:C284(User_SMTP_Server_txt)
User_SMTP_Server_txt:=<>pref_SMTP
bApplyandSave:=0
C_TEXT:C284(v_57_015_txt)
v_57_015_txt:=<>EmailMethod

C_LONGINT:C283($w_L; $h_L)
FORM GET PROPERTIES:C674("Preferences"; $w_L; $h_L)
CENTER_WINDOW($w_L; $h_L; Plain dialog box:K34:4; "User Preference Settings")
DIALOG:C40("Preferences")
CLOSE WINDOW:C154

If (Ok=1)
	
	<>ShowPrint:=(CBShowPrint=1)
	<>pref_TruckPost_NOL:=(CBHideLabel=1)
	
	If (User_SMTP_Server_txt#"")
		<>pref_SMTP:=User_SMTP_Server_txt
	End if 
	
	<>pref_New4DWR:=(CBUseOriginalWR=0)
	
	<>EmailMethod:=v_57_015_txt
	
	If (bApplyandSave=1)
		ut_ControlUserPrefs("SAVE")
	End if 
	
End if 