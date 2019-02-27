set PROJ_ROOT=%CD%
set PREBUILT_DIR=%PROJ_ROOT%\prebuilt\win
set CURL_ROOT=curl-7.64.0
set NGHTTP2_ROOT=%PROJ_ROOT%\..\nghttp2\prebuilt\win
set SSL_ROOT=%PROJ_ROOT%\..\openssl\prebuilt\win

call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars64.bat"

pushd %CURL_ROOT%\winbuild
set CL=/MP
nmake /f Makefile.vc mode=static VC=15 MACHINE=x64 ^
    WITH_NGHTTP2=static NGHTTP2_PATH=%NGHTTP2_ROOT% ^
    WITH_SSL=static SSL_PATH=%SSL_ROOT% ^
    ENABLE_IDN=no ^
    ENABLE_IPV6=yes 
popd

mkdir %PREBUILT_DIR%
xcopy %PROJ_ROOT%\%CURL_ROOT%\builds\libcurl-vc15-x64-release-static-ssl-static-ipv6-sspi-nghttp2-static %PREBUILT_DIR% /s /e /y