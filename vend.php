<html>
<head>
	<title>Inserimento Venditori</title>
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

<?php
echo nl2br("<pre> Codice Fiscale         Km Percorsi</pre>");
?>

<body>
<form method="post" action="">
	<input type="text" name="codice">
	<input type="text" name="kilometers">
	<input type="submit">
</form>

<?php 
$cod = $_POST['codice'];
$km = $_POST['kilometers'];

$link = mysql_connect('localhost', 'asasso', 'xrhcdW78');
if (!$link) {
    die('Could not connect: ' . mysql_error());
}

$db_selected = mysql_select_db('LiquoriVeneto', $link);
if (!$db_selected) {
    die ('Can\'t use LiquoriVeneto : ' . mysql_error());
}
$risultato = mysql_query("call nuovovenditore('$cod','$km')")
    or die("Query non valida: " . mysql_error());

echo"</table>";
echo nl2br("\n");

?>
</body>
</html>

