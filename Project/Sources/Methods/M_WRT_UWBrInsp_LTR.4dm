//%attributes = {"invisible":true}
//retrieve underwater inspection date
QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=[Bridge MHD NBIS:1]BIN:3; *)
QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6="DV@")
ORDER BY:C49([Inspections:27]; [Inspections:27]Insp Date:78; <)

If (Records in selection:C76([Inspections:27])>0)
	vUWInspDate:=[Inspections:27]Insp Date:78
End if 

G_WRT_GenericBridgeLetter("WRtemplate_UWBrInsp_LTR"; False:C215; True:C214)