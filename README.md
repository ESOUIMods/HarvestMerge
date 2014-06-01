HarvestMerge
============

## Slash Commands
```/merger reset```
Completely resets all gathered data.

```/merger reset DATATYPE```
Resets a specific type of data

```/merger debug on|off```
Toggles verbose addon debugging.

```/merger import ADDON```
Imports data from the specified mod.  Addons supported are "esohead", "esomerge", "harvester", "harvestmap".

```/merger datalog DATATYPE```
Returns the number of nodes in the database specified in DATATYPE.  

Valid data types are:

nodes - the primary nodes used by HarvestMap
mapinvalid - the invalid nodes for localized map names
esonodes - valid nodes for non localized map names
esoinvalid - invalid nodes for non localized map names

NOTE: When I update the localization HarvestMap automatically moves data from mapinvalid, esonodes, and esoinvalid to nodes.

```/rl```
Aliases of the reloadui command