If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(6/18/2007 15:04:14)
	Mods_2007_CM12_5301
End if 

CONFIRM:C162("Print Using"; "List Box"; "Quick Report")

If (OK=1)
	//C_OBJECT($ListBox_obj)
	//OB SET($ListBox_obj;"Table";Table(->[PRJ_DesignContracts]))
	//OB SET($ListBox_obj;"Form";"Output_LB")
	//OB SET($ListBox_obj;"ListBox";"DesignContracts_LB")
	//OB SET($ListBox_obj;"$LB_L";$lb_L)
	//OB SET($ListBox_obj;"$LB_T";$Lb_T)
	
	C_LONGINT:C283($lb_L; $Lb_T; $LB_R; $lB_b)
	OBJECT GET COORDINATES:C663(*; "DesignContracts_LB"; $lb_L; $Lb_T; $LB_R; $lB_b)
	//PrintListBoxUsingObject ($ListBox_obj)
	
	PrintListBox(->[PRJ_DesignContracts:123]; "Output_LB"; "DesignContracts_LB")
	OBJECT SET COORDINATES:C1248(*; "DesignContracts_LB"; $lb_L; $Lb_T; $Lb_R; $lB_b)
	
Else 
	QUERY:C277([Templates:86]; [Templates:86]TemplateName:2="QRT_ProjectDesign")
	C_LONGINT:C283($QuickRptArea_L)
	$QuickRptArea_L:=QR New offscreen area:C735
	QR BLOB TO REPORT:C771($QuickRptArea_L; [Templates:86]Template_:3)
	QR SET DOCUMENT PROPERTY:C772($QuickRptArea_L; qr printing dialog:K14907:1; 1)
	QR EXECUTE COMMAND:C791($QuickRptArea_L; qr cmd page setup:K14900:24)
	QR RUN:C746($QuickRptArea_L)
	QR DELETE OFFSCREEN AREA:C754($QuickRptArea_L)
End if 
