	function refresh()
	{
		document.location.reload(true);
	}
	
	function logout()
	{
		var $http = new XMLHttpRequest();
		var $url = "logout.php";
		$http.open("GET", $url, true);

		$http.onreadystatechange = function() {
			if ($http.readyState == 4 && $http.status == 200) {
				if ($http.responseText == "OK")
				{
					refresh(); 
				}
			}
		}
		$http.send(null);
	}
	
	function tweet()
	{
		// escapar & =
		var $text = document.getElementById("tweetext").value;
		if ($text.length < 1)
		{
			alert("Escribe algo antes de enviarlo");
			return;
		}
		
		var $http = new XMLHttpRequest();
		var $url = "tweet.php";
		var $params = "tweet=" + $text;
		$http.open("GET", $url+"?"+$params, true);

		$http.onreadystatechange = function() {
			if ($http.readyState == 4 && $http.status == 200) { tweeted($http.responseText, $text); }
		}
		$http.send(null);
	}
	
	function tweeted($response, $text)
	{
		if ($response == "OK")
		{
			alert("Twit enviado!");
			
			$name = document.getElementById("menu-user").innerHTML;
			$id = document.getElementById("menu-user-id").innerHTML;
			
			$tweets = document.querySelectorAll(".menu-info-tile-text")[0];
			$tweets.innerHTML = parseInt($tweets.innerHTML) + 1;
			
			$newtweet = document.createElement("div");
			$newtweet.className = "tweet";
			
			$avatar = document.createElement("img");
			$avatar.className = "tweet-avatar";
			$avatar.src="test.png";
			
			$a = document.createElement("div");
			$a.className = "tweet-body";
			
			$b = document.createElement("div");
			$b.className = "tweet-author";
			
			$b.innerHTML += "<span class=\"tweet-author-name\">" + $name + "</span>";
			$b.innerHTML += "<span class=\"tweet-author-user\">@" + $id + "</span>";
			//$date = dateFormat(Date.now(), "yyyy-mm-dd HH:mm:ss");
			$date = "Now";
			$b.innerHTML += "<span class=\"tweet-time\">" + $date + "</span>";
			
			$c = document.createElement("div");
			$c.className = "tweet-text";
			
			$c.appendChild(document.createTextNode($text));
			
			$a.appendChild($b);
			$a.appendChild($c);
			
			$newtweet.appendChild($avatar);
			$newtweet.appendChild($a);

			$tl = document.getElementById("TL-header");
			$tl.parentNode.insertBefore($newtweet, $tl.nextSibling);
			
			document.getElementById("tweetext").value = "";
		}
		else
		{
			alert("Error al enviar el twit");
			refresh();
		}
	}
	
	function timestamp()
	{
		return Math.round(Date.now / 1000);
	}
	
	setInterval(refresh, (1000 * 60));