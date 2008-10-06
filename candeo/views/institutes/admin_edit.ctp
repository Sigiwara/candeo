<h2>Edit Institute</h2>
	<?php echo $form->create('Institute');?>
	<?php echo $form->hidden('Institute/id'); ?>
<ul>
	<li>
		<?php echo $form->input('Institute/name', array('class' => 'text')); ?>
		<?php echo $form->error('Institute/name', 'Name is required.'); ?>
	</li>
	<li>
		<?php echo $form->input('Institute/shortcut', array('class' => 'text'))?>
		<?php echo $form->error('Institute/shortcut', 'A shortcut is required.') ?>
	</li>
	<li>
		<?php echo $form->input('Institute/url', array('class' => 'text'))?>
		<?php echo $form->error('Institute/url', 'A url is required.') ?>
	</li>
	<li class="radiofield">
		<?php echo $form->input('Institute/area', array('type'=>'radio', 'class' => 'radio', 'options' => array('1' => 'Inselspital', '2' => 'Buehlplatz', '3' => 'Tierklinik', '4' => 'Grosse Schanze', '5' => 'Sonstige')))?>
		<?php echo $form->error('Institute/area', 'An area definition is required.') ?>
	</li>
	<li>
		<?php echo $form->input('Building') ?>
	</li>
</ul>
<div id="page_nav">
	<?php echo $form->end('Save')?>
	<?php echo $html->link('Cancel', '/institutes', array('class' => 'back')); ?>
</div>