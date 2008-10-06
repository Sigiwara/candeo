<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<!-- ——————————————————————————————————————————————————————————————————— TITLE -->
	<title>Candeo | <?php echo $title_for_layout?></title>
	<!-- ——————————————————————————————————————————————————————————————————— META -->
	<meta http-equiv="Content-Type"					content="text/html; charset=utf-8"/>
	<meta http-equiv="Content-Language"			content="de-de" />
	<meta http-equiv="imagetoolbar"					content="no" />
	<meta name="Robots"											content="ALL" />
	<meta name="Keywords"										content="Bachelor App" />
	<meta name="Description"								content="Bachelor App of BW & CS" />
	<meta name="Author"											content="Benjamin Wiederkehr / Artillery.ch" />
	<meta name="MSSmartTagsPreventParsing"	content="true" />
	<meta name="Copyright"									content="2008 " />
	<!-- ——————————————————————————————————————————————————————————————————— DUBLIN CORE -->
	<meta name="DC.Title"										content="untitled" />
	<meta name="DC.Creator"									content="Benjamin Wiederkehr / Artillery.ch" />
	<meta name="DC.Identifier"							content="<?php echo $title_for_layout?>" />
	<meta name="DC.date"										content="2008-03-25" />
	<meta name="DC.Format" scheme="IMT"			content="text/html" />
	<meta name="DC.Language" scheme="UTF-8"	content="en" />
	<?php if (Configure::read() <= 2) { ?>
	<meta http-equiv="Refresh" content="<?php echo $pause; ?>;url=<?php echo $url; ?>"/>
	<?php } ?>
	<!-- ——————————————————————————————————————————————————————————————————— FAVICON -->
	<link rel="shortcut icon"	href="<?=$this->base ?>/img/favicon.ico"	type="image/x-icon" />
	<link rel="icon"					href="<?=$this->base ?>/img/favicon.ico"	type="image/x-icon" />
	<!-- ——————————————————————————————————————————————————————————————————— CSS -->
	<link rel="stylesheet"		href="<?=$this->base ?>/css/screen.css"	type="text/css"	media="screen" />
	<link rel="stylesheet"		href="<?=$this->base ?>/css/print.css"	type="text/css"	media="print" />
	<!--[if IE 7]>
		<link rel="stylesheet"	href="<?=$this->base ?>/css/ie7.css"						type="text/css"	media="screen" />
	<![endif]-->
	<!-- ——————————————————————————————————————————————————————————————————— JS -->
</head>
	<!-- ——————————————————————————————————————————————————————————————————— BODY -->
<body>
	<div id="header">
		<h1><?php echo $html->link('Candeo', '/',  array()); ?></h1>
	</div><!-- #header -->
	<div id="container">
		<div id="nav" class="<?php echo $title_for_layout?>">
			<? echo $this->renderElement('nav') ?>
		</div><!-- #nav -->
		<div id="content">
			<a href="<?php echo $url; ?>"><?php echo $message; ?></a>
		</div><!-- #content -->
		<div id="footer">
			<? echo $this->renderElement('footer') ?>
		</div><!-- #footer -->
	</div><!-- #container -->
</body>
</html>