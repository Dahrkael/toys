#include <wx/wx.h>
#include <wx/thread.h>
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

class UpdateThread : public wxThread
{
public:
	void Create() { wxThread::Create(); };
	void OnExit() { }
private:
	void* Entry();
	void download_file(std::string filename);
	std::string check_file(std::string filename);
	bool file_exists(std::string strFilename);
	void check_file_integrity(std::string file_to_check, std::string valid_md5);
};

void* UpdateThread::Entry()
{
	download_file("check.txt");
	
	wxMainMutex.Lock();
	status->AppendText(wxT("\n"));
	status_text->SetLabel(wxT("Checking files..."));
	wxMainMutex.Unlock();

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
		wxMainMutex.Lock();
		status_text->SetLabel(wxT("Update finished"));
		start_button->Enable(true);
		wxMainMutex.Unlock();
	}
	else
	{
		// Do nothing if check.txt fails
		wxMainMutex.Lock();
		status_text->SetLabel(wxT("Error while updating"));
		wxMainMutex.Unlock();
	}
	return 0;	
}

void UpdateThread::download_file(std::string filename)
{
	try 
	{	
		text = "Downloading " + filename + "...";
		text2.FromUTF8(text.c_str());
		wxMainMutex.Lock();
		status->AppendText(text2);
		wxMainMutex.Unlock();
	
		WebForm http_connection;
		http_connection.setHost(update_server.c_str());
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
			text2.FromUTF8(text.c_str());
			wxMainMutex.Lock();
			status->AppendText(text2);
			status->AppendText(wxT("\n"));
			wxMainMutex.Unlock();
		}
		else 
		{
			// No :(
			text = " Error"; 
			text2.FromUTF8(text.c_str());
			wxMainMutex.Lock();
			status->AppendText(text2);
			status->AppendText(wxT("\n"));
			wxMainMutex.Unlock();
		}
	} catch(WebFormException ex) { /*cout << ex.getMessage() << endl;*/ }
		
}

std::string UpdateThread::check_file(std::string filename)
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

bool UpdateThread::file_exists(std::string strFilename) 
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

void UpdateThread::check_file_integrity(std::string file_to_check, std::string valid_md5)
{
	string text;
	// Check if the file doesnt exist
	if(!file_exists(file_to_check))
	{
		// If not, then download it
		text = file_to_check + ":";
		text2.FromUTF8(text.c_str());
		wxMainMutex.Lock();
		status->AppendText(text2);
		wxMainMutex.Unlock();
		text = " No file"; 
		text2.FromUTF8(text.c_str());
		wxMainMutex.Lock();
		status->AppendText(text2);
		status->AppendText(wxT("\n"));
		wxMainMutex.Unlock();
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
			text2.FromUTF8(text.c_str());
			wxMainMutex.Lock();
			status->AppendText(text2);
			wxMainMutex.Unlock();
			text = " Outdated"; 
			text2.FromUTF8(text.c_str());
			wxMainMutex.Lock();
			status->AppendText(text2);
			status->AppendText(wxT("\n"));
			wxMainMutex.Unlock();
			download_file(file_to_check);
		}
		else
		{
			// the file is fine
			text = file_to_check + ":";
			text2.FromUTF8(text.c_str());
			wxMainMutex.Lock();
			status->AppendText(text2);
			wxMainMutex.Unlock();
			text = " Correct"; 
			text2.FromUTF8(text.c_str());
			wxMainMutex.Lock();
			status->AppendText(text2);
			status->AppendText(wxT("\n"));
			wxMainMutex.Unlock();
		}
	}		
}
