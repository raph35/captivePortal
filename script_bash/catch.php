<?php
$path = "/home/raph35/Captive_portal/script";
function getMac(){
	$mac = shell_exec('/usr/sbin/arp -na ' .$_SERVER['REMOTE_ADDR']);
	preg_match('/..:..:..:..:..:../', $mac, $matches);
	@$mac = $matches[0];
	return $mac;
}
function exclure($name, $mac){
	/**
	 * Cette fonction exclue une adresse mac dans le pare-feu
	 * @param: $name: nom du client
	 * @param: $mac: mac du client
	 */
	shell_exec($path . "./ajoutuser.sh " . $name . " " . $mac);
}

function redirectToWeb($url, $host){
	header("Location: http://$host?&url=$url");
}
function getUrl(){
	$url = $_SERVER[HTTP_HOST].$_SERVER['REQUEST_URI'];
	return $url;
}
function route($s){
	if($s === "accepted"){
		echo "Votre mac a ete enregistré ";
		$count ++;
		$mac = getMac();
		$name = isset($_GET['name'])? $_GET['name']: "user" . $count;
		echo $name . " : " . $mac;
		//exclure($name, $mac);
	}
	elseif($s === "rejected"){
		echo "Mac rejetée";
	}
	else{
		echo "Vous etes redirige vers la page d'authentification";
		$url = getUrl();
		$host = '192.168.10.84';
		redirectToWeb($url, $host);
	}
}
?>