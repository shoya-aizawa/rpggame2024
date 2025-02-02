:: セーブデータ選択画面用


::@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
::@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
if "%ESD_1%"=="true" (
    rem ESD_1をロードして変数を読み込む(今はここでロードするけど最適化に向けてINDEXでロード挟むでもいいかもね)
    rem Player_Naneとかも読み込んで表示するために
    rem 文字数取得してセーブデータ選択画面用にDAAをセットしたい
    for /f "delims=" %%a in (SaveData_1.txt) do (%%a)

    rem 他のセーブデータの変数との干渉対策
    call set Player_LV_1=%%Player_LV%%
    call set Player_Name_1=%%Player_Name%%
    call set Player_HP_1=%%Player_HP%%
    call set Player_MP_1=%%Player_MP%%

    setlocal enabledelayedexpansion
    call set str=%%Player_LV%%
    set len=0
    :LOOP1_1_0
    if not "!str!"=="" (
        call set str=%%str:~1%%
        set /a len+=1
        goto :LOOP1_1_0
    )
    rem 環境遅延変数を外に持ち出す
    endlocal & set len=%len%
    call set /a DAA_Lv_len=5 - %%len%%
    call set DAA_Lv_1=%%DAA_%DAA_Lv_len%%%

    setlocal enabledelayedexpansion
    call set str=%%Player_Name%%
    set len=0
    :LOOP1_1_1
    if not "!str!"=="" (
        call set str=%%str:~1%%
        set /a len+=1
        goto :LOOP1_1_1
    )
    rem 環境遅延変数を外に持ち出す
    endlocal & set len=%len%
    call set /a DAA_Name_len=14 - %%len%%
    call set DAA_Name_1=%%DAA_%DAA_Name_len%%%

    setlocal enabledelayedexpansion
    call set str=%%Player_HP%%
    set len=0
    :LOOP1_1_2
    if not "!str!"=="" (
        call set str=%%str:~1%%
        set /a len+=1
        goto :LOOP1_1_2
    )
    rem 環境遅延変数を外に持ち出す
    endlocal & set len=%len%
    call set /a DAA_HP_len=5 - %%len%%
    call set DAA_HP_1=%%DAA_%DAA_HP_len%%%

    setlocal enabledelayedexpansion
    call set str=%%Player_MP%%
    set len=0
    :LOOP1_1_3
    if not "!str!"=="" (
        call set str=%%str:~1%%
        set /a len+=1
        goto :LOOP1_1_3
    )
    rem 環境遅延変数を外に持ち出す
    endlocal & set len=%len%
    call set /a DAA_MP_len=15 - %%len%%
    call set DAA_MP_1=%%DAA_%DAA_MP_len%%%

    call set SaveDataText_A=%while_space_1%%Player_Name_1%%DAA_Name_1%Lv:%Player_LV_1%%DAA_LV_1%HP=%Player_HP_1%%DAA_HP_1%MP=%Player_MP_1%%DAA_MP_1%
    call set SaveDataText_B=%while_space_1%Location:xxxxxx xxxxxx%while_space_24%
    call set SaveDataText_C=%while_space_1%AUTO-SAVE%while_space_22%Playtime - hh:mm%while_space_1%
)
if "%ESD_1%"=="false" (
    call set SaveDataText_A=%while_space_1%SaveData:1%while_space_38%
    call set SaveDataText_B=%while_space_22%ENPTY%while_space_22%
    call set SaveDataText_C=%while_space_49%
)

::@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
::@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

