##
## Auto Generated makefile by CodeLite IDE
## any manual changes will be erased      
##
## Debug
ProjectName            :=console-updater
ConfigurationName      :=Debug
IntermediateDirectory  :=./Debug
OutDir                 := $(IntermediateDirectory)
WorkspacePath          := "C:\ProyectosCodelite\Vengeance"
ProjectPath            := "C:\ProyectosCodelite\Vengeance\console-updater"
CurrentFileName        :=
CurrentFilePath        :=
CurrentFileFullPath    :=
User                   :=Santiago
Date                   :=10/19/10
CodeLitePath           :="C:\Archivos de programa\CodeLite"
LinkerName             :=g++
ArchiveTool            :=ar rcus
SharedObjectLinkerName :=g++ -shared -fPIC
ObjectSuffix           :=.o
DependSuffix           :=.o.d
PreprocessSuffix       :=.o.i
DebugSwitch            :=-gstab
IncludeSwitch          :=-I
LibrarySwitch          :=-l
OutputSwitch           :=-o 
LibraryPathSwitch      :=-L
PreprocessorSwitch     :=-D
SourceSwitch           :=-c 
CompilerName           :=g++
C_CompilerName         :=gcc
OutputFile             :=$(IntermediateDirectory)/$(ProjectName)
Preprocessors          :=
ObjectSwitch           :=-o 
ArchiveOutputSwitch    := 
PreprocessOnlySwitch   :=-E 
MakeDirCommand         :=makedir
CmpOptions             := -g $(Preprocessors)
LinkOptions            :=  
IncludePath            :=  "$(IncludeSwitch)." "$(IncludeSwitch)." 
RcIncludePath          :=
Libs                   :=$(LibrarySwitch)wininet 
LibPath                := "$(LibraryPathSwitch)." 


##
## User defined environment variables
##
CodeLiteDir:=C:\Archivos de programa\CodeLite
WXWIN:=C:\wxWidgets-2.8.7
PATH:=$(WXWIN)\lib\gcc_dll;$(PATH)
WXCFG:=gcc_dll\mswu
Objects=$(IntermediateDirectory)/main$(ObjectSuffix) $(IntermediateDirectory)/md5$(ObjectSuffix) $(IntermediateDirectory)/web$(ObjectSuffix) $(IntermediateDirectory)/tests$(ObjectSuffix) 

##
## Main Build Targets 
##
all: $(OutputFile)

$(OutputFile): makeDirStep $(Objects)
	@$(MakeDirCommand) $(@D)
	$(LinkerName) $(OutputSwitch)$(OutputFile) $(Objects) $(LibPath) $(Libs) $(LinkOptions)

makeDirStep:
	@$(MakeDirCommand) "./Debug"

PreBuild:


##
## Objects
##
$(IntermediateDirectory)/main$(ObjectSuffix): main.cpp $(IntermediateDirectory)/main$(DependSuffix)
	$(CompilerName) $(SourceSwitch) "C:/ProyectosCodelite/Vengeance/console-updater/main.cpp" $(CmpOptions) $(ObjectSwitch)$(IntermediateDirectory)/main$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/main$(DependSuffix): main.cpp
	@$(CompilerName) $(CmpOptions) $(IncludePath) -MT$(IntermediateDirectory)/main$(ObjectSuffix) -MF$(IntermediateDirectory)/main$(DependSuffix) -MM "C:/ProyectosCodelite/Vengeance/console-updater/main.cpp"

$(IntermediateDirectory)/main$(PreprocessSuffix): main.cpp
	@$(CompilerName) $(CmpOptions) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/main$(PreprocessSuffix) "C:/ProyectosCodelite/Vengeance/console-updater/main.cpp"

$(IntermediateDirectory)/md5$(ObjectSuffix): md5.cpp $(IntermediateDirectory)/md5$(DependSuffix)
	$(CompilerName) $(SourceSwitch) "C:/ProyectosCodelite/Vengeance/console-updater/md5.cpp" $(CmpOptions) $(ObjectSwitch)$(IntermediateDirectory)/md5$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/md5$(DependSuffix): md5.cpp
	@$(CompilerName) $(CmpOptions) $(IncludePath) -MT$(IntermediateDirectory)/md5$(ObjectSuffix) -MF$(IntermediateDirectory)/md5$(DependSuffix) -MM "C:/ProyectosCodelite/Vengeance/console-updater/md5.cpp"

$(IntermediateDirectory)/md5$(PreprocessSuffix): md5.cpp
	@$(CompilerName) $(CmpOptions) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/md5$(PreprocessSuffix) "C:/ProyectosCodelite/Vengeance/console-updater/md5.cpp"

$(IntermediateDirectory)/web$(ObjectSuffix): web.cpp $(IntermediateDirectory)/web$(DependSuffix)
	$(CompilerName) $(SourceSwitch) "C:/ProyectosCodelite/Vengeance/console-updater/web.cpp" $(CmpOptions) $(ObjectSwitch)$(IntermediateDirectory)/web$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/web$(DependSuffix): web.cpp
	@$(CompilerName) $(CmpOptions) $(IncludePath) -MT$(IntermediateDirectory)/web$(ObjectSuffix) -MF$(IntermediateDirectory)/web$(DependSuffix) -MM "C:/ProyectosCodelite/Vengeance/console-updater/web.cpp"

$(IntermediateDirectory)/web$(PreprocessSuffix): web.cpp
	@$(CompilerName) $(CmpOptions) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/web$(PreprocessSuffix) "C:/ProyectosCodelite/Vengeance/console-updater/web.cpp"

$(IntermediateDirectory)/tests$(ObjectSuffix): tests.cpp $(IntermediateDirectory)/tests$(DependSuffix)
	$(CompilerName) $(SourceSwitch) "C:/ProyectosCodelite/Vengeance/console-updater/tests.cpp" $(CmpOptions) $(ObjectSwitch)$(IntermediateDirectory)/tests$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/tests$(DependSuffix): tests.cpp
	@$(CompilerName) $(CmpOptions) $(IncludePath) -MT$(IntermediateDirectory)/tests$(ObjectSuffix) -MF$(IntermediateDirectory)/tests$(DependSuffix) -MM "C:/ProyectosCodelite/Vengeance/console-updater/tests.cpp"

$(IntermediateDirectory)/tests$(PreprocessSuffix): tests.cpp
	@$(CompilerName) $(CmpOptions) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/tests$(PreprocessSuffix) "C:/ProyectosCodelite/Vengeance/console-updater/tests.cpp"


-include $(IntermediateDirectory)/*$(DependSuffix)
##
## Clean
##
clean:
	$(RM) $(IntermediateDirectory)/main$(ObjectSuffix)
	$(RM) $(IntermediateDirectory)/main$(DependSuffix)
	$(RM) $(IntermediateDirectory)/main$(PreprocessSuffix)
	$(RM) $(IntermediateDirectory)/md5$(ObjectSuffix)
	$(RM) $(IntermediateDirectory)/md5$(DependSuffix)
	$(RM) $(IntermediateDirectory)/md5$(PreprocessSuffix)
	$(RM) $(IntermediateDirectory)/web$(ObjectSuffix)
	$(RM) $(IntermediateDirectory)/web$(DependSuffix)
	$(RM) $(IntermediateDirectory)/web$(PreprocessSuffix)
	$(RM) $(IntermediateDirectory)/tests$(ObjectSuffix)
	$(RM) $(IntermediateDirectory)/tests$(DependSuffix)
	$(RM) $(IntermediateDirectory)/tests$(PreprocessSuffix)
	$(RM) $(OutputFile)
	$(RM) $(OutputFile).exe


