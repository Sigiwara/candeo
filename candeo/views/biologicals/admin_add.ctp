<h2>Add Biological</h2>
	<?php echo $form->create('Biological')?>
<ul>
	<li>
		<?php echo $form->input('Biological/name', array('class' => 'text'))?>
		<?php echo $form->error('Biological/name', 'A name is required.') ?>
	</li>
	<li class="radiofield">
		<?php echo $form->input('Biological/activity', array('type'=>'radio', 'class' => 'radio', 'options' => array('1' => 'Class 1', '2' => 'Class 2', '3' => 'Class 3', '4' => 'Class 4')))?>
		<?php echo $form->error('Biological/activity', 'An activity definition is required.') ?>
	</li>
	<li class="radiofield">
		<?php echo $form->input('Biological/group', array('type'=>'radio', 'class' => 'radio', 'options' => array('1' => 'Group 1', '2' => 'Group 2', '3' => 'Group 3', '4' => 'Group 4')))?>
		<?php echo $form->error('Biological/group', 'An group definition is required.') ?>
	</li>
	<li class="radiofield">
		<?php echo $form->input('Biological/security', array('type'=>'radio', 'class' => 'radio', 'options' => array('1' => 'BSL 1', '2' => 'BSL 2', '3' => 'BSL 3', '4' => 'BSL 4')))?>
		<?php echo $form->error('Biological/security', 'An security definition is required.') ?>
	</li>
	<li>
		<?php echo $form->input('Biological/openness', array('type'=>'checkbox', 'class' => 'checkbox'))?>
		<?php echo $form->error('Biological/openness', 'An openness definition is required.') ?>
	</li>
</ul>
<div id="page_nav">
	<?php echo $form->end('Save')?>
	<?php echo $html->link('Cancel', '/biologicals', array('class' => 'back')); ?>
</div>