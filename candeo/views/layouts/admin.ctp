<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<!-- ——————————————————————————————————————————————————————————————————— TITLE -->
	<title>Candeo | <?php echo $title_for_layout?></title>
	<!-- ——————————————————————————————————————————————————————————————————— META -->
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<?php echo $html->charset(); ?>
	<meta http-equiv="Content-Language" content="de-de" />
	<meta http-equiv="imagetoolbar" content="no" />
	<meta name="Robots" content="ALL" />
	<meta name="Keywords" content="Bachelor App" />
	<meta name="Description" content="Bachelor App of BW & CS" />
	<meta name="Author" content="Benjamin Wiederkehr / Artillery.ch" />
	<meta name="MSSmartTagsPreventParsing" content="true" />
	<meta name="Copyright" content="<?php date('Y'); ?> Benjamin Wiederkehr & Christian Siegrist" />
	<!-- ——————————————————————————————————————————————————————————————————— FAVICON -->
	<link rel="shortcut icon" href="<?=$this->base ?>/img/favicon.ico" type="image/x-icon" />
	<link rel="icon" href="<?=$this->base ?>/img/favicon.ico" type="image/x-icon" />
	<!-- ——————————————————————————————————————————————————————————————————— CSS -->
	<?php echo $html->css('base', 'stylesheet', array('media'=>'all')); ?>
	<!-- ——————————————————————————————————————————————————————————————————— JS -->
	<?php echo $scripts_for_layout; ?>
	<script src="<?=$this->base ?>/js/jquery-1.2.6.min.js" type="text/javascript"></script>
	<script type="text/javascript">
		<!--
		$(document).ready(function(){
			if($('.hint') != null){
				$('.close').click(function(){
					var hint = $(this).parent();
					$(hint).fadeOut('slow');
				})
			}
			if($('.message') != null){
				setTimeout(function(){
					$('.message').fadeOut('slow');
				}, 4000)
			}
			//if($('.extended') == null){
				$('.secondary').hide();
				$('#con_secondary').hide();
				$('#ex_secondary').click(function(){
					$('.secondary').fadeIn();
					$(this).hide();
					$('#con_secondary').show();
				})
				$('#con_secondary').click(function(){
					$('.secondary').fadeOut();
					$(this).hide();
					$('#ex_secondary').show();
				})
			//}
		})
		//-->
	</script>
</head>
	<!-- ——————————————————————————————————————————————————————————————————— BODY -->
<body class="admin">
	<div id="header">
		<h1><?php echo $html->link('Candeo', '/',  array()); ?></h1>
		<?php echo $this->element('meta'); ?>
	</div><!-- #header -->
	<?php echo $this->element('flash'); ?>
	<div id="container">
		<div id="nav" class="<?php echo $title_for_layout?>">
			<?php echo $this->element('admin/nav'); ?>
		</div><!-- #nav -->
		<div id="content">
			<?php echo $content_for_layout; ?>
		</div><!-- #content -->
		<div id="footer">
			<?php echo $this->element('admin/footer'); ?>
		</div><!-- #footer -->
	</div><!-- #container -->
</body>
</html>