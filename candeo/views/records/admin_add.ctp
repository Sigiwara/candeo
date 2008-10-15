<h2>Add Record</h2>
	<?php echo $form->create('Record')?>
<ul>
	<li>
		<?php echo $form->input('Record.amount', array('class' => 'text'))?>
		<?php echo $form->error('Record.amount', 'An amount is required.') ?>
	</li>
	<li>
		<?php echo $form->input('Record.field_id', array('class' => 'text'))?>
		<?php echo $form->error('Record.field_id', 'A field is required.') ?>
	</li>
	<li>
		<?php echo $form->input('Record.institute_id') ?>
		<?php echo $form->error('Record.institute_id', 'An institute is required.') ?>
	</li>
	<li>
		<?php echo $form->input('Record.building_id') ?>
		<?php echo $form->error('Record.building_id', 'An building is required.') ?>
	</li>
	<li>
		<?php echo $form->input('Record.room', array('class' => 'text'))?>
		<?php echo $form->error('Record.room', 'A room is required.') ?>
	</li>
	<li>
		<?php echo $form->input('Record.notes', array('class' => 'text'))?>
	</li>
</ul>
<div id="page_nav">
	<?php echo $form->end('Save')?>
	<?php echo $html->link('Cancel', '/records', array('class' => 'back')); ?>
</div>