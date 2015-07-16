<?php
	// impedir acceso directo
	if ( !defined('Flag') ) { header('Location: index.php'); }
	include "config.php";
	
	$conn = new mysqli($DB_addr, $DB_user, $DB_pass, $DB_name);
	if (mysqli_connect_errno()) { exit('Error al conectar: '. mysqli_connect_error()); }
	
	// numero tweets
	$sql = "SELECT COUNT(*) FROM `tweets` WHERE `user_id`='".$_SESSION["id"]."'";
	$row = $conn->query($sql)->fetch_row();
	$ntweets = $row[0];
	
	// siguiendo te siguen
	$sql = "SELECT COUNT(*) FROM `following` WHERE `user_id_1`='".$_SESSION["id"]."'";
	$row = $conn->query($sql)->fetch_row();
	$following = $row[0] - 1;
	
	$sql = "SELECT COUNT(*) FROM `following` WHERE `user_id_2`='".$_SESSION["id"]."'";
	$row = $conn->query($sql)->fetch_row();
	$followed = $row[0] - 1;
	
	echo_header();
	echo "<div id=\"main\">";
		echo_toolbar();
		echo_menu($ntweets, $following, $followed);
		echo_timeline($conn);
	echo "</div>"; // main
	echo_footer();
	
	$conn->close();
	
	// =====================================================================================================
	
	function echo_header()
	{
		echo "<!DOCTYPE html>";
		echo "<html><head>";
		echo "<title>Twitter</title>";
		echo "<link rel=\"stylesheet\" type=\"text/css\" href=\"profile.css\" />";
		echo "<script language=\"javascript\" src=\"profile.js\"></script>";
		echo "</head><body>";
	}
	
	function echo_footer()
	{
		echo "</body></html>";
	}
	
	function echo_toolbar()
	{
		echo "<div id=\"toolbar\">";
		echo "<input type=\"button\" value=\"Actualizar\" onclick=\"refresh()\"> ";
		echo "<input type=\"button\" value=\"Usuarios\" onclick=\"search()\"> ";
		echo "<input type=\"button\" value=\"Cerrar sesion\" onclick=\"logout()\">";
		echo "</div>";
	}
	
	function echo_menu($ntweets, $following, $followed)
	{
		echo "<div id=\"menu\">";
			echo "<img id=\"menu-avatar\" src=\"" . $_SESSION["avatar"] . "\">";
			echo "<div id=\"menu-user\">" . $_SESSION["name"] . "</div>";
			echo "<div id=\"menu-user-id\">" . $_SESSION["id"] . "</div>";
			echo "<div id=\"menu-info\">";
				echo "<div class=\"menu-info-tile\"><span class=\"menu-info-tile-text\">" . $ntweets . "</span><br>TWEETS</div>";
				echo "<div class=\"menu-info-tile\"><span class=\"menu-info-tile-text\">" . $following . "</span><br>SIGUIENDO</div>";
				echo "<div class=\"menu-info-tile\"><span class=\"menu-info-tile-text\">" . $followed . "</span><br>SEGUIDORES</div>";
			echo "</div>";
			echo_tweeter();
		echo "</div>";
	}
	
	function echo_tweeter()
	{
		echo "<div id=\"menu-controls\">";
			echo "<form>";
			echo "<center>";
				echo "<textarea id=\"tweetext\"></textarea><br>";
				echo "<input type=\"button\" value=\"Twittear\" onclick=\"tweet()\">";
			echo "</center";
			echo "</form>";
		echo "</div>";
	}
	
	function echo_timeline($conn)
	{
		echo "<div id=\"TL\">";
			echo "<div id=\"TL-header\">Tweets</div>";
			// tweets
			$sql = "SELECT tw.text, tw.date, us.name, us.id FROM `tweets` AS tw, `users` AS us, `following` as fo  WHERE fo.user_id_1='".$_SESSION["id"]."' AND tw.user_id=fo.user_id_2 AND us.id=tw.user_id ORDER BY tw.date DESC";
			$result = $conn->query($sql);
			if ($result->num_rows > 0) 
			{
				while ($row = $result->fetch_assoc())
				{
					// htmlspecialchars("<a href='test'>Test</a>", ENT_QUOTES);
					echo_tweet($row["id"], $row["name"], $row["date"], $row["text"]);
				}
			}
		echo "</div>"; // TL
	}
	
	function echo_tweet($id, $name, $date, $text)
	{
		echo "<div class=\"tweet\">";
			echo "<img class=\"tweet-avatar\" src=\"test.png\">";
			echo "<div class=\"tweet-body\">";
				echo "<div class=\"tweet-author\">";
					echo "<span class=\"tweet-author-name\">" . $name . "</span>";
					echo "<span class=\"tweet-author-user\">@" . $id . "</span>";
					echo "<span class=\"tweet-time\">" . $date . "</span>";
				echo "</div>";
				echo "<div class=\"tweet-text\">" . $text . "</div>";
			echo "</div>";
		echo "</div>";
	}
?>