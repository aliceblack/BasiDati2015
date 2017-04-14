<html>
	<link rel="stylesheet" type="text/css" href="stile.css">
	<head><title>Area Dispositiva</title></head>
	<body>
		<h1 class="logo"></h1>
	</body>
<nav>
	<ul>
		<li><a href="prod.php">LISTINO</a></li>
		<li><a href="quatt.php">INTERROGAZIONE DATABASE</a></li>
		<li><a href="vend.php">INSERIMENTO VENDITORI</a></li>
		<li><a href="fatt.php">INSERIMENTO FATTURE</a></li>
	</ul>
</nav>
<body>
	<form method="post" action="">
	<input type="text" name="value">
	<input type="submit">
</form>
<?php 
$prova = $_POST['value'];


// we connect to localhost
$link = mysql_connect('localhost', 'asasso', 'xrhcdW78');
if (!$link) {
    die('Could not connect: ' . mysql_error());
}
echo 'Connected successfully';

$db_selected = mysql_select_db('LiquoriVeneto', $link);
if (!$db_selected) {
    die ('Can\'t use LiquoriVeneto : ' . mysql_error());
}
echo nl2br(" \n and Successfully selected db LiquoriVeneto\n");



$risultato = mysql_query($prova)
    or die("Query non valida: " . mysql_error());

$num_righe = mysql_num_rows($risultato);

echo nl2br("La query ha prodotto  $num_righe Righe\n");

while ($row = mysql_fetch_array($risultato, MYSQL_ASSOC)) {
    print_r($row);
	echo nl2br(" \n");
}

//echo $_POST['value'];

?>



</body>
</html>

