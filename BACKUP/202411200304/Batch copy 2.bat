


cls & set hashtag=#
echo %hashtag%
cls & set hashtag=##
echo %hashtag%
cls & set hashtag=###
echo %hashtag%
cls & set hashtag=###





for /l %%a in (1,1,6) do (
    echo %hashtag%%a%
    for /l %%t in (1,1,100000) do (
        cls
    )
)



set hashtag1=#
set hashtag2=##
set hashtag3=###
set hashtag4=####
set hashtag5=#####
set hashtag6=######





pause