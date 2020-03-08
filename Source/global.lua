g_LeadwerksHeaderPath = _WORKING_DIR .."/Engine/Include"
g_LeadwerksLibPath = _WORKING_DIR .."/Engine/Libs"

function GlobalSettings()
	-- Include Directories
	includedirs
	{
		"$(UniversalCRT_LibraryPath)",
		"%{g_LeadwerksHeaderPath}",
		"%{g_LeadwerksHeaderPath}/Libraries/PluginSDK",
		"%{g_LeadwerksHeaderPath}/Libraries/nlohmann_json/include",
		"%{g_LeadwerksHeaderPath}/Libraries/sol3/include",
		"%{g_LeadwerksHeaderPath}/Libraries/freetype/include",
		"%{g_LeadwerksHeaderPath}/Libraries/OpenAL/include",
		"%{g_LeadwerksHeaderPath}/Libraries/RecastNavigation/RecastDemo/Include",
		"%{g_LeadwerksHeaderPath}/Libraries/RecastNavigation/DetourCrowd/Include",
		"%{g_LeadwerksHeaderPath}/Libraries/RecastNavigation/DetourTileCache/Include",
		"%{g_LeadwerksHeaderPath}/Libraries/RecastNavigation/DebugUtils/Include",
		"%{g_LeadwerksHeaderPath}/Libraries/RecastNavigation/Recast/Include",
		"%{g_LeadwerksHeaderPath}/Libraries/RecastNavigation/Detour/Include",
		"%{g_LeadwerksHeaderPath}/Libraries/LuaJIT/src",
		"%{g_LeadwerksHeaderPath}/Libraries/enet/include",
		"%{g_LeadwerksHeaderPath}/Libraries/NewtonDynamics/sdk/dMath",
		"%{g_LeadwerksHeaderPath}/Libraries/NewtonDynamics/sdk/dgNewton",
		"%{g_LeadwerksHeaderPath}/Libraries/NewtonDynamics/sdk/dgTimeTracker",
		"%{g_LeadwerksHeaderPath}/Libraries/NewtonDynamics/sdk/dContainers",
		"%{g_LeadwerksHeaderPath}/Libraries/NewtonDynamics/sdk/dCustomJoints"
	}

	-- Global Defines:
	defines
	{
		"_HAS_STD_BYTE=0"
	}

	-- Windows Exclusive:
	filter "system:windows"
		systemversion "latest"
		entrypoint "mainCRTStartup"
		--pchsource "stdafx.cpp"

		links 
		{
			"Shcore.lib",
			"winmm.lib",
			"Psapi.lib",
			"msimg32.lib",
			"ws2_32.lib",
			"Wldap32.lib",
			"Dwmapi.lib",
			"Rpcrt4.lib",

			"lua51.lib",
			"OpenAL32.lib",
			"openvr_api.lib",
			"vulkan-1.lib"
		}

		libdirs 
		{ 
			"%{g_LeadwerksLibPath}/Win64/"
		}
		
		--[[
		defines
		{
			"PSAPI_VERSION=1",
			"PTW32_STATIC_LIB",
			"PTW32_BUILD",
			"_NEWTON_USE_LIB",
			"_LIB",
			"DG_USE_NORMAL_PRIORITY_THREAD",
			"GLEW_STATIC",
			"WINDOWS",
			"WIN32",
			"OS_WINDOWS",
			"PLATFORM_WINDOWS",
			"_WIN_32_VER"
		}
		]]--

		buildoptions
		{	
			--"/D \"SLB_LIBRARY\"" 
			"/std:c++17"
		}

		flags
		{
		--	"NoMinimalRebuild"
		}

		linkoptions
		{
			--"/NODEFAULTLIB:MSVCRT.lib",
			--"/NODEFAULTLIB:MSVCRTD.lib"
		}		

	-- Debug Build:
	filter "configurations:Debug"
		runtime "Debug"
		kind "ConsoleApp"
		symbols "on"
		targetsuffix ".debug"
		defines
		{
			"DEBUG",
			"_DEBUG"
		}

		links 
		{
			"Turbo_d.lib",
			"newton_d.lib",
			"dContainers_d.lib",
			"dCustomJoints_d.lib"
		}

	-- Release Build:
	filter "configurations:Release"
		runtime "Release"
		kind "WindowedApp"
		symbols "off"
		optimize "on"

		buildoptions
		{
			"/MP"
		}
			
		links 
		{
			"Turbo.lib",
			"newton.lib",
			"dContainers.lib",
			"dCustomJoints.lib"
		}
end
