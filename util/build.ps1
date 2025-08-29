param(
	[ValidateSet("configure", "build")]
	[string]$Action = "build"
)

$srcRoot = "D:\Games\luanti"
$releaseBuildDir = "$srcRoot\out\build\Release"
$vcpkgInstalledPath = "$srcRoot\out\build\Release\vcpkg_installed"
$curlLibPath = "$vcpkgInstalledPath\vcpkg\pkgs\curl_x64-windows\lib\libcurl.lib"
$curlIncludeDir = "$vcpkgInstalledPath\vcpkg\pkgs\curl_x64-windows\include\"
$freetypeIncludeDir = "$vcpkgInstalledPath\vcpkg\pkgs\freetype_x64-windows\include\"

$cmakeConfigureArgs = @(
	"-DCMAKE_TOOLCHAIN_FILE=$($env:VCPKG_ROOT)\scripts\buildsystems\vcpkg.cmake",
	"-DCURL_LIBRARY=$curlLibPath",
	"-DCURL_INCLUDE_DIR=$curlIncludeDir",
	"-DFREETYPE_INCLUDE_DIRS=$freetypeIncludeDir",
	"-DCMAKE_BUILD_TYPE=Release",
	"-DENABLE_CURSES=OFF",
	"-S", $srcRoot,
	"-B", $releaseBuildDir
)

$cmakeBuildArgs = @(
	"--build", $releaseBuildDir,
	"--config", "Release"
)

$msbuildArgs = @(
	"/p:VcpkgEnableManifest=true",
	"/p:VcpkgInstalledDir=$vcpkgInstalledPath",
	"/p:VcpkgRoot=$($env:VCPKG_ROOT)"
)

switch ($Action) {
	"configure" {
		cmake $cmakeConfigureArgs
	}
	"build" {
		cmake $cmakeBuildArgs -- $msbuildArgs
	}
}
