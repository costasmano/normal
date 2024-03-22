//%attributes = {"invisible":true}
// Modified by: costasmanousakis-(Designer)-(5/1/2007 08:31:24)
// Modified Form Methods : 
//[Bridge Design];"Bridge Design In"
//  `Declared variable ◊LogBridgeDesign_b to control loging of bridge design changes;
//  ` used it in the on Validate event.
// Modified Forms : 
//[Bridge Design];"Bridge Design In"
//  `Renamed delete and save buttons to @_BrgDes
// Modified Object Methods : 
//[Bridge Design];"Bridge Design In".vbDelete_BrgDes
//[Bridge Design];"Bridge Design In".vbSave_BrgDes
//  `Use the ◊LogBridgeDesign_b to log the new record or deletion events

// Modified Table(s) : 
//[Bridge Design]
//Changed R/W privileges to the FieldGroup.

// Modified User Group : 
//FieldGroup
//  `Added BridgeDataSheet group to the FieldGroup

// Modified Method(s) : 
//ReSendLogEntries
//  `Do not clear the DestID fields for records with RefIDType=0 (these are global IDs, don't need fixing.)