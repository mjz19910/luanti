$dstDllDir = ".\bin\Release"
$srcDllDir = ".\out\build\Release\vcpkg_installed\x64-windows\bin"

$srcDlls = Get-ChildItem $srcDllDir -Filter *.dll
foreach ($dll in $srcDlls) {
	$dstPath = Join-Path $dstDllDir $dll.Name

	$needsCopy = $true
	if (Test-Path $dstPath) {
		$srcTime = $dll.LastWriteTime
		$dstTime = (Get-Item $dstPath).LastWriteTime
		if ($dstTime -ge $srcTime) {
			$needsCopy = $false
		}
	}

	if ($needsCopy) {
        Write-Host "Updating $($dll.Name)"
		Copy-Item $dll.FullName $dstPath -Force
	}
}
