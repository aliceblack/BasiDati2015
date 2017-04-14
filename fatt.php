<html>
<head>
	<title>Inserimento Fatture</title>
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
echo nl2br("<pre> ID                     Data                   Venditore             Cliente</pre>");
?>


<form method="post" action="">
	<input type="text" name="fid">
	<input type="text" name="fdata">
	<input type="text" name="fvenditore">
	<input type="text" name="fcliente">
	<input type="submit">
</form>

<?php 
$id = $_POST['fid'];
$data = $_POST['fdata'];
$venditore = $_POST['fvenditore'];
$cliente = $_POST['fcliente'];

$link = mysql_connect('localhost', 'asasso', 'xrhcdW78');
if (!$link) {
    die('Could not connect: ' . mysql_error());
}

$db_selected = mysql_select_db('LiquoriVeneto', $link);
if (!$db_selected) {
    die ('Can\'t use LiquoriVeneto : ' . mysql_error());
}
$risultato = mysql_query("call nuovafattura('$id','$data','$venditore','$cliente')")
    or die("Query non valida: " . mysql_error());

echo"</table>";
echo nl2br("\n");

?>
</body>
</html>

