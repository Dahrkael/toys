<?php
	// impedir acceso directo
	if ( !defined('Flag') ) { header('Location: index.php'); }
	include "config.php";
	
	if ( isset($_POST["user"]) and isset($_POST["pass"]) )
	{
		$conn = new mysqli($DB_addr, $DB_user, $DB_pass, $DB_name);
		if (mysqli_connect_errno()) { exit('Error al conectar: '. mysqli_connect_error()); }
		
		// escapar esto
		$user = $_POST["user"];
		$pass = $_POST["pass"];

		$sql = "SELECT id, name FROM `users` WHERE `id`='".$user."' AND `password`='".$pass."'";
		
		$result = $conn->query($sql);
		if ($result->num_rows > 0) 
		{
			$row = $result->fetch_assoc();
			$_SESSION["logged"] = time();
			$_POST["expire"] == 1 ? $_SESSION["expire"] = false : $_SESSION["expire"] = true;
			$_SESSION ["id"] = $row['id'];
			$_SESSION["name"] = $row["name"];
			$_SESSION["avatar"] = "test.png";
		}
		else
		{
			$_SESSION["failed_login"] = true;
		}

		$conn->close();
		header('Location: index.php');
	}
	else
	{
		// mostrar formulario de acceso
		echo_header();
		echo_stub();
		echo "<div id=\"main\">";
		echo_title();
		if ( isset($_SESSION["failed_login"]) )
		{
			echo_form(true);
			unset($_SESSION["failed_login"]);
		}
		else
		{
			echo_form(false);
		}
		echo "</div>";
		echo_footer();
	}
	
	function echo_header()
	{
		echo "<html>";
		echo "<head><title>Twitter</title>";
		echo "<link rel=\"stylesheet\" type=\"text/css\" href=\"login.css\" />";
		echo "</head><body>";
	}
	
	function echo_footer()
	{
		echo "</body>";
		echo "</html>";
	}
	
	function echo_warning()
	{
		echo "<p>Usuario o contraseña incorrecto</p>";
	}
	
	function echo_stub()
	{
		echo "<div><br></div>";
	}
	
	function echo_title()
	{
		echo "<div id=\"title\">";
		echo "Twitter<br>";
		echo "<span style=\"font-size: 25%;\">alpha version<span>";
		echo "</div>";
	}
	
	function echo_form($warning)
	{
		echo "<div id=\"panel\">";
			if ($warning == true)
			{
				echo_warning();
			}
			echo "<form action=\"index.php\" method=\"POST\">";
			echo "<label> Usuario";
			echo "<input type=\"text\" name=\"user\" size=\"32\" maxlength=\"16\">";
			echo "</label><br>";
			echo "<label> Contraseña";
			echo "<input type=\"password\" name=\"pass\" size=\"32\" maxlength=\"32\">";
			echo "</label><br>";
			echo "<label>No cerrar sesion";
			echo "<input type=\"checkbox\" name=\"expire\">";
			echo "</label><br><br>";
			echo "<input type=\"submit\" value=\"Entrar\">";
			echo "</form>";
			echo "<a href=\"register.php\">registrarse</a>";
		echo "</div>";
	}
?>