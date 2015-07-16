<?php
	session_start();

	define('Flag', TRUE);
	
	if ( isset($_SESSION["logged"]) )
	{
		if ( ($_SESSION["expire"] == true) and (time() - $_SESSION["logged"]) > (5 * 60) )
		{
			session_destroy();
		}
		else
		{
			$_SESSION["logged"] = time();
			include 'profile.php';
			return;
		}
	}
	include 'login.php';
?>