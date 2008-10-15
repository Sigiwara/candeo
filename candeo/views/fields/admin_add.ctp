<h2>Add New Field</h2>
	<?php echo $form->create('Field')?>
<ul>
	<li>
		<?php echo $form->input('Field.name', array('label'=>false, 'class' => 'title', 'value'=>'Field name')); ?>
		<?php echo $form->error('Field.name', 'Name is required.'); ?>
	</li>
	<li>
		<?php echo $form->input('Field.symbol', array('class' => 'text'))?>
		<?php echo $form->error('Field.symbol', 'A symbol is required.') ?>
	</li>
	<li>
		<?php echo $form->input('Field.group', array('class' => 'text'))?>
		<?php echo $form->error('Field.group', 'A group is required.') ?>
	</li>
	<li>
		<?php echo $form->input('Field.factor', array('class' => 'text'))?>
		<?php echo $form->error('Field.factor', 'A factor is required.') ?>
	</li>
</ul>
<div id="page_nav">
	<?php echo $form->end('Save')?>
	<?php echo $html->link('Cancel', array('action'=>'index'),  array('class'=>'back')); ?>
</div>