if "%ESD_2%"=="true" (
    for /f "delims=" %%a in (SaveData_2.txt) do (%%a)

    rem 他のセーブデータの変数との干渉対策
    call set Player_LV_2=%%Player_LV%%
    call set Player_Name_2=%%Player_Name%%
    call set Player_HP_2=%%Player_HP%%
    call set Player_MP_2=%%Player_MP%%

    setlocal enabledelayedexpansion
    call set str=%%Player_LV%%
    set len=0
    :LOOP2_1_0
    if not "!str!"=="" (
        call set str=%%str:~1%%
        set /a len+=1
        goto :LOOP2_1_0
    )
    rem 環境遅延変数を外に持ち出す
    endlocal & set len=%len%
    call set /a DAA_Lv_len=5 - %%len%%
    call set DAA_Lv_2=%%DAA_%DAA_Lv_len%%%

    setlocal enabledelayedexpansion
    call set str=%%Player_Name%%
    set len=0
    :LOOP2_1_1
    if not "!str!"=="" (
        call set str=%%str:~1%%
        set /a len+=1
        goto :LOOP2_1_1
    )
    rem 環境遅延変数を外に持ち出す
    endlocal & set len=%len%
    call set /a DAA_Name_len=14 - %%len%%
    call set DAA_Name_2=%%DAA_%DAA_Name_len%%%

    setlocal enabledelayedexpansion
    call set str=%%Player_HP%%
    set len=0
    :LOOP2_1_2
    if not "!str!"=="" (
        call set str=%%str:~1%%
        set /a len+=1
        goto :LOOP2_1_2
    )
    rem 環境遅延変数を外に持ち出す
    endlocal & set len=%len%
    call set /a DAA_HP_len=5 - %%len%%
    call set DAA_HP_2=%%DAA_%DAA_HP_len%%%

    setlocal enabledelayedexpansion
    call set str=%%Player_MP%%
    set len=0
    :LOOP2_1_3
    if not "!str!"=="" (
        call set str=%%str:~1%%
        set /a len+=1
        goto :LOOP2_1_3
    )
    rem 環境遅延変数を外に持ち出す
    endlocal & set len=%len%
    call set /a DAA_MP_len=15 - %%len%%
    call set DAA_MP_2=%%DAA_%DAA_MP_len%%%

    call set SaveDataText_D=%DAA_1%%Player_Name_2%%DAA_Name_2%Lv:%Player_LV_2%%DAA_LV_2%HP=%Player_HP_2%%DAA_HP_2%MP=%Player_MP_2%%DAA_MP_2%
    call set SaveDataText_E=%DAA_1%Location:xxxxxx xxxxxx%DAA_24%
    call set SaveDataText_F=%DAA_1%AUTO-SAVE%DAA_22%Playtime - hh:mm%DAA_1%
)
if "%ESD_2%"=="false" (
    call set SaveDataText_D=%while_space_1%SaveData:2%while_space_38%
    call set SaveDataText_E=%while_space_22%ENPTY%while_space_22%
    call set SaveDataText_F=%while_space_49%
)

::@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
::@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

if "%ESD_3%"=="true" (
    for /f "delims=" %%a in (SaveData_3.txt) do (%%a)

    rem 他のセーブデータの変数との干渉対策
    call set Player_LV_3=%%Player_LV%%
    call set Player_Name_3=%%Player_Name%%
    call set Player_HP_3=%%Player_HP%%
    call set Player_MP_3=%%Player_MP%%

    setlocal enabledelayedexpansion
    call set str=%%Player_LV%%
    set len=0
    :LOOP3_1_0
    if not "!str!"=="" (
        call set str=%%str:~1%%
        set /a len+=1
        goto :LOOP3_1_0
    )
    rem 環境遅延変数を外に持ち出す
    endlocal & set len=%len%
    call set /a DAA_Lv_len=5 - %%len%%
    call set DAA_Lv_3=%%DAA_%DAA_Lv_len%%%

    setlocal enabledelayedexpansion
    call set str=%%Player_Name%%
    set len=0
    :LOOP3_1_1
    if not "!str!"=="" (
        call set str=%%str:~1%%
        set /a len+=1
        goto :LOOP3_1_1
    )
    rem 環境遅延変数を外に持ち出す
    endlocal & set len=%len%
    call set /a DAA_Name_len=14 - %%len%%
    call set DAA_Name_3=%%DAA_%DAA_Name_len%%%

    setlocal enabledelayedexpansion
    call set str=%%Player_HP%%
    set len=0
    :LOOP3_1_2
    if not "!str!"=="" (
        call set str=%%str:~1%%
        set /a len+=1
        goto :LOOP3_1_2
    )
    rem 環境遅延変数を外に持ち出す
    endlocal & set len=%len%
    call set /a DAA_HP_len=5 - %%len%%
    call set DAA_HP_3=%%DAA_%DAA_HP_len%%%

    setlocal enabledelayedexpansion
    call set str=%%Player_MP%%
    set len=0
    :LOOP3_1_3
    if not "!str!"=="" (
        call set str=%%str:~1%%
        set /a len+=1
        goto :LOOP3_1_3
    )
    rem 環境遅延変数を外に持ち出す
    endlocal & set len=%len%
    call set /a DAA_MP_len=15 - %%len%%
    call set DAA_MP_3=%%DAA_%DAA_MP_len%%%

    call set SaveDataText_G=%DAA_1%%Player_Name_3%%DAA_Name_3%Lv:%Player_LV_3%%DAA_LV_3%HP=%Player_HP_3%%DAA_HP_3%MP=%Player_MP_3%%DAA_MP_3%
    call set SaveDataText_H=%DAA_1%Location:xxxxxx xxxxxx%DAA_24%
    call set SaveDataText_I=%DAA_1%AUTO-SAVE%DAA_22%Playtime - hh:mm%DAA_1%
)
if "%ESD_3%"=="false" (
    call set SaveDataText_G=%while_space_1%SaveData:3%while_space_38%
    call set SaveDataText_H=%while_space_22%ENPTY%while_space_22%
    call set SaveDataText_I=%while_space_49%
)

::@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
::@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@





