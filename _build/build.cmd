:: @echo off

:: 设置为utf-8编码
call CHCP 65001

:: 定义目录
set code_folder=C:/Product/server-daemon
set build_folder=_build

:: 定义项目信息
set config_name=config.toml
set project_name=server-daemon


echo 正在打包: %project_name%
echo 代码路径: %code_folder%
echo 打包输出目录: %build_folder%

cd %code_folder%

echo 打包windows
set CGO_ENABLE=0
set GOOS=linux
set GOARCH=amd64
go build -ldflags "-s -w" -o %build_folder%/windows/%project_name%-windows-x86_64.exe

echo 打包linux
set CGO_ENABLE=0
set GOOS=windows
set GOARCH=amd64
go build -ldflags "-s -w" -o %build_folder%/linux/%project_name%-linux-x86_64.exe

echo 打包darwin
set CGO_ENABLE=0
set GOOS=darwin
set GOARCH=amd64
go build -ldflags "-s -w" -o %build_folder%/darwin/%project_name%-darwin-x86_64.exe


echo 拷贝配置文件
copy /y %config_name% %build_folder%\windows\
copy /y %config_name% %build_folder%\linux\
copy /y %config_name% %build_folder%\darwin\


@pause