// some standard headers
#include <string>
#include <vector>
#include <iostream>
#include <fstream>
// more headers
#include <sys/stat.h>
// windows headers
#include <windows.h>
#include <wininet.h>

using namespace std;

// cool headers
#include "web.h"
#include "md5.h"

using namespace openutils;


// global variables
	// url to the files
	//const char* update_server = "http://ofarts.rpgmaker.es/updater-test/";
	const char* update_server = "http://vengeance-rpg.com/updates/";
	// path for the local files
	string local_path = "./";
	// handle for the console
	HANDLE hconsole;
	
// Functions

	// Function to draw the text with nice colors, everything white is boring
	void draw_colored_text(std::string text, int color)
	{
		//int background = 0;
		//colorattribute = foreground + background * 16
		int colorattribute = color + 0 * 16;
		SetConsoleTextAttribute(hconsole, colorattribute);
		cout << text;
	}
	
	// Function to download the files trought HTTP
	// the filename is the name and path from the update_server
	void download_file(std::string filename)
	{
		try 
		{	
			string text = "Downloading " + filename + "...";
			draw_colored_text(text, 15);

			WebForm http_connection;
			http_connection.setHost(update_server);
			http_connection.setScriptFile(filename.c_str()); 
			http_connection.sendRequest();
			string complete_path = "";
			complete_path += local_path;
			complete_path += filename;
			bool success = http_connection.downloadBigFile(complete_path.c_str());
			// Downloaded succesfully?
			if(success)
			{
				// Yes :)
				text = " Done"; 
				draw_colored_text(text, 10); cout << endl;
			}
			else 
			{
				// No :(
				text = " Error"; 
				draw_colored_text(text, 12); cout << endl;
			}
		} catch(WebFormException ex) { cout << ex.getMessage() << endl; }
		
	}
	
	// Function that gets the md5 from a file, to compare it later
	std::string check_file(std::string filename)
	{
		FILE* file;
		unsigned char buffer[16384];
		int length = 0;
		string complete_path = "";
		complete_path += local_path;
		complete_path += filename;
		
		file = fopen(filename.c_str(), "rb");
		MD5 md5 = MD5();
		while ((length = (int) fread(buffer, 1, sizeof buffer, file)) > 0) 
		{
			md5.update(buffer, (unsigned) length);
		}
		fclose(file);
		md5.finalize();
		return md5.hexdigest();
	}
	
	// Function to check if a file exists
	bool file_exists(std::string strFilename) 
	{
		struct stat stFileInfo;
		bool blnReturn;
		int intStat;
		intStat = stat(strFilename.c_str(),&stFileInfo);
		if(intStat == 0) 
		{ blnReturn = true; } 
		else 
		{ blnReturn = false; }
		return blnReturn;
	}
	
	// Function that compares the online files with the local files
	// if the md5 are differents or the file doesnt exist
	// the function downloads it
	void check_file_integrity(std::string file_to_check, std::string valid_md5)
	{
		string text;
		// Check if the file doesnt exist
		if(!file_exists(file_to_check))
		{
			// If not, then download it
			text = file_to_check + ":";
			draw_colored_text(text, 15); 
			text = " No file"; 
			draw_colored_text(text, 12); cout << endl;
			download_file(file_to_check);
		}
		else
		{
			// if it exists, compare it with the online one
			if(check_file(file_to_check) != valid_md5)
			{
				// If its different, can be edited or outdated
				// redownload it
				text = file_to_check + ":";
				draw_colored_text(text, 15); 
				text = " Outdated"; 
				draw_colored_text(text, 14); cout << endl;
				download_file(file_to_check);
			}
			else
			{
				// the file is fine
				text = file_to_check + ":";
				draw_colored_text(text, 15); 
				text = " Correct"; 
				draw_colored_text(text, 10); cout << endl;
			}
		}
		
	}

	// Entrypoint function
	int main(int argc, char *argv[])
	{
		// string to draw colored
		string text; 
		// get the consoles handles for drawing
		hconsole = GetStdHandle(STD_OUTPUT_HANDLE);
		
		// Title for the console
		SetConsoleTitle("Vengeance Online RPG - Updater");
		
		// clear the screen
		system("cls");
		// Draw the title, etc
		text = "--------------------------------------------------------------------------------";
		draw_colored_text(text, 11);
		text = "                              Vengeance Online RPG";
		draw_colored_text(text, 13); cout << endl;
		text = "                                  Updater v0.1";
		draw_colored_text(text, 9); cout << endl;
		text = "--------------------------------------------------------------------------------";
		draw_colored_text(text, 11); cout << endl;
		// Download the file containing the md5s to compare later
		download_file("check.txt");
		
		// Say something
		cout << endl;
		text = "Checking files...";
		draw_colored_text(text, 11); cout << endl;
		
		// open the md5s file and push the lines into a vector
		// with pairs:
		// files_list[i] 	= the file name
		// files_list[i+1] 	= the md5
		ifstream checkfile("check.txt");
		string line;
		vector<string> files_list;
		
		if(checkfile.is_open())
		{
			while(checkfile.good())
			{
				getline(checkfile,line);
				files_list.push_back(line);
			}
			checkfile.close();
		
			for(int i=0; i<files_list.size();i+=2)
			{
				// Check all the files
				check_file_integrity(files_list[i], files_list[i+1]);
			}
			
			// Say something
			cout << endl;
			text = "Update finished";
			draw_colored_text(text, 10); cout << endl;
			
			// Wait a little
			Sleep(2);
			
			// Launch the game

			HINSTANCE nResult = ShellExecute(NULL, "open", "Game.exe", "", NULL, SW_SHOWNORMAL);

			if((int)nResult == SE_ERR_ACCESSDENIED)
			{
				nResult = ShellExecute(NULL, "runas", "Game.exe", "", NULL, SW_SHOWNORMAL);
			}
		}
		else
		{
			// Do nothing if check.txt fails
			cout << endl;
			text = "Error while updating";
			draw_colored_text(text, 12); cout << endl;
			Sleep(3);
		}
		// Finish
		return 0;
	}
