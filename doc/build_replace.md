search for: (<ClCompile>)(?!\n\s*<MultiProcessorCompilation>)
replace with: $1\n      <MultiProcessorCompilation>true</MultiProcessorCompilation>

to find release build config for c/c++
search for: (?<=<ItemDefinitionGroup Condition="'\$\(Configuration\)\|\$\(Platform\)'==')Release(?=\|x64'">\n\s+<ClCompile>)

include: out/build, *.vcxproj
exclude: doc/build_replace.md, vcpkg_installed
