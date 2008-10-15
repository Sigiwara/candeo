<h2>Edit Institute</h2>
	<?php echo $form->create('Institute');?>
	<?php echo $form->hidden('Institute.id'); ?>
<ul>
	<li>
		<?php echo $form->input('Institute.name', array('label'=>false, 'class' => 'title')); ?>
		<?php echo $form->error('Institute.name', 'Name is required.'); ?>
	</li>
	<li>
		<?php echo $form->input('Institute.shortcut', array('class' => 'text'))?>
		<?php echo $form->error('Institute.shortcut', 'A shortcut is required.') ?>
	</li>
	<li>
		<?php echo $form->input('Institute.url', array('class' => 'text'))?>
		<?php echo $form->error('Institute.url', 'A url is required.') ?>
	</li>
	<li class="hint">
		<h3>Hint:</h3>
		Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure d.
		<a href="#" title="close this hint" class="close">close this hint</a>
	</li>
	<li class="radiofield clearfix">
		<label for="area">Area</label>
		<?php echo $form->input('Institute.area', array('legend'=>false, 'type'=>'radio', 'class' => 'radio', 'div'=>'radio clearfix', 'options' => array('1' => 'Inselspital', '2' => 'Buehlplatz', '3' => 'Tierklinik', '4' => 'Grosse Schanze', '5' => 'Sonstige')))?>
		<?php echo $form->error('Institute.area', 'An area definition is required.') ?>
	</li>
	<li>
		<?php echo $form->input('Building') ?>
	</li>
</ul>
<div id="page_nav">
	<?php echo $form->end('Save')?>
	<?php echo $html->link('Cancel', array('action'=>'index',),  array('class'=>'back')); ?>
</div>