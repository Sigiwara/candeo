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
	<?php
		echo $html->charset();
		echo $scripts_for_layout;
	?>
	<!-- ——————————————————————————————————————————————————————————————————— DUBLIN CORE -->
	<meta name="DC.Title"										content="untitled" />
	<meta name="DC.Creator"									content="Benjamin Wiederkehr / Artillery.ch" />
	<meta name="DC.Identifier"							content="<?php echo $title_for_layout?>" />
	<meta name="DC.date"										content="2008-03-25" />
	<meta name="DC.Format" scheme="IMT"			content="text/html" />
	<meta name="DC.Language" scheme="UTF-8"	content="en" />
	<!-- ——————————————————————————————————————————————————————————————————— FAVICON -->
	<link rel="shortcut icon"	href="<?=$this->base ?>/img/favicon.ico"	type="image/x-icon" />
	<link rel="icon"					href="<?=$this->base ?>/img/favicon.ico"	type="image/x-icon" />
	<!-- ——————————————————————————————————————————————————————————————————— CSS -->
	<?php echo $html->css('base', 'stylesheet', array('media'=>'all')); ?>
	<!--[if IE 7]>
		<?php echo $html->css('ie7', 'stylesheet', array('media'=>'all')); ?>
	<![endif]-->
	<!-- ——————————————————————————————————————————————————————————————————— JS -->
	<script src="<?=$this->base ?>/js/jquery.js" type="text/javascript"></script>
</head>
	<!-- ——————————————————————————————————————————————————————————————————— BODY -->
<body>
	<div id="header">
		<h1><?php echo $html->link('Candeo', '/',  array()); ?></h1>
	</div><!-- #header -->
	<div id="container">
		<div id="nav" class="<?php echo $title_for_layout?>">
			<? echo $this->element('admin/nav') ?>
		</div><!-- #nav -->
		<div id="content">
			<?php echo $content_for_layout ?>
		</div><!-- #content -->
		<div id="footer">
			<? echo $this->element('admin/footer') ?>
		</div><!-- #footer -->
	</div><!-- #container -->
</body>
</html>