<html>
<head>
	<title>Prodotti</title>
	<link rel="stylesheet" type="text/css" href="stile.css">
</head>

<body><h1 class="logo"></h1></body>

<nav>
<ul>
<li><a href="prod.php">LISTINO</a></li>
<li><a href="quatt.php">INTERROGAZIONE DATABASE</a></li>
<li><a href="vend.php">INSERIMENTO VENDITORI</a></li>
<li><a href="fatt.php">INSERIMENTO FATTURE</a></li>
</ul>
</nav>


<body>
<?php 
$link = mysql_connect('localhost', 'asasso', 'xrhcdW78');
if (!$link) {
    die('Could not connect: ' . mysql_error());
}

$db_selected = mysql_select_db('LiquoriVeneto', $link);
if (!$db_selected) {
    die ('Can\'t use LiquoriVeneto : ' . mysql_error());
}
$risultato = mysql_query("SELECT * from prodotto")
    or die("Query non valida: " . mysql_error());

echo "<pre> Prodotto                      Prezzo</pre>";
echo"<table>";
while ($row = mysql_fetch_assoc($risultato)) {
$nome=$row['nome'];
$prezzo=$row['prezzo'];

echo"<tr><td>".$nome."</td><td>".$prezzo."</td></tr>";

}
echo"</table>";
echo nl2br("\n");

?>
</body>
</html>

