<h2>Add Chemical Class</h2>
	<?php echo $form->create('ChemicalClass')?>
<ul>
	<li>
		<?php echo $form->input('ChemicalClass/name', array('class' => 'text'))?>
		<?php echo $form->error('ChemicalClass/name', 'A name is required.') ?>
	</li>
	<li>
		<?php echo $form->input('ChemicalClass/abbriviation', array('class' => 'text'))?>
		<?php echo $form->error('ChemicalClass/abbriviation', 'A abbriviation is required.') ?>
	</li>
	<li>
		<?php echo $form->input('ChemicalClass/criteria', array('class' => 'text'))?>
		<?php echo $form->error('ChemicalClass/criteria', 'A criteria is required.') ?>
	</li>
	<li>
		<?php echo $form->input('ChemicalClass/precaution', array('class' => 'text'))?>
		<?php echo $form->error('ChemicalClass/precaution', 'A precaution is required.') ?>
	</li>
</ul>
<div id="page_nav">
	<?php echo $form->end('Save')?>
	<?php echo $html->link('Cancel', '/chemicalClasses', array('class' => 'back')); ?>
</div>