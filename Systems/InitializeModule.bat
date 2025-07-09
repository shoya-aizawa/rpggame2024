:: Initialize ANSI escape sequence
for /f %%a in ('cmd /k prompt $e^<nul') do (set "esc=%%a")

:: Set short paths relative to the root directory (%cd%)
set cd_enemydata=%cd%\EnemyData
set cd_itemdata=%cd%\ItemData
set cd_newgame=%cd%\NewGame
set cd_playerdata=%cd%\PlayerData
set cd_savedata=%cd%\SaveData
set cd_sounds=%cd%\Sounds
set cd_stories=%cd%\Stories
set cd_stories_maps=%cd%\Stories\Maps
set cd_systems=%cd%\Systems
set cd_systems_debug=%cd%\Systems\Debug
set cd_systems_display=%cd%\Systems\Display
set cd_systems_savesys=%cd%\Systems\SaveSys

:: Initialize save execution source variables
set autosave=false
set manualsave=false
set newgame=false
set continue=false

:: Initialize GUI space variables
call "%cd_systems%\WhileSpaceVariable_Initialize.bat"

:: Initialize the game text data
:: ============================
::       Will be updated
:: ============================
call "%cd_newgame%\TextFile.bat"


