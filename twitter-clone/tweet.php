<?php
	session_start();
	define('Flag', TRUE);
	include "config.php";

	if ( isset($_SESSION["logged"]) )
	{
		if ( ($_SESSION["expire"] == true) and (time() - $_SESSION["logged"]) > (5 * 60) )
		{
			session_destroy();
		}
		else
		{
			$_SESSION["logged"] = time();
			// check empty
			if ( isset($_GET["tweet"]) )
			{
				$conn = new mysqli($DB_addr, $DB_user, $DB_pass, $DB_name);
				if (mysqli_connect_errno()) { exit('Error al conectar: '. mysqli_connect_error()); }
				$sql = "INSERT INTO `tweets` (user_id, text) VALUES('".$_SESSION["id"]."', '".$_GET["tweet"]."')";
				$result = $conn->query($sql) or die();
				$conn->close();
				echo "OK";
				return;
			}
		}
	}
	echo "NO";
?>