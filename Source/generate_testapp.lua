require("global")

function GenerateTestApp()
	-- Test application	
	project "TestApp"
		kind "ConsoleApp"
		language "C++"
		location "%{prj.name}"
		staticruntime "on"
		--characterset("Unicode")
		--editandcontinue "off"

		-- Project Directory:
		projectDir = "%{prj.name}/"

		-- Game Directory:
		gameDir = _WORKING_DIR .. "/../Projects/%{prj.name}"

		-- OBJ Directory
		objdir (projectDir .. "%{cfg.buildcfg}_%{prj.name}")
		targetdir (gameDir)

		files 
		{ 
			"%{prj.name}/**.h", 
			"%{prj.name}/**.cpp" 
		}
		
		if os.target() == "windows" then 
			pchheader "pch.h"
			pchsource "TestApp/pch.cpp" -- Bug: the file path must be defined per project. 
		else
			pchheader "pch.h"
		end
		
		-- Custom Defines
		defines
		{
			"__TEST_ME_",
		}

		GlobalSettings()	
end

workspace "TestApp"
	startproject "TestApp"
	architecture "x86_64"
	configurations
	{
		"Debug",
		"Release"
	}
	GenerateTestApp()