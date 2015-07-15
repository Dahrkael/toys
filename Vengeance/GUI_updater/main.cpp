#include <wx/wx.h>
#include <wx/bitmap.h>

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

#include "logo.h"

using namespace openutils;

// application class
class wxMiniApp : public wxApp
{
    public:
		// function called at the application initialization
        virtual bool OnInit();

		void download_file(wxString filename);
		wxString check_file(wxString filename);
		bool file_exists(wxString strFilename);
		void check_file_integrity(wxString file_to_check, wxString valid_md5);
		void DoIt();

		// event handler for button click
		void launch_game(wxCommandEvent& event);
        void OnClick(wxCommandEvent& event) { window->Close(true); }
		
		// variables
		//wxFrame*			window; 
		wxFrame*			window; 
		wxPanel* 			main_panel;
		wxBitmapButton* 	logo;
		wxButton* 			start_button;
		wxButton* 			exit_button;
		wxTextCtrl* 		status;
		wxStaticText* 		status_text;
		
	private:
		wxString 			update_server;
		wxString 			local_path;
		wxString	 		text;
		

		
} MyApp;

IMPLEMENT_APP(wxMiniApp);

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////


void wxMiniApp::DoIt()
{
	download_file(wxT("check.txt"));
	
	status->AppendText(wxT("\n"));
	status_text->SetLabel(wxT("Checking files..."));
	 
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
			wxString mystring1(files_list[i].c_str(), wxConvUTF8);
			wxString mystring2(files_list[i+1].c_str(), wxConvUTF8);
			check_file_integrity(mystring1, mystring2);
		}
		
		// Say something
		status_text->SetLabel(wxT("Update finished"));
		start_button->Enable(true);
		
	}
	else
	{
		// Do nothing if check.txt fails
		status_text->SetLabel(wxT("Error while updating"));
		
	}
}

void wxMiniApp::download_file(wxString filename)
{
	try 
	{	
		text = wxT("Downloading ") + filename + wxT("...");
		status->AppendText(text);
		
		WebForm http_connection;
		http_connection.setHost(update_server.mb_str());
		http_connection.setScriptFile(filename.mb_str()); 
		http_connection.sendRequest();
		wxString complete_path = wxT("");
		complete_path += local_path;
		complete_path += filename;
		bool success = http_connection.downloadBigFile(complete_path.mb_str());
		// Downloaded succesfully?
		if(success)
		{
			// Yes :)
			text = wxT(" Done"); 
			status->AppendText(text);
			status->AppendText(wxT("\n"));
			
		}
		else 
		{
			// No :(
			text = wxT(" Error"); 
			status->AppendText(text);
			status->AppendText(wxT("\n"));
			
		}
	} catch(WebFormException ex) { /*cout << ex.getMessage() << endl;*/ }
		
}

wxString wxMiniApp::check_file(wxString filename)
{
	FILE* file;
	unsigned char buffer[16384];
	int length = 0;
	wxString complete_path = wxT("");
	complete_path += local_path;
	complete_path += filename;
	
	file = fopen(filename.mb_str(), "rb");
	MD5 md5 = MD5();
	while ((length = (int) fread(buffer, 1, sizeof buffer, file)) > 0) 
	{
		md5.update(buffer, (unsigned) length);
	}
	fclose(file);
	md5.finalize();
	wxString ret(md5.hexdigest().c_str(), wxConvUTF8);
	return ret;
}

bool wxMiniApp::file_exists(wxString strFilename) 
{
	struct stat stFileInfo;
	bool blnReturn;
	int intStat;
	intStat = stat(strFilename.mb_str(),&stFileInfo);
	if(intStat == 0) 
	{ blnReturn = true; } 
	else 
	{ blnReturn = false; }
	return blnReturn;
}

void wxMiniApp::check_file_integrity(wxString file_to_check, wxString valid_md5)
{
	// Check if the file doesnt exist
	if(!file_exists(file_to_check))
	{
		// If not, then download it
		text = file_to_check + wxT(":");
		status->AppendText(text);
		
		text = wxT(" No file"); 
		status->AppendText(text);
		status->AppendText(wxT("\n"));
		
		download_file(file_to_check);
	}
	else
	{
		// if it exists, compare it with the online one
		if(check_file(file_to_check) != valid_md5)
		{
			// If its different, can be edited or outdated
			// redownload it
			text = file_to_check + wxT(":");
			status->AppendText(text);
			
			text = wxT(" Outdated"); 
			status->AppendText(text);
			status->AppendText(wxT("\n"));
			
			download_file(file_to_check);
		}
		else
		{
			// the file is fine
			text = file_to_check + wxT(":");
			status->AppendText(text);
			
			text = wxT(" Correct"); 
			status->AppendText(text);
			status->AppendText(wxT("\n"));
			
		}
	}		
}
/////////////////////////////////



/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

bool wxMiniApp::OnInit()
{
	//update_server = "http://vengeance-rpg.com/updates/";
	update_server = wxT("http://ofarts.rpgmaker.es/updater-test/");
	local_path = wxT("./");
	window = new wxFrame( NULL, -1, wxT("Vengeance RPG Online Updater"), wxDefaultPosition, wxSize( 400, 300) );
    SetTopWindow( window );
	
	GetTopWindow()->SetMinSize(wxSize(400,300));
	GetTopWindow()->SetMaxSize(wxSize(400,300));
	
	main_panel = new wxPanel(GetTopWindow(), wxID_ANY, wxPoint(0, 0), wxSize(400, 300));
	
	wxImage::AddHandler(new wxPNGHandler);	
	initialize_images();
	// 134 height
	logo = new wxBitmapButton(main_panel, wxID_ANY, _img_vengeance, wxDefaultPosition, wxDefaultSize, wxBORDER_NONE);

	status = new wxTextCtrl(main_panel, wxID_ANY, wxT(""), wxPoint(1,135), wxSize(389,100), wxTE_READONLY|wxTE_MULTILINE);
	
	status_text = new wxStaticText(main_panel, wxID_ANY, wxT("Conectando..."), wxPoint(15, 245), wxDefaultSize);
    
	start_button = new wxButton(main_panel, 21, wxT("Start Game"), wxPoint(210, 242), wxSize(80,20));
	start_button->Enable(false);
	exit_button = new wxButton(main_panel, wxID_EXIT, wxT("Exit"), wxPoint(305, 242), wxSize(80,20));
	
	Connect(21, wxEVT_COMMAND_BUTTON_CLICKED, wxCommandEventHandler(wxMiniApp::launch_game) );
    Connect(wxID_EXIT, wxEVT_COMMAND_BUTTON_CLICKED, wxCommandEventHandler(wxMiniApp::OnClick) );

	// show main frame
    GetTopWindow()->Show();
	DoIt();
	
	// enter the application's main loop
    return true;
}



void wxMiniApp::launch_game(wxCommandEvent& event)
{
	HINSTANCE nResult = ShellExecute(NULL, (WCHAR*)"open", (WCHAR*)"Game.exe", (WCHAR*)"", NULL, SW_SHOWNORMAL);
	if((int)nResult == SE_ERR_ACCESSDENIED)
	{
		nResult = ShellExecute(NULL, (WCHAR*)"runas", (WCHAR*)"Game.exe", (WCHAR*)"", NULL, SW_SHOWNORMAL);
	}
}
///////////////////////////////////////////////////////////////////////////

