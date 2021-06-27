<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
<!--
body,td,th {
	font-family: Verdana, Arial, Helvetica, sans-serif;
}
-->
</style>
<meta http-equiv="refresh" content="0;url=delectomorfo.svg" /> 
<!-- <meta http-equiv="refresh" content="0;url=animate.php" /> -->
<title>Dibujando...</title>
</head>
<body>
<?
$ranuras = $_GET['ranuras'];
$diametro = $_GET['diametro'];
$puntoa = $_GET['puntoa'];
$puntob = $_GET['puntob'];
$razon = $_GET['razon'];
//$razon = rand(1, $ranuras);
$color = $_GET['colores'];
$stroke = $_GET['stroke'];
$fondo = $_GET['colorfondo'];
$radio = $diametro / 2;

if ($color <> NULL) {$col = 1;}

$myFile = "delectomorfo.svg";
$fh = fopen($myFile, 'w') or die("can't open file");

$stringData = "<?xml version=\"1.0\" standalone=\"no\"?>\n
<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" 
\"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">\n
<svg width=\"$diametro\" height=\"$diametro\" version=\"1.1\"
xmlns=\"http://www.w3.org/2000/svg\">\n
<rect x=\"0\" y=\"0\" width=\"$diametro\" height=\"$diametro\"
style=\"fill:$fondo;fill-opacity:1;\"/>\n";

$j = 0;
$endtheta = $razon * 2 * pi() / $ranuras;

for ($i = 0; $i <= $ranuras + $ranuras * ($ranuras - 3)/2; $i++) {
	//$razon = rand(1, $ranuras/2);
	if ($col <> 0) {
		$val1 = rand(0, 255); $val2 = rand(0, 255); $val3 = rand(0, 255);
	} else {
		$val1 = 0; $val2 = 0; $val3 = 0;
	}
	$theta = $j * 2 * pi() / $ranuras;
	if (($theta == 0) && ($i > 0)) {break;}
	$stringData .=  "<line class=\"line\" x1=\"";
	$stringData .=  strval($radio + $radio * sin($theta));
	$stringData .=  "\" y1=\"";
	$stringData .=  strval($radio - $radio * cos($theta));
	$j = ($j + $razon) % $ranuras; 
	$theta = $j * 2 * pi() / $ranuras;
	$stringData .=  "\" x2=\"";
	$stringData .=  strval($radio + $radio * sin($theta));
	$stringData .=  "\" y2=\"";
	$stringData .=  strval($radio - $radio * cos($theta));
	$stringData .=  "\" shape-rendering=\"geometricPrecision\" style=\"stroke:rgb($val1,$val2,$val3); stroke-width:$stroke; stroke-linecap:round;\"/>\n";
}
$stringData .=  "</svg>";

fwrite($fh, $stringData);
fclose($fh);
?>
<h2>Por favor, espere...</h2>
<h2 align="left"><strong><a href="delectomorfo.svg">Si no ve el gr&aacute;fico, haga click aqu&iacute;</a></strong></h2>

<p>O vea el c&oacute;digo fuente del SVG:</p>
<textarea cols="85" rows="15">
<?php echo $stringData; ?>
</textarea> 
</body>
</html>