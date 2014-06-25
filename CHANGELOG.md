##0.2.7

Update
- Minor update to Eyevea map name.
- Synchronized import functions with HarvestMap

##0.2.6

Bugfix
- Fixed bug that cause an exception when importing with debug mode on

##0.2.5

Bugfix
- Fixed bug that allowed containers from Esohead.lua files to be added as Solvent nodes.[1]

[1]The easiest way to fix this is to use your HarvestMerge data and import into HarvestMap with the solvent filters ON.  Then turn the filters back OFF when you import other Esohead.lua files.  You will only loose the valid "Pure Water" nodes but those are very easy to find.  Once you import the HarvestMerge with the filters on, I would reset your HarvestMerge data and import from HarvestMap so you don't import the solvent nodes again in the future.

##0.2.4

Updates
- Added Node Name translation.[1]

Bugfix
- Updated how HarvestMerge handles importing different nodes in the same location.[2]

[1] This prevents the tooltip from having the node name in each language and translating two from German or French to English.
[2] For example High Iron Ore, Orichalcum Ore and Calcinium Ore spawning in the same spot.  The tooltip should properly reflect the nodes that have spawned it its location.


##0.2.3

Bugfix
- updated version detection for HarvestMap

Update
- Simplified duplicate node detection routine

##0.2.2

Update
- Updated import routines and duplicate node detection to be inline with HarvestMap for greater accuracy

##0.2.1

Updates
- Updated localization routines[1][2]
- Updated auto update routines for when localization has changed

[1] Upon further investigation HarvestMap versions 2.4.7, 2.4.8, and 2.4.9 would not have handled Cgarlorn data correctly due to lack of localization information from Esohead.com.  This has been resolved.  All versions of HarvestMap 2.5.0 or newer handle Craglorn data.  HarvestMap will automatically move Craglorn data to the pool of usable data for map pins.
[2] Upon further investigation HarvestMerge version 0.1.4 had some Craglorn support.  HarvestMerge versions 0.1.5 or newer handle Craglorn data.  HarvestMerge will automatically move Craglorn data to the pool of usable data for importing into HarvestMap.

##0.2.0

Bugfix
- Duplicate node verification was too strict

Feature
- added "/harvest datalog NODETYPE" to return the number of nodes in the database
For example "/harvest datalog nodes" will tell you how many nodes and what kind are being used by HarvestMap


It was reported that Craglorn data was made unavailable after 2.4.7 of Harvestmap.  I could still use backups of HarvestMap.lua from 2.4.0 to 2.4.6 and 2.5.0 or higher.  All versions of HarvestMpa 2.5.0 or higher have proper Craglorn support.  HarvestMap will automatically move Craglorn data to the pool of usable data for map pins.

##0.1.9

Bugfix
- Fixed debug variable causing error when toggled on

##0.1.8

Bugfix
- Normalized importing routines and synced with other addons

##0.1.7

Bugfix
- Fixed issue with HarvestMerge skipping chests and fishing holes in certain cases.

##0.1.6

Bugfix
- Fixed importing of negative professions or professions greater than 8 that were removed in 2.4 Beta.

##0.1.5

Updates
- Attempted to make counters more accurate.

##0.1.4

Updates
- Added craglorn support to localization files

##0.1.3

Updates
- Removed Redundant code and comments

##0.1.2

Bugfixes
- removed datalog slash command since it doesn't work correctly

Updates
- Updated import code for HarvestMap

##0.1.1

Bugfixes
- Fixed error in line 808
